local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local set                       = false
local PlayerData                = {}
local GUI                       = {}
local HasAlreadyEnteredMarker   = false
local LastStation               = nil
local LastPart                  = nil
local LastEntity                = nil
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local IsHandcuffed              = false
local IsDragged                 = false
local CopPed                    = 0
local allBlip                   = {}
local Data                      = {}

ESX                             = nil
GUI.Time                        = 0

Citizen.CreateThread(function()
while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
end
end)

function OpenCloakroomMenu()

  local elements = {
    {label = _U('citizen_wear'), value = 'citizen_wear'},
    {label = 'Posheshe Gang', value = 'gang_wear'}
  }

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cloakroom',
    {
      title    = _U('cloakroom'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)
      menu.close()

      ESX.TriggerServerCallback('esx_skin:getGangSkin', function(skin, gangSkin)
        if data.current.value == 'citizen_wear' then
            TriggerEvent('skinchanger:loadSkin', skin)
            TriggerEvent('esx:restoreLoadout')
        elseif data.current.value == 'gang_wear' then
          if skin.sex == 0 then
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_male)
          else
            TriggerEvent('skinchanger:loadClothes', skin, gangSkin.skin_female)
          end
        end
      end)
      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_cloakroom'
      CurrentActionMsg  = _U('open_cloackroom')
      CurrentActionData = {}
    end
)

end

function OpenArmoryMenu(station)
local station = station
if Config.EnableArmoryManagement then

   local elements = {
    {label = 'Gang Inventory', value = 'property_inventory'},
    {label = _U('get_armor'),  value = 'get_armor'}
  }

   ESX.UI.Menu.CloseAll()

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory',
    {
      title    = _U('armory'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)

		if data.current.value == "property_inventory" then
			menu.close()
			OpenGangInventoryMenu(station)
    elseif data.current.value == 'get_armor' then

        local ped = GetPlayerPed(-1)
        local armor = GetPedArmour(ped)

        if armor == 50 then
          ESX.ShowNotification("~g~Armor shoma por ast nemitavanid dobare armor kharidari konid!")
        else
          TriggerServerEvent("gangprop:setArmor", source)
        end
    end

    end,
    function(data, menu)

      menu.close()

      CurrentAction     = 'menu_armory'
      CurrentActionMsg  = _U('open_armory')
      CurrentActionData = {station = station}
    end
  )

 else

   local elements = {}

   ESX.UI.Menu.CloseAll()

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory',
    {
      title    = _U('armory'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)
      local weapon = data.current.value
      TriggerServerEvent('gangprop:giveWeapon', weapon,  1000)
    end,
    function(data, menu)

       menu.close()

       CurrentAction     = 'menu_armory'
      CurrentActionMsg  = _U('open_armory')
      CurrentActionData = {station = station}

     end
  )

 end

end

function OpenGangInventoryMenu(station)
	ESX.TriggerServerCallback(
		"gangs:getPropertyInventory",
    function(inventory)
			TriggerEvent("esx_inventoryhud:openGangInventory", inventory)
		end,
		station
	)
end

function ListOwnedCarsMenu()
	local elements = {}
	
	table.insert(elements, {label = '| Pelak | Esm Mashin |'})

	ESX.TriggerServerCallback('gangprop:getCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_nocars'))
		else
      for _,v in pairs(ownedCars) do
        if v.stored then
          local hashVehicule = v.vehicle.model
          local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
          local vehicleName  = GetLabelText(aheadVehName)
          local plate        = v.plate
          local labelvehicle
          labelvehicle = '| '..plate..' | '..vehicleName..' |'
				  table.insert(elements, {label = labelvehicle, value = v})          
				end
			end
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title    = 'Gang Parking',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value.stored then
        menu.close()
        Wait(math.random(0,500))
        ESX.TriggerServerCallback('gangprop:carAvalible', function(avalibele)
          if avalibele then        
            SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
          else
            ESX.ShowNotification('In Mashin Qablan az Parking Dar amade ast')
          end
        end, data.current.value.plate)
			else
				ESX.ShowNotification(_U('car_is_impounded'))
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

-- Spawn Cars
function SpawnVehicle(vehicle, plate)
  local shokol = GetClosestVehicle(Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  3.0,  0,  71)
  if not DoesEntityExist(shokol) then
    ESX.Game.SpawnVehicle(vehicle.model, {
      x = Data.vehspawn.x,
      y = Data.vehspawn.y,
      z = Data.vehspawn.z + 1
    }, Data.vehspawn.a, function(callback_vehicle)
      ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
      SetVehRadioStation(callback_vehicle, "OFF")
      TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
    end)
    
    TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, false)
  else
    ESX.ShowNotification('Mahale Spawn mashin ro Khali konid')
  end
