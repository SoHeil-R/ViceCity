CREATE TABLE `owned_vehicles` (
	`owner` varchar(30) NOT NULL,
	`plate` varchar(12) NOT NULL,
	`vehicle` longtext NOT NULL,
	`type` VARCHAR(20) NOT NULL DEFAULT 'car',
	`job` VARCHAR(20) NOT NULL,
	`stored` TINYINT(1) NOT NULL DEFAULT '0',

	PRIMARY KEY (`plate`)
);