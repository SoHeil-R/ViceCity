local ESX = nil
local Vehicles = {}
local Salaries = {}

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand('debugs', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.permission_level == 10 then
         print(ESX.dump(Salaries))
    else
        TriggerClientEvent('esx:showNotification', source, '~r~Kos sher to ino az koja peyda kardi?')
    end
end, false)

RegisterServerEvent('esx-salary:calculateSalary')
AddEventHandler('esx-salary:calculateSalary', function(source)

    local housesesPrice = calculateTaxForHouses(source)
    local vehiclesPrice = calculateTaxForCars(source)
    local totalMoney = calculateTaxForMoney(source)
    Citizen.Wait(1000)

    if housesesPrice ~= nil and vehiclesPrice ~= nil and totalMoney ~= nil then

        local totalPrice = housesesPrice + vehiclesPrice + totalMoney
        local tax = ESX.Math.Round(totalPrice / 200000)
        

        if tax > 45 then
            tax = 45

        end
        
        local identifier = GetPlayerIdentifier(source)

                local amount = Salaries[identifier].salary
                if amount >= 1000 and amount ~= nil then

                    local salary = amount - (amount * tax / 100)
                    
                    MySQL.Async.execute('UPDATE users SET salary = 0 WHERE identifier=@identifier', 
                    {
                        ['@identifier'] = identifier, 
                        
                    }, function(rowsChanged)

                        if rowsChanged > 0 then

                            local xPlayer = ESX.GetPlayerFromId(source)
                            
                                if xPlayer then
                                    if Salaries[identifier] then
                                        xPlayer.addBank(salary)
                                        TriggerClientEvent('esx-salary:modify', source, "set", 0)
                                        Salaries[identifier].salary = 0
                                        TriggerClientEvent('chatMessage', source, "[Bank]", {255, 0, 0}, " ^0Shoma ba movafaghiat ^2" .. salary .. "$ ^0ba etekhaz ^1" .. tax .. "% ^0maliat daryaft kardid!")
                                    else
                                        TriggerClientEvent('esx:showHelpNotification', source, "~r~Moshkeli dar pardakht salary shoma be vojoud amad lotfan admin ra motale konid!")
                                    end
                                end

                        else
                            TriggerClientEvent('esx:showHelpNotification', source, "~r~Moshkeli dar pardakht salary shoma be vojoud amad lotfan admin ra motale konid!")
                        end

                    end)

                else
                    TriggerClientEvent('chatMessage', source, "[Bank]", {255, 0, 0}, " ^0Hade aghal mablagh pardakht salary ^2$1000 ^0mibashad!")
                end

    else
        TriggerClientEvent('esx:showHelpNotification', source, "~r~Moshkeli dar system pish amade lotfan be amdin etela dahid!")
    end

end)

RegisterServerEvent('esx-salary:passTheVehicleName')
AddEventHandler('esx-salary:passTheVehicleName', function(vehicle)
    
    local identifier = GetPlayerIdentifier(source)

    if Vehicles[identifier] then
        Vehicles[identifier] = nil
    end

    Vehicles[identifier] = {source = source, Vehicles = vehicle}


end)

RegisterNetEvent('esx-salary:ThisHide_modify')
AddEventHandler('esx-salary:ThisHide_modify', function(target, type, amount)

    local identifier = GetPlayerIdentifier(target)
    if type == "add" then

        if Salaries[identifier] then
            Salaries[identifier].salary = Salaries[identifier].salary + amount
            TriggerClientEvent('esx-salary:modify', target, "add", amount)
        end

    elseif type == "set" then

        if Salaries[identifier] then
            Salaries[identifier].salary = amount
            TriggerClientEvent('esx-salary:modify', target, "set", amount)
        end

    end

end)

function calculateTaxForCars(target)

    local identifier = GetPlayerIdentifier(target)
    local price = 0
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier', {
		['@identifier'] = identifier
    }, function (result)
        if result then
            for i=1, #result, 1 do
                Citizen.Wait(10)
                local vehicle = json.decode(result[i].vehicle)

                 if vehicle.model then
                    local vehicleModel = vehicle.model
                    TriggerClientEvent('esx-salary:checkModelForVehicle', target, vehicleModel)
                 end

            end

            
            Citizen.Wait(100)
            if Vehicles[identifier].Vehicles then

                for i=1, #Vehicles[identifier].Vehicles, 1 do
                    

                    if Vehicles[identifier].Vehicles[i] ~= "CARNOTFOUND" then

                        MySQL.Async.fetchAll('SELECT price, category FROM vehicles WHERE model = @model', {
                            ['@model'] = string.lower(Vehicles[identifier].Vehicles[i]),
                        }, function (result2)
                            if result2 then
                                
                                if result2[1].price and result2[1].category then
                                    price = price + result2[1].price
                                end
                        
                            end
                        end)

                    end

                end
            
            end

        end
    end)
    Wait(500)
    return price
    
end

function calculateTaxForHouses(target)

    local identifier = GetPlayerIdentifier(target)
    local price = 0
    MySQL.Async.fetchAll('SELECT price FROM owned_properties WHERE owner = @identifier AND rented = false', {
		['@identifier'] = identifier
    }, function (result)
        if result then

            for i=1, #result, 1 do

                Citizen.Wait(10)
                price = price + result[i].price

            end
            Citizen.Wait(500)

        end
    end)
    Wait(500)
    return price

end

function calculateTaxForMoney(target)
    local xPlayer = ESX.GetPlayerFromId(target)
        if xPlayer then

            local totalMoney = xPlayer.money + xPlayer.bank
            return totalMoney

        end
end

AddEventHandler('esx:playerLoaded', function(source)

    local _source = source
    local identifier = GetPlayerIdentifier(_source)
    MySQL.Async.fetchAll("SELECT salary FROM users WHERE identifier = @identifier", { ["@identifier"] = identifier }, function(result)

        local salary = result[1].salary
        Salaries[identifier] = {source = _source, salary = result[1].salary}
        TriggerClientEvent('esx-salary:modify', _source, "set", Salaries[identifier].salary)

    end)

    
end)

AddEventHandler('playerDropped', function()
	
	local _source = source
        if _source ~= nil then
            local identifier = GetPlayerIdentifier(_source)

            if Salaries[identifier] ~= nil then

                MySQL.Async.execute('UPDATE users SET salary = @salary WHERE identifier=@identifier', 
                {
                    ['@identifier'] = identifier,
                    ['@salary'] = Salaries[identifier].salary
                    
                }, function(rowsChanged)

                    if rowsChanged == 0 then
                        print('Moshkeli dar save kardan salarie ' .. GetPlayerName(_source) .. 'pish amad lotfan peygiri konid!')
                    end
                    Salaries[identifier] = nil

                end)

            end

        end

end)