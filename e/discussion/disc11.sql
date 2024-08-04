#1
create table california as
    SELECT * FROM cities WHERE state = 'CA';

#2
create table younger as
    SELECT name, population FROM cities
    WHERE founded > 1840
    ORDER BY (population / area);

#3
create table same as
    SELECT a.name, b.name FROM cities as a, cities as b
    WHERE a.state = b.state AND a.area > b.area;

#4
create table percentages as
    SELECT c.name, (c.population / s.population * 100) AS percentages
    FROM cities AS c, states as s
    WHERE c.state = s.abbreviation
    ORDER BY (c.population / s.population);

#5
SELECT m.day FROM records AS r, meetings AS m
WHERE r.division = m.divition
ORDER BY m.day HAVING COUNT(*) < 5;

#6
SELECT supervisor, SUM(salary) FROM records GROUP BY supervisor;

#7
-- Pizza places that open before 1pm in alphabetical order
CREATE TABLE opening AS
    SELECT name FROM pizzas WHERE open < 13 ORDER BY name DESC;

#8
-- Pizza places and the duration of a study break that ends at 14 o'clock
CREATE TABLE study AS
    SELECT name, MAX(14 - open, 0) AS duration FROM pizzas ORDER BY duration DESC;

#9
-- Pizza places that are open for late-night-snack time and when they close
CREATE TABLE late AS
    SELECT name || ' closes at ' || close AS status FROM pizzas, meals
    WHERE meal = 'snack' AND close >= time;

#10
-- Two meals at the same place
CREATE TABLE double AS
    SELECT a.meal AS first, b.meal AS second, name
    FROM meals AS a, meals AS b, pizzas
    WHERE (b.time - a.time) > 6 AND open <= a.time AND close >= b.time;