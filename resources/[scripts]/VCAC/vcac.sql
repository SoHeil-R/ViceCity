CREATE TABLE `vcac_ban` (
	`identifier` VARCHAR(25) NOT NULL COLLATE 'utf8mb4_bin',
	`license` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`liveid` VARCHAR(21) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`xblid` VARCHAR(21) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`discord` VARCHAR(30) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`playerip` VARCHAR(25) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`sourceplayername` VARCHAR(50) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	`reason` TEXT(65535) NOT NULL DEFAULT '0' COLLATE 'utf8mb4_bin',
	`report_id` VARCHAR(300) NULL DEFAULT NULL COLLATE 'utf8mb4_bin',
	PRIMARY KEY (`identifier`) USING BTREE
)
COLLATE='utf8mb4_bin'
ENGINE=InnoDB
;
