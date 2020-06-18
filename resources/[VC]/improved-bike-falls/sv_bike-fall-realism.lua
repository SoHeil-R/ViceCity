RegisterServerEvent("bike:knockOff")
AddEventHandler("bike:knockOff", function(id, force, wasFall)
    TriggerClientEvent("bike:knockOff", id, force, wasFall)
end)