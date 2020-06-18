RegisterNetEvent('esx:playerLoaded')

AddEventHandler('esx:playerLoaded', function(xPlayer)

	SendNUIMessage({event = 'updateBank', banking = xPlayer.bank})

end)



RegisterNetEvent('bankUpdate')

AddEventHandler('bankUpdate', function(bank)

    SendNUIMessage({event = 'updateBank', banking = bank})

end)