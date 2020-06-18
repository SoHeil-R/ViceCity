local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = false -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = Keys["LEFTALT"]

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 500

Config.localWeight = {
    bread = 125,
	water = 330,
    WEAPON_COMBATPISTOL = 2500,
    WEAPON_SNSPISTOL = 2500,
	WEAPON_PISTOL50 = 2500, 
	WEAPON_PISTOL = 2500,
    WEAPON_SMG = 5000,
    WEAPON_ASSAULTRIFLE = 5000,
	black_money = 1, -- poids pour un argent
	alcool = 1000,
	alcool_cargo = 5000,
	alive_chicken = 5000,
	bandage = 125,
	cagoule = 500,
	clip = 100,
	clothe = 500,
	coke_pooch = 5000,
	copper = 2000,
	croquettes = 100,
	cutted_wood = 2000,
	diamond = 500,
	drill = 2000,
	energy = 500,
	essence = 3000,
	fabric = 500,
	fish = 1000,
	flashlight = 250,
	gold = 2000,
	golem = 10000,
	iron = 2000,
	jewels = 250,
	medikit = 500,
	meth_pooch = 5000,
	menthe = 5000,
	opium_pooch = 5000,
	packaged_chicken = 500,
	packaged_plank = 500,
	petrol = 2000,
	petrol_raffin = 2000,
	slaughtered_chicken = 2500,
	stone = 2500,
	viande = 2000,
	weed = 10000,
	weed_pack = 5000,
    weed_paper = 1500,
    coca = 3000,
    cocaine_bricks = 25000,
    cocaine = 1000,
    medicine = 2500,
    acetone = 3000,
    hydraulic_acid = 1000,
    red_phosphor = 1000
}

Config.VehicleLimit = {
    [0] = 30000, --Compact
    [1] = 40000, --Sedan
    [2] = 200000, --SUV
    [3] = 25000, --Coupes
    [4] = 30000, --Muscle
    [5] = 10000, --Sports Classics
    [6] = 5000, --Sports
    [7] = 5000, --Super
    [8] = 5000, --Motorcycles
    [9] = 300000, --Off-road
    [10] = 300000, --Industrial
    [11] = 70000, --Utility
    [12] = 300000, --Vans
    [13] = 2000, --Cycles
    [14] = 5000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 40000, --Emergency
    [19] = 0, --Military
    [20] = 210000, --Commercial
    [21] = 0, --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}
