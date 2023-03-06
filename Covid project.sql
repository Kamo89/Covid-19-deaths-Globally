SELECT * FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL;
SELECT * FROM COVID_VACCINATIONS
WHERE CONTINENT IS NOT NULL;

--Select data that will be using first
SELECT LOCATION, DATES,TOTAL_CASES, NEW_CASES, TOTAL_DEATHS, POPULATION
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
ORDER BY 1,2;

--reviewing total_cases vs total_deaths
--basically shows the likelyhood of dying if you contract covid in South Africa
SELECT LOCATION, DATES,TOTAL_CASES, TOTAL_DEATHS, (total_deaths/total_cases) * 100 as Death_Percentage
FROM COVID_DEATHS
WHERE location like 'South Africa'
ORDER BY 1,2;

--reviewing total_cases vs population
--basically shows percentage of popultaion infected by covid
SELECT LOCATION, DATES,TOTAL_CASES,POPULATION,(total_cases/population) * 100 as Infected_Population
FROM COVID_DEATHS
--WHERE location like 'South Africa'
ORDER BY 1,2;

--Which country has the hisghest infection rate compared to population
SELECT LOCATION, POPULATION,MAX(total_cases) as highest_Infection, MAX(total_cases/population) * 100 as PerPopulation_infected
FROM COVID_DEATHS
--WHERE location like 'South Africa'
Group by Location, Population
ORDER BY PerPopulation_infected desc

--showing countries with the highest death count
SELECT LOCATION, MAX(total_cases) as Total_deathCount
FROM COVID_DEATHS
WHERE CONTINENT IS NOT NULL
GROUP BY LOCATION
ORDER BY TOTAL_deathCount desc;

--Using Global Numbers
--Selectin the total_case amd the Total_deaths to get the over roll percentage of those that died
SELECT SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases) * 100 as Death_Percentage
From COVID_DEATHS
WHERE CONTINENT IS NOT NULL
ORDER BY 1,2

--Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
SELECT COVID_DEATHS.CONTINET,
COVID_DEATHS.LOCATION,
COVID_DEATHS.POPULATION,
COVID_VACCINATIONS.NEW_VACCINATIONS,
SUM(COVID_VACCINATION.NEW_VACCINATIONS) OVER (PARTITION BY COVID_DEATHS.LOCATION ORCER BY COVID_DEATHS.LOCATION, COVID_DEATHS.DATES) AS Rolling_PeoVac
FROM COVID_DEATHS
JOING COVID_VACCINATIONS
    ON COVID_DEATHS.LOCATION = COVID_VACCINATION.LOCATION
WHERE COVID_DEATHS.CONTINENT IS NOT NULL
ORDER BY 2,3


