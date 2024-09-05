local config = { ["mysteriando"] = "Desert Quest: credit for puzzle ", ["granted"] = " - granted." }

local questline = Storage.DesertQuestOne.Questline

local function playerCompletedCurrentMysteriando(player, currentActionid)
	return player:getStorageValue(currentActionid) == 1
end

local function playerCompletedNoMysteriandos(player)
	return player:getStorageValue(questline) == -1
end

local function giveMysteriandoCredit(player, aid, nextQuestlineValue)
	player:setStorageValue(questline, nextQuestlineValue)
	player:setStorageValue(aid, 1)
	local localizer = player:Localizer(Storage.DesertQuestOne.Questline)
	local mysteriandoString = localizer:Get(config["mysteriando"])
	local grantedString = localizer:Get(config["granted"])

	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, mysteriandoString .. nextQuestlineValue .. grantedString)
	player:getPosition():sendMagicEffect(CONST_ME_PURPLEENERGY)
end

function TryProgressDesertQuest(creature, itemOrAid)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	local aid = 0
	if type(itemOrAid) == "number" then
		aid = itemOrAid
	else
		aid = itemOrAid:getActionId()
	end

	local mysteriandoActionid = aid
	local nextQuestlineValue = aid - questline

	if playerCompletedNoMysteriandos(player) then
		player:setStorageValue(questline, 0)
	end

	if playerCompletedCurrentMysteriando(player, mysteriandoActionid) then
		return false
	end

	giveMysteriandoCredit(player, aid, nextQuestlineValue)
	return true
end

local validPortals = { [1949] = true, [8262] = true, [8261] = true }

local function isPortal(item)
	local id = item:getId()
	return validPortals[id]
end

local skipDoor = MoveEvent()

function skipDoor.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if not isPortal(item) then
		TryProgressDesertQuest(creature, item)
		return
	end

	local aid = item:getActionId()
	local toPosOffset = DESERT_QUEST_ONE_SKIPS[aid]
	if not toPosOffset then
		return
	end

	player:teleportTo(DESERT_QUEST_ONE_ANCHOR:Moved(toPosOffset))
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

for _, actionId in pairs(Storage.DesertQuestOne.QuestState) do
	skipDoor:aid(actionId)
end
skipDoor:type("stepin")
skipDoor:register()
