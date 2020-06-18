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

RegisterNetEvent('esx_cpr:dothecpr') 
AddEventHandler('esx_cpr:dothecpr', function(targetplayer)

        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 1.0)
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
				if GetPlayerServerId(players[i]) == targetplayer then
					
					TriggerServerEvent('esx_cpr:setCprStatus', targetplayer, true)
                    TriggerEvent("mythic_progbar:client:progress", {
						name = "cpr_player",
						duration = 10000,
						label = "Dar hale CPR kardan",
						useWhileDead = false,
						canCancel = true,
						controlDisables = {
							disableMovement = true,
							disableCarMovement = true,
							disableMouse = false,
							disableCombat = true,
						},
						animation = {
							animDict = "mini@cpr@char_a@cpr_str",
							anim = "cpr_pumpchest",
						}
					}, function(status)
						if not status then
				
							TriggerServerEvent('esx_cpr:healplayer', targetplayer)
                		    TriggerServerEvent('esx_cpr:sendmessagetarget', targetplayer, PlayerId())
							TriggerServerEvent('esx_cpr:sendmessage', targetplayer)  
					
						elseif status then
						   TriggerServerEvent('esx_cpr:setCprStatus', targetplayer, false)
						end
					end)
					          
                end
            end
        end    
end)

RegisterNetEvent("esx_cpr:healPlayerClient")
AddEventHandler("esx_cpr:healPlayerClient",function()

	local sourcePed = GetPlayerPed(-1)
	local hp = GetEntityHealth(sourcePed)
	hp = hp + 30
	SetEntityHealth(sourcePed, hp)
	ESX.ShowNotification("~g~~h~Shoma CPR shodid!")

end)