
CREATE TABLE `blackmarket` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`store` varchar(100) NOT NULL,
	`item` varchar(100) NOT NULL,
	`price` int(11) NOT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `blackmarket` (store, item, price) VALUES
	('blackmarket', 'loole', 400),
	('blackmarket', 'fanar', 300),
	('blackmarket', 'capsul', 400),
	('blackmarket', 'picklock', 200),
	('blackmarket', 'drillsharji', 2000),
	('blackmarket', 'mattezakhim', 2000),
	('blackmarket', 'battery', 1500),
	('blackmarket', 'clip', 2000),
	('blackmarket', 'silencer', 10000),
	('blackmarket', 'grip', 3000),
	('blackmarket', 'flashlight', 1500),
	('blackmarket', 'yusuf', 5000)
;