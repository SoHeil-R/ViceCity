ESX = nil
local target = 0

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("cpr", function(source, args, user)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == "police" or xPlayer.job.name == "ambulance" then

		MySQL.Async.fetchAll("SELECT is_dead FROM users WHERE identifier=@identifier",{
			['@identifier'] = xPlayer.identifier,
		}, 
		function(result)

				if result[1].is_dead ~= true then
					
					if args[1] then
						target = tonumber(args[1])
						
						-- is the argument a number?
						if target ~= nil then
				
							if GetPlayerName(source) ~= GetPlayerName(target) then 
							
							-- is the number a valid player?
							if GetPlayerName(target) then
				
								MySQL.Async.fetchAll("SELECT is_dead FROM users WHERE identifier=@identifier",{
									['@identifier'] = GetPlayerIdentifiers(target)[1],
								}, 
								function(result)
				
										if result[1].is_dead then


											MySQL.Async.fetchAll("SELECT isBeingCprd FROM users WHERE identifier=@identifier",{
												['@identifier'] = GetPlayerIdentifiers(target)[1],
											}, 
											function(result)
							
													if result[1].isBeingCprd == false then
														-- TriggerClientEvent('esx_cpr:healPlayer', target)
														TriggerClientEvent('esx_cpr:dothecpr', source, target)
								                            
													else
														TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Player mored nazar yekbar cpr shode ast!")
													end
											end)
											
										else
											TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Player mored nazar zakhmi nist!")
										end
								end)
				
							else
								TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Player mored nazar online nist!")
							end
				
						else
							TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Shoma nemitavanid khodetan ra CPR konid!")
						end
				
						else
							TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid")
						end
				
					else
						TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Shoma hich IDi vared nakardid")
					end

				else
					TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "Shoma nemitavanid hengami ke zakhmi hastid digaran ra CPR konid!")
				end
		end)
	
	
else
    TriggerClientEvent("esx:showNotification", source, "~r~~h~Shoma police ya medic nisid!")
end

end, false)

ESX.RegisterServerCallback('esx_cpr:checkdeath', function(source, cb, target)
	CheckInjuredState(target, cb)
end)

function CheckInjuredState(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT is_dead FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1].is_dead then
				cb(true)
			else
				cb(false)
			end
		end
	)
end

RegisterServerEvent('esx_cpr:healplayer')
AddEventHandler('esx_cpr:healplayer', function(target)

	TriggerClientEvent('esx_cpr:healPlayerClient', target)
	

end)

RegisterServerEvent('esx_cpr:sendmessagetarget')
AddEventHandler('esx_cpr:sendmessagetarget', function(target)
	TriggerClientEvent('chatMessage', target, "[CPR]", {255, 0, 0}, "^0Shoma tavasot ^3" .. GetPlayerName(source) .. "^0 CPR shodid!")
end)

RegisterServerEvent('esx_cpr:sendmessage')
AddEventHandler('esx_cpr:sendmessage', function(target)
	TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "^0Shoma ^3" .. GetPlayerName(target) .. "^0 ra CPR kardid!")
end)

RegisterServerEvent('esx_cpr:sendmessagenotnear')
AddEventHandler('esx_cpr:sendmessagenotnear', function(target)
	TriggerClientEvent('chatMessage', source, "[CPR]", {255, 0, 0}, "^3" .. GetPlayerName(target) .. "^0 Nazdik shoma nist!")
end)

RegisterServerEvent('esx_cpr:setCprStatus')
AddEventHandler('esx_cpr:setCprStatus', function(target, isBeingCprd)
	local identifier = GetPlayerIdentifiers(target)[1]

	if type(isBeingCprd) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET isBeingCprd = @isBeingCprd WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isBeingCprd'] = isBeingCprd
	})
end)