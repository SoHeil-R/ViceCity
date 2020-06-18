ChocoHaxCc = {}

ChocoHaxCc.GeneralStuff = true -- Includes: NO INFINITE AMMO, NO GODMODE, NO ANTI RUNOFF

--//Anti GodMode//--
ChocoHaxCc.AntiGodMode = true -- Master switch for AntiGodMode
ChocoHaxCc.AntiGodModeTimer = 20000 -- AntiGodMode Timer, default: 200000 / 20 seconds, it does the check every x ms
ChocoHaxCc.AntiGodModeDemiGod = true -- Detects a player that get detected with demigod during the check (DO NOT USE THIS ON VRP)
ChocoHaxCc.MaxPlayerHealth = 200 -- Max player health
ChocoHaxCc.AntiGodModeKick = true -- Kick the AntiGodMode detected player
ChocoHaxCc.AntiGodModeBan = true -- Ban the AntiGodMode detected player

--//Anti AdminStuff//--
ChocoHaxCc.AntiPlayerBlips = true -- Detects a user that activated Player Blips and is not allowed
ChocoHaxCc.AntiSpectate = true -- Detects a user that is spectating someone else and is not allowed

--//Anti Blacklisted Weapons//--
ChocoHaxCc.BlacklistedWeapons = true -- Master switch for BlacklistedWeapons (detects who's holding a blacklisted weapon)
ChocoHaxCc.BlacklistedWeaponsTable = { -- Table for all blacklisted Weapons (don't forget the comma! bitch)
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_FIREWORK",
	"WEAPON_BALL",
	"WEAPON_BOTTLE",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_GARBAGEBAG",
	"WEAPON_RAILGUN",
	"WEAPON_RAILPISTOL",
	"WEAPON_RAYPISTOL", 
	"WEAPON_RAYCARBINE", 
	"WEAPON_RAYMINIGUN",
	"WEAPON_DIGISCANNER",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_HOMINGLAUNCHER", 
	"WEAPON_SMG_MK2"
}

--//Automatic Model Deleter//-- This script is going to delete any ANTINUKE BLACKLISTED Model (NOT RECOMMENDED FOR LOW-END/LOW SERVERS)
ChocoHaxCc.AutomaticMDTimer = 7500 -- Timer default: 7500 / 7.5 seconds (lower the timer/higher the load aka. lag)
ChocoHaxCc.AutomaticMDModel = false
ChocoHaxCc.AutomaticMDEntity = false
ChocoHaxCc.AutomaticMDPeds = false

--//Anti Cheat Engine//--
ChocoHaxCc.AntiDamageModifier = true -- Detects if a player tries to modify his damage or defence value
ChocoHaxCc.AntiVehicleHashChanger = true -- Detects if a player tried to change his vehicle hash model

ChocoHaxCc.AntiModelChanger = true -- Detects if a player tried to change his model to a blacklisted model
ChocoHaxCc.AntiModelChangerTable = {
	"s_m_y_swat_01",
	"a_m_y_mexthug_01", 
    "a_c_cat_01", 
    "a_c_boar", 
    "a_c_sharkhammer", 
    "a_c_coyote", 
    "a_c_chimp",  
    "a_c_cow", 
    "a_c_deer", 
    "a_c_dolphin", 
    "a_c_fish", 
    "a_c_hen", 
    "a_c_humpback", 
    "a_c_killerwhale", 
    "a_c_mtlion",
    "a_c_rabbit_01",  
    "a_c_rhesus",  
    "a_c_sharktiger", 
	"u_m_y_zombie_01"
}

--//Resource Injection Protection//--
--<<ANTI RESTART BOOLS>> (DO NOT RESTART SCRIPTS IF YOU ENALBED THESE!!!)
ChocoHaxCc.ResourceCounter = true -- This script will check if a player have a diffrent amount of resources
ChocoHaxCc.AntiResourceRestart = true -- This scripts will check if a player tries to restart scripts
ChocoHaxCc.AntiResourceStop = true -- This script will check if a player tries to STOP a script
ChocoHaxCc.AntiFCommands = true -- This script will check if a player injected custom commands into the server
ChocoHaxCc.RandomStringResource = true -- This script will check if a player tried to inject a random resource into the server
