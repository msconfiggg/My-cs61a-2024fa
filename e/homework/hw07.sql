#1
-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
    SELECT d.name FROM dogs AS d, parents AS p, dogs AS pd
    WHERE d.name = p.child AND p.parent = pd.name
    ORDER BY pd.height DESC;

#2
-- The size of each dog
CREATE TABLE size_of_dogs AS
    SELECT d.name, s.size FROM dogs AS d, sizes AS s
    WHERE s.min < d.height AND d.height<= s.max;

#3
-- Filling out this helper table is optional
CREATE TABLE siblings AS
    SELECT a.name AS name1, b.name AS name2, a.size
    FROM size_of_dogs AS a, size_of_dogs AS b, parents AS c, parents AS d
    WHERE a.size = b.size AND a.name < b.name
    AND a.name = c.child AND b.name = d.child AND c.parent = d.parent;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
    SELECT 'The two siblings, ' || name1 || ' and ' || name2 ||
    ', have the same size: ' || size AS sentences FROM siblings;

#4
-- Height range for each fur type where all of the heights differ by no more than 30% from the average height
CREATE TABLE low_variance AS
    SELECT fur, MAX(height) - MIN(height) AS range
    FROM dogs GROUP BY fur
    HAVING MAX(height) <= AVG(height) * 1.3 AND MIN(height) >= AVG(height) * 0.7;

#5
SELECT quarter FROM scoring
GROUP BY quarter HAVING SUM(points) > 10;

#6
SELECT team, SUM(points) FROM players AS p, scoring AS s 
WHERE p.name = s.player GROUP BY team;

#7
SELECT food, MIN(price) FROM shops GROUP BY food;

#8
SELECT dish, SUM(price) FROM ingredients, shops
WHERE part = food AND shop = 'A' GROUP BY dish;

#9
SELECT DISTINCT a.food FROM shops AS a, shops AS b
WHERE a.food = b.food AND a.price != b.price;

SELECT food FROM shops GROUP BY food HAVING COUNT(DISTINCT price) > 1;