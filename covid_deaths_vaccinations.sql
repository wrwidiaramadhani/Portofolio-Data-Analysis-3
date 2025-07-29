-- Create Covid Deaths Table
CREATE TABLE covid_deaths(
	covid_deaths_id SERIAL PRIMARY KEY,
	iso_code VARCHAR(10),
	continent VARCHAR(25),
	location VARCHAR(25),
	date TIMESTAMP,
	population NUMERIC,
	total_case NUMERIC,
	new_case NUMERIC,
	new_cases_smoothed NUMERIC,
	toatl_death NUMERIC,
	new_death NUMERIC,
	new_date_smoothed NUMERIC,
	total_case_per_million NUMERIC,
	new_cases_per_million NUMERIC,
	new_cases_smoothed_per_million NUMERIC,
	total_deaths_per_million NUMERIC,
	new_deaths_per_million NUMERIC,
	new_deaths_smoothed_per_million NUMERIC,
	reproduction_rate NUMERIC,
	icu_patients NUMERIC,
	icu_patients_per_million NUMERIC,
	hosp_patients NUMERIC,
	hosp_patients_per_million NUMERIC,
	weekly_icu_admissions NUMERIC,
	weekly_icu_admissions_per_million NUMERIC,
	weekly_hosp_admissions NUMERIC,
	weekly_hosp_admissions_per_million NUMERIC		
);


-- Modify Column Type
ALTER TABLE covid_deaths
ALTER COLUMN continent TYPE VARCHAR(50),
ALTER COLUMN location TYPE VARCHAR(50)


-- Check database that has been created
SELECT * 
FROM covid_deaths


-- Create Table Covid Vaccinations
CREATE TABLE covid_vaccinations(
	
)

-- Create Covid Vaccinations Table
CREATE TABLE covid_vaccinations(
	covid_vaccincation_id SERIAL PRIMARY KEY,
	iso_code VARCHAR(10),
	continent VARCHAR(50),
	location VARCHAR(50),
	date TIMESTAMP,
	new_tests NUMERIC,
	total_tests NUMERIC,
	total_tests_per_thousand NUMERIC,
	new_tests_per_thousand NUMERIC,
	new_tests_smoothed NUMERIC,
	new_tests_smoothed_per_thousand NUMERIC,
	positive_rate NUMERIC,
	tests_per_case NUMERIC,
	tests_units VARCHAR (100),
	total_vaccinations NUMERIC,
	people_vaccinated NUMERIC,
	people_fully_vaccinated NUMERIC,
	new_vaccinations NUMERIC,
	new_vaccinations_smoothed NUMERIC,
	total_vaccinations_per_hundred NUMERIC,
	people_vaccinated_per_hundred NUMERIC,
	people_fully_vaccinated_per_hundred NUMERIC,
	new_vaccinations_smoothed_per_million NUMERIC,
	stringency_index NUMERIC,
	population_density NUMERIC,
	median_age NUMERIC,
	aged_65_older NUMERIC,
	aged_70_older NUMERIC,
	gdp_per_capita NUMERIC,
	extreme_poverty NUMERIC,
	cardiovasc_death_rate NUMERIC,
	diabetes_prevalence NUMERIC,
	female_smokers NUMERIC,
	male_smokers NUMERIC,
	handwashing_facilities NUMERIC,
	hospital_beds_per_thousand NUMERIC,
	life_expectancy NUMERIC,
	human_development_index NUMERIC
);


-- Check database that has been created
SELECT * 
FROM covid_vaccinations

-- Setting Datestyle to MDY (Becaus defaul setting in pgadmin is YMD)
SET datestyle TO 'ISO, MDY';
-- other setting way:
-- SET datestyle TO 'US';


-- Import Covid Deaths Dataset
COPY covid_deaths(
	iso_code,
	continent,
	location,
	date,
	population,
	total_case,
	new_case,
	new_cases_smoothed,
	toatl_death,
	new_death,
	new_date_smoothed,
	total_case_per_million,
	new_cases_per_million,
	new_cases_smoothed_per_million,
	total_deaths_per_million,
	new_deaths_per_million,
	new_deaths_smoothed_per_million,
	reproduction_rate,
	icu_patients,
	icu_patients_per_million,
	hosp_patients,
	hosp_patients_per_million,
	weekly_icu_admissions,
	weekly_icu_admissions_per_million,
	weekly_hosp_admissions,
	weekly_hosp_admissions_per_million		
)
FROM 'D:\Data Analysis\Analysis Data with Microsoft Excel\Portofolio\covid_deaths.csv'
CSV
HEADER;


