--------------------------------------
------Created By Whit3Xlightning------
--https://github.com/Whit3XLightning--
--------------------------------------

RegisterNetEvent("wld:delallveh")
AddEventHandler("wld:delallveh", function ()

    for vehicle in EnumerateVehicles() do
        if (not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1))) then 
            NetworkRequestControlOfEntity(vehicle)
        
            local timeout = 2000
            while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end

            SetEntityAsMissionEntity(vehicle, true, true)
            
            local timeout = 2000
            while timeout > 0 and not IsEntityAMissionEntity(vehicle) do
                Wait(100)
                timeout = timeout - 100
            end

            Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( vehicle ) )
            
            if (DoesEntityExist(vehicle)) then 
                DeleteEntity(vehicle)
            end
        end
    end

end)