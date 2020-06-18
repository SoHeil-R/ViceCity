ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 50000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

RegisterCommand('heal', function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.permission_level > 1 then
			if xPlayer.get('aduty') then
				if args[1] then
					local playerId = tonumber(args[1])

					-- is the argument a number?
					if playerId then
						-- is the number a valid player?
						if GetPlayerName(playerId) then
							print(('esx_basicneeds: %s healed %s'):format(GetPlayerIdentifier(source, 0), GetPlayerIdentifier(playerId, 0)))
							TriggerClientEvent('esx_basicneeds:healPlayer', playerId)
							TriggerClientEvent('chat:addMessage', source, { args = { '^5HEAL', 'You have been healed.' } })
						else
							TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Player not online.' } })
						end
					else
						TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Invalid player id.' } })
					end
				else
					print(('esx_basicneeds: %s healed self'):format(GetPlayerIdentifier(source, 0)))
					TriggerClientEvent('esx_basicneeds:healPlayer', source)
				end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
			end
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
		end

end, false)