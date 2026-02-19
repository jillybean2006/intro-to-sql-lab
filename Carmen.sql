-- what finally worked (copied from terminal)


--clue 1:

➜  intro-to-sql-lab-starter-code git:(main) psql -d world
psql (16.11 (Ubuntu 16.11-0ubuntu0.24.04.1))
Type "help" for help.

world=# SELECT name, code, population
FROM countries
WHERE region = 'Southern Europe'
ORDER BY population
LIMIT 1;
             name              | code | population
-------------------------------+------+------------
 Holy See (Vatican City State) | VAT  |       1000
(1 row)

world=#



--clue 2:

world=# SELECT language
FROM countrylanguages
WHERE countrycode = 'VAT'
  AND isofficial = 'T'
ORDER BY percentage DESC
LIMIT 1;
 language
----------
 Italian
(1 row)

world=#


--clue 3:


world=# SELECT c.name, c.code, c.region, c.population
FROM countries c
JOIN countrylanguages cl ON cl.countrycode = c.code
WHERE cl.language = 'Italian'
  AND cl.isofficial = 'T'
  AND cl.percentage = 100
ORDER BY c.population
LIMIT 5;
    name    | code |     region      | population
------------+------+-----------------+------------
 San Marino | SMR  | Southern Europe |      27000
(1 row)

world=#


--clue 4:

world=# SELECT name, population
FROM cities
WHERE countrycode = 'SMR'
ORDER BY population DESC;
    name    | population
------------+------------
 Serravalle |       4802
 San Marino |       2294
(2 rows)

world=#


--clue 5:

world=# SELECT ci.name AS city, co.name AS country, co.continent
FROM cities ci
JOIN countries co
  ON co.code = ci.countrycode
WHERE co.continent = 'South America'
  AND ci.name ILIKE 'Serra%';
 city  | country |   continent
-------+---------+---------------
 Serra | Brazil  | South America
(1 row)

world=#

--clue 6:

world=# SELECT cap.name AS capital
FROM countries c
JOIN cities cap
  ON cap.id = c.capital
WHERE c.name = 'Brazil';
 capital
----------
 Brasília
(1 row)

world=#


--clue 7:

world=# SELECT ci.name AS city,
       co.name AS country,
       ci.population
FROM cities ci
JOIN countries co
  ON co.code = ci.countrycode
WHERE ci.population BETWEEN 90000 AND 92000
ORDER BY ci.population;
world=# SELECT ci.name AS city,
       ci.population
FROM cities ci
JOIN countries co ON co.code = ci.countrycode
WHERE co.name = 'Brazil'
ORDER BY ABS(ci.population - 91085)
LIMIT 10;
         city          | population
-----------------------+------------
 Campo Largo           |      91203
 Patos                 |      90519
 Ituiutaba             |      90507
 Votorantim            |      91777
 Santana do Livramento |      91779
 São Lourenço da Mata  |      91999
 Corumbá               |      90111
 Guaíba                |      92224
 Palhoça               |      89465
 Cametá                |      92779
(10 rows)

world=#

-- shes headed to Campo Largo, Brazil!