end

function OpenGangActionsMenu()

 ESX.UI.Menu.CloseAll()

       ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'citizen_interaction',
        {
          title    = _U('citizen_interaction'),
          align    = 'top-right',
          elements = {
            {label = _U('handcuff'),        value = 'handcuff'},
            {label = _U('drag'),            value = 'drag'},
            {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
            {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
          },
        },
        function(data2, menu2)

           local player, distance = ESX.Game.GetClosestPlayer()

           if distance ~= -1 and distance <= 3.0 then

             if data2.current.value == 'handcuff' then
              TriggerServerEvent('gangprop:handcuff', GetPlayerServerId(player))
            end

             if data2.current.value == 'drag' then
              TriggerServerEvent('gangprop:drag', GetPlayerServerId(player))
            end

             if data2.current.value == 'put_in_vehicle' then
              TriggerServerEvent('gangprop:putInVehicle', GetPlayerServerId(player))
            end

             if data2.current.value == 'out_the_vehicle' then
                TriggerServerEvent('gangprop:OutVehicle', GetPlayerServerId(player))
            end

           else
            ESX.ShowNotification(_U('no_players_nearby'))
          end

         end,
        function(data2, menu2)
          menu2.close()
        end
      )

--      end

--      if data.current.value == 'vehicle_interaction' then

--        ESX.UI.Menu.Open(
--         'default', GetCurrentResourceName(), 'vehicle_interaction',
--         {
--           title    = _U('vehicle_interaction'),
--           align    = 'top-right',
--           elements = {
--             {label = _U('pick_lock'),    value = 'hijack_vehicle'},
--           },
--         },
--         function(data2, menu2)

--           local playerPed = GetPlayerPed(-1)
--           local coords    = GetEntityCoords(playerPed)
--           local vehicle   = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

--           if DoesEntityExist(vehicle) then

--             local vehicleData = ESX.Game.GetVehicleProperties(vehicle)

--             if data2.current.value == 'hijack_vehicle' then

--               local playerPed = GetPlayerPed(-1)
--               local coords    = GetEntityCoords(playerPed)

--               if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then

--                 local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  3.0,  0,  71)

--                 if DoesEntityExist(vehicle) then

--                   Citizen.CreateThread(function()

--                     TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)

--                     Wait(20000)

--                     ClearPedTasksImmediately(playerPed)

--                     SetVehicleDoorsLocked(vehicle, 1)
--                     SetVehicleDoorsLockedForAllPlayers(vehicle, false)

--                     TriggerEvent('esx:showNotification', _U('vehicle_unlocked'))

--                   end)

--                 end

--               end

--             end

--           else
--             ESX.ShowNotification(_U('no_vehicles_nearby'))
--           end

--          end,
--         function(data2, menu2)
--           menu2.close()
--         end
--       )

--      end

--    end,
--   function(data, menu)

--      menu.close()

--    end
-- )

end

function OpenGetWeaponMenu(gang)
  local gang = gang

  ESX.TriggerServerCallback('gangs:getArmoryWeapons', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
        table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
      end
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        menu.close()

        ESX.TriggerServerCallback('gangs:removeArmoryWeapon', function()
          OpenGetWeaponMenu(gang)
        end, data.current.value, gang)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, gang)

end

function OpenPutWeaponMenu(gang)
local gang = gang
local elements   = {}
local playerPed  = GetPlayerPed(-1)
local weaponList = ESX.GetWeaponList()

 for i=1, #weaponList, 1 do

   local weaponHash = GetHashKey(weaponList[i].name)

   if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
    table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
  end

end

 ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'armory_put_weapon',
  {
    title    = _U('put_weapon_menu'),
    align    = 'top-right',
    elements = elements,
  },
  function(data, menu)

     menu.close()

     ESX.TriggerServerCallback('gangs:addArmoryWeapon', function()
      OpenPutWeaponMenu(gang)
    end, data.current.value, gang)

   end,
  function(data, menu)
    menu.close()
  end
)

end

