DROP DATABASE CiCharity;

CREATE DATABASE CiCharity;

USE CiCharity;

CREATE TABLE sector
  (Id INT(10) NOT NULL AUTO_INCREMENT,
  Name VARCHAR(50) NOT NULL, PRIMARY KEY(Id));


CREATE TABLE charity
    (Regist_no INT(10) NOT NULL,
    Name VARCHAR(20) NOT NULL,
    Common_name VARCHAR(20),
    Street VARCHAR(50),
    Web VARCHAR(100),
    PRIMARY KEY(Regist_no));
ALTER TABLE charity
    ADD Province Varchar(50) NOT NULL;


CREATE TABLE employee
      (Id INT(10) NOT NULL AUTO_INCREMENT,
      Name VARCHAR(50) NOT NULL,
      Last_name VARCHAR(50) NOT NULL,
      SIN VARCHAR(20) NOT NULL,
      Address VARCHAR(100) NOT NULL,
      Phone VARCHAR(10) NOT NULL,
      Email VARCHAR(50) NOT NULL,
      PRIMARY KEY (Id));


CREATE TABLE session
	  (Id INT(10) NOT NULL AUTO_INCREMENT,
	  SDate DATE NOT NULL,
	  STime TIME NOT NULL,
	  Edate DATE NOT NULL,
	  Etime TIME NOT NULL,
	  PRIMARY KEY (Id));
ALTER TABLE session
    ADD Cookie_id Varchar(50) NOT NULL;


CREATE TABLE article
	  (Id INT(10) NOT NULL AUTO_INCREMENT,
	  Pdate DATE NOT NULL,
	  Title VARCHAR(50) NOT NULL,
	  Atext TEXT NOT NULL,
	  PRIMARY KEY (Id));


CREATE TABLE charitysector
	  (Charity_No INT(10) NOT NULL,
	  Sector_Id INT(10) NOT NULL,
	  FOREIGN KEY fk_charity1(Charity_No) REFERENCES charity(Regist_no) ON DELETE CASCADE ON UPDATE CASCADE,
	  FOREIGN KEY fk_sector(Sector_Id) REFERENCES sector(Id) ON DELETE CASCADE ON UPDATE CASCADE,
	  Primary Key (Charity_No,Sector_Id));


CREATE TABLE profile
	(Year INT(4) NOT NULL,
	About TEXT NOT NULL,
	Financial_review TEXT NOT NULL,
	Transparency_score INT(3) NOT NULL,
	CONSTRAINT check_score CHECK (Transparency_score>=0)AND(Transparency_score<=100)
	Notes TEXT,
	Charity_No INT(10) NOT NULL,
	FOREIGN KEY fk_charity(Charity_No) REFERENCES charity(Regist_no) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY(Year,Charity_No));


CREATE TABLE profileautho
	(Profile_year INT(10) NOT NULL,
	Charity_No INT(10) NOT NULL,
	Employee_id INT(10) NOT NULL,
	FOREIGN KEY fk_profile_year(Profile_year) REFERENCES profile(Year) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY fk_profile_charity(Charity_No) REFERENCES profile(Charity_No) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY fk_employee(Employee_id) REFERENCES employee(Id) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (Profile_year,Charity_No,Employee_id));


