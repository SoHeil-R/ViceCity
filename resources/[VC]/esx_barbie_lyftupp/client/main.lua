-- Barbie was here --
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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}

local isCarry 				  = false
local hasRope 				  = true
local hasUsedRope 			= true

ESX                     = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)


function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Lift up'), value = 'drag'})
  
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Lift up'),
			align    = 'top-left',
			elements = elements
		},
    function(data, menu)

		local player, distance = ESX.Game.GetClosestPlayer()

		ESX.UI.Menu.CloseAll()	
		
		if data.current.value == 'drag' then			
			TriggerServerEvent('esx_barbie_lyftupp:checkRope')
			ESX.ShowNotification('You are lifting this person up...')
			TriggerServerEvent('esx_barbie_lyftupp:lyfteruppn', GetPlayerServerId(player))
			Citizen.Wait(5000)
			if hasRope == true then
				local dict = "anim@heists@box_carry@"
				
				RequestAnimDict(dict)
				while not HasAnimDictLoaded(dict) do
					Citizen.Wait(100)
				end
				
				local player, distance = ESX.Game.GetClosestPlayer()
				local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
				
				if distance ~= -1 and distance <= 3.0 then
					local closestPlayer, distance = ESX.Game.GetClosestPlayer()
					TriggerServerEvent('esx_barbie_lyftupp:lyfter', GetPlayerServerId(closestPlayer))		
					
					TaskPlayAnim(GetPlayerPed(-1), dict, "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
					isCarry = true
				else
					ESX.ShowNotification("No one is nearby...")
				end
			else
				--ESX.ShowNotification("You don't own any rope...")
      end
			menu.close()
		end

  end)

end

function LoadAnimationDictionary(animationD)
	while(not HasAnimDictLoaded(animationD)) do
		RequestAnimDict(animationD)
		Citizen.Wait(1)
	end
end

RegisterNetEvent('esx_barbie_lyftupp:upplyft')
AddEventHandler('esx_barbie_lyftupp:upplyft', function(target)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	local lPed = GetPlayerPed(-1)
	local dict = "amb@code_human_in_car_idles@low@ps@"
	
	if isCarry == false then
		LoadAnimationDictionary("amb@code_human_in_car_idles@generic@ps@base")
		TaskPlayAnim(lPed, "amb@code_human_in_car_idles@generic@ps@base", "base", 8.0, -8, -1, 33, 0, 0, 40, 0)
		
		AttachEntityToEntity(GetPlayerPed(-1), targetPed, 9816, 0.015, 0.38, 0.11, 0.9, 0.30, 90.0, false, false, false, false, 2, false)
		
		isCarry = true
	else
		DetachEntity(GetPlayerPed(-1), true, false)
		ClearPedTasksImmediately(targetPed)
		ClearPedTasksImmediately(GetPlayerPed(-1))
		
		isCarry = false
	end
end)

--[[Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if IsControlJustReleased(0, Keys['F3']) and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'action_menu') then
		OpenActionMenuInteraction()
    end
  end
end)]]--

RegisterNetEvent('esx_barbie_lyftupp')
AddEventHandler('esx_barbie_lyftupp', function()
  OpenActionMenuInteraction()
end)
