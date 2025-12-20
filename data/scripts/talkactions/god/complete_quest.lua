local requiredParamsCompleted = RequiredParams( --
	RequiredParam("player", "player id or name", Player),
	RequiredParam("storage", "quest name (english)", COMMAND_REQUIRED_PARAM.STRING)
)

local completeQuest = TalkAction("/completeQuest", "/completequest")
function completeQuest.onSay(cid, words, param)
	local success, parsed = requiredParamsCompleted:ParsedOrSendErrorMessage(param, cid)
	if not success then
		return
	end

	local player = parsed.player
	local storage = parsed.storage
	local quest = Game.getQuestByName(storage)
	if quest and quest.missions then
		for _, mission in pairs(quest.missions) do
			player:setStorageValueByKey(mission.storage, MISSION_FINISHED)
			player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Completed mission " .. mission.storage)
		end
	else
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Quest not found")
	end
end
completeQuest:separator(" ")
completeQuest:groupType("god")
completeQuest:register()

local requiredParamsUncompleted = RequiredParams( --
	RequiredParam("player", "player id or name", Player),
	RequiredParam("storage", "quest name (english)", COMMAND_REQUIRED_PARAM.STRING)
)

local uncompleteQuest = TalkAction("/uncompleteQuest", "/uncompletequest")
function uncompleteQuest.onSay(cid, words, param)
	local success, parsed = requiredParamsUncompleted:ParsedOrSendErrorMessage(param)
	if not success then
		return
	end

	local player = parsed.player
	local storage = parsed.storage
	local quest = Game.getQuestByName(storage)
	if quest and quest.missions then
		for _, mission in pairs(quest.missions) do
			player:setStorageValueByKey(mission.storage, MISSION_NOT_STARTED)
			player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Uncompleted mission " .. mission.storage)
		end
	else
		player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Quest not found")
	end
end
uncompleteQuest:separator(" ")
uncompleteQuest:groupType("god")
uncompleteQuest:register()
