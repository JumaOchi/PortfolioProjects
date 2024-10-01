USE PortfolioProject;

--  DESCRIBE covid_deaths; Not supported on SQL Server

sp_help 'covid_deaths';


SELECT * FROM covid_deaths
ORDER BY 3, 4

-- SELECT * FROM covid_vaccinations
-- ORDER BY 3, 4 

 -- Selecting the data we will be working with

 SELECT location, date, total_cases, new_cases, total_deaths, population
 FROM covid_deaths ORDER BY 1,2 ;

 -- looking at total cases Vs Death (Deathpercentage)


SELECT location, date, total_cases, total_deaths,
    CASE 
        WHEN total_cases IS NULL OR total_deaths IS NULL THEN NULL
        WHEN total_cases = 0 THEN 0
        ELSE (CAST(total_deaths AS DECIMAL(12,2)) / CAST(total_cases AS DECIMAL(12, 2))) * 100
    END AS deathpercentage
FROM covid_deaths
WHERE location like '%Kenya%'
ORDER BY 1, 2;
-- Looking at Total cases vs Population (Prevalence or infection rate)

SELECT location, date, total_cases, population,
CASE
	WHEN total_cases = 0 THEN 0
    ELSE (CAST(total_cases AS DECIMAL(12,2)) / CAST(population AS DECIMAL(12, 2))) * 100
END AS infectionrate
FROM covid_deaths
-- WHERE location like '%Kenya%'
ORDER BY 1, 2;

-- Looking at countries with the highest Infection Rate Compared to population

SELECT location, population, MAX(total_cases) as HighestInfectionCount,
MAX((CAST(total_cases AS DECIMAL(12,2)) / CAST(population AS DECIMAL(12, 2))) * 100)
AS highestinfectionrate
FROM covid_deaths
-- WHERE location like '%Kenya%'
GROUP BY location, population
ORDER BY highestinfectionrate DESC;

-- Showing countries with highest death count per population

SELECT location, population, MAX(total_deaths) as HighestDeathCount,
MAX((CAST(total_deaths AS DECIMAL(12,2)) / CAST(population AS DECIMAL(12, 2))) * 100)
AS highestdeathrate
FROM covid_deaths
-- WHERE location like '%Kenya%'
WHERE continent is not null
GROUP BY location, population
ORDER BY HighestDeathCount DESC;

-- Showing Continents with the highest deathCount

SELECT continent, max(total_deaths) as HighestDeathCount
FROM covid_deaths
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount DESC;

-- GLOBAL NUMBERS


SELECT date,
    SUM(SUM(new_cases)) OVER (ORDER BY date) as cumulative_cases,
    SUM(SUM(cast(new_deaths as int))) OVER (ORDER BY date) as cumulative_deaths
	--CASE
	--	WHEN SUM(new_cases) = 0 THEN 0
	--	ELSE SUM(CAST(new_deaths AS int))/SUM(new_cases) * 100 
	--END	AS deathPercentage
FROM covid_deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;


-- Looking at total population vs vaccinations

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
AS cumulative_vaccinations
FROM covid_deaths dea
 INNER JOIN covid_vaccinations vac
 ON dea.location = vac.location and dea.date = vac.date
 WHERE dea.continent is not null
 order by 2, 3;

 -- USING CTE to get the vaccinated vs population
  
 with popvsvac ( continent, location, date, population,new_vaccinations, Cumulative_vaccinations)
 as 
(SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
AS cumulative_vaccinations
FROM covid_deaths dea
 INNER JOIN covid_vaccinations vac
 ON dea.location = vac.location and dea.date = vac.date
 WHERE dea.continent is not null)
 --order by 2, 3);

 SELECT * FROM popvsvac


 -- TEMP TABLES

CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
Cumulative_vaccinations numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
AS cumulative_vaccinations
FROM covid_deaths dea
 INNER JOIN covid_vaccinations vac
 ON dea.location = vac.location and dea.date = vac.date
 WHERE dea.continent is not null

 SELECT *, (Cumulative_vaccinations/population) * 100
 FROM #PercentPopulationVaccinated

 --CREATING VIEW to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated as
 SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CONVERT(bigint, vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.date)
AS cumulative_vaccinations
FROM covid_deaths dea
 INNER JOIN covid_vaccinations vac
 ON dea.location = vac.location and dea.date = vac.date
 WHERE dea.continent is not null

 SELECT * FROM PercentPopulationVaccinated