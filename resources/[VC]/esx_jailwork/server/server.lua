ESX                = nil

local jailone = false
local jailtwo = false
local jailthree = false
local jailfour = false
local bjailone = false
local bjailtwo = false
local bjailthree = false
local bjailfour = false
local bjailfive = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('playerDropped', function(reason)
	local _source = source
			
		exports.ghmattimysql:scalar(
			'SELECT cell FROM users WHERE identifier=@identifier',
			{
				['@identifier'] = GetPlayerIdentifier(_source),
			}, function(cell)
				
				if cell then
	
					if cell == "jailone" then
		
						jailone = false
						
					elseif cell == "jailtwo" then
		
						jailtwo = false
					
					elseif cell == "jailthree" then
		
						jailthree = false
					
					elseif cell == "jailfour" then
		
						jailfour = false
					
					elseif cell == "bjailone" then

						bjailone = false
					
					elseif cell == "bjailtwo" then

						bjailtwo = false

					elseif cell == "bjailthree" then

						bjailthree = false

					elseif cell == "bjailfour" then

						bjailfour = false

					elseif cell == "bjailfive" then

						bjailfive = false
		
					end
					
				end
	
			end)

end)

TriggerEvent('es:addCommand', 'jail', function(src, args, user)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then
		if args[1] and args[2] and args[3] and args[4] then
			if tonumber(args[1]) then
				if tonumber(args[3]) then
					if tonumber(args[3]) <= 60 then

		local jailPlayer = tonumber(args[1])
		local jailId =  args[2]
		local jailTime = tonumber(args[3])
		local jailReason = table.concat(args, " ",4)
		
	if jailId == "jail" or jailId == "prison" then

		if jailId == "jail" then

			if GetPlayerName(jailPlayer) then

				local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)

				MySQL.Async.fetchAll(
				'SELECT jail FROM users WHERE identifier=@identifier',
				{
					['@identifier'] = GetPlayerIdentifier(jailPlayer)
				}, function(result)
					if result[1].jail == 0 then
						
						if not bjailone then

							JailPlayer(jailPlayer, jailTime, 1, "bjailone")
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		
							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
							
								GetRPName(jailPlayer, function(name)
									TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
								end)
								
							MySQL.Async.execute('UPDATE users SET cell="bjailone" WHERE identifier=@identifier', 
							{
								['@identifier'] = GetPlayerIdentifier(jailPlayer) 
							})
		
							bjailone = true
		
						elseif not bjailtwo then
		
							JailPlayer(jailPlayer, jailTime, 1, "bjailtwo")
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		
							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
							
								GetRPName(jailPlayer, function(name)
									TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
								end)
							MySQL.Async.execute('UPDATE users SET cell="bjailtwo" WHERE identifier=@identifier', 
							{
								['@identifier'] = GetPlayerIdentifier(jailPlayer) 
							})
							bjailtwo = true
		
						elseif not bjailthree then
		
							JailPlayer(jailPlayer, jailTime, 1, "bjailthree")
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		
							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
							
								GetRPName(jailPlayer, function(name)
									TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
								end)
							MySQL.Async.execute('UPDATE users SET cell="bjailthree" WHERE identifier=@identifier', 
							{
								['@identifier'] = GetPlayerIdentifier(jailPlayer) 
							})
							bjailthree = true
						
						elseif not bjialfour then
		
							JailPlayer(jailPlayer, jailTime, 1, "bjailfour")
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		
							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
							
								GetRPName(jailPlayer, function(name)
									TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
								end)
							MySQL.Async.execute('UPDATE users SET cell="bjailfour" WHERE identifier=@identifier', 
							{
								['@identifier'] = GetPlayerIdentifier(jailPlayer) 
							})
							bjailfour = true
					
						elseif not bjailfive then
		
							JailPlayer(jailPlayer, jailTime, 1, "bjailfive")
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		
							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
							
								GetRPName(jailPlayer, function(name)
									TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
								end)
							MySQL.Async.execute('UPDATE users SET cell="bjailfive" WHERE identifier=@identifier', 
							{
								['@identifier'] = GetPlayerIdentifier(jailPlayer) 
							})
							bjailfive = true
						
						else
		
							TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Tamami selol haye PD por ast!")
		
						end
						

					else

						TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar ghablan zendani shode ast.")

					end
		
				end)

			
			else
			
				TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")

			end

		elseif jailId == "prison" then


			if GetPlayerName(jailPlayer) ~= nil then

				if jailTime ~= nil then

					MySQL.Async.fetchAll(
					'SELECT jail FROM users WHERE identifier=@identifier',
					{
						['@identifier'] = GetPlayerIdentifier(jailPlayer)
					}, function(result)
						if result[1].jail == 0 then
							
							local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
							JailPlayer(jailPlayer, jailTime, 2, nil)
							TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)

							TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
						
							GetRPName(jailPlayer, function(name)
								TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ",  "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
							end)
							

						else

							TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar ghablan zendani shode ast.")

						end
			
					end)

				else
					TriggerClientEvent("esx:showNotification", src, "Zaman na motabar!")
				end

			else
				TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
			end


		end

	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Jail vared shode sahih nist!")
	end

	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Zaman zendan nemitavanad bishtar az 60 daghighe bashad.")
	end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid.")
	end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
	end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Syntax vared shode eshtebah ast.")
	end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid!")
	end

