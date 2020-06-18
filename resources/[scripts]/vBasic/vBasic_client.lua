-- vBasic by Vespura.
-- v4.0 / 29-06-2018
-- No need to touch anything in here, use the convars instead.


local settings = {}
Citizen.CreateThread(function()
    -- Handler for whenever the settings are received from the server.
    RegisterNetEvent("vBasic:setSettings")
    AddEventHandler("vBasic:setSettings", function(data)
        settings = json.decode(data)
    end)
    
    -- Wait a little before requesting the settings.
    Citizen.Wait(100)
    TriggerServerEvent("vBasic:getSettings")
    
    -- Wait for the settings to be received.
    while settings.pvp == nil do
        Citizen.Wait(1)
    end
    
    -- Loop these things every 10 ticks.
    while true do
        Citizen.Wait(10) -- these things don't need to run every tick.
        
        -- manage pvp
        if (settings.pvp == 1) then
            SetCanAttackFriendly(PlayerPedId(), true, false)
            NetworkSetFriendlyFireOption(true)
        elseif (settings.pvp == 2) then
            SetCanAttackFriendly(PlayerPedId(), false, false)
            NetworkSetFriendlyFireOption(false)
        end
        
        -- manage godmode
        if (settings.godmode == 1) then
            SetPlayerInvincible(PlayerId(), true)
            SetEntityInvincible(PlayerPedId(), true)
        elseif (settings.godmode == 2) then
            SetPlayerInvincible(PlayerId(), false)
            SetEntityInvincible(PlayerPedId(), false)
        end
        
        -- manage unlimited stamina
        if (settings.unlimitedStamina) then
            ResetPlayerStamina(PlayerId())
        end
    end
end)

Citizen.CreateThread(function()
    for i = 1, 13 do
        EnableDispatchService(i, false)
    end
	while true do
        DisablePlayerVehicleRewards(PlayerId())
        SetParkedVehicleDensityMultiplierThisFrame(0.1)
        SetVehicleDensityMultiplierThisFrame(0.3)
        SetRandomVehicleDensityMultiplierThisFrame(0.3)
        SetPedDensityMultiplierThisFrame(1.0)
        SetScenarioPedDensityMultiplierThisFrame(1.0, 1.0)
		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
        SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("dump"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
        SetVehicleModelIsSuppressed(GetHashKey("bus"), true)

        Citizen.Wait(1)
	end
end)
