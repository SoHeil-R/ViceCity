ESX          = nil
CheckVehicle = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_basicneeds:OnSmokeCigarett')
AddEventHandler('esx_basicneeds:OnSmokeCigarett', function()
	TaskStartScenarioInPlace(GetPlayerPed(-1), 'WORLD_HUMAN_SMOKING', 0, true)
end)

RegisterNetEvent('esx_customItems:useClipcli')
AddEventHandler('esx_customItems:useClipcli', function()
	local inventory = ESX.GetPlayerData().inventory
				local clip = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'clip' then
						clip = inventory[i].count
					  end
					end

		if clip > 0 then

				ped = GetPlayerPed(-1)
				if IsPedArmed(ped, 4) then
					hash= GetSelectedPedWeapon(ped)
					
					if hash~=nil then
					TriggerServerEvent('esx_customItems:remove', "clip")
					AddAmmoToPed(GetPlayerPed(-1), hash, 25)
					ESX.ShowNotification("Shoma ba movafaghiat az kheshab estefade kardid")
					else
					ESX.ShowNotification("hash aslahe mored nazar namaloom ast")
					end
					
				else
					ESX.ShowNotification("Shoma aslaheyi dar dast naddarid")
				end
			
			else
				ESX.ShowNotification("Shoma clip nadarid")
			end

	end)

RegisterNetEvent('esx_customItems:useSilencer')
AddEventHandler('esx_customItems:useSilencer', function()
				local inventory = ESX.GetPlayerData().inventory
				local silencer = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'silencer' then
						silencer = inventory[i].count
					  end
					end

		if silencer > 0 then

			local ped = PlayerPedId()
			local currentWeaponHash = GetSelectedPedWeapon(ped)

					if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("component_at_pi_supp_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_VINTAGEPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_VINTAGEPISTOL"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_PI_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_SR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_SNIPERRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SNIPERRIFLE"), GetHashKey("COMPONENT_AT_AR_SUPP_02"))
						TriggerServerEvent('esx_customItems:remove', "silencer")
						ESX.ShowNotification("Shoma yek silencer estefade kardid")
						
					else 
						ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az silencer ra nadarad")
						
					end

			else
				ESX.ShowNotification("Shoma silencer nadarid")
			end
end)

RegisterNetEvent('esx_customItems:useFlashlight')
AddEventHandler('esx_customItems:useFlashlight', function()
					local inventory = ESX.GetPlayerData().inventory
				local flashlight = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'flashlight' then
						flashlight = inventory[i].count
					  end
					end

		if flashlight > 0 then

			local ped = PlayerPedId()
			local currentWeaponHash = GetSelectedPedWeapon(ped)

					if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid") 
						
					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid") 
						
					elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_AT_PI_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSMG"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
							
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_PUMPSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PUMPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_FLSH"))
						TriggerServerEvent('esx_customItems:remove', "flashlight")
						ESX.ShowNotification("Shoma yek flashlight estefade kardid")
						
					else 
						ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az flashlight ra nadarad")		
					end

		else
			ESX.ShowNotification("Shoma flashlight nadarid")
		end
end)

RegisterNetEvent('esx_customItems:useGrip')
AddEventHandler('esx_customItems:useGrip', function()
					local inventory = ESX.GetPlayerData().inventory
				local grip = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'grip' then
						grip = inventory[i].count
					  end
					end

		if grip > 0 then

			local ped = PlayerPedId()
			local currentWeaponHash = GetSelectedPedWeapon(ped)

					
					if currentWeaponHash == GetHashKey("WEAPON_COMBATPDW") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_COMBATPDW"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_SPECIALCARBINE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SPECIALCARBINE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_BULLPUPSHOTGUN") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_BULLPUPSHOTGUN"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_MARKSMANRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MARKSMANRIFLE"), GetHashKey("COMPONENT_AT_AR_AFGRIP"))
						TriggerServerEvent('esx_customItems:remove', "grip")
						ESX.ShowNotification("Shoma yek grip estefade kardid")
						
					else 
						ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade az grip ra nadarad")
						
					end

		else
			ESX.ShowNotification("Shoma grip nadarid")
		end
end)

