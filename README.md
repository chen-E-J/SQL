# SQL Data Management class project

Created database(Rock&Roll) using CREATE and INSERT queries

Used SQL queries to extract information such as:
  Cost and price of item from a given band
  Total count and cost of all items
  List showing name, location and profit margin for every item, ordered by profit margin
  Percentage of item count in shelves 1-3 versus 4-6
  
# Challenges faced
Many quiery methods used for this project was not introduced in class. I had to do learn basics from this website: https://www.w3schools.com/sql/sql_join.asp as well as doing more than 2 hours of research.

There were three problems that I had difficulty in solving at first. One of them was: Query percentage of item count in shelves 1-3 versus 4-6. I needed to classify items into two categories based on shelf number, count items in each category, and divide category count by total count. I tried to seperate two categories of data with the WHERE clause and didn't suceed because I need to count total number of items in the SELECT clause and it couldn't be achieved with a following WHERE clause. Then after reviewing a lot of sort of similar examples from stackflow, I learned the 'CASE WHEN...THEN...ELSE' clause which is like the if...else... clause in other programming languages and incorporated it into the SELECT clause. The final code was:
  SELECT 
  COUNT(CASE WHEN location.Shelf<=3 THEN item.Id ELSE null END)/COUNT(item.Id) AS Percentage_in_shelf1_3, COUNT(CASE WHEN location.Shelf>3 THEN item.Id ELSE null END)/COUNT(item.Id) AS Percentage_in_shelf4_6
  FROM item
  LEFT JOIN location
  ON item.Loc_ID=location.Id
Successfully displayed the correct percentage with clear tags.

# Learning points
Learned to use SQL to create database
Learned to join tables, WHERE clause, Case When...Then...Else clause, Union
Practised SQL query
Learned to apply fast-learning and creativity to solve problems.
