-- require "resources/essentialmode/lib/MySQL"

--[[ ***** EVENTS GUI ***** ]]
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("antirpquestion:kick")
AddEventHandler("antirpquestion:kick", function()
	DropPlayer(source, "Be soalat natoonestid javab bedid.")
end)

RegisterServerEvent("antirpquestion:success")
AddEventHandler("antirpquestion:success", function()

	local _source = source
	exports.ghmattimysql:execute("UPDATE users SET question_rp = true WHERE `identifier`= @identifier;", {identifier = GetPlayerIdentifier(_source) }, function()
	end)

end)

--[[ ***** SPAWN ***** ]]
RegisterServerEvent("antirpquestion:didQuestion")
AddEventHandler("antirpquestion:didQuestion", function()

	local _source = source
	exports.ghmattimysql:execute('SELECT question_rp FROM users WHERE `identifier`= @identifier;', {identifier = GetPlayerIdentifier(_source)}, function(result)

		if not result[1].question_rp then
			TriggerClientEvent('antirpquestion:notMade', _source)
		end

	end)

end)