end, {help = "Jahat jail kardan player", params = { { name="ID", help="ID player mored nazar" }, { name="Makan", help="Entekhab makan jail mitavanad jail ya prison bashad" }, { name="Zaman", help="Zaman jail" }, { name="Dalil", help="Dalil jail" } }})

RegisterCommand("ajail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

							if args[1] and args[2] and args[3] then
								if tonumber(args[1]) then
									if tonumber(args[2]) then
							
						local jailPlayer = tonumber(args[1])
						local jailTime = tonumber(args[2])
						local jailReason = table.concat(args, " ",3)
				
						if GetPlayerName(jailPlayer) ~= nil then
				
							if jailTime ~= nil then

								local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
				
									
									MySQL.Async.execute('INSERT INTO adminjaillog (identifier, name, jailreason, jailtime, punisher) VALUES (@identifier, @name, @reason, @jailtime, @punisher)', 
											{
												['@identifier'] = GetPlayerIdentifiers(jailPlayer)[1], 
												['@name'] = GetPlayerName(jailPlayer),
												['@jailtime'] = jailTime,
												['@reason'] = jailReason,
												['@punisher']= GetPlayerName(src)
											})
				
											TriggerClientEvent('chatMessage', -1, "[AdminJail]", {255, 0, 0}, "^1" .. GetPlayerName(jailPlayer) .. "^0 Admin jail shod be Dalile:^2 " .. jailReason .. "^0 Be modat ^3" .. jailTime .. " ^0Daghighe")
				
								JailPlayer(jailPlayer, jailTime, 2 , nil)
								TriggerEvent('DiscordBot:ToDiscord', 'ajail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
				
								TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
								
							else
								TriggerClientEvent("esx:showNotification", src, "Zaman na motabar ast!")
							end
						else
							TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player  mored nazar online nist!")
						end
					else
						TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid.")
					end
					else
						TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
					end
					else
						TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Syntax vared shode eshtebah ast.")
					end
					
				else

					TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
					
				end
	
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
	end
end)

RegisterCommand("aunjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer.permission_level > 1 then

				if xPlayer.get('aduty') then

					if tonumber(args[1]) then
						local jailPlayer = args[1]
				
						if GetPlayerName(jailPlayer) ~= nil then
							local jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
							TriggerClientEvent('chatMessage', src, "[AdminJail]", {255, 0, 0}, "^2" .. GetPlayerName(tonumber(args[1])) .. " ^0unjail shod!")
							UnJail(jailPlayer)
							TriggerEvent('DiscordBot:ToDiscord', 'ajail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(args[1]) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
						else
							TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
						end
					else
						TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
					end
					
				else

					TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, " ^0Shoma nemitavanid dar halat ^1OffDuty ^0az command haye admini estefade konid!")
					
				end
	

	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma admin nistid!")
	end
end)


TriggerEvent('es:addCommand', 'unjail', function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)
	local name = GetPlayerName(src)

	if xPlayer["job"]["name"] == "police" then
        if tonumber(args[1]) then
		local jailPlayer = tonumber(args[1])

		if GetPlayerName(jailPlayer) ~= nil then
			jailPlayerData = ESX.GetPlayerFromId(jailPlayer)
			TriggerClientEvent('chatMessage', src, "[POLICE]", {255, 0, 0}, "^2" .. GetPlayerName(tonumber(args[1])) .. " ^0unjail shod!")
			UnJail(jailPlayer)
			TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(jailPlayer) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
		else
			TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist!")
		end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")
	end
	else
		TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid!")
	end
end, {help = "Jahat unjail kardan player", params = { { name="ID", help="ID player mored nazar" } }})

