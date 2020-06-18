VCAC_A = {}

--//LoliHunter//--
VCAC_A.ConfigVersion = 1 -- Don't touch, it's better


VCAC_A.ConnectCheck = false -- Check Player connect to anticheat

--//Log System//--
VCAC_A.ConsoleLog = true -- This will log on console warnings/kicks/bans/infos
VCAC_A.DiscordLog = true -- This will log on discord webhook warnings/kicks/bans/infos
VCAC_A.ChatLog = true -- This will log on ingame chat FOR ALL PLAYERS warnings/kicks/bans

--//Chat Control Stuff//--
VCAC_A.BlacklistedWordsDetection = false -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
VCAC_A.BlacklistedWordsKick = false -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
VCAC_A.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
VCAC_A.TriggerDetection = true -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids

--//Ban System//--
VCAC_A.BanSystem = true -- This on false will disable the ChocoHax's Ban System

--//Kick Message//--
VCAC_A.KickMessage = "Baka... don't touch my server." -- You can edit this UwU

--//Anti Explosion System (tables are in tables folder)//--
VCAC_A.DetectExplosions = true -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)

VCAC_A.AntiNuke = true
VCAC_A.AntiSpawnVehicles = true
VCAC_A.AntiSpawnPeds     = true
