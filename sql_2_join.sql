# SQL Join exercise
#
#
# 1: Get the cities with a name starting with ping sorted by their population with the least populated cities first
SELECT * FROM world.city WHERE Name LIKE "ping%" ORDER BY Population ASC;
#
# 2: Get the cities with a name starting with ran sorted by their population with the most populated cities first
SELECT * FROM world.city WHERE Name LIKE "ran%" ORDER BY Population DESC;
#
# 3: Count all cities
SELECT Count(*) FROM world.city;
#
# 4: Get the average population of all cities
SELECT AVG(Population) FROM world.city;
#
# 5: Get the biggest population found in any of the cities
SELECT MAX(Population) FROM world.city;
#
# 6: Get the smallest population found in any of the cities
SELECT MIN(Population) FROM world.city;
#
# 7: Sum the population of all cities with a population below 10000
SELECT SUM(Population) FROM world.city WHERE Population < 10000;
#
# 8: Count the cities with the countrycodes MOZ and VNM
SELECT Count(*) FROM world.city WHERE CountryCode IN ('MOZ', 'VNM');
#
# 9: Get individual count of cities for the countrycodes MOZ and VNM
SELECT Count(*) AS count FROM world.city WHERE CountryCode IN ('MOZ', 'VNM') GROUP BY CountryCode;
#
# 10: Get average population of cities in MOZ and VNM
SELECT AVG(Population) FROM world.city WHERE CountryCode IN ('MOZ', 'VNM');
#
# 11: Get the countrycodes with more than 200 cities
SELECT CountryCode FROM world.city GROUP BY CountryCode HAVING COUNT(*) > 200;
#
# 12: Get the countrycodes with more than 200 cities ordered by city count
SELECT CountryCode FROM world.city GROUP BY CountryCode HAVING COUNT(*) > 200 ORDER BY COUNT(*);
#
# 13: What language(s) is spoken in the city with a population between 400 and 500 ?
SELECT cl.Language
FROM world.city ci
INNER JOIN world.countrylanguage  cl
ON ci.CountryCode = cl.CountryCode
WHERE ci.Population BETWEEN 400 AND 500;
#
# 14: What are the name(s) of the cities with a population between 500 and 600 people and the language(s) spoken in them
SELECT ci.Name, cl.Language
FROM world.city ci
INNER JOIN world.countrylanguage cl
ON ci.CountryCode = cl.CountryCode
WHERE ci.Population BETWEEN 500 AND 600;
#
# 15: What names of the cities are in the same country as the city with a population of 122199 (including the that city itself)
SELECT ci.Name
FROM world.city ci
WHERE ci.CountryCode = (
    SELECT c.CountryCode
    FROM world.city c
    WHERE c.Population = 122199
)
#
# 16: What names of the cities are in the same country as the city with a population of 122199 (excluding the that city itself)
SELECT ci.Name
FROM world.city ci
WHERE ci.CountryCode = (
    SELECT c.CountryCode
    FROM world.city c
    WHERE c.Population = 122199
)
AND ci.Population != 122199;
#
# 17: What are the city names in the country where Luanda is capital?
SELECT ci.Name
FROM world.city ci
JOIN world.country c ON ci.CountryCode = c.Code
WHERE c.Capital = (
    SELECT ci2.ID
    FROM world.city ci2
    WHERE ci2.Name = 'Luanda'
);

#
# 18: What are the names of the capital cities in countries in the same region as the city named Yaren
SELECT c2.Name AS capital
FROM world.city c2
JOIN world.country c1 ON c1.Region = (
    SELECT c1.Region
    FROM world.city c
    JOIN world.country c1 ON c.CountryCode = c1.Code
    WHERE c.Name = 'Yaren'
)
WHERE c2.ID = c1.Capital;
#
# 19: What unique languages are spoken in the countries in the same region as the city named Riga
SELECT DISTINCT cl.Language
FROM world.countrylanguage cl
JOIN world.country c1 ON cl.CountryCode = c1.Code
WHERE c1.Region = (
    SELECT c2.Region
    FROM world.city ci
    JOIN world.country c2 ON ci.CountryCode = c2.Code
    WHERE ci.Name = 'Riga'
);
#
# 20: Get the name of the most populous city
SELECT Name
FROM world.city
ORDER BY Population DESC
LIMIT 1;

