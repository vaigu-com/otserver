local taskScope = Scope("Task")
local taskBossRoomExitPortalKey = taskScope:Get("BossRoomExitPortal")
local taskBossRoomLastEnterPos = taskScope:Get("LastBossRoomEnterPosition")

local function tryTeleportToLastEnterPosition(player)
	local lastEnterPosition = player:getStorageValueByKey(taskBossRoomLastEnterPos)
	if lastEnterPosition.x and lastEnterPosition.y and lastEnterPosition.z then
		player:teleportTo(lastEnterPosition)
		Position(lastEnterPosition):sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end

	return false
end
local function clearBossRoom(task)
	local players = task.bossRoomZone:getPlayers()
	for _, player in pairs(players) do
		if not tryTeleportToLastEnterPosition(player) then
			player:teleportTo(player:getTemplePosition())
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
local function beforeEnter(player, task, fromPosition)
	local remainingMonsters = task.bossRoomZone:getMonsters()
	for _, monster in pairs(remainingMonsters) do
		monster:remove()
	end

	local bossAdmits = player:getStorageValueByKey(task.bossAdmitCounter)
	local nextAdmits = bossAdmits - 1
	if nextAdmits == 0 then
		nextAdmits = MISSION_NOT_STARTED
	end
	player:setStorageValueByKey(task.bossAdmitCounter, nextAdmits)
	player:setStorageValueByKey(taskBossRoomLastEnterPos, fromPosition)

	local timeLimitMinutes = task.bossTimeLimit or defaultTimeLimitMinutes
	stopEvent(task.clearRoomEvent)
	task.clearRoomEvent = addEvent(clearBossRoom, 60 * timeLimitMinutes * 1000, task)
end
local function taskRandomBossName(task)
	local bossName = task.bossName
	if type(task.bossName) == "table" then
		bossName = table.random(task.bossName)
	end
	return bossName
end
local function afterEnter(player, task)
	local bossName = taskRandomBossName(task)
	local boss = Game.createMonster(bossName, task.bossSpawnPosition, true, true)
	if not boss then
		logger.error(T("Could not create boss ':bossName:' creature for the task :name: on position :pos:.", { bossName = task.bossName, name = task.name, pos = task.bossSpawnPosition:ToString() }))
	end

	player:teleportTo(task.playerSpawnPosition)
	task.playerSpawnPosition:sendMagicEffect(CONST_ME_TELEPORT)

	local timeLimitMinutes = task.bossTimeLimit or defaultTimeLimitMinutes
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

	local availableBossEntries = player:getStorageValueByKey(task.bossAdmitCounter)
	if availableBossEntries <= 0 then
		player:sendCancelMessage("You can not enter until you finish the task.")
		return false
	end

	if task.bossRoomZone:countPlayers() > 0 then
		player:sendCancelMessage("Someone is already inside.")
		return false
	end

	return true
end

function RegisterTasksBossTp()
	local bossRoomEntrance = MoveEvent()
	function bossRoomEntrance.onStepIn(creature, item, toPosition, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end

		local task = GetTaskByPortalKey(item:getKey())
		if canEnter(player, task, fromPosition, toPosition) then
			beforeEnter(player, task, fromPosition)
			afterEnter(player, task)
		else
			player:teleportTo(fromPosition)
		end

		return true
	end
	bossRoomEntrance:type("stepin")
	for _, task in pairs(GetAllTasks()) do
		bossRoomEntrance:key(task.bossRoomEnterPortal)
	end
	bossRoomEntrance:register()

	local bossRoomExit = MoveEvent()
	function bossRoomExit.onStepIn(creature, item, toPosition, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return
		end

		tryTeleportToLastEnterPosition(player)
		return true
	end
	bossRoomExit:type("stepin")
	bossRoomExit:key(taskBossRoomExitPortalKey)
	bossRoomExit:register()
end
