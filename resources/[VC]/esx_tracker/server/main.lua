local policetable = {}
local ambulancetable = {}
local taxitable = {}
local mechanictable = {}
ESX                 = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function getIdentity(identifier, callback)
 
	MySQL.Async.fetchAll("SELECT * FROM `users` WHERE `identifier` = @identifier", {['@identifier'] = identifier},
	function(result)
	  if result[1]['playerName'] ~= nil then
		local data = {
		  identifier    = result[1]['identifier'],
		  name = string.gsub(result[1]['playerName'], "_", " "),
		  dateofbirth   = result[1]['dateofbirth'],
		  sex           = result[1]['sex'],
		  phone_number  = result[1]['phone_number']
		}
		callback(data)
	  else
		local data = {
		  identifier    = '',
		  name = '',
		  dateofbirth   = '',
		  sex           = '',
		  phone_number  = '',
		}
		callback(data)
	  end
	end)
  end


---//Ambulance//---
-------------------------------------------------------------------
RegisterServerEvent('esx_tracker:addAmbulanceToTable')
AddEventHandler('esx_tracker:addAmbulanceToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local i = GetPlayerName(source) 
	
	if  #ambulancetable > 0 then
	
		for k,v in pairs(ambulancetable) do
			if ambulancetable[k].i == i then
				table.remove(ambulancetable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(ambulancetable, {
			i = i,
			name = (data.name)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removeAmbulanceFromTable')
AddEventHandler('esx_tracker:removeAmbulanceFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(ambulancetable) do
		if ambulancetable[k].i == i then
			table.remove(ambulancetable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updateAmbulance',-1,ambulancetable,i,showblips)
end)



--------------------------------------------------------------------------------- 
  
  


---//Police//---
RegisterServerEvent('esx_tracker:addPoliceToTable')
AddEventHandler('esx_tracker:addPoliceToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local i = GetPlayerName(source) 
	
	if  #policetable > 0 then
	
		for k,v in pairs(policetable) do
			if policetable[k].i == i then
				table.remove(policetable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(policetable, {
			i = i,
			name = (data.name)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removePoliceFromTable')
AddEventHandler('esx_tracker:removePoliceFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(policetable) do
		if policetable[k].i == i then
			table.remove(policetable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updatePolice',-1,policetable,i,showblips)
end)
-----------------------------------------------------------------------------------





---//Taxi//---
-------------------------------------------------------------------
RegisterServerEvent('esx_tracker:addTaxiToTable')
AddEventHandler('esx_tracker:addTaxiToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local i = GetPlayerName(source) 
	
	if  #taxitable > 0 then
	
		for k,v in pairs(taxitable) do
			if taxitable[k].i == i then
				table.remove(taxitable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(taxitable, {
			i = i,
			name = (data.name)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updateTaxi',-1,taxitable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removeTaxiFromTable')
AddEventHandler('esx_tracker:removeTaxiFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(taxitable) do
		if taxitable[k].i == i then
			table.remove(taxitable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updateTaxi',-1,taxitable,i,showblips)
end)



--------------------------------------------------------------------------------- 

---//Mechanic//---
-------------------------------------------------------------------
RegisterServerEvent('esx_tracker:addMechanicToTable')
AddEventHandler('esx_tracker:addMechanicToTable',function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local identifier = xPlayer.identifier
	local i = GetPlayerName(source) 
	
	if  #mechanictable > 0 then
	
		for k,v in pairs(mechanictable) do
			if mechanictable[k].i == i then
				table.remove(mechanictable,k)
				
			end
		end
	end
	
	getIdentity(identifier, function(data)
	
		table.insert(mechanictable, {
			i = i,
			name = (data.name)
		})

		showblips = true
		TriggerClientEvent('esx_tracker:updateMechanic',-1,mechanictable,i,showblips)
	end)
end)


RegisterServerEvent('esx_tracker:removeMechanicFromTable')
AddEventHandler('esx_tracker:removeMechanicFromTable',function()

	local i = GetPlayerName(source)	

	for k,v in pairs(mechanictable) do
		if mechanictable[k].i == i then
			table.remove(mechanictable,k)
		end
	end
		showblips = false
		TriggerClientEvent('esx_tracker:updateMechanic',-1,mechanictable,i,showblips)
end)



--------------------------------------------------------------------------------- 



----
RegisterServerEvent('esx_tracker:changejob')
AddEventHandler('esx_tracker:changejob',function(job)

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if job == "police" then

		local grade = xPlayer.grade
		xPlayer.setJob("offpolice", grade)
		xPlayer.setJob("police", grade)

	elseif job == "ambulance" then

		local grade = xPlayer.grade
		xPlayer.setJob("offambulance", grade)
		xPlayer.setJob("ambulance", grade)
	
	elseif job == "taxi" then

		local grade = xPlayer.grade
		xPlayer.setJob("offtaxi", grade)
		xPlayer.setJob("taxi", grade)
	
	elseif job == "mechanic" then

		local grade = xPlayer.grade
		xPlayer.setJob("offmechanic", grade)
		xPlayer.setJob("mechanic", grade)

	end

end)
----