function ParseCurrentKills(currentKills, requiredKills)
	if currentKills == MISSION_FINISHED then
		return requiredKills
	end
	return currentKills
end

local function isTaskFinished(player, task)
	local currentKills = player:getStorageValueByKey(task.storage)
	return currentKills == MISSION_FINISHED
end

function Player:AddTaskKill(task)
	local currentKills = self:getStorageValueByKey(task.storage)
	if currentKills >= MISSION_FINISHED then
		return true
	end

	local nextKills = currentKills + 1
	self:setStorageValueByKey(task.storage, nextKills)

	local currentKillsString = self:Localizer(Storage.Tasks.TaskInfo):Context({ task = task }):Get("TASK_CURRENT_KILLS")
	self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

	if nextKills >= task.requiredKills then
		self:setStorageValueByKey(task.storage, MISSION_FINISHED)
		local translatedMessageWhenFinished = self:Localizer(Storage.Tasks.TaskInfo):Context({ task = task }):Get("TASK_READY_TO_TURN_IN")
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)
		self:IncrementStorage(task.bossStorage, 1)
	end
end

function Player:CanAddTaskKill(task)
	if not task then
		return false
	end
	local state = self:getStorageValueByKey(task.storage)
	if state == TASK_CAN_START_DESPITE_HIGHER_LEVEL then
		return false
	end
	if state == TASK_FINISHED then
		return false
	end
	if isTaskFinished(self, task) then
		return false
	end
	return true
end

function Player:TryAddTaskKill(task)
	if self:CanAddTaskKill(task) then
		self:AddTaskKill(task)
		return true
	end
	return false
end

function GetTopKillers(damageMap, lastHitKiller)
	if not lastHitKiller:getPlayer() then
		lastHitKiller = nil
	end

	local damageMapSorted = {}
	for playerId, damage in pairs(damageMap) do
		local player = Player(playerId)
		if not player then
			goto continue
		end
		if player == lastHitKiller then
			goto continue
		end
		if not player then
			goto continue
		end
		table.insert(damageMapSorted, { player = player, damage = damage.total })
		::continue::
	end

	table.sort(damageMapSorted, function(a, b)
		return a.damage > b.damage
	end)

	local topKillers = { lastHitKiller }
	for _, playerDamage in pairs(damageMapSorted) do
		table.insert(topKillers, playerDamage.player)
	end
	return topKillers
end

local grantCreditForUpto = 2
local creatureEvent = CreatureEvent("TaskMonsterDeath")
function creatureEvent.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
	local targetMonster = killedCreature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local task = GetTaskByCreatureName(killedCreature:getName():lower())
	if not task then
		return
	end

	local damageMap = killedCreature:getDamageMap()
	local topKillers = GetTopKillers(damageMap, lastHitKiller)
	local playersGranted = 0
	for _, player in pairs(topKillers) do
		if playersGranted >= grantCreditForUpto then
			return
		end
		if player:TryAddTaskKill(task) then
			playersGranted = playersGranted + 1
		end
	end
	return true
end
creatureEvent:register()

-- Setup onDeath events
local serverstartup = GlobalEvent("TaskMonsterDeathStartup")
function serverstartup.onStartup()
	local monsters = Set({}, { insensitive = true })
	for _, task in pairs(GetAllTasks()) do
		monsters = monsters:union(task.creatures)
	end

	for monster in monsters:iter() do
		local mType = MonsterType(monster)
		if not mType then
			logger.error("[TaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monster)
		else
			mType:registerEvent("TaskMonsterDeath")
		end
	end
end
serverstartup:register()
