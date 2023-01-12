-- 1. Hent ut alle byer som begynner og slutter på 'o' (stor bokstav først, liten bakerst) 
-- og deres befolkningstall. Sorter de alfabetisk. (Trenger foreløpig ikke JOIN. 
-- Tips: Husker du wildcards fra tidligere?) 

SELECT name, population
FROM city
WHERE name LIKE 'O%o'
ORDER BY name ASC;


/* 2. Ta resultatet fra oppgave 1 og å få med navnet på landet som byene ligger i. 
Landet skal listes ut som en ny, første kolonne. Kolonnene blir altså: landsnavn, bynavn og bybefolkning. 
Vi ønsker svaret sortert alfabetisk på land, deretter på by. */

SELECT country.name AS "landsnavn", city.name AS "bynavn", city.population as "bybefolkning"
FROM city
JOIN country ON country.code = city.countrycode
WHERE city.name LIKE 'O%o'
ORDER BY country.name ASC, city.name ASC;

/* 3. Hent ut alle land og deres (eventuelle) hovedsteder. 
Sorter resultatet på kontinent, og deretter alfabetisk på landets navn. */

SELECT country.name AS "country", city.name, continent
FROM country
JOIN city ON city.id = country.capital
ORDER BY continent ASC, country.name ASC;


/* 4. Hent ut en oversikt over alle land som har minst én by, hvor mange byer de har og 
gjennomsnittlig innbyggertall i disse byene.  */

SELECT country.name, COUNT(city.name) AS "number of cities", ROUND(AVG(city.population)) AS "avg population"
FROM country
JOIN city on city.countrycode = country.code
GROUP BY country.name
HAVING COUNT(city.name) >= 1
ORDER BY COUNT(city.name)


/* 5. Få opp alle land og alle deres byer, der innbyggertallet i landet er under 
1000.  Vi vil se navnet på landet, befolkningen i landet, hvilket kontinent landet 
tilhører, navnet på evt. byer der, befolkning i evt. byer der. Vi ønsker resultatet sortert 
alfabetisk etter landenes navn. (Hint: Mitt svar gir 10 rader ut, er det samme antall rader du 
får?)  */

SELECT country.name AS "country name", 
country.population AS "country population", 
country.continent, 
city.name AS "city name", 
city.population AS "city population"
FROM country 
LEFT JOIN city on city.countrycode = country.code
WHERE country.population < 1000
ORDER BY country.name


/* 6. Ranger byene i verden som ligger i et land med en eller annen form for monarkisk styresett 
etter folketall. Den mest folkerike byen først. */

SELECT country.name AS "country", 
governmentform, 
city.name AS " city name", 
city.population AS "city population"
from country
RIGHT join city on city.countrycode = country.code
WHERE governmentform LIKE ('%Monarch%')
ORDER BY city.population DESC


/* 7. Hent ut en liste med byer i verden som har minst 8.000.000 innbyggere, og hvilket kontinent 
de tilhører. Sorter etter innbyggertall, største først. 
Altså: byens navn, byens innbyggere og hvilket kontinent de tilhører.  */

SELECT continent, 
city.name AS "city name", 
city.population AS "city population"
from country
left join city on city.countrycode = country.code
WHERE city.population > 8000000
ORDER BY city.population DESC


/* 8. Lag en spørring som henter ut en oversikt over de landene i Asia der det snakkes minst 10 
forskjellige språk. Spørringen skal hente ut: Navn på land, antall språk og dette skal sorteres 
synkende på antall språk.   */

SELECT name, COUNT(language) 
from country
join countrylanguage on countrylanguage.countrycode = country.code
GROUP BY country.name
HAVING COUNT(language) >= 10
ORDER BY COUNT(language) dESC