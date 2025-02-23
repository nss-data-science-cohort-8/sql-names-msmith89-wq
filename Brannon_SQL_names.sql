
--1. How many rows are in the names table?

SELECT COUNT(*)
FROM names;

--There are 1,957,046 rows in the names table.

--2. How many total registered people appear in the dataset?

SELECT SUM(num_registered)
FROM names;

--There are 351,653,025 registered people that appear in the dataset.

--3. Which name had the most appearances in a single year in the dataset?

SELECT *
FROM names
ORDER BY num_registered DESC
LIMIT 1;

--The name Linda had the most appearances in a single year, which is 1947.

--4. What range of years are included?

SELECT  MIN(year) AS minimum_year, MAX(year) AS maximum_year
FROM names;

--The years range from 1880 to 2018

SELECT (MAX(year) - MIN(year)) AS year_range
FROM names;

--The range of years is 138.

--5. What year has the largest number of registrations?

SELECT year, SUM(num_registered) AS reg_per_year
FROM names
GROUP BY year
ORDER BY reg_per_year DESC
LIMIT 1;

--1957 had the largest number of registrations at 4,200,022

--6. How many different (distinct) names are contained in the dataset?

SELECT COUNT(DISTINCT name) AS name_count
FROM names;

--There 98,400 different names in the dataset.

--7. Are there more males or more females registered?

SELECT gender, SUM(num_registered) AS gender_sum
FROM names
GROUP BY gender;

--The are more males registered than females.

SELECT SUM(num_registered) - LAG(SUM(num_registered)) OVER (ORDER BY gender) AS gender_reg_diff
FROM names
GROUP BY gender;

--There are 3,494,561 more males registered than females.

--8. What are the most popular male and female names overall (i.e., the most total registrations)?

SELECT name, SUM(num_registered) AS pop_name
FROM names
WHERE gender = 'M'
GROUP BY name
ORDER BY pop_name DESC
LIMIT 1;

SELECT name, SUM(num_registered) AS pop_name
FROM names
WHERE gender = 'F'
GROUP BY name
ORDER BY pop_name DESC
LIMIT 1;

--The popular male name is James and the most popular female name is Mary, according to the dataset.

--9. What are the most popular boy and girl names of the first decade of the 2000s (2000 - 2009)?

SELECT name, SUM(num_registered) AS pop_name
FROM names
WHERE gender = 'M'
AND year BETWEEN 2000 AND 2009
GROUP BY name
ORDER BY pop_name DESC
LIMIT 1;

SELECT name, SUM(num_registered) AS pop_name
FROM names
WHERE gender = 'F'
AND year BETWEEN 2000 AND 2009
GROUP BY name
ORDER BY pop_name DESC
LIMIT 1;

-- Jacob is the most popular boy name and Emily is the most popular girl name during 2000-2009.

--10. Which year had the most variety in names (i.e. had the most distinct names)?

SELECT year, COUNT(DISTINCT name) AS year_name_variety_count
FROM names
GROUP BY year
ORDER BY year_name_variety_count DESC
LIMIT 1;

--2008 had the largest variety in names.

--11. What is the most popular name for a girl that starts with the letter X?

SELECT name, SUM(num_registered) AS girl_name_X_pop
FROM names
WHERE gender = 'F'
AND name LIKE 'X%'
GROUP BY name
ORDER BY girl_name_X_pop DESC
LIMIT 1;

--Ximena is the most popular name for a girl that starts with X.

--12. Write a query to find all (distinct) names that start with a 'Q' but whose second letter is not 'u'.

SELECT DISTINCT name
FROM names
WHERE name LIKE 'Q%'
AND name NOT LIKE 'Qu%';

--13. Which is the more popular spelling between "Stephen" and "Steven"? Use a single query to answer this question.

SELECT name, SUM(num_registered) AS name_pop
FROM names
WHERE name = 'Stephen'
OR name = 'Steven'
GROUP BY name;

--Steven is the more popular name according to the query.

--14. Find all names that are "unisex" - that is all names that have been used both for boys and for girls.

SELECT DISTINCT gender, name
FROM names
WHERE name IN
(SELECT name
 FROM names
 WHERE gender = 'F')
AND name IN
 (SELECT name
  FROM names
  WHERE gender = 'M')
ORDER BY name, gender;

--15. Find all names that have made an appearance in every single year since 1880.

SELECT name, year
FROM names
WHERE name IN
 (SELECT name
  FROM names
  GROUP BY name
  HAVING COUNT(DISTINCT year) = (SELECT COUNT(DISTINCT year) FROM names))
ORDER BY name, year;   

--16. Find all names that have only appeared in one year.

SELECT name, year
FROM names
WHERE name IN
(SELECT name
 FROM names
 GROUP BY name
 HAVING COUNT(DISTINCT year) = 1)
ORDER BY name;

--17. Find all names that only appeared in the 1950s.

SELECT name, MIN(year), MAX(year)
FROM names
GROUP BY name
HAVING MIN(year) >= 1950
AND MAX(year) <= 1959
ORDER BY name;

--18. Find all names that made their first appearance in the 2010s.

SELECT name, MIN(year), MAX(year)
FROM names
GROUP BY name
HAVING MIN(year) >= 2010
AND MAX(year) <= 2018
ORDER BY name;


--19. Find the names that have not be used in the longest.

SELECT name, MAX(year) AS last_year_used
FROM names
GROUP BY name
ORDER BY last_year_used;

--20. Come up with a question that you would like to answer using this dataset. Then write a query to answer this question.




