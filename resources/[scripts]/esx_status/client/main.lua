ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local Status = {}
local PlayerData


function GetStatusData(minimal)
	local status = {}
	local ped = GetPlayerPed(-1)

	for i=1, #Status, 1 do

		if minimal then

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		else

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		end

	end

	local pedhealth = GetEntityHealth(ped)

	if pedhealth < 100 then
	  pedhealth = 0
	else
	  pedhealth = pedhealth - 100
	end

	table.insert(status, {
		name	= 'health',
		val		= pedhealth,
		percent	= pedhealth
	})

	local armor = GetPedArmour(ped)
	
	table.insert(status, {
		name	= 'armor',
		val		= armor ,
		percent	= armor
	})
	return status
end

AddEventHandler('esx_status:registerStatus', function(name, default, color, visible, tickCallback)
	local s = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, s)
end)

local health = 200
local armor	 = 0

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	for i=1, #Status, 1 do
		for j=1, #PlayerData.status, 1 do
			if Status[i].name == PlayerData.status[j].name then
				Status[i].set(PlayerData.status[j].val)
			elseif PlayerData.status[j].name == 'health' then
				health = tonumber(PlayerData.status[j].val) + 100
			elseif PlayerData.status[j].name == 'armor' then
				armor = tonumber(PlayerData.status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
	  while true do

	  	for i=1, #Status, 1 do
	  		Status[i].onTick()
	  	end
	
		TriggerEvent('esx_customui:updateStatus', GetStatusData(true))
	    Citizen.Wait(Config.TickTime)
	  end
	end)
end)

RegisterNetEvent('esx_status:setLastStats')
AddEventHandler('esx_status:setLastStats', function()
	local ped = GetPlayerPed(-1)
	SetEntityHealth(ped, health)
	if armor > 0 then
		SetPedArmour(ped, armor)
	
		if PlayerData.job.name ~= "police" then 

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

		else

			TriggerEvent('skinchanger:getSkin', function(skin)
				if skin.sex == 0 then
					local clothesSkin = {
						['bproof_1'] = 12,  ['bproof_2'] = 3,
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				elseif skin.sex == 1 then
					local clothesSkin = {
						['bproof_1'] = 11,  ['bproof_2'] = 3,
					}
					TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
				end
			end)

		end

	else

		TriggerEvent('skinchanger:getSkin', function(skin)
			local clothesSkin = {
				['bproof_1'] = 0,  ['bproof_2'] = 0,
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)

	end
end)

RegisterNetEvent('esx_status:set')
AddEventHandler('esx_status:set', function(name, val)	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:add')
AddEventHandler('esx_status:add', function(name, val)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

RegisterNetEvent('esx_status:remove')
AddEventHandler('esx_status:remove', function(name, val)	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	TriggerServerEvent('esx_status:update', GetStatusData(true))
end)

AddEventHandler('esx_status:getStatus', function(name, cb)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end
end)

-- Loaded event
Citizen.CreateThread(function()
	TriggerEvent('esx_status:loaded')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)
		TriggerServerEvent('esx_status:update', GetStatusData(true))
	end
end)