-- Check Imported Dataset
SELECT *
FROM covid_deaths


-- Import Covid Vaccinations Dataset
COPY covid_vaccinations(
	iso_code,
	continent,
	location,
	date,
	new_tests,
	total_tests,
	total_tests_per_thousand,
	new_tests_per_thousand,
	new_tests_smoothed,
	new_tests_smoothed_per_thousand,
	positive_rate,
	tests_per_case,
	tests_units,
	total_vaccinations,
	people_vaccinated,
	people_fully_vaccinated,
	new_vaccinations,
	new_vaccinations_smoothed,
	total_vaccinations_per_hundred,
	people_vaccinated_per_hundred,
	people_fully_vaccinated_per_hundred,
	new_vaccinations_smoothed_per_million,
	stringency_index,
	population_density,
	median_age,
	aged_65_older,
	aged_70_older,
	gdp_per_capita,
	extreme_poverty,
	cardiovasc_death_rate,
	diabetes_prevalence,
	female_smokers,
	male_smokers,
	handwashing_facilities,
	hospital_beds_per_thousand,
	life_expectancy,
	human_development_index
)
FROM 'D:\Data Analysis\Analysis Data with Microsoft Excel\Portofolio\covid_vaccinations.csv'
CSV
HEADER;





-- Check Imported Dataset
SELECT *
FROM covid_vaccinations

SELECT * 
FROM covid_vaccinations


-- Cek Column and Data Type of The Table Created
SELECT 
	column_name,
	data_type,
	is_nullable, 
	character_maximum_length,
	numeric_precision,
	numeric_scale
FROM 
	information_schema.columns
WHERE
	table_schema = 'public'
	AND table_name = 'covid_deaths'
ORDER BY
	ordinal_position

-- Select Data will be Used
SELECT 
	continent,
	location, 
	date,
	total_case,
	total_death,
	population
FROM covid_deaths
WHERE continent = 'Asia'
ORDER BY 2,3


-- Select All information that Continent Is Not Null
SELECT *
FROM covid_deaths
WHERE continent IS NOT NULL
ORDER BY continent ASC


-- Total Cases vs Total Death in Asia
-- Mengetahui kemungkinan peluang meninggal di Asia
SELECT 
	continent,
	location,
	date,
	total_case,
	total_death,
	(total_death/total_case) * 100 
	AS death_percentage
FROM covid_deaths
WHERE continent = 'Asia'
ORDER BY 2,3


-- Summary of Total Cases & Deaths by Location
-- Mengetahui ringkasan jumlah orang yang terkena covid & meninggal berdasarkan continent di Asia
SELECT 
	continent,
	location,
	SUM(total_case) AS grand_total_cases,
	SUM(total_death) AS grand_total_deaths
FROM covid_deaths
WHERE continent = 'Asia'
GROUP BY 1,2
ORDER BY 3 DESC


-- Total Cases vs Population in Asia
-- Mengetahui persentase terkena covid dari keseluruhan populasi
SELECT 
	continent,
	location,
	date,
	total_case,
	population,
	(total_case/population) * 100 
	AS population_infected_percentage
FROM covid_deaths
WHERE continent = 'Asia'
ORDER BY 3 ASC



-- Shows Total ICU Patient at Countries in Asia 
SELECT 
	continent,
	location,
	SUM(icu_patients) AS total_icu_patients
FROM covid_deaths
WHERE continent = 'Asia'
GROUP BY 1,2


-- Showing The Highest Infection Cases in each Country in Asia (Compared to Population)
SELECT 
	location, 
	population,
	MAX(total_case) AS highest_infection,
	MAX(total_case/population) * 100 
	AS population_infected_percentage
FROM covid_deaths
WHERE continent = 'Asia'
GROUP BY 1,2
ORDER BY 4 DESC


-- Showing Countries with Highest Death Count per Population
SELECT 
	location,
	MAX(total_death) AS total_death_count
FROM covid_deaths
WHERE continent = 'Asia'
GROUP BY 1
ORDER BY 2 DESC


-- Showing the highest death count on every continent
SELECT 
	continent,
	MAX(total_death) AS highest_death_count
FROM covid_deaths
Where continent IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC


-- Showing Total New Cases, Total New Death, and Death Percentage per Location
-- Continent = 'Asia'

