--[[

  ESX RP Chat

--]]
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

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', name , {255, 0, 0}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', name , {255, 0, 0}, message)
  end
end)

RegisterCommand('mp', function(source, args)

  local player = GetPlayerPed(-1)
	if PlayerData.job.name == "police" then 
		if (IsPedSittingInAnyVehicle(player)) then
			local vehicles = {1912215274, -2007026063, 2046537925, -1627000575, 456714581, -1323100960, 2071877360, 831758577, 699188170, 1341474454, -1674384553, -1973172295, 1127131465, -1647941228, -34623805, -1683328900, 1922257928, -305727417, -304857564, -1176401295, 1624609239, -1661555510, -982610657, -1083357304, 1496279100, -1959382956, -834607087, -1631996672, 653331214, 38057582 }

			local function contains(table, val)
				for i=1,#table do
				   if table[i] == val then 
					  return true
				   end
				end
				return false
       end
       
  if contains(vehicles, GetEntityModel(GetVehiclePedIsIn(player))) then
    if args[1] then
    TriggerServerEvent('mpCommand', table.concat(args," "))
    else
      ESX.ShowNotification('~r~~h~Shoma Hadeaghal bayad yek kalame type konid.')
    end
  else
    ESX.ShowNotification('~r~~h~Shoma Savar mashin police nistid!')
  end
else
  ESX.ShowNotification('~g~~h~Baraye estefade az in command bayad dakhel mashin bashid')
end
else
  ESX.ShowNotification('~r~~h~Shoma Police nistid!')
end
end, false)



RegisterNetEvent('sendProximityMessageShout')
AddEventHandler('sendProximityMessageShout', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
    if pid == myId then
      TriggerEvent('chatMessage',  name, {255, 0, 0}, message)
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 30.0 then
      TriggerEvent('chatMessage', name, {255, 0, 0},  message)
    end
end)

RegisterNetEvent('sendProximityMessageMP')
AddEventHandler('sendProximityMessageMP', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage',  name, {0, 25, 255}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 40.0 then
    TriggerEvent('chatMessage', name, {0, 25, 255},  message)
  end
end)

RegisterNetEvent('sendProximityMessageProxevent')
AddEventHandler('sendProximityMessageProxevent', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage',  name, {0, 25, 255}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 40.0 then
    TriggerEvent('chatMessage', name, {0, 25, 255},  message)
  end
end)


RegisterNetEvent('sendProximityMessageMMe')
AddEventHandler('sendProximityMessageMMe', function(id, name, message)

        local myId = PlayerId()
        local pid = GetPlayerFromServerId(id)
        if pid == myId then
          TriggerEvent('chatMessage',  name, {250, 175, 214}, message)
        elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
          TriggerEvent('chatMessage', name, {250, 175, 214},  message)
        end

end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', name, {200, 200, 200}, message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', name, {200, 200, 200},  message)
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, message  .."  (( " .. name .. " )) ")
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, message  .."  (( " .. name .. " )) ")
  end
end)