ALTER TABLE owned_vehicles ADD modelname VARCHAR(150);
ALTER TABLE owned_vehicles DROP PRIMARY KEY;
ALTER TABLE owned_vehicles ADD `id` int(11) NOT NULL AUTO_INCREMENT;
