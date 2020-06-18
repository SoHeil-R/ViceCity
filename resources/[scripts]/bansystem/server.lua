local Text               = {}
local lastduree          = ""
local lasttarget         = ""
local BanList            = {}
local BanListHistory     = {}
local BanListHistoryLoad = false
Text = Config.TextEn

AddEventHandler(
  "onMySQLReady",
  function()
	loadBanList()
  end
)

CreateThread(function()
	while Config.MultiServerSync do
		Wait(1000*60*10)
		MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
			if #data ~= #BanList then
			  BanList = {}

			  for i=1, #data, 1 do
				table.insert(BanList, {
					name 	   = data[i].targetplayername,
					identifier = data[i].identifier,
					license    = data[i].license,
					liveid     = data[i].liveid,
					xblid      = data[i].xblid,
					discord    = data[i].discord,
					playerip   = data[i].playerip,
					reason     = data[i].reason,
					added      = data[i].added,
					expiration = data[i].expiration,
					permanent  = data[i].permanent
				  })
			  end
			-- loadBanListHistory()
			TriggerClientEvent('BanSql:Respond', -1)
			end
		end
		)
	end
end)

TriggerEvent('es:addAdminCommand', 'banreload', 6, function (source)
	loadBanList()
	TriggerEvent('bansql:sendMessage', source, Text.banlistloaded)
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.reload})

TriggerEvent('es:addAdminCommand', 'unban', 4, function (source, args, user)
  if args[1] then
	local playerName = string.lower(args[1])
	local found = false
	for i=1, #BanList do 
		if string.lower(BanList[i].name) == playerName then 
			found = true
			table.remove(BanList, i)
		end 
	end
	if found then
		MySQL.Async.fetchAll('DELETE FROM banlist WHERE lower(`targetplayername`) = @playername', 
		{
			['@playername'] = (playerName)
		}, function(data)
			TriggerEvent('bansql:sendMessage', source, '^4[`' .. playerName .. '`]' .. ' ^1 Has Been ^*Unbaned!')
		end)
	else
		TriggerEvent('bansql:sendMessage', source, '^4[`' .. playerName .. '`]' .. '^1 is not in BanList!')
	end
  else
	TriggerEvent('bansql:sendMessage', source, Text.cmdunban)
  end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.unban, params = {{name = "name", help = Text.steamname}}})

TriggerEvent('es:addAdminCommand', 'ban', 3, function (source, args, user)
	local identifier
	local license
	local liveid    = "no info"
	local xblid     = "no info"
	local discord   = "no info"
	local playerip
	local target    = tonumber(args[1])
	local duree     = tonumber(args[2])
	local reason    = table.concat(args, " ",3)

	if args[1] then		
		if reason == "" then
			reason = 'Shoma Ban Shodid, Baraye Etela\'ate Bishtar Be Discord ViceCity Moraje\'e Konid!'
		end
		if target and target > 0 then
			local ping = GetPlayerPing(target)
        
			if ping and ping > 0 then
				if duree and duree < 365 then
					local sourceplayername = GetPlayerName(source)
					local targetplayername = GetPlayerName(target)
					local targeticname	   = exports.essentialmode:GetPlayerICName(target)
						for k,v in ipairs(GetPlayerIdentifiers(target))do
							if string.sub(v, 1, string.len("steam:")) == "steam:" then
								identifier = v
							elseif string.sub(v, 1, string.len("license:")) == "license:" then
								license = v
							elseif string.sub(v, 1, string.len("live:")) == "live:" then
								liveid = v
							elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
								xblid  = v
							elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
								discord = v
							elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
								playerip = v
							end
						end
				
					if duree > 0 then
						ban(source,identifier,license,liveid,xblid,discord,playerip,targeticname,sourceplayername,duree,reason,0)
						DropPlayer(target, '[Ban]: ' .. reason)
						TriggerClientEvent('chatMessage', -1, "[Admin]", {255, 0, 0}, "^1" .. targetplayername .. " ^0Tavasot ^2" .. sourceplayername .. " ^0Ban Shod Be Modat ^8" .. duree .. " ^0Rooz Be Dalile: ^3" .. reason )
						TriggerEvent('DiscordBot:ToDiscord', 'bansystem', 'BanSystem', targetplayername .. " Tavasot " .. sourceplayername .. " Ban Shod Be Modat " .. duree .. " Rooz Be Dalile : ^*" .. reason  ,'user', true, source, false)
					else
						ban(source,identifier,license,liveid,xblid,discord,playerip,targeticname,sourceplayername,duree,reason,1)
						DropPlayer(target, Text.yourpermban .. reason)
						TriggerClientEvent('chatMessage', -1, "[Admin]", {255, 0, 0}, "^1" .. targetplayername .. " ^0Tavasot ^2" .. sourceplayername .. " ^0Permanent Ban Shod Be Dalile: ^3" .. reason )
						TriggerEvent('DiscordBot:ToDiscord', 'bansystemp', 'BanSystem', targetplayername .. " tavasot " .. sourceplayername .. " permanent ban shod be dalile : " .. reason  ,'user', true, source, false)
					end
				
				else
					TriggerEvent('bansql:sendMessage', source, '[^8System^7]: Wrong Time Entered!')
				end	
			else
				TriggerEvent('bansql:sendMessage', source, '[^8System^7]: This Player is not Online!')
			end
		else
			TriggerEvent('bansql:sendMessage', source, '[^8System^7]: Wrong Id Entered!')
		end
	else
		TriggerEvent('bansql:sendMessage', source, Text.cmdban)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.ban, params = {{name = "id"}, {name = "day", help = Text.dayhelp}, {name = "reason", help = Text.reason}}})