RegisterCommand("solitary", function(source, args)

	local xPlayer = ESX.GetPlayerFromId(source)

		if xPlayer.job.name == "police" then

			if args[1] then

				local target = tonumber(args[1])

					if target then

						if GetPlayerName(target) then

							if args[2] then

								local jailtime = tonumber(args[2])

								if jailtime then

									local targetPlayer = ESX.GetPlayerFromId(target)

										MySQL.Async.fetchAll(
											'SELECT jail FROM users WHERE identifier=@identifier',
											{
												['@identifier'] = targetPlayer.identifier
											}, function(result)
												if result[1].jail > 0 then
													
													exports.ghmattimysql:scalar(
														'SELECT cell FROM users WHERE identifier=@identifier',
														{
															['@identifier'] = GetPlayerIdentifier(_source),
														}, function(cell)
														if cell == nil then
															
														exports.ghmattimysql:scalar(
														'SELECT solitary FROM users WHERE identifier=@identifier',
														{
															['@identifier'] = targetPlayer.identifier
														}, function(solitary)
															if solitary == false then
																
																if not jailone then
															
																	jailone = true
					
																	TriggerClientEvent('esx-qalle-jail:solitaryEffects', target, jailtime, "jailone")

																	MySQL.Async.execute('UPDATE users SET solitary=true WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target)
																		
																	})

																	MySQL.Async.execute('UPDATE users SET cell="jailone" WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target) 
																	})

																	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma ^1" .. GetPlayerName(target) .. "^0 ra be enferadi enteghal dadid va ^3" .. jailtime .. " ^0daghighe be zaman zendan fard ezafe kardid!")
																	TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, "Mamoran zendan be dastor ^2" .. GetPlayerName(source) .. "^0 shoma ra be enferadi enteghal dadand va ^1" .. jailtime .. " ^0daghighe be zaman zendan shoma ezafe shod!")
																	TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Solitary Log', 'Mamoran zendan be dastor ' .. GetPlayerName(source) .. ", " .. GetPlayerName(target) .. ' ra be enferadi enteghal dadand va ' .. jailtime .. ' daghighe be zaman zendan fard ezafe shod!','user', true, source, false)
					
																elseif not jailtwo then
					
																	jailtwo = true
					
																	TriggerClientEvent('esx-qalle-jail:solitaryEffects', target, jailtime, "jailtwo")

																	MySQL.Async.execute('UPDATE users SET solitary=true WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target)
																		
																	})

																	MySQL.Async.execute('UPDATE users SET cell="jailtwo" WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target) 
																	})

																	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma ^1" .. GetPlayerName(target) .. "^0 ra be enferadi enteghal dadid va ^3" .. jailtime .. " ^0daghighe be zaman zendan fard ezafe kardid!")
																	TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, "Mamoran zendan be dastor ^2" .. GetPlayerName(source) .. "^0 shoma ra be enferadi enteghal dadand va ^1" .. jailtime .. " ^0daghighe be zaman zendan shoma ezafe shod!")
																	TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Solitary Log', 'Mamoran zendan be dastor ' .. GetPlayerName(source) .. ", " .. GetPlayerName(target) .. ' ra be enferadi enteghal dadand va ' .. jailtime .. ' daghighe be zaman zendan fard ezafe shod!','user', true, source, false)
					
																elseif not jailthree then
					
																	jailthree = true
					
																	TriggerClientEvent('esx-qalle-jail:solitaryEffects', target, jailtime, "jailthree")

																	MySQL.Async.execute('UPDATE users SET solitary=true WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target)
																		
																	})

																	MySQL.Async.execute('UPDATE users SET cell="jailthree" WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target) 
																	})

																	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma ^1" .. GetPlayerName(target) .. "^0 ra be enferadi enteghal dadid va ^3" .. jailtime .. " ^0daghighe be zaman zendan fard ezafe kardid!")
																	TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, "Mamoran zendan be dastor ^2" .. GetPlayerName(source) .. "^0 shoma ra be enferadi enteghal dadand va ^1" .. jailtime .. " ^0daghighe be zaman zendan shoma ezafe shod!")
																	TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Solitary Log', 'Mamoran zendan be dastor ' .. GetPlayerName(source) .. ", " .. GetPlayerName(target) .. ' ra be enferadi enteghal dadand va ' .. jailtime .. ' daghighe be zaman zendan fard ezafe shod!','user', true, source, false)
					
																elseif not jailfour then
					
																	jailfour = true
					
																	TriggerClientEvent('esx-qalle-jail:solitaryEffects', target, jailtime, "jailfour")

																	MySQL.Async.execute('UPDATE users SET solitary=true WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target)
																		
																	})

																	MySQL.Async.execute('UPDATE users SET cell="jailfour" WHERE identifier=@identifier', 
																	{
																		['@identifier'] = GetPlayerIdentifier(target) 
																	})

																	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma ^1" .. GetPlayerName(target) .. "^0 ra be enferadi enteghal dadid va ^3" .. jailtime .. " ^0daghighe be zaman zendan fard ezafe kardid!")
																	TriggerClientEvent('chatMessage', target, "[SYSTEM]", {255, 0, 0}, "Mamoran zendan be dastor ^2" .. GetPlayerName(source) .. "^0 shoma ra be enferadi enteghal dadand va ^1" .. jailtime .. " ^0daghighe be zaman zendan shoma ezafe shod!")
																	TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Solitary Log', 'Mamoran zendan be dastor ' .. GetPlayerName(source) .. ", " .. GetPlayerName(target) .. ' ra be enferadi enteghal dadand va ' .. jailtime .. ' daghighe be zaman zendan fard ezafe shod!','user', true, source, false)
					
																else
																
																	TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Tamami selol haye enferadi por ast.")

																end

															else

																TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "In player dar hale hazer dakhel enferadi hast.")

															end
												
														end)

														else

															TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Player mored nazar dakhel zendan markazi nist.")

														end
											
													end)
													

												else

													TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Player mored nazar zendani nist.")

												end
									
											end)

								
								else

									TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman faghat mitavanid adad vared konid.")

								end

							else

								TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat Zaman chizi vared nakardid.")

							end
							
						else
							TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Player mored nazar online nist.")
						end

					else

						TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID faghat mitavanid adad vared konid.")

					end

			else

				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma dar ghesmat ID chizi vared nakrdid.")
			
			end
		
		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid.")
		
		end

