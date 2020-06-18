TriggerEvent('es:addAdminCommand', 'addcar', 10, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then
			local newOwner = tonumber(args[1])
			if newOwner then
				local plate = args[2]
				TriggerClientEvent('addDonationCar', source, newOwner, plate)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Lotfan Id Sahebe Mashin Ro befrestid!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "add car for player", params = {{name = "PlayerID", help = "Id Playeri ke Online hast"}, {name = "Pelak", help = "Mitonid in bakhsh ro khali bezarid"}}})

TriggerEvent('es:addAdminCommand', 'tp', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			
			if x and y and z then
				TriggerClientEvent('esx:teleport', source, {
					x = x,
					y = y,
					z = z
				})
			else
				TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Invalid coordinates!")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = "Teleport to coordinates", params = {{name = "x", help = "X coords"}, {name = "y", help = "Y coords"}, {name = "z", help = "Z coords"}}})

TriggerEvent('es:addAdminCommand', 'setjob', 3, function(source, args, user)

	local admin = ESX.GetPlayerFromId(source)

		if admin.get('aduty') then

			if tonumber(args[1]) and args[2] and tonumber(args[3]) then
				local xPlayer = ESX.getPlayerFromId(args[1])

				if xPlayer then
					xPlayer.setJob(args[2], tonumber(args[3]))
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setjob'), params = {{name = "id", help = _U('id_param')}, {name = "job", help = _U('setjob_param2')}, {name = "grade_id", help = _U('setjob_param3')}}})

TriggerEvent('es:addAdminCommand', 'setgang', 3, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(args[1])
	local admin = ESX.GetPlayerFromId(source)
	if admin.get('aduty') then
		if tonumber(args[1]) and args[2] and tonumber(args[3]) then

			if xPlayer then
				if ESX.DoesGangExist(args[2], args[3]) then
					xPlayer.setGang(args[2], args[3])
				else
					TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'That gang does not exist.' } })
				end

			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addAdminCommand', 'creategang', 5, function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.get('aduty') then
		if args[1] and tonumber(args[2]) then
			TriggerEvent('gangs:registerGang', _source, args[1], args[2])
		else
			TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid usage.' } })
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addAdminCommand', 'savegangs', 5, function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.get('aduty') then
		TriggerEvent('gangs:saveGangs', _source)
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)


TriggerEvent('es:addAdminCommand', 'changegangdata', 5, function(source, args, user)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.get('aduty') then
		local playerPos = xPlayer.coords
		if ESX.DoesGangExist(args[1], 6) then
			if args[2] == 'blip' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z + 0.5 }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'armory' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'locker' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'boss' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'veh' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'vehdel' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = (playerPos.z - 1.0) }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'vehspawn' then
				local Pos     = { x = playerPos.x, y = playerPos.y, z = playerPos.z , a = xPlayer.angel }
				TriggerEvent('gangs:changeGangData', args[1], args[2], Pos, _source)
			elseif args[2] == 'expire' then
				if tonumber(args[3]) then
					TriggerEvent('gangs:changeGangData', args[1], args[2], args[3], _source)
				else
					TriggerClientEvent('esx:showNotification', source, 'Please enter a number for days are gonna to set until expire, like: 30')
				end
			else
				TriggerClientEvent('esx:showNotification', source, 'You Entered Invalid Option!')
			end
		else
			TriggerClientEvent('esx:showNotification', source, 'You Entered Invalid Gang!')
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'loadipl', 'admin', function(source, args, user)
	TriggerClientEvent('esx:loadIPL', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('load_ipl')})

TriggerEvent('es:addGroupCommand', 'unloadipl', 'admin', function(source, args, user)
	TriggerClientEvent('esx:unloadIPL', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('unload_ipl')})

TriggerEvent('es:addGroupCommand', 'playanim', 'admin', function(source, args, user)
	TriggerClientEvent('esx:playAnim', -1, args[1], args[3])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_anim')})

TriggerEvent('es:addGroupCommand', 'playemote', 'admin', function(source, args, user)
	TriggerClientEvent('esx:playEmote', -1, args[1])
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('play_emote')})

