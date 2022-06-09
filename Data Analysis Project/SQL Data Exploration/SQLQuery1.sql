Select * 
FROM SQLExploration..covid19death
order by 3,4


--Select * 
--FROM SQLExploration..covid19vaccination
--order by 3,4

-- selecting columns from table
Select Location, DATE, total_cases, new_cases, total_deaths, population 
FROM SQLExploration..covid19death
order by 1, 2

--Looking at total case vs total death
-- selecting deathpercntage  from table
Select Location, DATE, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathPercentage
FROM SQLExploration..covid19death
order by 1, 2

-- selecting deathpercntage  for USA from table
Select Location, DATE, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathPercentage
FROM SQLExploration..covid19death
where Location like '%states%'
order by 1, 2

-- selecting deathpercntage  for Nepal from table
-- shows likelihood of dying if you contract covid in your country
Select Location, DATE, total_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathPercentage
FROM SQLExploration..covid19death
where Location like '%Nepal%'
order by 1, 2


--Looking at total cases vs population
-- shows what percentage of population got COVID
Select Location, DATE, total_cases,  population, (total_cases/population)*100 as InfectionPercentage
FROM SQLExploration..covid19death
where Location like '%Nepal%'
order by 1, 2


--Looking at total cases vs population for all country
-- Shows what percentage of population got covid
Select Location, DATE, population, total_cases,   (total_cases/population)*100 as InfectionPercentage
FROM SQLExploration..covid19death
--where Location like '%Nepal%'
order by 1, 2


--Looking at countries with highest infection rate compared to population
Select Location, population, Max(total_cases) as HighInfectionCount,  Max((total_cases/population))*100 as InfectionPopulationPercentage
FROM SQLExploration..covid19death
--where Location like '%Nepal%'
group by Location, Population
order by InfectionPopulationPercentage desc

--Showing countries with highest death count per population

Select Location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is not null
-- and Location like '%Nepal%'
group by Location
order by HighestDeathCount desc

-- Breaking it by continent

Select continent, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is not null
-- and Location like '%Nepal%'
group by continent
order by HighestDeathCount desc


-- Breaking it by continent

Select location, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is null
-- and Location like '%Nepal%'
group by location
order by HighestDeathCount desc



-- Breaking it by continent
--below code has error, recheck it.
Select location, COUNT(location), MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is null and
-- Where continent like '%middle income%'
location not like '%income%'
-- and Location like '%Nepal%'
group by location
order by HighestDeathCount desc



-- Breaking it by country. this gives only exact list of countries
--below code has error, recheck it.
Select location, COUNT(location), MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is not null and
-- Where continent like '%middle income%'
location not like '%income%'
-- and Location like '%Nepal%'
group by location
order by HighestDeathCount desc


-- Breaking it by continent
--below code has error, recheck it.
Select continent, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM SQLExploration..covid19death
Where continent is not null
-- and Location like '%Nepal%'
-- group by continent
order by HighestDeathCount desc

-- Breaking it down by continent only


-- Breaking it by continent
Select location,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM SQLExploration..covid19death
Where continent is null and
-- Where continent like '%middle income%'
location not like '%income%' and 
location not like '%European%'
-- and Location like '%Nepal%'
group by location
order by TotalDeathCount desc


-- Breaking it by continent
Select continent,  MAX(cast(total_deaths as int)) as TotalDeathCount
FROM SQLExploration..covid19death
Where continent is not null 
-- Where continent like '%middle income%'
-- location not like '%income%' and 
-- location not like '%European%'
-- and Location like '%Nepal%'
group by continent
order by TotalDeathCount desc


-- Global Numbers 
select date, SUM(cast(new_deaths as int) --, SUM(cast(new_deaths as int)
FROM SQLExploration..covid19death 
where continent is not null
Group by date 
order by 1, 2

Select date, SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage
FROM SQLExploration..covid19death
Where continent is not null 
Group by date 
order by 1, 2


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths,
SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as DeathPercentage
FROM SQLExploration..covid19death
Where continent is not null 
--Group by date 
order by 1, 2

-- new table

select * 
from SQLExploration..covid19vaccination

select * 
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date


--Looking at total population vs vaccinations
select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 1, 2, 3



--Looking at total population vs vaccinations since vaccination is not null
select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.new_vaccinations is not null 
order by 1, 2, 3

-- some wrong in this code
-- check it later
-- error is Msg 8115, Level 16, State 2, Line 205
-- Arithmetic overflow error converting expression to data type int.
select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations,
SUM(convert(int, dea.new_vaccinations)) -- over (PARTITION by dea.location)
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
and dea.new_vaccinations is not null 
order by 1, 2, 3


-- Use CTE
-- some wrong in this code
-- check it later
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as 
(
select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations,
SUM(convert(int, dea.new_vaccinations))  over (PARTITION by dea.location order by dea.location, dea.Date)
as RollingPeopleVaccinated
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
-- and dea.new_vaccinations is not null 
order by  2, 3
)
Select *
from PopvsVac


-- Use CTE
-- some wrong in this code
-- check it later
With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) 
as 
(
select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations,
SUM(convert(int, dea.new_vaccinations))  over (PARTITION by dea.location order by dea.location, dea.Date)
as RollingPeopleVaccinated
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
-- and dea.new_vaccinations is not null 
order by  2, 3
)
Select *
from PopvsVac


-- Temp table
Drop Table if exists #PercentPopulationVaccinated 
Create Table #PercentPopulationVaccinated 
( continent nvarchar(255), 
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
) 
Insert into #PercentPopulationVaccinated 

select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations,
SUM(convert(int, dea.new_vaccinations))  over (PARTITION by dea.location order by dea.location, dea.Date)
as RollingPeopleVaccinated
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
-- and dea.new_vaccinations is not null 
order by  2, 3

Select * (RollingPeopleVaccinated/Population) * 100 
From #PercentPopulationVaccinated 

-- Creating view to store data for later vizualtions

Create view PercentPopulationVaccinated as 

select dea.continent, dea.location, dea.date, dea.population,  dea.new_vaccinations,
SUM(convert(int, dea.new_vaccinations))  over (PARTITION by dea.location order by dea.location, dea.Date)
as RollingPeopleVaccinated
from SQLExploration..covid19death dea
join SQLExploration..covid19vaccination vac
 on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
-- and dea.new_vaccinations is not null 
--order by  2, 3

Select * 
from PercentPopulationVaccinated