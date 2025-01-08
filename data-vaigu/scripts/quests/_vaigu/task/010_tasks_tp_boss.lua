local taskBossRoomExitPortalKey = TaskBossPortalKeyScope:Get("Exit")
local taskBossRoomLastEnterPos = TaskBossPortalKeyScope:Get("LastEnterPos")

local function roomIsOccupied(bossRoomCenter, clearRadiusX, clearRadiusY, playerId)
	local spectators = Game.getSpectators(bossRoomCenter, false, true, clearRadiusX, clearRadiusX, clearRadiusY, clearRadiusY)
	if #spectators ~= 0 then
		local player = Player(playerId)
		for i = 1, #spectators do
			local spectator = spectators[i]
			if #spectators == 1 and spectator:getName() == player:getName() then
				return false
			end
		end
		return true
	end
	return false
end

local function clearBossRoom(playerId, bossId, bossRoomCenter, clearRadiusX, clearRadiusY, exitPosition)
	if not Creature(bossId) then
		return
	end
	local spectators, spectator = Game.getSpectators(bossRoomCenter, false, false, clearRadiusX, clearRadiusX, clearRadiusY, clearRadiusY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
end

local function playerIsCheesing(fromPosition, toPosition)
	if toPosition == fromPosition then
		return true
	end
	return false
end

local defaultTimeLimitMinutes = 5

local function onEnter(player, task, fromPosition)
	player:IncrementStorage(task.bossStorage, -1)
	player:setStorageValueByKey(taskBossRoomLastEnterPos, fromPosition)

	local spectators, spectator = Game.getSpectators(task.bossRoomCenter, false, false, task.clearRadiusX, task.clearRadiusX, task.clearRadiusY, task.clearRadiusY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end

	player:teleportTo(task.bossRoomPlayerEnterPosition)
	task.bossRoomPlayerEnterPosition:sendMagicEffect(CONST_ME_TELEPORT)

	local bossName = ""
	if type(task.bossName) == "table" then
		bossName = task.bossName[math.random(1, #task.bossName)]
	else
		bossName = task.bossName
	end

	local monster = Game.createMonster(bossName, task.bossPosition, true, true)
	if not monster then
		return true
	end
	local timeLimitMinutes = task.bossTimeLimit or defaultTimeLimitMinutes

	addEvent(clearBossRoom, 60 * timeLimitMinutes * 1000, player.uid, monster.uid, task.bossRoomCenter, task.clearRadiusX, task.clearRadiusY, fromPosition) --5 min
	player:say(T("You have :time: minutes to defeat :bossName:.", { time = timeLimitMinutes, bossName = bossName }), TALKTYPE_MONSTER_SAY)
end

local function canEnter(player, task, fromPosition, toPosition)
	if not player then
		return false
	end

	if playerIsCheesing(fromPosition, toPosition) then
		player:teleportTo(player:getTown():getTemplePosition())
		return false
	end

	local availableBossEntries = player:getStorageValueByKey(task.bossStorage)
	if availableBossEntries <= MISSION_NOT_STARTED then
		player:sendCancelMessage("You can not enter until you finish the task.")
		player:teleportTo(fromPosition)
		return false
	end

	if roomIsOccupied(task.bossRoomCenter, task.clearRadiusX, task.clearRadiusY, player.uid) then
		player:sendCancelMessage("Someone is already inside.")
		player:teleportTo(fromPosition)
		return false
	end

	return true
end

function RegisterTaskBossTp()
	local bossRoomPortalEntrance = MoveEvent()
	function bossRoomPortalEntrance.onStepIn(creature, item, toPosition, fromPosition)
		local task = GetTaskByPortalKey(item:getKey())

		local player = creature:getPlayer()

		if canEnter(player, task, fromPosition, toPosition) then
			onEnter(player, task, fromPosition)
		end

		return true
	end

	bossRoomPortalEntrance:type("stepin")
	for _, task in pairs(GetAllTasks()) do
		bossRoomPortalEntrance:key(task.bossPortalKey)
	end
	bossRoomPortalEntrance:register()

	local bossRoomPortal = MoveEvent()
	function bossRoomPortal.onStepIn(creature, item, toPosition, fromPosition)
		local player = creature:getPlayer()
		local lastEnterPosition = player:getStorageValueByKey(taskBossRoomLastEnterPos)
		if lastEnterPosition then
			player:teleportTo(lastEnterPosition)
			Position(lastEnterPosition):sendMagicEffect(CONST_ME_TELEPORT)
		end
		return true
	end

	bossRoomPortal:type("stepin")
	bossRoomPortal:key(taskBossRoomExitPortalKey)
	bossRoomPortal:register()
end
