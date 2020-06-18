ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetTime()

	local timestamp = os.time()
	local d         = os.date('%x', timestamp)
	local h         = tonumber(os.date('%H', timestamp))
	local m         = tonumber(os.date('%M', timestamp))
	local s         = tonumber(os.date('%S', timestamp))

	return {d = d, h = h, m = m, s = s}
end

RegisterCommand('ti', function(source, args)
    local myTime = GetTime()
	TriggerClientEvent('chatMessage', source, "[Time]: ", {253, 216, 53}, myTime.d..'  '..myTime.h..':'..myTime.m..':'..myTime.s)
end)

RegisterCommand('mcar', function(source, args)
    
    local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.permission_level > 1 then

			if xPlayer.get('aduty') then 

						if args[1] then
							
							if args[2] then

								if args[2] == "true" then

									TriggerClientEvent('sf:spawnVehicle', source, args[1], true)

								elseif args[2] == "false" then

									TriggerClientEvent('sf:spawnVehicle', source, args[1], false)
								
								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat turbo faghat mitavanid true ya false vared konid.")
								
								end

							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat turbo chizi vared nakardid!")
							end
                            
						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat esm mashin chizi vared nakardid!")
						end
			else

				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

			end
						
		
		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
		end

end, false)