function OpenBuyWeaponsMenu(station, gang)
local gang = gang

 ESX.TriggerServerCallback('gangs:getArmoryWeapons', function(weapons)

   local elements = {}
   for i=1, #weapons, 1 do
    table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name) .. ' $' .. weapons[i].price, value = weapons[i].name, price = weapons[i].price})
   end
   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_buy_weapons',
    {
      title    = _U('buy_weapon_menu'),
      align    = 'top-right',
      elements = elements,
    },
    function(data, menu)

       ESX.TriggerServerCallback('gangs:buy', function(hasEnoughMoney)

         if hasEnoughMoney then
          ESX.TriggerServerCallback('gangs:addArmoryWeapon', function()
            OpenBuyWeaponsMenu(station, gang)
          end, data.current.value, gang)
        else
          ESX.ShowNotification(_U('not_enough_money'))
        end

       end, data.current.price, gang)

     end,
    function(data, menu)
      menu.close()
    end
  )

 end, gang)

end

function OpenGetStocksMenu(gang)
local gang = gang

 ESX.TriggerServerCallback('gangs:getStockItems', function(items)

   -- print(json.encode(items))

  local elements = {}

  for i=1, #items, 1 do
    table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
  end

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'stocks_menu',
    {
      title    = _U('gang_stock'),
      elements = elements
    },
    function(data, menu)

       local itemName = data.current.value

       ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
        {
          title = _U('quantity')
        },
        function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('quantity_invalid'))
          else
            menu2.close()
            menu.close()
            TriggerServerEvent('gangs:getStockItem', gang, itemName, count)
            OpenGetStocksMenu(gang)
          end

         end,
        function(data2, menu2)
          menu2.close()
        end
      )

     end,
    function(data, menu)
      menu.close()
    end
  )

 end, gang)

end

function OpenPutStocksMenu(station)
local gang = station

 ESX.TriggerServerCallback('gangprop:getPlayerInventory', function(inventory)

   local elements = {}

   for i=1, #inventory.items, 1 do

     local item = inventory.items[i]

     if item.count > 0 then
      table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
    end

   end

   ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'stocks_menu',
    {
      title    = _U('inventory'),
      elements = elements
    },
    function(data, menu)

       local itemName = data.current.value

       ESX.UI.Menu.Open(
        'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
        {
          title = _U('quantity')
        },
        function(data2, menu2)

          local count = tonumber(data2.value)

          if count == nil then
            ESX.ShowNotification(_U('quantity_invalid'))
          else
            menu2.close()
            menu.close()

            TriggerServerEvent('gangs:putStockItems', gang, itemName, count)
            OpenPutStocksMenu(station)
          end

         end,
        function(data2, menu2)
          menu2.close()
        end
      )

     end,
    function(data, menu)
      menu.close()
    end
  )

 end)

end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.gang_name    = data.gang_name
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)

        Data.armory       = json.decode(data.armory)
        Data.locker       = json.decode(data.locker)
        Data.boss         = json.decode(data.boss)
        Data.vehicles     = json.decode(data.vehicles)
        Data.veh          = json.decode(data.veh)
        Data.vehdel       = json.decode(data.vehdel)
        Data.vehspawn     = json.decode(data.vehspawn)
        Data.vehprop      = json.decode(data.vehprop)
      else
        ESX.ShowNotification('You Gang has been expired, Contact admins for recharge!')
      end
    end, PlayerData.gang.name)
  end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
  PlayerData.gang = gang
  Data = {}
  if PlayerData.gang.name ~= 'nogang' then
    ESX.TriggerServerCallback('gangs:getGangData', function(data)
      if data ~= nil then
        Data.blip         = json.decode(data.blip)
        blipManager(Data.blip)

        Data.gang_name    = data.gang_name
        Data.armory       = json.decode(data.armory)
        Data.locker       = json.decode(data.locker)
        Data.boss         = json.decode(data.boss)
        Data.vehicles     = json.decode(data.vehicles)
        Data.veh          = json.decode(data.veh)
        Data.vehdel       = json.decode(data.vehdel)
        Data.vehspawn     = json.decode(data.vehspawn)
        Data.vehprop      = json.decode(data.vehprop)
      else
        ESX.ShowNotification('You Gang has been expired, Contact admins for recharge!')
      end
    end, PlayerData.gang.name)
  else
    for _, blip in pairs(allBlip) do
      RemoveBlip(blip)
    end
    allBlip = {}
  end
end)

