#1
CREATE TABLE number_of_options AS
    SELECT COUNT(DISTINCT meat) FROM main_course;

#2
CREATE TABLE calories AS
    SELECT COUNT(*) FROM main_course AS m, pies AS p
    WHERE m.calories + p.calories < 2500;

#3
CREATE TABLE healthiest_meats AS
    SELECT meat, MIN(m.calories + p.calories) AS calories
    FROM main_course AS m, pies AS p
    GROUP BY meat HAVING MAX(m.calories + p.calories) <= 3000;