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


RegisterCommand("rm", function(args, string)
    local ped = GetPlayerPed(PlayerId())
    local armor = GetPedArmour(ped)
    if armor > 0 then
	  if PlayerData.job.name ~= "police" then
        msg("Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid")
	  end
    else
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                     local clothesSkin = {
                     ['bproof_1'] = 0, ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            --  female
                   elseif skin.sex == 1 then
                     local clothesSkin = {
                     ['bproof_1'] = 0, ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                 end
            end)
            msg("Shoma jelighe khod ra daravardid.")
    end
    if armor > 0 and PlayerData.job.name == "police" then
        if PlayerData.job.grade == 4 or PlayerData.job.grade == 5 or PlayerData.job.grade == 6 or PlayerData.job.grade == 7 or PlayerData.job.grade == 8 then
        TriggerEvent('skinchanger:getSkin', function(skin)
            --  male
                   if skin.sex == 0 then
                     local clothesSkin = {
                     ['bproof_1'] = 0, ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            --  female
                   elseif skin.sex == 1 then
                     local clothesSkin = {
                     ['bproof_1'] = 0, ['bproof_2'] = 0
                     }
                     TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                 end
            end)
            msg("Shoma jelighe khod ra daravardid.")
			else
			msg("Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid")
			end
        else
		   if PlayerData.job.name == "police" then
            msg("Shoma nemitavanid hengami ke armor darid jelighe khod ra dar biyarid")
		   end
        end
end, false)

function msg(text)
    TriggerEvent("chatMessage", "System", {255, 4, 1}, text)
end