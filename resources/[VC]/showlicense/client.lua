RegisterCommand('sl', function(source, args, user)
		
	if args[1] then

		if tonumber(args[1]) then

			local target = tonumber(args[1])

				if GetPlayerName(GetPlayerFromServerId(target)) ~= "**Invalid**" then

					if GetPlayerName(PlayerId()) ~= GetPlayerName(GetPlayerFromServerId(target)) then

						local coords = GetEntityCoords(GetPlayerPed(-1))
						local tcoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
						if GetDistanceBetweenCoords(coords, tcoords, true) < 2 then

							TriggerEvent('chatMessage', "[SYSTEM]", {255, 0, 0}, "^0Shoma madarek khod ra be ^3" .. GetPlayerName(GetPlayerFromServerId(target)) ..  " ^0neshan dadid!")
							
							TriggerServerEvent('esx_showlicense:ShowTheLicense', GetPlayerServerId(PlayerId()), target)

						else

							TriggerEvent('chatMessage', "[SYSTEM]", {255, 0, 0}, "^0Player mored nazar nazdik shoma nist")
						
						end

					else

						TriggerEvent('chatMessage', "[SYSTEM]", {255, 0, 0}, "^0Shoma nemitavanid Madarek ra be khodetan neshan dahid")

					end

				else

					TriggerEvent('chatMessage', "[SYSTEM]", {255, 0, 0}, "^0ID vared shode eshtebah ast")

				end

		else

			TriggerEvent('chatMessage', "[SYSTEM]", {255, 0, 0}, "^0Shoma dar ghesmat ID fagat mitavanid adad vared konid")

		end

	else

		TriggerServerEvent('esx_showlicense:ShowTheLicense', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
	
	end

end, false)