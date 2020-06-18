local MarkerType = 1
local MarkerSize = 100.5
local Captured, InCaptureZone  = false, false
local Config     = {}
local Color      = {r = 255, g = 102, b = 0}
local PlayerData
local CaptureIsActive
local radiusBlip
local Blip

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(data)
    PlayerData = data
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
    PlayerData.gang = gang
end)

RegisterNetEvent('capture:CaptureStarted')
AddEventHandler('capture:CaptureStarted', function(capData, timer)
    while PlayerData.gang == nil do Citizen.Wait(100) end
    if PlayerData.gang.name ~= 'nogang' then
        CaptureIsActive = true
        
        ESX.ShowMissionText('Capture ' .. capData.name .. ' Fa\'al Shod')
        local point = vector3(capData.coords.x, capData.coords.y, capData.coords.z)
        -- show blip
        UpdateBlip(point, capData.name)
        
        -- show capture point
        UpdateCapturePoint(point)
        
        -- check if any user try capturing
        CheckCapturing(point)

        -- Start UI
        StartUI(capData.name)

        -- Update UI
        UpdateUI(capData.gang, timer)

        -- Deactive police and ambulance alert
        StartSecuringArea(point)
    else
        ESX.ShowMissionText('Capture ' .. capData.name .. ' Fa\'al Shod, Lotfan Varede Mantaqe nashavid')
    end
end)

RegisterNetEvent('capture:CaptureEnded')
AddEventHandler('capture:CaptureEnded', function()
    ESX.ShowMissionText('Capture Be Payan resid')
    CaptureIsActive = false
    EndUI()
end)

RegisterNetEvent('capture:ChangeCaptureHandler')
AddEventHandler('capture:ChangeCaptureHandler', function(gang, endTime)
    if PlayerData.gang.name ~= gang then
        ESX.ShowMissionText('Gange ' .. gang .. ' Dar hale capture Kardan ast')
        Color = {r = 255, g = 102, b = 0}
        MarkerType = 1
        MarkerSize = 100.5
        Captured   = false
    else
        ESX.ShowMissionText('Gange Shoma Dar Hale Capture kardan ast')
        Color = {r = 3, g = 144, b = 0}
        MarkerType = 28
        MarkerSize = 1.5
        Captured   = true
    end

    -- Update UI
    UpdateUI(gang, endTime)
end)

function StartUI(capName)
    SendNUIMessage({
        start      = true,
        CapName    = capName
    })
end

function EndUI()
    SendNUIMessage({
        stop = true
    })
end

function UpdateUI(gang, endTime)
    SendNUIMessage({
        update      = true,
        Handeler    = gang,
        Time        = endTime
    })
end

function UpdateBlip(blip, name)

    RemoveBlip(Blip)
    RemoveBlip(radiusBlip)

    Blip        = AddBlipForCoord(blip)
    radiusBlip  = AddBlipForRadius(blip, 50.0)

    SetBlipSprite (Blip, 378)
    SetBlipDisplay(Blip, 4)
    SetBlipScale  (Blip, 1.2)
    SetBlipColour (Blip, 76)
    SetBlipAsShortRange(Blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(Blip)
    
    SetBlipAlpha(radiusBlip, 80)
    SetBlipColour(radiusBlip, 22)
end

function UpdateCapturePoint(point)
    Citizen.CreateThread(function()
        while CaptureIsActive do

            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)

            if GetDistanceBetweenCoords(coords, point, true) < 300 then
                DrawMarker(MarkerType, point, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, MarkerSize, Color.r, Color.g, Color.b, 100, false, true, 2, false, false, false, false)
                DrawMarker(1, point.x, point.y, point.z - 50, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200.0, 200.0, 150.0, Color.r, Color.g, Color.b, 100, false, true, 2, false, false, false, false)
            end

            Wait(0)
        end
        return
    end)
end

function CheckCapturing(point)
    Citizen.CreateThread(function()
        while CaptureIsActive do 
            local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)

            Wait(1000)
            if not Captured then
                if GetDistanceBetweenCoords(coords, point, true) < 1.5 then
                    Color = {r = 3, g = 144, b = 0}
                    if MarkerType == 19 then
                        Captured   = true
                        TriggerServerEvent('capture:CaptureMe')
                    elseif MarkerType == 1 then
                        MarkerSize = 1.5
                        MarkerType = 10
                    elseif MarkerType < 19 then
                        MarkerType = MarkerType + 1
                    end
                elseif MarkerType ~= 1 and MarkerType ~= 28 then
                    MarkerSize = 100.5
                    Color = {r = 255, g = 102, b = 0}
                    MarkerType = 1
                end
            end
        end
        return
    end)
end

function StartSecuringArea(point)
    Citizen.CreateThread(function()
        while CaptureIsActive do
            Citizen.Wait(1000)

            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)

            if GetDistanceBetweenCoords(coords, point, false) <= 100 then
                if not InCaptureZone then
                    InCaptureZone = true
                    TriggerEvent('capture:inCapture', true)
                end
            elseif InCaptureZone then
                InCaptureZone = false
                TriggerEvent('capture:inCapture', false)
            end
        end
        TriggerEvent('capture:inCapture', false)
        return
    end)
end