CREATE TABLE articleautho
	(Article_id INT(10) NOT NULL,
	Employee_id INT(10) NOT NULL,
	FOREIGN KEY fk_article(Article_id) REFERENCES article(Id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY fk_employee1(Employee_id) REFERENCES employee(Id) ON DELETE CASCADE ON UPDATE CASCADE,
	PRIMARY KEY (Article_id,Employee_id));


CREATE TABLE articleview
(Id INT(10) NOT NULL AUTO_INCREMENT,
Viewdate DATE NOT NULL,
Viewtime Time NOT NULL,
Edate DATE NOT NULL,
Etime TIME NOT NULL,
Session_id INT(10) NOT NULL,
Article_id INT(10) NOT NULL,
FOREIGN KEY fk_session(Session_id) REFERENCES session(Id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY fk_article1(Article_id) REFERENCES article(Id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (Id));


CREATE TABLE charityview
(Id INT(10) NOT NULL AUTO_INCREMENT,
Viewdate DATE NOT NULL,
Viewtime Time NOT NULL,
Edate DATE NOT NULL,
Etime TIME NOT NULL,
Session_id INT(10) NOT NULL,
Charity_id INT(10) NOT NULL,
FOREIGN KEY fk_session1(Session_id) REFERENCES session(Id) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY fk_charity2(Charity_id) REFERENCES charity(Regist_no) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (Id));


CREATE TABLE donation
(Id INT(10) NOT NULL AUTO_INCREMENT,
Donation_date DATE NOT NULL,
Donation_time TIME NOT NULL,
Amount DECIMAl(10,2) NOT NULL,
Session_id INT(10) NOT NULL,
FOREIGN KEY fk_session2(Session_id) REFERENCES session(Id) ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY(Id));



insert into employee(Name,SIN,Address,Phone,Email,Last_name)
	values('Sarah','3456234','352 Dundas Street, Chicago,illinois','567834567','sarachamon@gmail.com','Amon'),
	('Rachel','3456245','352 Dundas Street, Chicago,illinois','5678436575','rachelbenson@gmail.com','Benson'),
	('Spencer','3457964','568 Sunset Street, LA,California','567839372','spencerwatson@gmail.com','Watson'),
	('Alex','34894204','52 Sarnia Street, Toronto,Ontario','567834453','alexrobert@gmail.com','Robert');

insert into session(Cookie_id,SDate,STime,Edate,Etime)
	values('ljafki234','2021-01-02','13:47:51','2021-01-02','13:58:51'),
	('ljafki234','2021-01-12','09:47:51','2021-01-02','10:12:59'),
	('jlknavd38','2021-01-03','11:47:51','2021-01-02','12:58:51'),
	('wrekisf34','2021-01-02','15:47:51','2021-01-02','15:44:51'),
	('wrekisf34','2021-02-02','12:47:51','2021-01-02','13:44:51'),
	('wetaisf34','2020-12-02','15:47:51','2021-12-02','15:49:51');
	
insert into charity (Regist_no,Name,Common_name,Street,Web,Province)
	values('123422','Gen to Gen','Gen2Gen','125 Willington Road,Coventry,UK','','Ontario'),
	('12532','Exerski','Exerski','235 Richmond Street,London,Canada','','Ontario'),
	('325135','GradMentor','GMATmentor','235 Queens Street,Toronto,Canada','gradmentor.org','British Columbia'),
	('23535','Betterhelp','Betterhelp','432 Liverpool Road,Portland,US','','Quebec'),
	('23456','Britishcanal','ukcanal','345 Frankfurt Street,London,UK','','Ontario');

insert into sector (Id,Name)
	values(1,'Education'),
	(2,'Environment'),
	(3,'Health');

insert into charitysector(Charity_No,Sector_Id)
	values(12532,2)
	(123422,1),
	(12532,3),
	(325135,1),
	(23535,3),
	(23456,2);

insert into profile(Year,About,Financial_review,Transparency_score,Notes,Charity_No)
	values(2019,'To increase digital literacy among elders with the help of our young volunteers','in good financial situation',93,'',123422),
	(2020,'To increase digital literacy rate among elders by connecting student volunteers with elders on one-to-one appointments','in good financial situation',93,'',123422),
	(2021,'outdoor lifestyle promotion through a webapp that recommends daily exercise activites based on local weather condition','in need of funding',75,'',12532),
	(2021,'To promote mental health and provide free therapy sessions for people that cannot afford to meet therapist','in good financial situation',80,'',23535),
	(2021,'To provide free grad school entrance exam tutoring by pairing volunteer tutors with students in need','in decent financial situation',95,'',325135);

insert into profileautho(Profile_year,Charity_No,Employee_id)
	values(2019,123422,1),
	(2020,123422,1),
	(2021,12532,3),
	(2021,23535,2),
	(2021,325135,4),
	(2021,12532,2),
	(2021,23535,4);

insert into article(Pdate,Title,Atext)
	values('2019-12-25','Gen2Gen established partnership with universities','Gen2Gen CEO Ronald Pearson recently reported that the nonprofit established relationship with warwick unversity, coventry unversity, leeds university, and lancaster university student volunteering association'),
	('2019-12-27','Betterhelp reached 2000 volunteers landmark',' lets say yeah'),
	('2020-02-05','Exerski reached 5000 users landmark',' lets say wow'),
	('2019-04-25','Britishcanal reported exciting annual results',' lets say yeah'),
	('2020-04-15','GradMentor reached 8000 users landmark',' lets say wow');

insert into articleautho(Article_id,Employee_id)
	values
	(1,4),
	(1,3),
	(2,2),
	(2,3),
	(3,1),
	(4,1);

insert articleview(Viewdate,Viewtime,Edate,Etime,Session_id,Article_id)
	values('2021-01-12','09:47:51','2021-01-02','10:12:59',2,1),
	('2021-01-03','11:47:51','2021-01-02','12:58:51',3,2),
	('2021-01-02','13:47:51','2021-01-02','13:58:51',1,2),
	('2021-02-02','12:47:51','2021-01-02','13:44:51',5,5),
	('2020-12-02','15:47:51','2021-12-02','15:49:51',6,5);

insert charityview(Viewdate,Viewtime,Edate,Etime,Session_id,Charity_id)
	values	('2021-01-02','11:48:51','2021-01-02','11:52:59',4,12532),
	('2021-01-12','09:47:51','2021-01-02','10:12:59',2,12532),
	('2021-01-03','11:47:51','2021-01-02','12:58:51',3,23456),
	('2021-01-02','13:47:51','2021-01-02','13:58:51',3,23535),
	('2021-02-02','12:47:51','2021-01-02','13:44:51',5,325135),
	('2020-12-02','15:47:51','2021-12-02','15:49:51',6,325135);

insert donation(Donation_date,Donation_time,Amount,Session_id)
	values('2021-01-12','09:49:51',70.67,2),
	('2021-01-03','11:50:51',50,3),
	('2021-01-02','15:55:59',300.7,4);


--Alphabetical list showing common and legal names of all Ontario charities
SELECT charity.Name,charity.Common_name FROM charity
WHERE Province='Ontario'
Order By Name ASC, Common_name ASC;

--a list with employee first name, last name, and number of articles published
SELECT Name,Last_name,COUNT(articleautho.Article_id) AS No_article_published FROM employee 
LEFT JOIN articleautho ON employee.Id =articleautho.Employee_id 
GROUP BY Employee_id
--How many times was each article viewed, from most to least popular?
SELECT article.Id,article.Title,count(articleview.Id) AS No_viewed FROM article
LEFT JOIN articleview ON articleview.Article_id=article.Id
GROUP BY article.Id
ORDER BY No_viewed DESC
--List the common name of each charity, along with its sector and sum of all donations made during 2020, starting with the highest donation total.
---i don't know how to do this one becuase if during one session, one viewed more than 1 charity and makes donations, we don't know which charity were donated.

