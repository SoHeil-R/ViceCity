ESX = nil
local mutedTable = {}

Citizen.CreateThread(function()    
   while ESX == nil do              TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)        
   Citizen.Wait(0)    
end     
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			name = string.gsub(identity['playerName'], "_", " "),
			dateofbirth = identity['dateofbirth'],
		}
	else
		return nil
	end
end

	AddEventHandler('chatMessage', function(source, name, message)
		if string.sub(message, 1, string.len("/")) ~= "/" then
			CancelEvent()
			local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessage", -1, source, name.name, message)
		end
		CancelEvent()
	end)
	
	TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
		local name =  GetPlayerName(source)
			TriggerClientEvent("sendProximityMessageMe", -1, source, "OOC | " .. name, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 'b', function(source, args, user)
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, "OOC | " .. name, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 's', function(source, args, user)
		local name = getIdentity(source)
		if args[1] then
		TriggerClientEvent("sendProximityMessageShout", -1, source, name.name .. " Faryad Mizanad", table.concat(args, " "))
		end
	end)

	-- TriggerEvent('es:addCommand', 'mp', function(source, args, user)
	-- 	xPlayer = ESX.GetPlayerFromId(source)
	-- 	if xPlayer.job.name == 'police' then
	-- 		TriggerClientEvent("sendProximityMessageMP", -1, source, "Bolandgo Police", table.concat(args, " "))
	-- 	end
	-- end)

	RegisterServerEvent('mpCommand')
	AddEventHandler('mpCommand', function(message)
		xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.job.name == 'police' then
			TriggerClientEvent("sendProximityMessageMP", -1, source, "Bolandgo Police", message)
		end
	end)

	RegisterServerEvent('proxevent')
	AddEventHandler('proxevent', function(message)
		local name =  GetPlayerName(source)
		TriggerClientEvent("sendProximityMessageProxevent", -1, source, "[Event]", name..' '..message)
	end)

	TriggerEvent('es:addCommand', 'do', function(source, args, user)
		local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageDo", -1, source, name.name, table.concat(args, " "))
	end)

	TriggerEvent('es:addCommand', 'tabligh', function(source, args, user)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.job.name == "journaliste" then
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Tabligh ferestade shod", type = "success", timeout = 3000, layout = "bottomCenter"})
			local name = getIdentity(source)
			TriggerClientEvent('chatMessage', -1, "[Tablighat] @" .. name.name ..'_'.. name.lastname .. "", {30, 144, 255}, table.concat(args, " "))
		else
			TriggerClientEvent("pNotify:SendNotification", source, {text = "Shoma Khabar negar nistid", type = "error", timeout = 3000, layout = "bottomCenter"})
		end
	end, {help = 'ye tablighat befres'})

	TriggerEvent('es:addCommand', 'aooc', function(source, args, user)

		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					local name =  GetPlayerName(source)
			        TriggerClientEvent("sendProximityMessageMe", -1, source, "^1Admin | " .. name, "^*" .. table.concat(args, " "))
					
				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
					
				end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
		end

	end, {help = 'admin chat ooc'})

	TriggerEvent('es:addCommand', 'ab', function(source, args, user)

		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					local name =  GetPlayerName(source)
			        TriggerClientEvent("sendProximityMessageMe", -1, source, "^1Admin | " .. name, "^*" .. table.concat(args, " "))
					
				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
					
				end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
		end

	end, {help = 'admin chat ooc'})

	-- TriggerEvent('es:addCommand', 'b', function(source, args, user)
	-- 	-- local name = getIdentity(source)
	-- 	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source) .. ": ", {200, 200, 200}, table.concat(args, " "))
	-- end, {help = 'Out Of Character message'})

	-- TriggerEvent('es:addCommand', 'ooc', function(source, args, user)
	-- 	-- local name = getIdentity(source)
	-- 	TriggerClientEvent('chatMessage', -1, "OOC | " .. GetPlayerName(source) .. ": ", {200, 200, 200}, table.concat(args, " "))
	-- end, {help = 'Out Of Character message'})

function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
