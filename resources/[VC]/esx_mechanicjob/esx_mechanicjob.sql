
INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_mechanic', 'Mechanic', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_mechanic', 'Mechanic', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('mechanic', 'Mechanic')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('mechanic',0,'recrue','Kar amooz', 4000,'{}','{}'),
	('mechanic',1,'novice','Taze kar', 6000,'{}','{}'),
	('mechanic',2,'experimente','Ba tajrobe', 8000,'{}','{}'),
	('mechanic',3,'chief',"Rahbar e team", 10000,'{}','{}'),
	('mechanic',4,'boss','Rais', 10000,'{}','{}')
;

INSERT INTO `items` (name, label, `limit`) VALUES
	('gazbottle', 'Ghooti gaz', 11),
	('fixtool', 'Abzar e tamir', 6),
	('carotool', 'Abzar e badane', 4),
	('blowpipe', "Mash`al", 10),
	('fixkit', 'Kit Tamir', 5),
	('carokit', 'Kit e badane', 3)
;
