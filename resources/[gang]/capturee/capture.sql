
CREATE TABLE `capture` (
	`name`          varchar(255) NOT NULL,
	`reward`        varchar(255) NOT NULL,
	`coordinate`    varchar(255) NOT NULL,
    `handeler`      varchar(255) NOT NULL
);

-- {name = 'benzin', reward = 'fuel:ChangeHandeler', coordiante = {"x":-805.779,"y":189.870,"z":71.835}},
-- {name = 'drug'  , reward = 'drug:ChangeHandeler', coordiante = {x = -805.779, y = 189.870, z = 71.835}},
-- {name = 'weapon', reward = 'weashop:ChangeHandeler' , coordiante = {x = -805.779, y = 189.870, z = 71.835}}