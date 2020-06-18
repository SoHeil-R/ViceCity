ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do

		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterCommand("dance1",function(source, args)

	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
		local anim = "li_dance_facedj_11_v1_male^1"
		local player = PlayerPedId()


		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
			loadAnimDict( ad )
			if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
				ClearPedSecondaryTask(player)
			else
				TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			end
		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
	end

end, false)

RegisterCommand("dance2",function(source, args)

	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
		local anim = "hi_dance_facedj_09_v2_male^5"
		local player = PlayerPedId()


		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
			loadAnimDict( ad )
			if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
				ClearPedSecondaryTask(player)
			else
				TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			end
		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
	end

end, false)

RegisterCommand("dance3",function(source, args)

	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		local ad = "anim@amb@nightclub@dancers@black_madonna_entourage@"
		local anim = "li_dance_facedj_15_v2_male^2"
		local player = PlayerPedId()


		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
			loadAnimDict( ad )
			if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
				ClearPedSecondaryTask(player)
			else
				TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			end
		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
	end

end, false)

RegisterCommand("dance4",function(source, args)

	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
		local anim = "mi_dance_prop_15_v1_male^1"
		local player = PlayerPedId()


		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
			loadAnimDict( ad )
			if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
				ClearPedSecondaryTask(player)
			else
				TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			end
		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
	end

end, false)

RegisterCommand("dance5",function(source, args)

	if ESX.GetPlayerData()['IsDead'] ~= 1 then

		local ad = "anim@amb@nightclub@djs@dixon@"
		local anim = "dixn_dance_a_dixon"
		local player = PlayerPedId()


		if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
			loadAnimDict( ad )
			if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
				TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
				ClearPedSecondaryTask(player)
			else
				TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			end
		end

	else
		ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
	end

end, false)

RegisterCommand("dance6",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@djs@solomun@"
	local anim = "sol_trans_out_to_rt_a_sol"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance7",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance8",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance9",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance10",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance11",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance12",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance13",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance14",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance15",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance16",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance17",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance18",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance19",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance20",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance21",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance22",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance23",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance24",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance25",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance26",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance27",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance28",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance29",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance30",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_09_v2_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance31",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance32",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance33",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance34",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance35",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance36",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance37",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance38",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance39",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance40",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance41",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance42",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance43",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance44",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance45",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance46",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance47",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance48",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance49",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance50",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance51",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance52",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance53",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance54",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "hi_dance_facedj_11_v2_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance55",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance56",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance57",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance58",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance59",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance60",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)



RegisterCommand("dance61",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance62",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance63",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance64",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance65",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance66",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance67",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance68",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance69",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance70",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance71",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance72",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@"
	local anim = "mi_dance_facedj_09_v2_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance73",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance74",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance75",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance74",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance75",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance76",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity"
	local anim = "hi_dance_facedj_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance77",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance78",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance79",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance80",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance81",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance82",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_low_intensity"
	local anim = "trans_dance_crowd_li_to_hi_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance83",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance84",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance85",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance86",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance87",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance88",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_groups_transitions@from_med_intensity"
	local anim = "trans_dance_crowd_mi_to_hi_09_v1_male^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance89",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance90",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance91",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance92",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance93",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance94",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_female^6"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance95",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^1"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance96",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^2"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance97",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^3"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance98",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^4"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

RegisterCommand("dance99",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = "anim@amb@nightclub@dancers@crowddance_single_props@"
	local anim = "hi_dance_prop_09_v1_male^5"
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE ----------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("dance100",function(source, args)
if ESX.GetPlayerData()['IsDead'] ~= 1 then
	local ad = ""
	local anim = ""
	local player = PlayerPedId()


	if ( DoesEntityExist( player ) and not IsEntityDead( player )) then
		loadAnimDict( ad )
		if ( IsEntityPlayingAnim( player, ad, anim, 3 ) ) then
			TaskPlayAnim( player, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
			ClearPedSecondaryTask(player)
		else
			TaskPlayAnim( player, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0 )
		end
	end
else
  ESX.ShowNotification("~r~Shoma nemitavanid hengami ke zakhmi shodid animation ejra konid")
end
end, false)

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE --|-- EXAMPLE ----------
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function(prop_name, secondaryprop_name)
	while true do
		Citizen.Wait(500000000)
		if IsPedRagdoll(PlayerPedId()) then
			local playerPed = PlayerPedId()
			local prop_name = prop_name
			local secondaryprop_name = secondaryprop_name
			DetachEntity(prop, 1, 1)
			DeleteObject(prop)
			DetachEntity(secondaryprop, 1, 1)
			DeleteObject(secondaryprop)
		end
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

-- Конец, я потратил на это дерьмо два часа ;D --
