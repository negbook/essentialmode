--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --


AddEventHandler('es_db:doesUserExist', function(identifier, callback)
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users WHERE identifier = @identifier', { ['@identifier'] = identifier }, function(users)
		if users > 0 then
			callback(true)
		else
			callback(false)
		end
	end)
end)

AddEventHandler('es_db:retrieveUser', function(identifier, callback)
	local Callback = callback
	MySQL.Async.fetchAll('SELECT * FROM users WHERE `identifier`=@identifier;', {identifier = identifier}, function(users)
		if users[1] then
			Callback(users[1])
		else
			Callback(false)
		end
	end)
end)

AddEventHandler('es_db:createUser', function(identifier, license, cash, bank, callback)
	local user = {
		identifier = identifier,
		money = cash or 0,
		bank = bank or 0,
		license = license,
		group = 'user',
		roles = 'normal',
		permission_level = 0
	}

	MySQL.Async.execute('INSERT INTO users (`identifier`, `money`, `bank`, `group`, `permission_level`, `license`, `roles`) VALUES (@identifier, @money, @bank, @group, @permission_level, @license, @roles);',
	{
		identifier = user.identifier,
		money = user.money,
		bank = user.bank,
		permission_level = user.permission_level,
		group = user.group,
		roles = user.roles,
		license = user.license
	}, function(rowsChanged)
		callback()
	end)
end)

AddEventHandler('es_db:retrieveLicensedUser', function(license, callback)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE `license`=@license;', {license = license}, function(users)
		if users[1] then
			callback(users[1])
		else
			callback(false)
		end
	end)
end)

AddEventHandler('es_db:doesLicensedUserExist', function(license, callback)
	MySQL.Async.fetchScalar('SELECT COUNT(1) FROM users WHERE license = @license', { ['@license'] = license }, function(users)
		if users > 0 then
			callback(true)
		else
			callback(false)
		end
	end)
end)

AddEventHandler('es_db:updateUser', function(identifier, new, callback)
	Citizen.CreateThread(function()
		--if(#new ~= 0)then
			local updateString = ''
			local params = {identifier = identifier}

			local length = tLength(new)
			local cLength = 1
			for k,v in pairs(new) do
				if (type(k) == 'string') then
					updateString = updateString .. '`' .. k .. '`=@' .. k
					params[k] = v
					if cLength < length then
						updateString = updateString .. ', '
					end
				end
				cLength = cLength + 1
			end

			MySQL.Async.execute('UPDATE users SET ' .. updateString .. ' WHERE `identifier`=@identifier', params, function(rowsChanged)
				if callback then
					callback(true)
				end
			end)
		--end
	end)
end)

function tLength(t)
	local l = 0
	for k,v in pairs(t)do
		l = l + 1
	end
	return l
end


db = {}

function db.firstRunCheck()
	TriggerEvent('es_db:firstRunCheck', ip, port)
end

function db.updateUser(identifier, new, callback)
	TriggerEvent('es_db:updateUser', identifier, new, callback)
end

function db.createUser(identifier, license, callback)
	TriggerEvent('es_db:createUser', identifier, license, tonumber(settings.defaultSettings.startingCash), tonumber(settings.defaultSettings.startingBank), callback)
end

function db.doesUserExist(identifier, callback)
	TriggerEvent('es_db:doesUserExist', identifier, callback)
end

function db.retrieveUser(identifier, callback)
	TriggerEvent('es_db:retrieveUser', identifier, callback)
end

db.firstRunCheck()

