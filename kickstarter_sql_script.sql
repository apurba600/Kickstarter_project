USE kickstarter;

# Pre Analysis
SELECT COUNT(*) FROM campaign;
SELECT * FROM campaign;
SELECT * FROM category;
SELECT * FROM sub_category;
SELECT * FROM currency;
SELECT * FROM country;
SELECT COUNT(*) FROM campaign WHERE currency_id = 2;
SELECT DISTINCT outcome FROM campaign;
SELECT COUNT(outcome) as count FROM campaign WHERE outcome = "successful";
SELECT COUNT(outcome) as count FROM campaign WHERE outcome = "failed";

# GOAL AMOUNT QUESTION 1

SELECT ROUND(AVG(GOAL)) as Mean_Goal,Outcome
FROM campaign
WHERE currency_id = "2" AND outcome = "successful"

UNION

SELECT ROUND(AVG(GOAL)) as Mean_Goal,Outcome
FROM campaign
WHERE currency_id = "2" AND outcome = "failed";

SELECT MAX(goal) FROM campaign;
SELECT MIN(goal) FROM campaign;

# QUESTION 2

#TOP 3 BACKED CATEGORIES
SELECT SUM(ca.backers) AS total_backers, cat.name AS Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
GROUP BY cat.name
ORDER BY total_backers DESC
LIMIT 3;

#BOTTOM 3 BACKED CATEGORIES
SELECT SUM(ca.backers) AS total_backers, cat.name AS Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
GROUP BY cat.name
ORDER BY total_backers ASC
LIMIT 3;

#TOP 3 BACKED SUBCATEGORIES
SELECT SUM(ca.backers) AS total_backers, sub.name AS Sub_Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
GROUP BY sub.name
ORDER BY total_backers DESC
LIMIT 3;

#BOTTOM 3 BACKED SUBCATEGORIES
SELECT SUM(ca.backers) AS total_backers, sub.name AS Sub_Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
GROUP BY sub.name
ORDER BY total_backers ASC
LIMIT 3;

# TOP 3 MOST RAISED BY CATEGORY
SELECT ROUND(SUM(ca.pledged)) AS pledged_value, cat.name AS Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
WHERE ca.currency_id = 2
GROUP BY cat.id
ORDER BY pledged_value DESC
LIMIT 3;

#BOTTOM 3 WORST RAISE BY CATEGORY
SELECT ROUND(SUM(ca.pledged)) AS pledged_value, cat.name AS Category
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
WHERE ca.currency_id = 2
GROUP BY cat.id
ORDER BY pledged_value ASC
LIMIT 3;

# TOP 3 MOST RAISED BY SUBCATEGORY
SELECT ROUND(SUM(ca.pledged)) AS pledged_value, sub.name AS SubCategory
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
WHERE ca.currency_id = 2
GROUP BY sub.id
ORDER BY pledged_value DESC
LIMIT 3;

#BOTTOM 3 WORST RAISED BY SUBCATEGORY
SELECT ROUND(SUM(ca.pledged)) AS pledged_value, sub.name AS SubCategory
FROM campaign AS ca
JOIN sub_category AS sub
ON ca.sub_category_id = sub.id
JOIN category AS cat
ON sub.category_id = cat.id
WHERE ca.currency_id = 2
GROUP BY sub.id
ORDER BY pledged_value ASC
LIMIT 3;

# MOST SUCCESSFUL BOARD GAME
SELECT pledged AS Pledged, name, backers
FROM campaign
WHERE sub_category_id = 14
ORDER BY pledged DESC
LIMIT 1;

# TOP 3 COUNTRIES PLEDGED
SELECT ROUND(SUM(ca.pledged)) AS pledged_value, co.name AS Country
FROM campaign AS ca
JOIN country AS co
ON ca.country_id = co.id
WHERE outcome = "successful"
GROUP BY co.id
ORDER BY pledged_value DESC
LIMIT 3;

# TOP 3 COUNTRIES BY BACKED
SELECT SUM(ca.backers) AS Total_backers, co.name AS Country
FROM campaign AS ca
JOIN country AS co
ON ca.country_id = co.id
WHERE ca.outcome = "successful"
GROUP BY co.id
ORDER BY Total_backers DESC
LIMIT 3;

# Duration of campaigns
SELECT ROUND(ca.pledged) AS money_raised, 
       DATEDIFF(ca.deadline, ca.launched) AS duration_in_days
FROM campaign AS ca
ORDER BY money_raised DESC
LIMIT 20;



