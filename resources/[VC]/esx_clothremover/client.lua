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


RegisterNetEvent('smerfikubrania:koszulka')
AddEventHandler('smerfikubrania:koszulka', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['tshirt_1'] = 15, ['tshirt_2'] = 0,
		['torso_1'] = 15, ['torso_2'] = 0,
		['arms'] = 15, ['arms_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)
RegisterNetEvent('smerfikubrania:spodnie')
AddEventHandler('smerfikubrania:spodnie', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['pants_1'] = 21, ['pants_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

RegisterNetEvent('smerfikubrania:buty')
AddEventHandler('smerfikubrania:buty', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
	

		local clothesSkin = {
		['shoes_1'] = 34, ['shoes_2'] = 0
		}
		TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
	end)
end)

function OpenActionMenuInteraction(target)

	local elements = {}

	table.insert(elements, {label = ('Poner ropa'), value = 'ubie'})
	table.insert(elements, {label = ('Quitar camiseta'), value = 'tul'})
	table.insert(elements, {label = ('Quitar pantalones'), value = 'spo'})
	table.insert(elements, {label = ('Quitar zapatos'), value = 'but'})
  		ESX.UI.Menu.CloseAll()	


	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'action_menu',
		{
			title    = ('Clothes'),
			align    = 'top-left',
			elements = elements
		},
    function(data, menu)



		
		if data.current.value == 'ubie' then			
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
		end)
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'tul' then
		TriggerEvent('smerfikubrania:koszulka')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'spo' then
		TriggerEvent('smerfikubrania:spodnie')
		ESX.UI.Menu.CloseAll()	
		elseif data.current.value == 'but' then
		TriggerEvent('smerfikubrania:buty')
		ESX.UI.Menu.CloseAll()	
	  end
	end)


end

RegisterCommand("camiseta", function()
	TriggerEvent('skinchanger:getSkin', function(skin)

		local ped = GetPlayerPed(-1)
		local armor = GetPedArmour(ped)

		if armor == 0 then


			if PlayerData.job.name ~= "police" then
			
				local clothesSkin = {
				['tshirt_1'] = 15, ['tshirt_2'] = 0,
				['torso_1'] = 15, ['torso_2'] = 0,
				['arms'] = 15, ['arms_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

			else

				ESX.ShowNotification("~r~Shoma nemitavanid dar halat on duty lebas haye khod ra daravarid")

			end

		else
			ESX.ShowNotification("~r~Shoma nemitavanid hengami ke armor darid lebas khod ra avaz konid")
		end

	end)
end)

RegisterCommand("pantalones", function()

	local ped = GetPlayerPed(-1)
	local armor = GetPedArmour(ped)

	if armor == 0 then

			if PlayerData.job.name ~= "police" then

			TriggerEvent('skinchanger:getSkin', function(skin)
			

				local clothesSkin = {
				['pants_1'] = 21, ['pants_2'] = 0
				}
				TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
			end)

			else

				ESX.ShowNotification("~r~Shoma nemitavanid dar halat on duty lebas haye khod ra daravarid")

			end

		else
			ESX.ShowNotification("~r~Shoma nemitavanid hengami ke armor darid lebas khod ra avaz konid")
		end

end)

RegisterCommand("zapatos", function()

	local ped = GetPlayerPed(-1)
	local armor = GetPedArmour(ped)

	if armor == 0 then

		if PlayerData.job.name ~= "police" then


		TriggerEvent('skinchanger:getSkin', function(skin)
		

			local clothesSkin = {
			['shoes_1'] = 34, ['shoes_2'] = 0
			}
			TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end)

		else

			ESX.ShowNotification("~r~Shoma nemitavanid dar halat on duty lebas haye khod ra daravarid")

		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke armor darid lebas khod ra avaz konid")
	end

end)

RegisterCommand("ropa", function()

	local ped = GetPlayerPed(-1)
	local armor = GetPedArmour(ped)

	if armor == 0 then
	
			if PlayerData.job.name ~= "police" then

			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)

			else
				ESX.ShowNotification("~r~Shoma nemitavanid dar halat on duty lebas haye khod ra daravarid")
			end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke armor darid lebas khod ra avaz konid")
	end

end)