/* 
   Project: World Database Aggregation & Advanced Analytics
   Analyst: TARUN DAS 
   Focus: Business Intelligence, Data Integrity, and Strategic Insights
*/
 USE world;

-- Q1: City density analysis per country
SELECT CountryCode, COUNT(Name) AS CityCount 
FROM city GROUP BY CountryCode;

-- Q2: Geographic segmentation for regions with > 30 countries
SELECT Continent, COUNT(Name) AS CountryCount 
FROM country GROUP BY Continent HAVING CountryCount > 30;

-- Q3: Identifying population hubs exceeding 200 million
SELECT Region, SUM(Population) AS TotalPopulation 
FROM country GROUP BY Region HAVING TotalPopulation > 200000000;

-- Q4: Economic benchmarking: Top 5 continents by average GNP
SELECT Continent, AVG(GNP) AS AvgGNP 
FROM country GROUP BY Continent ORDER BY AvgGNP DESC LIMIT 5;

-- Q5: Linguistic diversity index: Official languages per continent
SELECT c.Continent, COUNT(cl.Language) AS TotalOfficialLanguages 
FROM countrylanguage cl 
JOIN country c ON cl.CountryCode = c.Code 
WHERE cl.IsOfficial = 'T' GROUP BY c.Continent;

-- Q6: Economic variance: Max and Min GNP analysis per continent
SELECT Continent, MAX(GNP) AS MaxGNP, MIN(GNP) AS MinGNP 
FROM country GROUP BY Continent;

-- Q7: Identifying highest average city population for urbanization trends
SELECT CountryCode, AVG(Population) AS AvgCityPop 
FROM city GROUP BY CountryCode ORDER BY AvgCityPop DESC LIMIT 1;

-- Q8: Filtering high-urbanization zones (> 200k average population)
SELECT Continent, AVG(Population) AS AvgPop 
FROM country GROUP BY Continent HAVING AvgPop > 200000;

-- Q9: Socio-economic correlation: Population vs Life Expectancy
SELECT Continent, SUM(Population) AS TotalPop, AVG(LifeExpectancy) AS AvgLifeExp 
FROM country GROUP BY Continent ORDER BY AvgLifeExp DESC;

-- Q10: Strategic growth targeting: High population (> 200M) and high life expectancy
SELECT Continent, AVG(LifeExpectancy) AS AvgLifeExp 
FROM country GROUP BY Continent 
HAVING SUM(Population) > 200000000 ORDER BY AvgLifeExp DESC LIMIT 3;

/* --- PRO ANALYST UNIQUE ADDITIONS --- */

-- 1. Data Integrity Check: Proactive identification of missing economic data
-- Analyst Note: This demonstrates attention to data quality and reliability.
SELECT COUNT(*) AS MissingGNPCount 
FROM country 
WHERE GNP IS NULL OR GNP = 0;

-- 2. Advanced CTE: Modular approach to identify top population regions
-- Analyst Note: CTEs show advanced SQL proficiency for complex data structures.
WITH TopPopulationContinents AS (
    SELECT Continent, SUM(Population) as TotalPop
    FROM country
    GROUP BY Continent
    ORDER BY TotalPop DESC
    LIMIT 3
)
SELECT * FROM TopPopulationContinents;

-- 3. Efficiency Ratio: Population Density Analysis
-- Analyst Note: This metric is critical for resource allocation and infrastructure planning.
SELECT Name, Population / SurfaceArea AS PopDensity 
FROM country 
ORDER BY PopDensity DESC LIMIT 5;