TriggerEvent('es:addAdminCommand', 'car', 4, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)
	
		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:spawnVehicle', source, args[1])

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_car'), params = {{name = "car", help = _U('spawn_car_param')}}})

TriggerEvent('es:addAdminCommand', 'cardel', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:deleteVehicle', source)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('delete_vehicle')})

TriggerEvent('es:addAdminCommand', 'dv', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:deleteVehicle', source)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('delete_vehicle')})

TriggerEvent('es:addAdminCommand', 'spawnped', 4, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:spawnPed', source, args[1])

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_ped'), params = {{name = "name", help = _U('spawn_ped_param')}}})

TriggerEvent('es:addAdminCommand', 'spawnobject', 4, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('esx:spawnObject', source, args[1])

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('spawn_object'), params = {{name = "name"}}})

TriggerEvent('es:addAdminCommand', 'setmoney', 10, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			local _source = source
			local target = tonumber(args[1])
			local money_type = args[2]
			local money_amount = tonumber(args[3])
			
			local tPlayer = ESX.getPlayerFromId(target)

			if target and money_type and money_amount and tPlayer ~= nil then
				if money_type == 'cash' then
					xPlayer.setMoney(money_amount)
					TriggerEvent('DiscordBot:ToDiscord', 'amoney', 'Set Money Log', string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(xPlayer.source) .. ")" .. ' Pool jibe ' .. string.gsub(tPlayer.name, "_", " ") .. " (" .. GetPlayerName(tPlayer.source) .. ")" .. ' ra roye ' .. money_amount .. '$ set kard!','user', true, source, false)
				elseif money_type == 'bank' then
					xPlayer.setBank(money_amount)
					TriggerEvent('DiscordBot:ToDiscord', 'amoney', 'Set Money Log', string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(xPlayer.source) .. ")" .. ' Pool banke ' .. string.gsub(tPlayer.name, "_", " ") .. " (" .. GetPlayerName(tPlayer.source) .. ")" .. ' ra roye ' .. money_amount .. '$ set kard!','user', true, source, false)
				else
					TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "^2" .. money_type .. " ^0 is not a valid money type!")
					return
				end
			else
				TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Invalid arguments.")
				return
			end
			
			print('es_extended: ' .. GetPlayerName(source) .. ' just set $' .. money_amount .. ' (' .. money_type .. ') to ' .. xPlayer.name)
			
			if xPlayer.source ~= _source then
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('money_set', money_amount, money_type))
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('setmoney'), params = {{name = "id", help = _U('id_param')}, {name = "money type", help = _U('money_type')}, {name = "amount", help = _U('money_amount')}}})

TriggerEvent('es:addAdminCommand', 'giveitem', 10, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then
		if tonumber(args[1]) and args[2] then
			local _source = source
			local xPlayer = ESX.getPlayerFromId(args[1])
			local item    = args[2]
			local count   = (args[3] == nil and 1 or tonumber(args[3]))

			if count ~= nil then
				if xPlayer.getInventoryItem(item) ~= nil then
					xPlayer.addInventoryItem(item, count)
				else
					TriggerClientEvent('esx:showNotification', _source, _U('invalid_item'))
				end
			else
				TriggerClientEvent('esx:showNotification', _source, _U('invalid_amount'))
			end
		else
			TriggerClientEvent('chatMessage', _source, "SYSTEM", {255, 0, 0}, "Invalid arguments.")
			return
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveitem'), params = {{name = "id", help = _U('id_param')}, {name = "item", help = _U('item')}, {name = "amount", help = _U('amount')}}})

TriggerEvent('es:addAdminCommand', 'giveweapon', 10, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then
			if tonumber(args[1]) and args[2] and tonumber(args[3]) then
				local xPlayer    = ESX.getPlayerFromId(args[1])
				local weaponName = string.upper(args[2])
			
				xPlayer.addWeapon(weaponName, tonumber(args[3]))
			else
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid Usage.' } })
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('giveweapon'), params = {{name = "id", help = _U('id_param')}, {name = "weapon", help = _U('weapon')}, {name = "ammo", help = _U('amountammo')}}})

