--[[
    Converted for FiveM and slightly modified by minipunch for USA REALISM RP (https://usarrp.net). Makes people fall off bicycles and motorcycles easier than by default GTA standards as in real life.
    I just added things like the percent chance to fall when jumping from small-moderate heights and instead of using the for some reason seemingly non-working "KnockPedOffVehicle" native it _was_ using I just TP the player out of the vehicle instead among some other things.

    From original author at GTA5-mods.com:
    The mod detects high forces that impact your vehicle by looking at the acceleration and negativ acceleration values.
    MaxAllowedAccelerationBeforeFalloff sets max allowed acceleration force. Like when you drive into a wall. Set to 0 to deactivate this check. Mod standard is 80 for normal and alternative calculation.
    MaxAllowedUpDownAccelerationBeforeFalloff sets max allowed up and down acceleration forces. Like when you jump down from a high spot on the flat ground. Set to 0 to deactivate this check. Mod standard is 140.
    Lower the values to fall off sooner.
    If you set UseAlternativeCalculation true, MaxAllowedUpDownAccelerationBeforeFalloff will be ignored. The max up and down forces will be calculated by MaxAllowedAccelerationBeforeFalloff instead.

    See the original one from GTA5-mods.com here: https://www.gta5-mods.com/scripts/realistic-bike-and-quad-falloff
--]]

local UseAlternativeCalculation = false
local maxAllowedAccelerationBeforeFalloff = 80
local maxAllowedUpDownAccelerationBeforeFalloff = 95
local isRunningGetVehicleVelocityVectorAccelerations = false

local NOT_FALL_CHANCE = 0.25

RegisterNetEvent("bike:knockOff")
AddEventHandler("bike:knockOff", function(force, wasFall)
    local ped = PlayerPedId()
    KnockFromVehicle(ped, GetVehiclePedIsIn(ped), force, wasFall)
end)

function CanBeKnockedOffVehicle(ped, veh)
    if IsPedInAnyVehicle(ped, true) then
        if GetVehicleClass(veh) == 13 or GetVehicleClass(veh) == 8 then 
            return true
        else 
            return false 
        end
    else 
        return false
    end
end

function KnockFromVehicle(ped, currVeh, force, wasFall)
    local prevCoords = GetEntityCoords(ped)
    local ragdollTime = 2000
    local healthToRemove = 15
    if wasFall and force > 200 then -- ragdoll longer if it was a big fall, collisions all ragdoll the same amount of time atm
        ragdollTime = 4200
        healthToRemove = 35
        if force > 270 then 
            healthToRemove = 45
        end
    end
    SetPedToRagdoll(ped, ragdollTime, ragdollTime, 0, 0, 0, 0)
    SetEntityVelocity(ped, GetEntityVelocity(currVeh))
    SetEntityHealth(ped, GetEntityHealth(ped) - healthToRemove)
    lastKnownAcceleration = 0
end

function GetVehicleVelocityVectorAccelerations(vehicle)
    local vector3
    local vector31 = {}
    if not isRunningGetVehicleVelocityVectorAccelerations then 
        isRunningGetVehicleVelocityVectorAccelerations = true
        local character = PlayerPedId()
        if IsPedInAnyVehicle(character, true) then 
            local currentVehicle = GetVehiclePedIsIn(character)
            local vel = GetEntityVelocity(currentVehicle)
            local x = vel.x
            local y = vel.y
            local z = vel.z
            local num = 100
            Wait(num)
            local vel1 = GetEntityVelocity(currentVehicle)
            local single = vel1.x 
            local y1 = vel1.y
            local z1 = vel1.z
            vector31.x = (single - x) / (num / 1000.0)
            vector31.y = (y1 - y) / (num / 1000.0)
            vector31.z = (z1 - z) / (num / 1000.0)
        end
        isRunningGetVehicleVelocityVectorAccelerations = false
        vector3 = vector31
    else 
        vector3 = vector31
    end
    return vector3
end

function PlayerFallOffBikeVelocityVectorAccelerationsCheck()
    local character = PlayerPedId()
    local currVeh = GetVehiclePedIsIn(character, false)
    if GetPedInVehicleSeat(currVeh, -1) == character then -- only check driver (since passenger would fall off randomly for some reason)
        if CanBeKnockedOffVehicle(character, currVeh) then
            local vehicleVelocityVectorAccelerations = GetVehicleVelocityVectorAccelerations(currVeh)
            local single = math.abs(vehicleVelocityVectorAccelerations.x)
            local single1 = math.abs(vehicleVelocityVectorAccelerations.y)
            local single2 = math.abs(vehicleVelocityVectorAccelerations.z)
            local num = single * single + single1 * single1
            num = math.sqrt(num)
            -- colliding with something --
            local doCheck = (maxAllowedAccelerationBeforeFalloff ~= 0)
            local doForceOff = num > maxAllowedAccelerationBeforeFalloff
            if doCheck and doForceOff then 
                --print("knocking off from collision, force: " .. num)
                KnockFromVehicle(character, currVeh, num, false)
                local id = GetClosestPlayerID(character)
                if id then
                    TriggerServerEvent("bike:knockOff", id, num, false)
                end
            end
            -- falling from a height --
            doCheck = (maxAllowedUpDownAccelerationBeforeFallof ~= 0)
            doForceOff = single2 > maxAllowedUpDownAccelerationBeforeFalloff
            if doCheck and doForceOff then
                local isLucky = single2 < 200 and (math.random() <= NOT_FALL_CHANCE) -- % chance of not falling when eligible to fall
                if not isLucky then
                    --print("knocking off from height! force: " .. single2)
                    KnockFromVehicle(character, currVeh, single2, true)
                    local id = GetClosestPlayerID(character)
                    if id then
                        TriggerServerEvent("bike:knockOff", id, single2, true)
                    end
                end
            end
        end
    end
end

Citizen.CreateThread(function()
    while true do
        PlayerFallOffBikeVelocityVectorAccelerationsCheck()
        Wait(1)
    end
end)

function GetClosestPlayerID(myPed)
    local returnID = nil
    local players = GetActivePlayers()
    for i = 1, #players do 
        local otherPed = GetPlayerPed(players[i])
        if otherPed ~= myPed then 
            local myCoords = GetEntityCoords(myPed)
            local otherCoords = GetEntityCoords(otherPed)
            if Vdist(myCoords.x, myCoords.y, myCoords.z, otherCoords.x, otherCoords.y, otherCoords.z) <= 2.0 then 
                returnID = GetPlayerServerId(players[i])
                break
            end
        end
    end
    return returnID
end