-- Create blips
function blipManager(blip)
  for _, blip in pairs(allBlip) do
    RemoveBlip(blip)
  end
  allBlip = {}
  local blipCoord = AddBlipForCoord(blip.x, blip.y)
  table.insert(allBlip, blipCoord)
  SetBlipSprite (blipCoord, 378)
  SetBlipDisplay(blipCoord, 4)
  SetBlipScale  (blipCoord, 1.2)
  SetBlipColour (blipCoord, 76)
  SetBlipAsShortRange(blipCoord, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString('Gang')
  EndTextCommandSetBlipName(blipCoord)
end

AddEventHandler('gangprop:hasEnteredMarker', function(station, part)

if part == 'Cloakroom' then
  CurrentAction     = 'menu_cloakroom'
  CurrentActionMsg  = _U('open_cloackroom')
  CurrentActionData = {station = station}
end

if part == 'Armory' then
  CurrentAction     = 'menu_armory'
  CurrentActionMsg  = _U('open_armory')
  CurrentActionData = {station = station}
end

if part == 'VehicleSpawner' then
  CurrentAction     = 'menu_vehicle_spawner'
  CurrentActionMsg  = _U('vehicle_spawner')
  CurrentActionData = {station = station}
end

if part == 'VehicleDeleter' then

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)

  if IsPedInAnyVehicle(playerPed,  false) then

    local vehicle = GetVehiclePedIsIn(playerPed, false)

    if DoesEntityExist(vehicle) then
      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('store_vehicle')
      CurrentActionData = {vehicle = vehicle, station = station}
    end

  end

 end

 if part == 'BossActions' then
  CurrentAction     = 'menu_boss_actions'
  CurrentActionMsg  = _U('open_bossmenu')
  CurrentActionData = {station = station}
end

end)

AddEventHandler('gangprop:hasExitedMarker', function(station, part)
ESX.UI.Menu.CloseAll()
CurrentAction = nil
end)

-- AddEventHandler('gangprop:hasEnteredEntityZone', function(entity)

--   local playerPed = GetPlayerPed(-1)

--   if PlayerData.job ~= nil and PlayerData.job.name == 'gang' and not IsPedInAnyVehicle(playerPed, false) then
--     CurrentAction     = 'remove_entity'
--     CurrentActionMsg  = _U('remove_object')
--     CurrentActionData = {entity = entity}
--   end

--   if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then

--     local playerPed = GetPlayerPed(-1)
--     local coords    = GetEntityCoords(playerPed)

--     if IsPedInAnyVehicle(playerPed,  false) then

--       local vehicle = GetVehiclePedIsIn(playerPed)

--       for i=0, 7, 1 do
--         SetVehicleTyreBurst(vehicle,  i,  true,  1000)
--       end

--     end

--   end

-- end)

-- AddEventHandler('gangprop:hasExitedEntityZone', function(entity)

--   if CurrentAction == 'remove_entity' then
--     CurrentAction = nil
--   end

-- end)

RegisterNetEvent('gangprop:handcuff')
AddEventHandler('gangprop:handcuff', function()

 IsHandcuffed    = not IsHandcuffed;
local playerPed = GetPlayerPed(-1)

 Citizen.CreateThread(function()

   if IsHandcuffed then

    RequestAnimDict('mp_arresting')

    while not HasAnimDictLoaded('mp_arresting') do
      Wait(100)
    end

     TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
    SetEnableHandcuffs(playerPed, true)
    SetPedCanPlayGestureAnims(playerPed, false)
    FreezeEntityPosition(playerPed,  true)

   else

    ClearPedSecondaryTask(playerPed)
    SetEnableHandcuffs(playerPed, false)
    SetPedCanPlayGestureAnims(playerPed,  true)
    FreezeEntityPosition(playerPed, false)

   end

 end)
end)

RegisterNetEvent('gangprop:drag')
AddEventHandler('gangprop:drag', function(cop)
TriggerServerEvent('esx:clientLog', 'starting dragging')
IsDragged = not IsDragged
CopPed = tonumber(cop)
end)

Citizen.CreateThread(function()
while true do
  Wait(0)
  if IsHandcuffed then
    if IsDragged then
      local ped = GetPlayerPed(GetPlayerFromServerId(CopPed))
      local myped = GetPlayerPed(-1)
      AttachEntityToEntity(myped, ped, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    else
      DetachEntity(GetPlayerPed(-1), true, false)
    end
  end
end
end)

RegisterNetEvent('gangprop:putInVehicle')
AddEventHandler('gangprop:putInVehicle', function()

local playerPed = GetPlayerPed(-1)
local coords    = GetEntityCoords(playerPed)

 if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

   local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  71)

   if DoesEntityExist(vehicle) then

    local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
    local freeSeat = nil

     for i=maxSeats - 1, 0, -1 do
      if IsVehicleSeatFree(vehicle,  i) then
        freeSeat = i
        break
      end
    end

     if freeSeat ~= nil then
      TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
    end

   end

 end

end)

