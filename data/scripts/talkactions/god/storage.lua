local storage = TalkAction("/storage")

local function parseStorageId(input)
	if type(input) == "number" then
		return input
	end

	if type(input) == "string" then
		return _G[input]
	end

	logger.debug("[/storage] wrong storage id/name")
end

function storage.onSay(caster, words, paramsString)
	local params = string.split(paramsString, ",")
	local player = Player(params[1])
	local storageId = parseStorageId(params[2])
	local nextStorageValue = params[3]
	if nextStorageValue then
		player:setStorageValue(storageId, nextStorageValue)
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, T("Player :playerName: storage :storageId: set to :nextStorageValue:", { playerName = player:getName(), storageId = storageId, nextStorageValue = nextStorageValue }))
	else
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, T("Player :playerName: storage :storageId: value is :nextStorageValue:", { playerName = player:getName(), storageId = storageId, nextStorageValue = nextStorageValue }))
	end

	return false
end

storage:separator(" ")
storage:setDescription("[Get]: /storage playerName, storage [Set]: /storage playerName, storage, nextStorageValue")
storage:groupType("god")
storage:register()
