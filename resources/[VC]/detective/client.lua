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
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		PlayerData = xPlayer
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		PlayerData.job = job
	end
)

RegisterCommand("changeoutfit", function(source)
    if PlayerData.job.name == "police" then
        if PlayerData.job.grade == 5 or PlayerData.job.grade == 6 or PlayerData.job.grade == 7 or PlayerData.job.grade == 8 then
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
            ESX.ShowNotification("~r~~h~Dastresi shoma baraye estefade az in command kafi nist") 
        end
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid~")
        end
end, false)

RegisterCommand("vest", function(source)
    if PlayerData.job.name == "police" then
        if PlayerData.job.grade == 5 or PlayerData.job.grade == 6 or PlayerData.job.grade == 7 or PlayerData.job.grade == 8 then
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
            ESX.ShowNotification("~r~~h~Dastresi shoma baraye estefade az in command kafi nist") 
        end
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid~")
        end
end, false)

RegisterCommand("mask", function(source)
    if PlayerData.job.name == "police" then
        if PlayerData.job.grade == 5 or PlayerData.job.grade == 6 or PlayerData.job.grade == 7 or PlayerData.job.grade == 8 then
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
            ESX.ShowNotification("~r~~h~Dastresi shoma baraye estefade az in command kafi nist") 
        end
        else
        ESX.ShowNotification("~r~~h~Shoma police nistid~")
        end
end, false)