RegisterNetEvent('gangprop:OutVehicle')
AddEventHandler('gangprop:OutVehicle', function(t)
local ped = GetPlayerPed(t)
ClearPedTasksImmediately(ped)
plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
local xnew = plyPos.x+2
local ynew = plyPos.y+2

 SetEntityCoords(GetPlayerPed(-1), xnew, ynew, plyPos.z)
end)

-- Handcuff
Citizen.CreateThread(function()
while true do
  Wait(0)
  if IsHandcuffed then
    DisableControlAction(0, 142, true) -- MeleeAttackAlternate
    DisableControlAction(0, 30,  true) -- MoveLeftRight
    DisableControlAction(0, 31,  true) -- MoveUpDown
  end
end
end)

-- Display markers
Citizen.CreateThread(function()
while true do

  Wait(0)

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
  if Data.locker ~= nil then
    if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.DrawDistance then
      DrawMarker(Config.MarkerType, Data.locker.x,  Data.locker.y,  Data.locker.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
  end

  if Data.armory ~= nil then
    if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.DrawDistance then
      DrawMarker(Config.MarkerType, Data.armory.x,  Data.armory.y,  Data.armory.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
  end

  if Data.veh ~= nil then
    if GetDistanceBetweenCoords(coords,  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < Config.DrawDistance then
      DrawMarker(Config.MarkerType, Data.veh.x,  Data.veh.y,  Data.veh.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
  end

  if Data.vehdel ~= nil then
    if GetDistanceBetweenCoords(coords,   Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z,  true) < Config.DrawDistance then
      DrawMarker(Config.MarkerType, Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
  end

  if Data.boss ~= nil then
    if GetDistanceBetweenCoords(coords,  Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < Config.DrawDistance then
      DrawMarker(Config.MarkerType, Data.boss.x,  Data.boss.y,  Data.boss.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
    end
  end
    
end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()

 while true do

  Wait(0)

  if PlayerData.gang ~= nil then
    local playerPed      = GetPlayerPed(-1)
    local coords         = GetEntityCoords(playerPed)
    local isInMarker     = false
    local currentStation = nil
    local currentPart    = nil
    
    if Data.locker ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.locker.x,  Data.locker.y,  Data.locker.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'Cloakroom'
      end
    end

    if Data.armory ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.armory.x,  Data.armory.y,  Data.armory.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'Armory'
      end
    end

    if Data.veh ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.veh.x,  Data.veh.y,  Data.veh.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleSpawner'
      end
    end

    if Data.vehspawn ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.vehspawn.x,  Data.vehspawn.y,  Data.vehspawn.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleSpawnPoint'
      end
    end

    if Data.vehdel ~= nil then
      if GetDistanceBetweenCoords(coords,  Data.vehdel.x,  Data.vehdel.y,  Data.vehdel.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'VehicleDeleter'
      end
    end

    if Data.boss ~= nil and PlayerData.gang ~= nil and PlayerData.gang.grade == 6 then
      if GetDistanceBetweenCoords(coords,   Data.boss.x,  Data.boss.y,  Data.boss.z,  true) < Config.MarkerSize.x then
        isInMarker     = true
        currentStation = Data.gang_name
        currentPart    = 'BossActions' 
      end
    end

    local hasExited = false
    
    if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart)) then
      if
        (LastStation ~= nil and LastPart ~= nil) and
        (LastStation ~= currentStation or LastPart ~= currentPart)
      then
        TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
        hasExited = true
      end
      HasAlreadyEnteredMarker = true
      LastStation             = currentStation
      LastPart                = currentPart

      TriggerEvent('gangprop:hasEnteredMarker', currentStation, currentPart)
    end

    if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

      HasAlreadyEnteredMarker = false

      TriggerEvent('gangprop:hasExitedMarker', LastStation, LastPart)
    end
  end
 end
end)


-- Key Controls
Citizen.CreateThread(function()
while true do

   Citizen.Wait(0)

   if CurrentAction ~= nil then

    SetTextComponentFormat('STRING')
    AddTextComponentString(CurrentActionMsg)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)

      if IsControlPressed(0,  Keys['E']) and PlayerData.gang ~= nil and PlayerData.gang.name == CurrentActionData.station and (GetGameTimer() - GUI.Time) > 150 then
        if CurrentAction == 'menu_cloakroom' then
          OpenCloakroomMenu()
        elseif CurrentAction == 'menu_armory' and PlayerData.gang.grade > 1 then
          OpenArmoryMenu(CurrentActionData.station)
        elseif CurrentAction == 'menu_vehicle_spawner' then
          ListOwnedCarsMenu()
        elseif CurrentAction == 'delete_vehicle' then
          StoreOwnedCarsMenu()
        elseif CurrentAction == 'menu_boss_actions' then
          ESX.UI.Menu.CloseAll()
          TriggerEvent('gangs:openBossMenu', CurrentActionData.station, function(data, menu)
          menu.close()
          CurrentAction     = 'menu_boss_actions'
          CurrentActionMsg  = _U('open_bossmenu')
          CurrentActionData = {}
          end)
        end
        CurrentAction = nil
        GUI.Time      = GetGameTimer()
      end
    end
  end
end)

function StoreOwnedCarsMenu()
	local playerPed    = GetPlayerPed(-1)
  local coords       = GetEntityCoords(playerPed)
  local vehicle      = CurrentActionData.vehicle
  local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
  local engineHealth = GetVehicleEngineHealth(vehicle)
  local plate        = vehicleProps.plate
  
  ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
    if valid then
      if engineHealth < 990 then
        local apprasial = math.floor((1000 - engineHealth)/1000*1000*5)
        reparation(apprasial, vehicle, vehicleProps)
      else
        putaway(vehicle, vehicleProps)
      end	
    else
      ESX.ShowNotification('Shoma nemitavanid in mashin ro dar Parking Park konid')
    end
  end, vehicleProps)
end

-- Repair Vehicles
function reparation(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()
	
	local elements = {
		{label = 'Park kardane mashin va Pardakhte: ' .. ' ($'.. tonumber(apprasial)/2 .. ')', value = 'yes'},
		{label = 'Tamas Ba mechanic', value = 'no'}
	}
	
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title    = 'Mashine shoma Zarbe Khorde',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		if data.current.value == 'yes' then

			ESX.TriggerServerCallback('esx_advancedgarage:checkRepairCost', function(hasEnoughMoney)
				if hasEnoughMoney then
					TriggerServerEvent('esx_advancedgarage:payhealth', tonumber(apprasial)/2)
					putaway(vehicle, vehicleProps)
				else
					ESX.ShowNotification('Shoma Poole Kafi nadarid')
				end
			end, tonumber(apprasial))

		elseif data.current.value == 'no' then
			ESX.ShowNotification('Darkhaste Mechanic')
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Put Away Vehicles
function putaway(vehicle, vehicleProps)
	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	ESX.ShowNotification('Mashin dar Garage Park shod')
end

RegisterCommand('gm', function(source)
  if PlayerData.gang ~= nil and PlayerData.gang.label == 'gang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions')  then
    OpenGangActionsMenu()
  else
    ESX.ShowNotification('You are no registered as a gang!')
  end
end, false)
  
RegisterCommand('gangmenu', function(source)
  if PlayerData.gang ~= nil and PlayerData.gang.label == 'gang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'gang_actions')  then
    OpenGangActionsMenu()
  else
    ESX.ShowNotification('You are no registered as a gang!')
  end
end, false)

Citizen.CreateThread(function()
  TriggerEvent('chat:addSuggestion', '/gm', 'Menu gang')
  TriggerEvent('chat:addSuggestion', '/gangmenu', 'Menu gang')
end)

---------------------------------------------------------------------------------------------------------
-- NB : gestion des menu
---------------------------------------------------------------------------------------------------------

RegisterNetEvent('NB:openMenuGang')
AddEventHandler('NB:openMenuGang', function()
OpenGangActionsMenu()
end)

RegisterNetEvent("setArmorHandler")
AddEventHandler("setArmorHandler",function()
  local ped = GetPlayerPed(-1)
  SetPedArmour(ped, 50) 

  TriggerEvent('skinchanger:getSkin', function(skin)
    if skin.sex == 0 then
      local clothesSkin = {
        ['bproof_1'] = 4,  ['bproof_2'] = 1,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    elseif skin.sex == 1 then
      local clothesSkin = {
        ['bproof_1'] = 3,  ['bproof_2'] = 1,
      }
      TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
    end
  end)
  
end)