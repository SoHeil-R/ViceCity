ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

---------------------------------
--- Admin Area, Made by FAXES ---
---------------------------------

--- Config ---
misTxtDis = "~r~~h~Dar yek mantaghe az map RP pause ast lotfan vared mantaghe nashavid." -- Use colors from: https://gist.github.com/leonardosnt/061e691a1c6c0597d633
blipRadius = 80.0 -- default radius, if none is specified.
blipCol = 32 -- Default: 2 (Green) Use colors from https://wiki.gt-mp.net/index.php?title=Blips (At Bottom)
blipName = "Admin Area"

--- Code ---
local blip = nil
local radiusBlip = nil

function missionTextDisplay(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end

RegisterNetEvent('Fax:AdminAreaSet')
AddEventHandler("Fax:AdminAreaSet", function(s, adaRadius)
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)

    if adaRadius == nil then
        adaRadius = blipRadius
    end

    local src = s
    local coords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(src)))
    blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    radiusBlip = AddBlipForRadius(coords.x, coords.y, coords.z, adaRadius)
    SetBlipSprite(blip, 269)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, blipCol)
    SetBlipScale(blip, 1.0)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString(blipName)
    EndTextCommandSetBlipName(blip)

    
    SetBlipAlpha(radiusBlip, 80)
    SetBlipColour(radiusBlip, blipCol)

    missionTextDisplay(misTxtDis, 8000)
end)

RegisterNetEvent('Fax:AdminAreaClear')
AddEventHandler("Fax:AdminAreaClear", function()
    RemoveBlip(blip)
    RemoveBlip(radiusBlip)
    missionTextDisplay("RP dar mantaghe ghabl ~r~~h~unpause~s~ ~w~shod!", 5000)
end)


RegisterCommand('clearped', function(source)
    local coords = GetEntityCoords(GetPlayerPed(-1))
    local target, distance = ESX.Game.GetClosestPed(coords)
    if distance < 3 then
        SetEntityAsMissionEntity(target, true, true) DeleteEntity(target) Citizen.Wait(1000) Citizen.InvokeNative(0x9614299DCB53E54B , Citizen.PointerValueIntInitialized(target)) Citizen.InvokeNative(0xAE3CBE5BF394C9C9 , Citizen.PointerValueIntInitialized(target))
    end
    print('Peds Cleared')
end)