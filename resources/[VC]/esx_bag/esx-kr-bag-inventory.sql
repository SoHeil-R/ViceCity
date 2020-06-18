CREATE TABLE `owned_bags`(
`identifier` VARCHAR(50) NULL DEFAULT NULL, 
`id` INT(11) NULL DEFAULT NULL, 
`x` DOUBLE NULL DEFAULT NULL, 
`y` DOUBLE NULL DEFAULT NULL, 
`z` DOUBLE NULL DEFAULT NULL,
`itemcount` int(11) NOT NULL DEFAULT '0'
) COLLATE='latin1_swedish_ci' ENGINE=InnoDB ;

CREATE TABLE IF NOT EXISTS `owned_bag_inventory` (
  `id` int(11) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `label` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `count` int(11) DEFAULT NULL
);

INSERT INTO `items` (`name`, `label`, `limit`) VALUES
	('bag', 'Bag', 1)
;
