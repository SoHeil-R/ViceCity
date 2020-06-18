ESX = nil
Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
			PlayerData = ESX.GetPlayerData()
		end
	end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded",
	function(xPlayer)
        PlayerData = xPlayer
        Citizen.Wait(5000)
        CheckXrays()
    end)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

RegisterNetEvent("outfitHandler")
AddEventHandler("outfitHandler",function(source)
    if PlayerData.job.name == "police" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                     local clothesSkin = {
                        ['bproof_1'] = 0, ['bproof_2'] = 0,
                        ['tshirt_1'] = 20, ['tshirt_2'] = 1,
                        ['torso_1'] = 95, ['torso_2'] = 1,
                        ['pants_1'] = 28, ['pants_2'] = 0,
                        ['decals_1'] = 0, ['decals_2'] = 0,
                        ['arms'] = 11, 
                        ['helmet_1'] = -1,
                        ['mask_1'] = 0, ['mask_2'] = 0,
                        ['shoes_1'] = 10, ['shoes_2'] = 0,
                        ['chain_1'] = 6, ['chain_2'] = 0,
                        ['glasses_1'] = 5, ['glasses_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            --  female
                   elseif skin.sex == 1 then
                     ESX.ShowNotification("~r~~h~Bara dokhtar outfit nadarim :|")
                    end
            end)
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid")
        end
end)

RegisterNetEvent("swatHandler")
AddEventHandler("swatHandler",function(source)
    if PlayerData.job.name == "police" then
        if swat then
        local ped = GetPlayerPed(PlayerId())
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                     local clothesSkin = {
                        ['tshirt_1'] = 55,  ['tshirt_2'] = 0,
                        ['torso_1'] = 49,   ['torso_2'] = 2,
                        ['decals_1'] = 3,   ['decals_2'] = 0,
                        ['arms'] = 31,
                        ['pants_1'] = 31,   ['pants_2'] = 2,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['glasses_1'] = 0,
                        ['helmet_1'] = 117,  ['helmet_2'] = 0,
                        ['chain_1'] = 1,    ['chain_2'] = 0,
                        ['ears_1'] = 2,     ['ears_2'] = 0,
                        ['mask_1'] = 130,   ['mask_2'] = 0,
                        ['bproof_1'] = 12,  ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                     SetPedArmour(ped, 100)
            --  female
                   elseif skin.sex == 1 then
                    local clothesSkin = {
                        ['tshirt_1'] = 33,  ['tshirt_2'] = 1,
                        ['torso_1'] = 42,   ['torso_2'] = 2,
                        ['decals_1'] = 11,   ['decals_2'] = 0,
                        ['arms'] = 34,
                        ['pants_1'] = 30,   ['pants_2'] = 2,
                        ['shoes_1'] = 25,   ['shoes_2'] = 0,
                        ['helmet_1'] = 116,  ['helmet_2'] = 0,
                        ['chain_1'] = 1,    ['chain_2'] = 0,
                        ['glasses_1'] = 5,  ['glasses_2'] = 0,
                        ['ears_1'] = 2,     ['ears_2'] = 0,
                        ['mask_1'] = 130,   ['mask_2'] = 0,
                        ['bproof_1'] = 18,  ['bproof_2'] = 2
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                     SetPedArmour(ped, 100)
                    end
                    swat = false
                ESX.ShowNotification("~g~~h~Shoma onduty ~r~SWAT ~g~Shodid")
            end)
        else
            local ped = GetPlayerPed(PlayerId())
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
              end)
              SetPedArmour(ped, 0)
              swat = true
              ESX.ShowNotification("~g~~h~Shoma offduty ~r~SWAT ~g~Shodid")     
        end
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid~")
        end
end)

RegisterNetEvent("vestHandler")
AddEventHandler("vestHandler",function(source)
    if PlayerData.job.name == "police" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                    if skin.tshirt_1 == 20 and skin.tshirt_2 == 1 and skin.torso_1 == 95 and skin.torso_2 == 1 and skin.pants_1 == 28 and skin.pants_2 == 0 and skin.decals_1 == 0 and skin.decals_2 == 0 and skin.arms == 11 and skin.helmet_1 == -1 and skin.shoes_1 == 10 and skin.shoes_2 == 0 and skin.chain_1 == 6 and skin.chain_2 == 0 and skin.glasses_1 == 5 and skin.glasses_2 == 0 then
                        if skin.bproof_1 == 12 and skin.bproof_2 == 4 then
                     local clothesSkin = {
                        ['bproof_1'] = 0, ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                     ESX.ShowNotification("~g~~h~Shoma Jelighe khod ra daravardid") 
                    else
                        local clothesSkin = {
                            ['bproof_1'] = 12, ['bproof_2'] = 4
                         }
                         TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                         ESX.ShowNotification("~g~~h~Shoma jelighe poshidid")
                    end
                    else
                        ESX.ShowNotification("~r~~h~Shoma lebas detective nadarid!")
                    end
            --  female
                   elseif skin.sex == 1 then
                    if skin.bproof_1 == 8 and skin.bproof_2 == 1 then
                        local clothesSkin = {
                           ['bproof_1'] = 0, ['bproof_2'] = 0
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        ESX.ShowNotification("~g~~h~Shoma Jelighe khod ra daravardid") 
                       else
                           local clothesSkin = {
                               ['bproof_1'] = 8, ['bproof_2'] = 1
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            ESX.ShowNotification("~g~~h~Shoma jelighe poshidid")
                       end 
                    end
            end)
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid")
        end
end)

RegisterNetEvent("maskHandler")
AddEventHandler("maskHandler",function(source)
    if PlayerData.job.name == "police" then
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                    if skin.tshirt_1 == 20 and skin.tshirt_2 == 1 and skin.torso_1 == 95 and skin.torso_2 == 1 and skin.pants_1 == 28 and skin.pants_2 == 0 and skin.decals_1 == 0 and skin.decals_2 == 0 and skin.arms == 11 and skin.helmet_1 == -1 and skin.shoes_1 == 10 and skin.shoes_2 == 0 and skin.chain_1 == 6 and skin.chain_2 == 0 and skin.glasses_1 == 5 and skin.glasses_2 == 0 then
                        if skin.mask_1 == 0 then
                     local clothesSkin = {
                        ['mask_1'] = math.random(1, 147), ['mask_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                     ESX.ShowNotification("~g~~h~Shoma az mask estefade kardid") 
                    else
                        local clothesSkin = {
                            ['mask_1'] = 0, ['mask_2'] = 0
                         }
                         TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                         ESX.ShowNotification("~g~~h~Shoma mask ra daravardid")
                    end
                    else
                        ESX.ShowNotification("~r~~h~Shoma lebas detective nadarid!")
                    end
            --  female
                   elseif skin.sex == 1 then
                    if skin.mask_1 == 0 then
                        local clothesSkin = {
                           ['mask_1'] = math.random(1, 147), ['mask_2'] = 0
                        }
                        TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                        ESX.ShowNotification("~g~~h~Shoma az mask estefade kardid") 
                       else
                           local clothesSkin = {
                               ['mask_1'] = 0, ['mask_2'] = 0
                            }
                            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            ESX.ShowNotification("~g~~h~Shoma mask ra daravardid")
                       end
                    end
            end)
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid")
        end
end)

function CheckXrays()
Citizen.CreateThread(function()
while true do
    Citizen.Wait(5000)
    if PlayerData.job.name == "police" or PlayerData.job.name == "offpolice" then
    local player = GetPlayerPed(-1)
    if (IsPedSittingInAnyVehicle(player)) then
        local vehicle = GetVehiclePedIsIn(player, false)
        
            local vehicles = {
                353883353
            }

            local function contains(table, val)
                for i = 1, #table do
                    if table[i] == val then
                        return true
                    end
                end
                return false
            end
            if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
                local car = GetVehiclePedIsIn(player, false)
            if car then
                if GetPedInVehicleSeat(car, -1) == player then
                    IsEngineOn =  false
                ESX.TriggerServerCallback('esx_core:checkxray', function(isXray)
                    if isXray == false then

                        IsEngineOn = false
                        while (IsEngineOn == false) do
                            SetVehicleUndriveable(vehicle, true)
                            Citizen.Wait(0)
                        end
                        
                    else
                        
                        IsEngineOn = true
                        SetVehicleUndriveable(vehicle,false)
			            SetVehicleEngineOn(vehicle,true,false,false)
                        
                    end

                end, GetPlayerServerId(PlayerId()))
                  end
               end
           end
       end
    end
end
end)
end

RegisterNetEvent('sendRollThatShit')
AddEventHandler('sendRollThatShit', function()
	RequestAnimDict('mp_player_int_upperwank')
	if not HasAnimDictLoaded('mp_player_int_upperwank') then
		RequestAnimDict('mp_player_int_upperwank') 
		while not HasAnimDictLoaded('mp_player_int_upperwank') do 
			Citizen.Wait(1)
		end
	end
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 6.0, 'shake', 0.9)
	TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 6.0, 'drop', 0.9)
	
	local playerPed = GetPlayerPed(-1)

	local animation = 'mp_player_int_wank_01_enter'
	local animation2 = 'mp_player_int_wank_01_exit'
	local flags = 8
	TaskPlayAnim(playerPed, 'mp_player_int_upperwank', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
	Citizen.Wait(650)
	TaskPlayAnim(playerPed, 'mp_player_int_upperwank', animation2, 8.0, -8, -1, flags, 0, 0, 0, 0)
	
end)

RegisterNetEvent('sendTasMessage')
AddEventHandler('sendTasMessage', function(id, name, message)
	local myId = PlayerId()
	local pid = GetPlayerFromServerId(id)
	Citizen.Wait(1000)
	if pid == myId then
		TriggerEvent('chatMessage', name, {150, 150, 250}, message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', name, {150, 150, 250},  message)
	end
end)
