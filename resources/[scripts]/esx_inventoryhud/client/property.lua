RegisterNetEvent("esx_inventoryhud:openPropertyInventory")
AddEventHandler(
    "esx_inventoryhud:openPropertyInventory",
    function(data)
        setPropertyInventoryData(data)
        openPropertyInventory()
    end
)

function refreshPropertyInventory()
    ESX.TriggerServerCallback(
        "esx_property:getPropertyInventory",
        function(inventory)
            setPropertyInventoryData(inventory)
        end,
        ESX.GetPlayerData().identifier
    )
end

function setPropertyInventoryData(data)
    items = {}

    local propertyItems = data.items
    local propertyWeapons = data.weapons

    for i = 1, #propertyItems, 1 do
        local item = propertyItems[i]

        if item.count > 0 then
            item.type = "item_standard"
            item.usable = false
            item.rare = false
            item.limit = -1
            item.canRemove = false

            table.insert(items, item)
        end
    end

    for i = 1, #propertyWeapons, 1 do
        local weapon = propertyWeapons[i]

        if propertyWeapons[i].name ~= "WEAPON_UNARMED" then
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

function openPropertyInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "property"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback(
    "PutIntoProperty",
    function(data, cb)
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number) or nil

            TriggerServerEvent("esx_property:putItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, count)
        end

        Wait(150)
        refreshPropertyInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback(
    "TakeFromProperty",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            TriggerServerEvent("esx_property:getItem", ESX.GetPlayerData().identifier, data.item.type, data.item.name, tonumber(data.number))
        end

        Wait(150)
        refreshPropertyInventory()
        Wait(150)
        loadPlayerInventory()

        cb("ok")
    end
)