TriggerEvent('es:addGroupCommand', 'relog', 'user', function(source, args, user)
	DropPlayer(source, 'You have reserved slot for next two min.')
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addGroupCommand', 'clear', 'user', function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('chat:clear', source)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('chat_clear')})

TriggerEvent('es:addAdminCommand', 'clearall', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('chat:clear', -1)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end)

TriggerEvent('es:addAdminCommand', 'clearinventory', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			local xPlayer

			if args[1] then
				xPlayer = ESX.getPlayerFromId(args[1])
			else
				xPlayer = ESX.getPlayerFromId(source)
			end

			if not xPlayer then
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
				return
			end

			for i=1, #xPlayer.inventory, 1 do
				if xPlayer.inventory[i].count > 0 then
					xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
				end
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearinventory'), params = {{name = "playerId", help = _U('command_playerid_param')}}})

TriggerEvent('es:addAdminCommand', 'clearloadout', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			local xPlayer

			if args[1] then
				xPlayer = ESX.getPlayerFromId(args[1])
			else
				xPlayer = ESX.getPlayerFromId(source)
			end
		
			if not xPlayer then
				TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
				return
			end
		
			for i=1, #xPlayer.loadout, 1 do
				xPlayer.removeWeapon(xPlayer.loadout[i].name)
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = _U('command_clearloadout'), params = {{name = "playerId", help = _U('command_playerid_param')}}})

-- Noclip
TriggerEvent('es:addAdminCommand', 'noclip', 2, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent("es_admin:noclip", source)

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Enable or disable noclip"})

-- Kicking
--TriggerEvent('es:addAdminCommand', 'kick', 1, function(source, args, user)
--	if args[1] then
	--	if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
		--	local player = tonumber(args[1])

			-- User permission check
		--	TriggerEvent("es:getPlayerFromId", player, function(target)

			--	local reason = args
			--	table.remove(reason, 1)
			--	if(#reason == 0)then
				--	reason = "Kicked: You have been kicked from the server"
			--	else
				--	reason = "Kicked: " .. table.concat(reason, " ")
			--	end

			--	TriggerClientEvent('chat:addMessage', -1, {
			--		args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been kicked(^2" .. reason .. "^0)"}
			--	})
			--	DropPlayer(player, reason)
			--end)
	--	else
		--	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
	--	end
--	else
	--	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
--	end
--end, function(source, args, user)
	--TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
--end, {help = "Kick a user with the specified reason or no reason", params = {{name = "userid", help = "The ID of the player"}, {name = "reason", help = "The reason as to why you kick this player"}}})

-- Announcing
TriggerEvent('es:addAdminCommand', 'announce', 4, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			TriggerClientEvent('chat:addMessage', -1, {
				args = {"^1ANNOUNCEMENT", table.concat(args, " ")}
			})

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Announce a message to the entire server", params = {{name = "announcement", help = "The message to announce"}}})

-- Freezing
local frozen = {}
TriggerEvent('es:addAdminCommand', 'freeze', 2, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
		
						if(frozen[player])then
							frozen[player] = false
						else
							frozen[player] = true
						end
		
						TriggerClientEvent('es_admin:freezePlayer', player, frozen[player])
		
						local state = "unfrozen"
						if(frozen[player])then
							state = "frozen"
						end
		
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been " .. state .. " by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been " .. state} })
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Freeze or unfreeze a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Bring
TriggerEvent('es:addAdminCommand', 'bring', 1, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if args[1] then
			if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
				local player = tonumber(args[1])
		
					-- User permission check
				TriggerEvent("es:getPlayerFromId", player, function(target)
					if target then
						TriggerClientEvent('es_admin:teleportUser', target.get('source'), user.coords.x, user.coords.y, user.coords.z)
			
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have brought by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been brought"} })
					else
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "That player is offline"} })
					end
				end)
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
		end
	
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport a user to you", params = {{name = "userid", help = "The ID of the player"}}})

-- Slap
TriggerEvent('es:addAdminCommand', 'slap', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
		
						TriggerClientEvent('es_admin:slap', player)
		
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have slapped by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been slapped"} })
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slap a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Goto
TriggerEvent('es:addAdminCommand', 'goto', 2, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
						if(target)then
		
							TriggerClientEvent('es_admin:teleportUser', source, target.coords.x, target.coords.y, target.coords.z)
		
							TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been teleported to by ^2" .. GetPlayerName(source)} })
							TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Teleported to player ^2" .. GetPlayerName(player) .. ""} })
						end
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Teleport to a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Slay a player
TriggerEvent('es:addAdminCommand', 'slay', 4, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
		
						TriggerClientEvent('es_admin:kill', player)
		
						TriggerClientEvent('chat:addMessage', player, { args = {"^1SYSTEM", "You have been killed by ^2" .. GetPlayerName(source)} })
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been killed."} })
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Slay a user", params = {{name = "userid", help = "The ID of the player"}}})

-- Crashing
TriggerEvent('es:addAdminCommand', 'crash', 7, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					-- User permission check
					TriggerEvent("es:getPlayerFromId", player, function(target)
		
						TriggerClientEvent('es_admin:crash', player)
		
						TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Player ^2" .. GetPlayerName(player) .. "^0 has been crashed."} })
					end)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Crash a user", params = {{name = "userid", help = "The ID of the player"}}})

TriggerEvent('es:addAdminCommand', 'fix', 3, function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.get('aduty') then

			if args[1] then
				if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
					local player = tonumber(args[1])
		
					TriggerClientEvent('es_admin:repair', player)
				else
					TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Incorrect player ID"}})
				end
			else
				TriggerClientEvent('es_admin:repair', source)
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Repair a car"})

TriggerEvent('es:addCommand', 'admin', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Level: ^*^2 " .. tostring(user.get('permission_level'))}
	})
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1SYSTEM", "Group: ^*^2 " .. user.group}
	})
end, {help = "Shows what admin level you are and what group you're in"})

TriggerEvent('es:addCommand', 'report', function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, {
		args = {"^1REPORT", " (^2" .. GetPlayerName(source) .. " | " .. source .. "^0) " .. table.concat(args, " ")}
	})

	TriggerEvent("es:getPlayers", function(pl)
		for k,v in pairs(pl) do
			TriggerEvent("es:getPlayerFromId", k, function(user)
				if(user.permission_level > 0 and k ~= source)then
					TriggerClientEvent('chat:addMessage', k, {
						args = {"^1REPORT", " (^2" .. GetPlayerName(source) .." | "..source.."^0) " .. table.concat(args, " ")}
					})
				end
			end)
		end
	end)
end, {help = "Report a player or an issue", params = {{name = "report", help = "What you want to report"}}})

TriggerEvent('es:addAdminCommand', 'skinreload', 3, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then

		if args[1] then
			if args[1] == 'all' then
				TriggerClientEvent('esx_skin:reloadMe',-1)
			elseif type(tonumber(args[1])) == 'number' then
				TriggerClientEvent('esx_skin:reloadMe',args[1])
			else
				TriggerClientEvent('chat:addMessage', source, {
					args = {"[^1System^0]", " ^2 You Entered Wrong option! " .. args[1]}
				})
			end
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"[^1System^0]", " ^2 Enter option Please! " .. args[1]}
			})
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Reload a Player Skin"})

TriggerEvent('es:addAdminCommand', 'charmenu', 3, function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('aduty') then

		if args[1] then
			if type(tonumber(args[1])) == 'number' then
				TriggerClientEvent('skincreator:newChar',args[1])
			else
				TriggerClientEvent('chat:addMessage', source, {
					args = {"[^1System^0]", " ^2 You Didnt Enter a ID! " .. args[1]}
				})
			end
		else
			TriggerClientEvent('chat:addMessage', source, {
				args = {"[^1System^0]", " ^2 Enter ID Please! " .. args[1]}
			})
		end
	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
	end

end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1SYSTEM", "Insufficienct permissions!"} })
end, {help = "Show Character Create Menu to a Player "})