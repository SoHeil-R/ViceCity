ChocoHaxCs = {}

--//LoliHunter//--
ChocoHaxCs.ConfigVersion = 1 -- Don't touch, it's better

--//Log System//--
ChocoHaxCs.ConsoleLog = true -- This will log on console warnings/kicks/bans/infos
ChocoHaxCs.DiscordLog = true -- This will log on discord webhook warnings/kicks/bans/infos
ChocoHaxCs.ChatLog = true -- This will log on ingame chat FOR ALL PLAYERS warnings/kicks/bans

--//Chat Control Stuff//--
ChocoHaxCs.BlacklistedWordsDetection = false -- Detects and log the player that tried to say something blacklisted (configs/blacklistedwords.lua)
ChocoHaxCs.BlacklistedWordsKick = false -- Kick the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)
ChocoHaxCs.BlacklistedWordsBan = false -- Ban the player that tried to say a blacklisted word (require BlacklistedWordsDetection = true)

--//Default Stuff//--
ChocoHaxCs.TriggerDetection = true -- Kick the player that tried to execute or call a blacklisted trigger (remember to edit or obfuscate your original triggers), this will find all newbie cheaters/skids

--//Ban System//--
ChocoHaxCs.BanSystem = true -- This on false will disable the ChocoHax's Ban System

--//Region lock System//--
ChocoHaxCs.RegionLock = true -- Master switch for region lock (people from diffrent countries than below are not allowed to join the server)
ChocoHaxCs.RegionLockCountry = "IT" -- "IT" > Italy, "US" > USA, "UK" > United Kingdom, "ES" > Spain etc.

--//Kick Message//--
ChocoHaxCs.KickMessage = "Baka... don't touch my server." -- You can edit this UwU

--//Anti Explosion System (tables are in tables folder)//--
ChocoHaxCs.DetectExplosions = false -- Automatically detect blacklisted explosions from (tables/blacklistedexplosions.lua)

--//Anti Nuke System (tables are in tables folder)//--
ChocoHaxCs.AntiNuke = false -- Automatically detect blacklisted models spawn from (tables/antinukeblacklistedmodels.lua)


--//Permission System//-- DO NOT TOUCH IF YOU DON'T KNOW WHAT ARE U DOING 
ChocoHaxCs.Bypass = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to bypass Violation detections such as mod menus/weapons/godmode, etc.
ChocoHaxCs.AdminMenu = {"chocohaxadministrator"} -- This will allow the user with these perms to load the ChocoMenu.
ChocoHaxCs.Spectate = {"chocohaxadministrator","chocohaxmoderator"} -- This will allow the user with these perms to spectate other users.
ChocoHaxCs.Blips = {"chocohaxadministrator","chocohaxmoderator","chocohaxjobs"} -- This will allow the user with these perms to use Player Blips.