TriggerEvent('es:addAdminCommand', 'banoffline', 4, function (source, args, user)
	if args ~= "" then
		target				= args[1]
		duree				= tonumber(args[2])
		reason				= table.concat(args, " ",3)
		sourceplayername 	= GetPlayerName(source)
		if duree ~= "" then
			if target ~= "" then
				MySQL.Async.fetchAll('SELECT * from users WHERE playerName = @playername', 
				{
					['@playername'] = target
				}, function(result)

					if result then 
						MySQL.Async.fetchAll('SELECT * FROM baninfo WHERE lower(`playerName`) = @playername', 
						{
							['@playername'] = target
						}, function(data)
							if data[1] then
								if duree > 0 then
									function ban(source,identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
									ban(source,data[1].identifier,data[1].license,data[1].liveid,data[1].xblid,data[1].discord,data[1].playerip,data[1].playerName,sourceplayername,duree,reason,0)
									TriggerClientEvent('chatMessage', -1, "[Admin]", {255, 0, 0}, "^1" .. name .. " ^0tavasot ^2" .. sourceplayername .. " ^0ban shod be modat ^8" .. duree .. " ^0rooz be dalile: ^3" .. reason )
									TriggerEvent('DiscordBot:ToDiscord', 'bansystem', 'BanSystem', name .. " tavasot " .. sourceplayername .. " ban shod be modat " .. duree .. " rooz be dalile : " .. reason  ,'user', true, source, false)
									end
								else
									ban(source,data[1].identifier,data[1].license,data[1].liveid,data[1].xblid,data[1].discord,data[1].playerip,data[1].playerName,sourceplayername,duree,reason,1)
									TriggerClientEvent('chatMessage', -1, "[Admin]", {255, 0, 0}, "^1" .. target .. " ^0tavasot ^2" .. sourceplayername .. " ^0permanent ban shod be dalile: ^3" .. reason )
									TriggerEvent('DiscordBot:ToDiscord', 'bansystemp', 'BanSystem', target .. " tavasot " .. sourceplayername .. " permanent ban shod be dalile : " .. reason  ,'user', true, source, false)
								end
							
							else
								TriggerEvent('bansql:sendMessage', source, Text.invalidid)
							end
						end)

					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Karbar mored nazar ^1Vojoud ^0nadarad!")
					end

				end)
			else
				TriggerEvent('bansql:sendMessage', source, Text.invalidname)
			end
		else
			TriggerEvent('bansql:sendMessage', source, Text.invalidtime)
			TriggerEvent('bansql:sendMessage', source, Text.cmdbanoff)
		end
	else
		TriggerEvent('bansql:sendMessage', source, Text.cmdbanoff)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM ', 'Insufficient Permissions.' } })
end, {help = Text.banoff, params = {{name = "day", help = Text.dayhelp}, {name = "name", help = Text.steamname}}})


-- console / rcon can also utilize es:command events, but breaks since the source isn't a connected player, ending up in error messages
AddEventHandler('bansql:sendMessage', function(source, message)
	if source ~= 0 then
		TriggerClientEvent('chat:addMessage', source, { args = { '^1Banlist ', message } } )
	else
		print('SqlBan: ' .. message)
	end
end)

AddEventHandler('playerConnecting', function (playerName,setKickReason)
	local steamID  = "empty"
	local license  = "empty"
	local liveid   = "empty"
	local xblid    = "empty"
	local discord  = "empty"
	local playerip = "empty"

	for k,v in ipairs(GetPlayerIdentifiers(source))do
		if string.sub(v, 1, string.len("steam:")) == "steam:" then
			steamID = v
		elseif string.sub(v, 1, string.len("license:")) == "license:" then
			license = v
		elseif string.sub(v, 1, string.len("live:")) == "live:" then
			liveid = v
		elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
			xblid  = v
		elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
			discord = v
		elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
			playerip = v
		end
	end

	--Si Banlist pas chargée
	if (Banlist == {}) then
		Citizen.Wait(1000)
	end

	for i = 1, #BanList, 1 do
		if 
			((tostring(BanList[i].identifier)) == tostring(steamID) 
			or (tostring(BanList[i].license)) == tostring(license) 
			or (tostring(BanList[i].liveid)) == tostring(liveid) 
			or (tostring(BanList[i].xblid)) == tostring(xblid) 
			or (tostring(BanList[i].discord)) == tostring(discord) 
			or (tostring(BanList[i].playerip)) == tostring(playerip)) 
		then

			if (tonumber(BanList[i].permanent)) == 1 then

				setKickReason(Text.yourpermban .. BanList[i].reason)
				CancelEvent()
				break

			elseif (tonumber(BanList[i].expiration)) > os.time() then

				local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
				if tempsrestant >= 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = (day - math.floor(day)) * 24
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day ..txthrs .. Text.hour ..txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant >= 60 and tempsrestant < 1440 then
					local day        = (tempsrestant / 60) / 24
					local hrs        = tempsrestant / 60
					local minutes    = (hrs - math.floor(hrs)) * 60
					local txtday     = math.floor(day)
					local txthrs     = math.floor(hrs)
					local txtminutes = math.ceil(minutes)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				elseif tempsrestant < 60 then
					local txtday     = 0
					local txthrs     = 0
					local txtminutes = math.ceil(tempsrestant)
						setKickReason(Text.yourban .. BanList[i].reason .. Text.timeleft .. txtday .. Text.day .. txthrs .. Text.hour .. txtminutes .. Text.minute)
						CancelEvent()
						break
				end

			elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

				deletebanned(steamID)
				break

			end
		end

	end

end)

AddEventHandler('esx:playerLoaded',function(source)
	CreateThread(function()
	Wait(5000)
		local steamID  = "no info"
		local license  = "no info"
		local liveid   = "no info"
		local xblid    = "no info"
		local discord  = "no info"
		local playerip = "no info"
		local playername = exports.essentialmode:GetPlayerICName(source)

		for k,v in ipairs(GetPlayerIdentifiers(source))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("live:")) == "live:" then
				liveid = v
			elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
				xblid  = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				discord = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
			end
		end

		MySQL.Async.fetchAll('SELECT * FROM `baninfo` WHERE `identifier` = @identifier', {
			['@identifier'] = steamID
		}, function(data)
		local found = false
			for i=1, #data, 1 do
				if data[i].identifier == steamID then
					found = true
				end
			end
			if not found then
				MySQL.Async.execute('INSERT INTO baninfo (identifier,license,liveid,xblid,discord,playerip,playername) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@playername)', 
					{ 
					['@identifier'] = steamID,
					['@license']    = license,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			else
				MySQL.Async.execute('UPDATE `baninfo` SET `license` = @license, `liveid` = @liveid, `xblid` = @xblid, `discord` = @discord, `playerip` = @playerip, `playername` = @playername WHERE `identifier` = @identifier', 
					{ 
					['@identifier'] = steamID,
					['@license']    = license,
					['@liveid']     = liveid,
					['@xblid']      = xblid,
					['@discord']    = discord,
					['@playerip']   = playerip,
					['@playername'] = playername
					},
					function ()
				end)
			end
		end)
		if Config.MultiServerSync then
			doublecheck(source)
		end
	end)
end)


RegisterServerEvent('BanSql:CheckMe')
AddEventHandler('BanSql:CheckMe', function()
	doublecheck(source)
end)

function ban(source,identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,permanent)
--calcul total expiration (en secondes)
	local expiration = duree * 86400
	local timeat     = os.time()
	local added      = os.date()
	local message
	
	if expiration < os.time() then
		expiration = os.time()+expiration
	end
	
		table.insert(BanList, {
			identifier = identifier,
			license    = license,
			liveid     = liveid,
			xblid      = xblid,
			discord    = discord,
			playerip   = playerip,
			reason     = reason,
			expiration = expiration,
			permanent  = permanent
          })

		MySQL.Async.execute(
                'INSERT INTO banlist (identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
                { 
				['@identifier']       = identifier,
				['@license']          = license,
				['@liveid']           = liveid,
				['@xblid']            = xblid,
				['@discord']          = discord,
				['@playerip']         = playerip,
				['@targetplayername'] = targetplayername,
				['@sourceplayername'] = sourceplayername,
				['@reason']           = reason,
				['@expiration']       = expiration,
				['@timeat']           = timeat,
				['@permanent']        = permanent,
				},
				function ()
		end)

		if permanent == 0 then
			TriggerEvent('bansql:sendMessage', source, (Text.youban .. targetplayername .. Text.during .. duree .. Text.forr .. reason))
			message = (targetplayername .. Text.isban .." ".. duree .. Text.forr .. reason .." ".. Text.by .." ".. sourceplayername.."```"..identifier .."\n".. license .."\n".. liveid .."\n".. xblid .."\n".. discord .."\n".. playerip .."```")
		else
			TriggerEvent('bansql:sendMessage', source, (Text.youban .. targetplayername .. Text.permban .. reason))
			message = (targetplayername .. Text.isban .." ".. Text.permban .. reason .." ".. Text.by .." ".. sourceplayername.."```"..identifier .."\n".. license .."\n".. liveid .."\n".. xblid .."\n".. discord .."\n".. playerip .."```")
		end

		MySQL.Async.execute(
                'INSERT INTO banlisthistory (identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,added,expiration,timeat,permanent) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@added,@expiration,@timeat,@permanent)',
                { 
				['@identifier']       = identifier,
				['@license']          = license,
				['@liveid']           = liveid,
				['@xblid']            = xblid,
				['@discord']          = discord,
				['@playerip']         = playerip,
				['@targetplayername'] = targetplayername,
				['@sourceplayername'] = sourceplayername,
				['@reason']           = reason,
				['@added']            = added,
				['@expiration']       = expiration,
				['@timeat']           = timeat,
				['@permanent']        = permanent,
				},
				function ()
		end)
		
		BanListHistoryLoad = false
end

function loadBanList()
	MySQL.Async.fetchAll(
		'SELECT * FROM banlist',
		{},
		function (data)
		  BanList = {}

		  for i=1, #data, 1 do
			table.insert(BanList, {
				identifier = data[i].identifier,
				license    = data[i].license,
				liveid     = data[i].liveid,
				xblid      = data[i].xblid,
				discord    = data[i].discord,
				playerip   = data[i].playerip,
				reason     = data[i].reason,
				expiration = data[i].expiration,
				permanent  = data[i].permanent
			  })
		  end
    end)
end

-- function loadBanListHistory()
-- 	MySQL.Async.fetchAll(
-- 		'SELECT * FROM banlisthistory',
-- 		{},
-- 		function (data)
-- 		  BanListHistory = {}

-- 		  for i=1, #data, 1 do
-- 			table.insert(BanListHistory, {
-- 				identifier       = data[i].identifier,
-- 				license          = data[i].license,
-- 				liveid           = data[i].liveid,
-- 				xblid            = data[i].xblid,
-- 				discord          = data[i].discord,
-- 				playerip         = data[i].playerip,
-- 				targetplayername = data[i].targetplayername,
-- 				sourceplayername = data[i].sourceplayername,
-- 				reason           = data[i].reason,
-- 				added            = data[i].added,
-- 				expiration       = data[i].expiration,
-- 				permanent        = data[i].permanent,
-- 				timeat           = data[i].timeat
-- 			  })
-- 		  end
--     end)
-- end

function deletebanned(identifier) 
	MySQL.Async.execute(
		'DELETE FROM banlist WHERE identifier=@identifier',
		{
		  ['@identifier']  = identifier
		},
		function ()
			loadBanList()
	end)
end

function doublecheck(player)
	if GetPlayerIdentifiers(player) then
		local steamID  = "empty"
		local license  = "empty"
		local liveid   = "empty"
		local xblid    = "empty"
		local discord  = "empty"
		local playerip = "empty"

		for k,v in ipairs(GetPlayerIdentifiers(player))do
			if string.sub(v, 1, string.len("steam:")) == "steam:" then
				steamID = v
			elseif string.sub(v, 1, string.len("license:")) == "license:" then
				license = v
			elseif string.sub(v, 1, string.len("live:")) == "live:" then
				liveid = v
			elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
				xblid  = v
			elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
				discord = v
			elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
				playerip = v
			end
		end

		for i = 1, #BanList, 1 do
			if 
				((tostring(BanList[i].identifier)) == tostring(steamID) 
				or (tostring(BanList[i].license)) == tostring(license) 
				or (tostring(BanList[i].liveid)) == tostring(liveid) 
				or (tostring(BanList[i].xblid)) == tostring(xblid) 
				or (tostring(BanList[i].discord)) == tostring(discord) 
				or (tostring(BanList[i].playerip)) == tostring(playerip)) 
			then

				if (tonumber(BanList[i].permanent)) == 1 then
					DropPlayer(player, Text.yourban .. BanList[i].reason)
					break

				elseif (tonumber(BanList[i].expiration)) > os.time() then

					local tempsrestant     = (((tonumber(BanList[i].expiration)) - os.time())/60)
					if tempsrestant > 0 then
						DropPlayer(player, Text.yourban .. BanList[i].reason)
						break
					end

				elseif (tonumber(BanList[i].expiration)) < os.time() and (tonumber(BanList[i].permanent)) == 0 then

					deletebanned(steamID)
					break

				end
			end
		end
	end
end
