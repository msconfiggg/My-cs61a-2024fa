#4
CREATE TABLE sharing AS
    SELECT a.course, COUNT(DISTINCT a.hall) AS shared
    FROM finals AS a, finals AS b
    WHERE a.hall = b.hall AND a.course != b.course
    GROUP BY a.course;

#5
CREATE TABLE pairs AS
    SELECT a.room || ' and ' || b.room || ' together have ' || (a.seats + b.seats) || ' seats' AS rooms
    FROM sizes AS a, sizes AS b
    WHERE a.room < b.room AND (a.seats + b.seats) >= 1000
    ORDER BY (a.seats + b.seats) DESC;

#6
CREATE TABLE big AS
    SELECT course
    FROM finals, sizes
    WHERE finals.hall = sizes.room
    GROUP BY course
    HAVING SUM(seats) > 1000;

#7
CREATE TABLE remaining AS
    SELECT course, SUM(seats) - MAX(seats) AS remaining
    FROM finals, sizes
    WHERE finals.hall = sizes.room
    GROUP BY course;