end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, type, jailReason, status)
	local src = source
	local targetSrc = tonumber(targetSrc)
	local xPlayer = ESX.GetPlayerFromId(src)
	local jailPlayerData = ESX.GetPlayerFromId(targetSrc)

	if xPlayer["job"]["name"] == "police" then
		if type == 2 then
		JailPlayer(targetSrc, jailTime, 2, nil)
		elseif type == 1 then

			if not bjailone then

				JailPlayer(targetSrc, jailTime, 1, "bjailone")
				MySQL.Async.execute('UPDATE users SET cell="bjailone" WHERE identifier=@identifier', 
				{
					['@identifier'] = GetPlayerIdentifier(targetSrc) 
				})

				bjailone = true

			elseif not bjailtwo then

				JailPlayer(targetSrc, jailTime, 1, "bjailtwo")
				MySQL.Async.execute('UPDATE users SET cell="bjailtwo" WHERE identifier=@identifier', 
				{
					['@identifier'] = GetPlayerIdentifier(targetSrc) 
				})
				bjailtwo = true

			elseif not bjailthree then

				JailPlayer(targetSrc, jailTime, 1, "bjailthree")
				MySQL.Async.execute('UPDATE users SET cell="bjailthree" WHERE identifier=@identifier', 
				{
					['@identifier'] = GetPlayerIdentifier(targetSrc) 
				})
				bjailthree = true
			
			elseif not bjialfour then

				JailPlayer(targetSrc, jailTime, 1, "bjailfour")
				MySQL.Async.execute('UPDATE users SET cell="bjailfour" WHERE identifier=@identifier', 
				{
					['@identifier'] = GetPlayerIdentifier(targetSrc) 
				})
				bjailfour = true
		
			elseif not bjailfive then

				JailPlayer(targetSrc, jailTime, 1, "bjailfive")
				MySQL.Async.execute('UPDATE users SET cell="bjailfive" WHERE identifier=@identifier', 
				{
					['@identifier'] = GetPlayerIdentifier(targetSrc) 
				})
				bjailfive = true
			
			else

				TriggerClientEvent('chatMessage', src, "[SYSTEM]", {255, 0, 0}, "Tamami selol haye PD por ast!")

			end

		end
		if status then
			TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(jailPlayerData.name, "_", " ") .. " (" .. GetPlayerName(targetSrc) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' jail shod be modat ' .. jailTime .. ' daghighe be dalil: ' .. jailReason,'user', true, source, false)
		end
		

		GetRPName(targetSrc, function(name)
			TriggerClientEvent('chat:addMessage', -1, { args = { "^4[POLICE]^3 ", "^3" .. name .. " ^0Zendani shod be elate^8:^0 " .. jailReason }, color = { 249, 166, 0 } })
		end)

		TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " Zendani shod baraye ~r~~h~" .. jailTime .. " ~w~Daghighe!")
	else
		return TriggerEvent('VCAC:BanFuckinCheater', src,"trade to jail player!")
	end
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier, status)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local theJailPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if theJailPlayer ~= nil then
		UnJail(theJailPlayer.source)
		if status then
			TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(theJailPlayer.name, "_", " ") .. " (" .. GetPlayerName(theJailPlayer.source) .. ")" .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
			TriggerClientEvent("esx:showNotification", src, string.gsub(theJailPlayer.name, "_", " ")  .. " Azad shod!")
		end
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
		if status then

			MySQL.Async.fetchAll(
			'SELECT * FROM users WHERE identifier = @identifier',
			{
				['@identifier'] = targetIdentifier,
			}, function(result)

				TriggerEvent('DiscordBot:ToDiscord', 'jail', 'Jail Log', string.gsub(result[1].playerName, "_", " ") .. ' tavasot ' .. string.gsub(xPlayer.name, "_", " ") .. " (" .. GetPlayerName(src) .. ")" .. ' unjail shod','user', true, source, false)
				TriggerClientEvent("esx:showNotification", src, string.gsub(result[1].playerName, "_", " ")  .. " Azad shod!")
	
			end)

		end
	end

	
