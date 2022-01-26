--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --

local bs = { [0] =
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
	'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
	'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
	'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/',
}

db = {}

function db.firstRunCheck()
	TriggerEvent('es_db:firstRunCheck', ip, port)
end

function db.updateUser(identifier, new, callback)
	TriggerEvent('es_db:updateUser', identifier, new, callback)
end

db.requestDB = requestDB

function db.createUser(identifier, license, callback)
	TriggerEvent('es_db:createUser', identifier, license, tonumber(settings.defaultSettings.startingCash), tonumber(settings.defaultSettings.startingBank), callback)
end

function db.doesUserExist(identifier, callback)
	TriggerEvent('es_db:doesUserExist', identifier, callback)
end

function db.retrieveUser(identifier, callback)
	TriggerEvent('es_db:retrieveUser', identifier, callback)
end

function db.performCheckRunning()
	requestDB('GET', nil, nil, nil, function(err, rText, header)
		print(rText)
	end)
end

db.firstRunCheck()

-- Why the fuck is this required?
local theTestObject, jsonPos, jsonErr = json.decode('{"test":"tested"}')