-- With CTE
WITH total_new_case_death AS(
	SELECT 
		location,
		SUM(new_case) AS total_case,
		SUM(new_death) AS total_death
	FROM covid_deaths
	WHERE continent = 'Asia'
	GROUP BY 1
)
	SELECT 
		location,
		total_case,
		total_death,
		total_death/total_case AS death_percentage
	FROM total_new_case_death
	ORDER BY 2 DESC
	

-- Another Way
SELECT 
	location,
	SUM(new_case) AS total_case,
	SUM(new_death) AS total_death,
	(SUM(new_case))/(SUM(new_death)) AS death_percentage
FROM covid_deaths
WHERE continent = 'Asia'
GROUP BY 1
ORDER BY 2,3 DESC


	
	

-- Showing Grand Total New Cases, Total New Death, and Death Percentage
-- Continent = 'Asia'
WITH total_new_case_death AS(
	SELECT 
		SUM(new_case) AS total_case,
		SUM(new_death) AS total_death
	FROM covid_deaths
	WHERE continent = 'Asia'
)
	SELECT 
		total_case,
		total_death,
		total_death/total_case AS death_percentage
	FROM total_new_case_death

		
-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT 
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cvac.new_vaccinations,
	SUM(cvac.new_vaccinations) 
	OVER(PARTITION BY cd.location ORDER BY cd.location, cd.date) 
	AS rolling_people_vaccinated
FROM covid_deaths cd
JOIN covid_vaccinations cvac
	ON cd.location = cvac.location
	and cd.date = cvac.date
WHERE cd.continent = 'Asia' AND new_vaccinations IS NOT NULL
ORDER BY 2


-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine
-- Using CTE to perform calculation on Partition By in previous query
WITH pop_vs_vac AS (
	SELECT 
		cd.continent,
		cd.location,
		cd.date,
		cd.population,
		cvac.new_vaccinations,
		SUM(cvac.new_vaccinations) 
		OVER(PARTITION BY cd.location ORDER BY cd.location, cd.date)
		AS rolling_people_vaccinated
	FROM covid_deaths cd
	JOIN covid_vaccinations cvac
		ON cd.location = cvac.location
		AND cd.date = cvac.date
	WHERE cd.continent = 'Asia' AND new_vaccinations IS NOT NULL
)
	SELECT *,
		(rolling_people_vaccinated/population) * 100 AS vaccinated_percentage
	FROM pop_vs_vac
	ORDER BY (rolling_people_vaccinated/population) * 100 DESC


-- Create Table Temporary #PercentPopulationVaccinated
-- This table is result of previous query
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated(
	Continent VARCHAR(255),
	Location VARCHAR(255),
	Date TIMESTAMP,
	Population NUMERIC,
	New_vaccinations NUMERIC,
	Rolling_people_vaccinated NUMERIC
);


-- Insert Data for Table Temporary from Previous Query
INSERT INTO PercentPopulationVaccinated(
	continent,
	location,
	date,
	population,
	new_vaccinations,
	rolling_people_vaccinated
)
SELECT 
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cvac.new_vaccinations,
	SUM(cvac.new_vaccinations) 
	OVER (PARTITION BY cd.location, cd.date) 
	AS rolling_people_vaccinated
FROM covid_deaths cd
JOIN covid_vaccinations cvac
	ON cd.location = cvac.location
	AND cd.date = cvac.date

SELECT *,
	(rolling_people_vaccinated/population) * 100 AS vaccinated_percentage
FROM PercentPopulationVaccinated


-- Test Temporary Table
SELECT *
FROM PercentPopulationVaccinated

-- Creating View to Store Data for Later Visualizations
CREATE VIEW PercentPopulationVaccinated AS
SELECT 
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cvac.new_vaccinations,
	SUM(cvac.new_vaccinations) OVER (PARTITION BY cd.location, cd.date) 
	AS rolling_people_vaccinated
FROM covid_deaths cd
JOIN covid_vaccinations cvac
	ON cd.location = cvac.location
	AND cd.date = cvac.date
WHERE cd.continent IS NOT NULL


-- How to use View
SELECT 
	location,
	rolling_people_vaccinated,
	(rolling_people_vaccinated/population) * 100 AS vaccinated_percentage
FROM PercentPopulationVaccinated
WHERE rolling_people_vaccinated > (rolling_people_vaccinated/population) * 100 




	





	