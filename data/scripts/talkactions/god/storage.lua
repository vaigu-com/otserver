local storage = TalkAction("/storage")

local function parseStorageId(input)
	if tonumber(input) then
		return tonumber(input)
	end

	if type(input) == "string" then
		return input
	end

	logger.debug("[/storage] wrong storage id/name")
end

function storage.onSay(caster, words, paramsString)
	local params = string.split(paramsString, ",")
	local player = Player(params[1])
	local storageId = parseStorageId(params[2])
	local nextState = params[3]
	if nextState then
		player:setStorageValueByKey(storageId, nextState)
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, T("Player :playerName: storage :storageId: set to :nextState:", { playerName = player:getName(), storageId = storageId, nextState = nextState }))
	else
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, T("Player :playerName: storage :storageId: value is :currentState:", { playerName = player:getName(), storageId = storageId, currentState = player:getStorageValueByKey(storageId) }))
	end

	return false
end

storage:separator(" ")
storage:setDescription("[Get]: /storage playerName, storage [Set]: /storage playerName, storage, nextState")
storage:groupType("god")
storage:register()
