RegisterNetEvent("esx_inventoryhud:openGangInventory")
AddEventHandler(
    "esx_inventoryhud:openGangInventory",
    function(data)
        setGangInventoryData(data)
        openGangInventory()
    end
)

function refreshGangInventory()
    ESX.TriggerServerCallback("gangs:getGangInventory", function(inventory)
        setGangInventoryData(inventory)
    end)
end

function setGangInventoryData(data)
    items = {}

    local gangItems = data.items
    local gangWeapons = data.weapons

    for i = 1, #gangItems, 1 do
        local item = gangItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #gangWeapons, 1 do
        local weapon = gangWeapons[i]

        if gangWeapons[i].name ~= "WEAPON_UNARMED" then
            table.insert(
                items,
                {
                    label = ESX.GetWeaponLabel(weapon.name),
                    count = weapon.ammo,
                    limit = -1,
                    type = "item_weapon",
                    name = weapon.name,
                    usable = false,
                    rare = false,
                    canRemove = false
                }
            )
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items
        }
    )
end

function openGangInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "gang"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoGang",
    function(data, cb)
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number) or nil

            TriggerServerEvent("gangs:addToInventory", data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshGangInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromGang",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("gangs:getFromInventory", data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(150)
        refreshGangInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