RegisterNetEvent('esx_customItems:useYusuf')
AddEventHandler('esx_customItems:useYusuf', function()
					local inventory = ESX.GetPlayerData().inventory
				local yusuf = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'yusuf' then
						yusuf = inventory[i].count
					  end
					end

		if yusuf > 0 then
			
			local ped = PlayerPedId()
			local currentWeaponHash = GetSelectedPedWeapon(ped)

					if currentWeaponHash == GetHashKey("WEAPON_PISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL"), GetHashKey("COMPONENT_PISTOL_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_PISTOL50") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_PISTOL50"), GetHashKey("COMPONENT_PISTOL50_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_APPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_APPISTOL"), GetHashKey("COMPONENT_APPISTOL_VARMOD_LUXE"))  
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_HEAVYPISTOL") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_HEAVYPISTOL"), GetHashKey("COMPONENT_HEAVYPISTOL_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_SMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_SMG"), GetHashKey("COMPONENT_SMG_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_MICROSMG") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_MICROSMG"), GetHashKey("COMPONENT_MICROSMG_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")

					elseif currentWeaponHash == GetHashKey("WEAPON_ASSAULTRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ASSAULTRIFLE"), GetHashKey("COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_CARBINERIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_CARBINERIFLE"), GetHashKey("COMPONENT_CARBINERIFLE_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
						
					elseif currentWeaponHash == GetHashKey("WEAPON_ADVANCEDRIFLE") then
						GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("WEAPON_ADVANCEDRIFLE"), GetHashKey("COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE"))
						TriggerServerEvent('esx_customItems:remove', "yusuf")
						ESX.ShowNotification("Shoma yek skin talaee estefade kardid")
					
					else 
						ESX.ShowNotification("Aslahe mored nazar ghabeliat estefade kardan az skin talaee ra nadarad")
					end
		else
			ESX.ShowNotification("Shoma skin talaee nadarid")
		end
end)

RegisterNetEvent('esx_customItems:useBlowtorch')
AddEventHandler('esx_customItems:useBlowtorch', function()
					local inventory = ESX.GetPlayerData().inventory
				local blowtorch = 0
					for i=1, #inventory, 1 do
					  if inventory[i].name == 'blowtorch' then
						blowtorch = inventory[i].count
					  end
					end
					
		if blowtorch > 0 then

			local vehicle = ESX.Game.GetVehicleInDirection(4)
			if DoesEntityExist(vehicle) then
				local playerPed = GetPlayerPed(-1)

				CheckVehicle = true
				checkvehicle(vehicle)

				  TriggerServerEvent('esx_customItems:remove', "blowtorch")
                  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
                  SetVehicleAlarm(vehicle, true)
                  StartVehicleAlarm(vehicle)
                  SetVehicleAlarmTimeLeft(vehicle, 40000)
                  TriggerEvent("mythic_progbar:client:progress", {
                    name = "hijack_vehicle",
                    duration = 60000,
                    label = "LockPick kardan mashin",
                    useWhileDead = false,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }
				}, function(status)
					
                    if not status then

                      SetVehicleDoorsLocked(vehicle, 1)
                      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                      ClearPedTasksImmediately(playerPed)
              
					  ESX.ShowNotification("Mashin baz shod")
					  CheckVehicle = false
                    elseif status then
					  ClearPedTasksImmediately(playerPed)
					  CheckVehicle = false
					end
					
                end)

           else
            ESX.ShowNotification("Hich mashini nazdik shoma nist")
          end

		else

			ESX.ShowNotification("Shoma blowtorch nadarid")
		
		end
end)

RegisterNetEvent('esx_customItems:checkVehicleDistance')
AddEventHandler('esx_customItems:checkVehicleDistance', function(vehicle)

	CheckVehicle = true
	checkvehicle(vehicle)

end)

RegisterNetEvent('esx_customItems:checkVehicleStatus')
AddEventHandler('esx_customItems:checkVehicleStatus', function(status)

	CheckVehicle = status

end)


function checkvehicle(vehicle)
	Citizen.CreateThread(function()
		while CheckVehicle do
		  Citizen.Wait(2000)
		
		  local coords = GetEntityCoords(GetPlayerPed(-1))
		  local NearVehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  4.0,  0,  71)
			if vehicle ~= NearVehicle then
				ESX.ShowNotification("Mashin mored nazar az shoma ~r~door ~s~shod!")
				TriggerEvent("mythic_progbar:client:cancel")
				CheckVehicle = false
			end

		end
	  end)

end