end)

RegisterServerEvent("esx-qalle-jail:changeJailStatusServerSided")
AddEventHandler("esx-qalle-jail:changeJailStatusServerSided", function(status)

	local src = source

	if type(status) ~= 'boolean' then
		print(('esx_jailwork: %s Sai kard value bejoz true ya false dar jail jay gozari konad!'):format(GetPlayerName(src)))
		return
	end

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer ~= nil then
		xPlayer.set('jailed', status)
	end

end)

RegisterServerEvent("esx-qalle-jail:jobSet")
AddEventHandler("esx-qalle-jail:jobSet", function()

	_source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if xPlayer.job.name == "police" then

		local grade = xPlayer.job.grade
		xPlayer.setJob("offpolice", grade)
		
	elseif xPlayer.job.name == "mecano" then

		local grade = xPlayer.job.grade
		xPlayer.setJob("offmecano", grade)

	elseif xPlayer.job.name == "ambulance" then

		local grade = xPlayer.job.grade
		xPlayer.setJob("offambulance", grade)
	
	elseif xPlayer.job.name == "taxi" then

		local grade = xPlayer.job.grade
		xPlayer.setJob("offtaxi", grade)

	end

end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:updateSolitary")
AddEventHandler("esx-qalle-jail:updateSolitary", function(solitary, cell)

	local src = source

	MySQL.Async.execute(
       "UPDATE users SET solitary = @solitary, cell = @cell WHERE identifier = @identifier",
        {
			['@identifier'] = GetPlayerIdentifier(src),
			['@solitary'] = solitary,
			['@cell'] = cell
		}
	)

end)

RegisterServerEvent("esx-qalle-jail:updateSolitaryStatus")
AddEventHandler("esx-qalle-jail:updateSolitaryStatus", function(status)

	local src = source

	exports.ghmattimysql:scalar(
		'SELECT cell FROM users WHERE identifier=@identifier',
		{
			['@identifier'] = GetPlayerIdentifier(_source),
		}, function(cell)

			if cell == "jailone" then

				jailone = status
				
			elseif cell == "jailtwo" then

				jailtwo = status
			
			elseif cell == "jailthree" then

				jailthree = status
			
			elseif cell == "jailfour" then

				jailfour = status

			end

		end)
	

end)

RegisterServerEvent("esx-qalle-jail:updateBjailStatus")
AddEventHandler("esx-qalle-jail:updateBjailStatus", function(status)

	local src = source

	exports.ghmattimysql:scalar(
		'SELECT cell FROM users WHERE identifier=@identifier',
		{
			['@identifier'] = GetPlayerIdentifier(_source),
		}, function(cell)

			if cell == "bjailone" then

				bjailone = status
				
			elseif cell == "bjailtwo" then

				bjailtwo = status
			
			elseif cell == "bjailthree" then

				bjailthree = status
			
			elseif cell == "bjailfour" then

				bjailfour = status
			
			elseif cell == "bjailfive" then

				bjailfive = status

			end

		end)
	

end)


RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))

	TriggerClientEvent("esx:showNotification", src, "Mamnoon ye kam pool bara ghaza gereftid")
