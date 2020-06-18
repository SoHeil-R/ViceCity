function tLength(t)
	local l = 0
	for k,v in pairs(t)do
		l = l + 1
	end

	return l
end
db = {}

RegisterServerEvent('db:updateUser')
AddEventHandler('db:updateUser', function(new)
	identifier = GetPlayerIdentifier(source, 0)
	db.updateUser(identifier, new)
end)

function db.updateUser(identifier, new, callback)
	local updateString = ""

	local length = tLength(new)
	local cLength = 1
	for k,v in pairs(new)do
		if cLength < length then
			if(type(v) == "number")then
				updateString = updateString .. "`" .. k .. "`=" .. v .. ","
			elseif(type(v) == "string")then
				updateString = updateString .. "`" .. k .. "`='" .. v .. "',"
			elseif(type(v) == "talbe")then
				updateString = updateString .. "`" .. k .. "`='" .. ESX.dump(v) "',"
			end
		else
			if(type(v) == "number")then
				updateString = updateString .. "`" .. k .. "`=" .. v .. ""
			else
				updateString = updateString .. "`" .. k .. "`='" .. ESX.dump(v) .. "'"
			end
		end
		cLength = cLength + 1
	end

	exports.ghmattimysql:execute('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', 
	{
		['identifier'] = identifier
	}, function(done)
		if callback then
			callback(true)
		end
	end)
end

function db.createUser(identifier, license, callback)
	exports.ghmattimysql:execute('INSERT INTO users (`identifier`, `money`, `bank`, `group`, `inventory`, `loadout`,`permission_level`, `license`) VALUES (@identifier, @money, @bank, @group, @inventory, @loadout, @permission_level, @license);', 
	{
		['identifier'] 			= identifier, 	
		['money'] 				= 500, 
		['bank'] 				= 4500, 
		['license'] 			= license, 
		['group'] 				= "user", 
		['inventory'] 			= '[{"count":0,"item":"iron"},{"count":0,"item":"fish"},{"count":0,"item":"petrol"},{"count":0,"item":"ephedra"},{"count":0,"item":"fabric"},{"count":0,"item":"slaughtered_chicken"},{"count":0,"item":"water"},{"count":0,"item":"bread"},{"count":0,"item":"wood"},{"count":0,"item":"ephedrine"},{"count":0,"item":"cigarett"},{"count":0,"item":"alive_chicken"},{"count":0,"item":"chips"},{"count":0,"item":"cocaine"},{"count":1,"item":"gps"},{"count":0,"item":"blowpipe"},{"count":0,"item":"diamond"},{"count":0,"item":"whiskey"},{"count":0,"item":"pcp"},{"count":0,"item":"cheesebows"},{"count":0,"item":"narcan"},{"count":0,"item":"tequila"},{"count":0,"item":"coca"},{"count":0,"item":"stone"},{"count":0,"item":"cocacola"},{"count":0,"item":"dabs"},{"count":0,"item":"lighter"},{"count":1,"item":"sprite"},{"count":0,"item":"vodka"},{"count":0,"item":"medikit"},{"count":0,"item":"bandage"},{"count":0,"item":"breathalyzer"},{"count":0,"item":"drugtest"},{"count":0,"item":"fixtool"},{"count":0,"item":"carokit"},{"count":1,"item":"pizza"},{"count":0,"item":"fixkit"},{"count":0,"item":"crack"},{"count":1,"item":"phone"},{"count":0,"item":"fakepee"},{"count":0,"item":"clothe"},{"count":0,"item":"wool"},{"count":0,"item":"gazbottle"},{"count":0,"item":"essence"},{"count":0,"item":"beer"},{"count":0,"item":"burger"},{"count":0,"item":"petrol_raffin"},{"count":0,"item":"painkiller"},{"count":0,"item":"meth"},{"count":0,"item":"carotool"},{"count":0,"item":"gold"},{"count":0,"item":"copper"},{"count":0,"item":"marabou"},{"count":0,"item":"fanta"},{"count":0,"item":"packaged_plank"},{"count":0,"item":"washed_stone"},{"count":0,"item":"packaged_chicken"},{"count":0,"item":"creditcard"},{"count":0,"item":"lotteryticket"},{"count":0,"item":"poppy"},{"count":0,"item":"cutted_wood"},{"count":0,"item":"macka"},{"count":0,"item":"loka"},{"count":0,"item":"loole"},{"count":0,"item":"drillsharji"},{"count":0,"item":"yusuf"},{"count":0,"item":"blowtorch"},{"count":0,"item":"clip"},{"count":0,"item":"silencer"},{"count":0,"item":"flashlight"},{"count":0,"item":"battrey"},{"count":0,"item":"mattezakhim"},{"count":0,"item":"lockpick"},{"count":0,"item":"capsul"},{"count":0,"item":"fanar"},{"count":0,"item":"drill"},{"count":0,"item":"grip"},{"count":0,"item":"bag"}]',
		['loadout']	 			= '[]',
		['permission_level'] 	= 0 
	}, function(e)
		callback()
	end)
end

function db.doesUserExist(identifier, callback)
	exports.ghmattimysql:execute('SELECT * FROM `users` WHERE `identifier` = @identifier', 
	{
		['@identifier'] = identifier
	}, function(users)
		if users[1] then
			callback(true)
		else
			callback(false)
		end
	end)
end

function db.retrieveUser(identifier, callback)
	exports.ghmattimysql:execute('SELECT * FROM users WHERE `identifier`=@identifier;', 
	{
		['identifier'] = identifier
	}, function(users)
		if users[1] then
			callback(users[1])
		else
			callback(false)
		end
	end)
end