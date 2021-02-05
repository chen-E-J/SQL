DROP DATABASE DM_rockroll;

CREATE DATABASE DM_rockroll;

USE DM_rockroll;

CREATE TABLE band
  (ID INT(10) NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL, PRIMARY KEY(Id));

CREATE TABLE location
    (Id INT(10) NOT NULL AUTO_INCREMENT,
    Ocean VARCHAR(15) NOT NULL,
    Pillar VARCHAR(1) NOT NULL,
    Shelf INT(2) NOT NULL,
    Bin INT(2) NOT NULL,
    PRIMARY KEY(Id));

CREATE TABLE item
      (Id INT(10) NOT NULL AUTO_INCREMENT,
      Name VARCHAR(50) NOT NULL,
      Quantity INT(10) NOT NULL,
      Cost DECIMAL(10,2) NOT NULL,
      Price DECIMAL(10,2) NOT NULL,
      Band_Id INT(10),
      Loc_ID INT(10),
      PRIMARY KEY (Id),
      FOREIGN KEY_fk_band (Band_Id) REFERENCES band(Id)
      ON DELETE CASCADE ON UPDATE CASCADE,
      FOREIGN KEY fk_loc(Loc_Id) REFERENCES location(Id)
      ON DELETE CASCADE ON UPDATE CASCADE);

insert into band (ID, Name)
  values (1,'U2'), (2,'KISS'), (3,'The Hip'), (10,'AC/DC');

insert into location (Ocean, Pillar, Shelf, Bin)
  values ('Arctic','C',2,1),
  ('Pacific','F',4,2),
  ('Indian','A',3,3),
  ('Pacific','A',1,2),
  ('Atlantic','B',5,1);

insert into item (Name, Quantity, Cost, Price, Band_ID, Loc_ID)
  values ('Bono Sunglasses',39,9.5,9.99,1,1),
('Edge Pick',165,.25,1,1,2),
('Joshua Tree Vinyl LP',6,8.75,26.50,1,2), 
('Kiss Boots',71,145.50,425,2,4), 
('Simmons Fake Blood',5,1.75,5.75,2,3), 
('Downie Jacket',1,850,1500,3,5), 
('Farewell Tour DVD',12,6.20,15,3,4), 
('Red iPhone Case',75,4.35,18,1,1), 
('Joshua Tree Poster',9,3.65,21,1,2), 
('Road Apples CD',3,2.7,12,3,4), 
('Mask Mug',12,1.1,4.99,2,2), 
('ie Ball Cap',21,7.5,15,1,5), 
('Larry Lithograph',2,89,189,1,4), 
('Mini Bass Guitar',10,6,16,NULL,4), 
('Toaster oven',3,34.5,75.99,NULL,4);

--"ROCK & ROLL"
SELECT item.Id,Cost,Price,band.Name FROM item LEFT JOIN band ON item.Band_id=band.ID WHERE band.Name='U2'

SELECT COUNT(item.Id) FROM item

SELECT SUM(Cost*Quantity) AS totalcost, SUM((Price-Cost)*Quantity) AS profitpotential FROM `item` 

SELECT item.Name,location.Ocean,location.Pillar,location.Shelf,location.Bin,(Price-Cost)/Price AS profit_margin FROM item
LEFT JOIN location
ON item.Loc_ID=location.Id
ORDER BY profit_margin DESC

--"god i am so proud of figuring this out"
SELECT 
COUNT(CASE WHEN location.Shelf<=3 THEN item.Id ELSE null END)/COUNT(item.Id) AS Percentage_in_shelf1_3, COUNT(CASE WHEN location.Shelf>3 THEN item.Id ELSE null END)/COUNT(item.Id) AS Percentage_in_shelf4_6
FROM item
LEFT JOIN location
ON item.Loc_ID=location.Id

--"World DB"
SELECT* FROM city
ORDER BY Name DESC

SELECT SUM(Population) FROM country

SELECT COUNT(Code) FROM country
WHERE GNP>1000000

SELECT Name, GNP/1000000 AS GNP_trillions FROM country
ORDER BY GNP ASC

SELECT Language, IsOfficial FROM countrylanguage
LEFT JOIN country
ON countrylanguage.CountryCode=country.Code
WHERE country.Name="Uzbekistan" AND IsOfficial="T"

SELECT AVG(LifeExpectancy) FROM country
LEFT JOIN countrylanguage
ON country.Code=countrylanguage.CountryCode
WHERE countrylanguage.Language="Spanish"

--'i have to use parenthesis here for some reasons. took me so much time to figure out'
(SELECT Name
FROM country
ORDER BY LifeExpectancy DESC
LIMIT 1)
UNION ALL
(SELECT Name
FROM country
ORDER BY LifeExpectancy ASC    
LIMIT 1)

--"god who would have thought"

select Name,LifeExpectancy from country 
LEFT JOIN countrylanguage
ON country.Code=countrylanguage.CountryCode
where (Language="Spanish" AND LifeExpectancy > (select avg(LifeExpectancy) from country
                                               LEFT JOIN countrylanguage
                                               ON country.Code=countrylanguage.CountryCode
                                               where Language="Spanish"))