end)

function JailPlayer(jailPlayer, jailTime, type, cell)
	TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime, type , cell)

	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = GetPlayerIdentifier(playerId)

	MySQL.Async.fetchAll("SELECT playerName FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(string.gsub(result[1].playerName, "_", " "))

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT playerName, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name =  string.gsub(result[i].playerName, "_", " "), jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail, solitary, cell FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)
		local solitary = result[1].solitary
		local cell = tostring(result[1].cell)
		

		if JailTime > 0 then
			cb(true, JailTime, solitary, cell)
		else
			cb(false, 0, nil, nil)
		end

	end)
end)

RegisterCommand('getstatus', function(source)
	
	local xPlayer = ESX.GetPlayerFromId(source)
		
		if xPlayer.job.name == "police" then

			if xPlayer.job.grade == 7 or xPlayer.job.grade == 8 then

				print('jail one:' .. tostring(jailone))
				print('jail two:' .. tostring(jailtwo))
				print('jail three: ' .. tostring(jailthree))
				print("jail four: " .. tostring(jailfour))
				print("bjailone: " .. tostring(bjailone))
				print("bjailtwo: " .. tostring(bjailtwo))
				print("bjailthree: " .. tostring(bjailthree))
				print("bjailfour: " .. tostring(bjailfour))
				print("bjailfive: " .. tostring(bjailfive))

				

			else
				
				TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma Chief ya DeputyChief nistid.")

			end

		else

			TriggerClientEvent('chatMessage', source, "[SYSTEM]", {255, 0, 0}, "Shoma police nistid.")

		end


end, false)