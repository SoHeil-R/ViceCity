ESX                = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterServerEvent('esx_showlicense:ShowTheLicense')
AddEventHandler('esx_showlicense:ShowTheLicense', function(player, target)

	TriggerEvent('esx_license:getLicenses', player, function(licenses)
						
		local ownedLicenses = {}
		for i=1, #licenses, 1 do
			ownedLicenses[licenses[i].type] = true
		end
		local xPlayer = ESX.GetPlayerFromId(player)
		TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^0^*------ ^3List Madarek ^0------")
		TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Cart Shenasaei:^0 "  .. string.gsub(xPlayer.name, "_", " "))
	
		if ownedLicenses['dmv'] then
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Ayin naame: ^2Darad")
		else
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Ayin naame: ^8Nadarad")
		end
	
		if ownedLicenses['drive'] then
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname mashin: ^2Darad")
		else
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname mashin: ^8Nadarad")
		end
	
		if ownedLicenses['drive_bike'] then
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname motor: ^2Darad")
		else
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname motor: ^8Nadarad")
		end
	
		if ownedLicenses['drive_truck'] then
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname kamiyon: ^2Darad")
		else
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Govahiname kamiyon: ^8Nadarad")
		end
	
		if ownedLicenses['weapon'] then
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Mojavez aslahe: ^2Darad")
		else
			TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^4^*Mojavez aslahe: ^8Nadarad")
		end
	
		TriggerClientEvent('chatMessage', target, "", {255, 0, 0}, "^0^*------ ^3List Madarek ^0------")
	
	end)
end)