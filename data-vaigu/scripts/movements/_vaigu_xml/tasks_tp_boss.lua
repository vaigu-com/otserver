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
	local spectators, spectator = Game.getSpectators(bossRoomCenter, false, false, clearRadiusX, clearRadiusX, clearRadiusY, clearRadiusY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
end

local function playerIsCheesing(player, fromPosition, toPosition)
	if toPosition == fromPosition then
		return true
	end
	return false
end

local movement = MoveEvent()
function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if playerIsCheesing(player, fromPosition, toPosition) then
		player:teleportTo(player:getTown():getTemplePosition())
		return true
	end

	local task = GetTaskByPortalUid(item.uid)

	local playerState = player:getStorageValue(task.bossStorage)
	if playerState == -1 then
		player:sendCancelMessage("You can not enter until you finish the task.")
		player:teleportTo(fromPosition)
		return true
	end

	if roomIsOccupied(task.bossRoomCenter, task.clearRadiusX, task.clearRadiusY, player.uid) then
		player:sendCancelMessage("Someone is already inside.")
		player:teleportTo(fromPosition)
		return true
	end

	player:IncrementStorage(task.bossStorage, -1)

	local spectators, spectator = Game.getSpectators(task.bossRoomCenter, false, false, task.clearRadiusX, task.clearRadiusX, task.clearRadiusY, task.clearRadiusY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end

	if task.bossName == "Pirate Lord" then
		local rand = math.random(1, 4)
		if rand == 1 then
			local monster = Game.createMonster("Brutus Bloodbeard", task.bossPosition, true, true)
		elseif rand == 2 then
			local monster = Game.createMonster("Deadeye Devious", task.bossPosition, true, true)
		elseif rand == 3 then
			local monster = Game.createMonster("Lethal Lissy", task.bossPosition, true, true)
		elseif rand == 4 then
			local monster = Game.createMonster("Ron the Ripper", task.bossPosition, true, true)
		end
		if not monster then
			return true
		end

		addEvent(clearBossRoom, 60 * 5 * 1000, player.uid, monster.uid, task.bossRoomCenter, task.clearRadiusX, task.clearRadiusY, fromPosition) --5 min
		player:say("Masz 5 minut na pokonanie bossa piratow.", TALKTYPE_MONSTER_SAY)
	else
		local monster = Game.createMonster(task.bossName, task.bossPosition, true, true)
		if not monster then
			return true
		end
		addEvent(clearBossRoom, 60 * 5 * 1000, player.uid, monster.uid, task.bossRoomCenter, task.clearRadiusX, task.clearRadiusY, fromPosition) --5 min
		player:say("Masz 5 minut na pokonanie " .. task.bossName .. ".", TALKTYPE_MONSTER_SAY)
	end
	return true
end

movement:type("stepin")

for uniqueRange = 10001, 10090 do
	movement:uid(uniqueRange)
end

movement:register()
