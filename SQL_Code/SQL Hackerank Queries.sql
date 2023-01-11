-- Query all columns (attributes) for every row in the CITY table.
-- The CITY table is described as follows:
SELECT * 
FROM CITY


-- Query all columns for a city in CITY with the ID 1661.

SELECT * 
FROM CITY
WHERE ID = 1661

--Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.
-- The STATION table is described as follows:

SELECT COUNT(city) - COUNT(DISTINCT city)
from station

--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
-- The STATION table is described as follows:


SELECT city,LENGTH(city) FROM station WHERE LENGTH(city)=(SELECT MIN(LENGTH(city)) FROM station) ORDER BY city LIMIT 1;
SELECT city,LENGTH(city) FROM station WHERE LENGTH(city)=(SELECT MAX(LENGTH(city)) FROM station) ORDER BY city LIMIT 1

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
select  DISTINCT CITY from STATION where CITY rlike '^[a,e,i,o,u]'

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

select  DISTINCT CITY from STATION where CITY rlike '[a,e,i,o,u]$'

-- Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
-- Your result cannot contain duplicates.

select  DISTINCT CITY from STATION where CITY rlike '^[a,e,i,o,u].*[a,e,i,o,u]$';

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.

select  DISTINCT CITY from STATION where CITY not rlike '^[a,e,i,o,u]'

-- Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.
select  DISTINCT CITY from STATION where CITY not rlike '[a,e,i,o,u]$'


-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
-- Your result cannot contain duplicates.

select  DISTINCT CITY from STATION where CITY not rlike '^[a,e,i,o,u].*[a,e,i,o,u]$';

--Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. 
-- Your result cannot contain duplicates.

select  DISTINCT CITY from STATION where CITY not rlike '^[a,e,i,o,u]' and
 CITY not rlike '[a,e,i,o,u]$'

