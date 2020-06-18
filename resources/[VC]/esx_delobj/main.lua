ESX = nil
Citizen.CreateThread(function ()
	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(0)
	   PlayerData = ESX.GetPlayerData()
	end
  end)
  
  RegisterNetEvent('esx:playerLoaded')
  AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
  end)
  
  RegisterNetEvent('esx:setJob')
  AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
  end)  

  RegisterCommand('delobject', function(source, args, rawCommand)
  if PlayerData.job.name == "police" or PlayerData.job.name == "journaliste" then
    local prop = 0
    local deelz = 10
    local deelxy = 2
    for offsety=-2,2 do
        for offsetx=-2,2 do
            for offsetz=-8,8 do
                local CoordFrom = GetEntityCoords(PlayerPedId(), true)
                local CoordTo = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 2.0, 0.0)
                local RayHandle = StartShapeTestRay(CoordFrom.x, CoordFrom.y, CoordFrom.z-(offsetz/deelz), CoordTo.x+(offsetx/deelxy), CoordTo.y+(offsety/deelxy), CoordTo.z-(offsetz/deelz), 16, PlayerPedId(), 0)
                local _, _, _, _, object = GetShapeTestResult(RayHandle)
                if object ~= 0 then
                    prop = object
                    break
                end
            end
        end
    end
    if prop == 0 then
        TriggerEvent('chatMessage', '', {255,255,255}, '^8Error: ^0could not detect object.')
    else
        NetworkRegisterEntityAsNetworked(prop)
        Citizen.Wait(100)           
                                        
        NetworkRequestControlOfEntity(prop)            

        if not IsEntityAMissionEntity(prop) then
            SetEntityAsMissionEntity(prop)        
        end

        Citizen.Wait(100)            
        DeleteEntity(prop)
	 end
  else
	ESX.ShowNotification('~r~~h~Shoma police nistid')
	end
  
  end, false)