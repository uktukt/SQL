USE portfolioprojectcovid;

SELECT * FROM coviddeaths
WHERE continent is not null
ORDER by 3,4;

SELECT * FROM covidvaccinations
WHERE continent is not null
ORDER by 3,4;

# Select Data that we are goint go be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
WHERE continent is not null
ORDER by 1,2;

# Looking at Total Cases vs total Deaths
# Shows likelihood of dying if you contract covid

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent is not null
ORDER by 1,2;

SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE location = 'Lithuania'
ORDER by 1,2;

# Looking at Total Cases vs Population
# Show what percentage of population got Covid

SELECT Location, date, Population, total_cases, (total_cases/Population)*100 as PercentPopulationInfected
FROM coviddeaths
WHERE location = 'Lithuania'
ORDER by 1,2;

# Looking at Countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Population))*100 as PercentPopulationInfected
FROM coviddeaths
WHERE continent is not null
GROUP BY Location, Population
ORDER by PercentPopulationInfected DESC;

# Showing Countries with Highest Death Count per Population

SELECT Location, MAX(CAST(total_deaths as DECIMAL)) as TotalDeathCount
FROM coviddeaths
WHERE continent is not null AND location not in ('Europe', 'North America', 'European Union', 'South America', 'Africa', 'Asia')
GROUP BY Location
ORDER by TotalDeathCount DESC;

# Break down by Continent
# Showing contintents with the highest death count per population

SELECT continent, MAX(CAST(total_deaths as DECIMAL)) as TotalDeathCount
FROM coviddeaths
WHERE continent is not null AND continent not in ('')
GROUP BY continent
ORDER by TotalDeathCount DESC;

# GLOBAL NUMBERS

SELECT date, SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER by 1,2;

SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases)*100 as DeathPercentage
FROM coviddeaths
WHERE continent is not null
ORDER by 1,2;

# Total Population vs Vaccinations
# Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations as DECIMAL)) OVER (Partition by dea.Location ORDER BY dea.Location, dea.Date) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
	ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3;
 
 # Use CTE
 
WITH  PopvsVac (Continent, Location, Date, New_vaccinations, Population, RollingPeopleVaccinated)
AS 
(SELECT dea.continent, dea.location, dea.date, vac.new_vaccinations, dea.population,
SUM(CAST(vac.new_vaccinations as DECIMAL)) OVER (Partition by dea.Location ORDER BY dea.Location, dea.date ) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
	ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent is not null)

SELECT *, (RollingPeopleVaccinated/Population)*100 FROM PopvsVac;

# TEMP Table

DROP TABLE IF EXISTS PercentagePopulationVaccinated;
CREATE TABLE PercentagePopulationVaccinated
(
Continent varchar(50),
Location varchar(50),
Date datetime,
Population int,
New_vaccinations varchar(50),
RollingPeopleVaccinated varchar(50)
);

INSERT INTO PercentagePopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.Location ORDER BY dea.Location, dea.date ) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
	ON dea.location = vac.location
    AND dea.date = vac.date;

SELECT *, (RollingPeopleVaccinated/Population)*100 FROM PercentagePopulationVaccinated;

SELECT * FROM PercentagePopulationVaccinated;

# View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(vac.new_vaccinations) OVER (Partition by dea.Location ORDER BY dea.Location, dea.date ) AS RollingPeopleVaccinated
FROM coviddeaths dea
JOIN covidvaccinations vac
	ON dea.location = vac.location
    AND dea.date = vac.date
WHERE dea.continent is not null;