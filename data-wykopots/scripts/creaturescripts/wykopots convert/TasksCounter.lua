local function isTaskFinished(player, task)
	local currentKills = player:getStorageValue(task.storage)
	local requiredKills = task.requiredKills
	return currentKills >= requiredKills
end

function Player:AddTaskKill(task)
	self:IncrementStorage(task.storage, 1)
	local currentKillsString = self:Localizer(Storage.Tasks.TaskInfo):Context({ task = task }):Get("TASK_CURRENT_KILLS")
	self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

	if isTaskFinished(self, task) then
		local translatedMessageWhenFinished = self:Localizer(Storage.Tasks.TaskInfo):Context({ task = task }):Get("TASK_READY_TO_TURN_IN")
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)
		self:IncrementStorage(task.bossStorage, 1)
	end

	return true
end

function Player:CanAddTaskKill(task)
	if not task then
		return false
	end
	local state = self:getStorageValue(task.storage)
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

local grantCreditToKillers = 2
local creatureEvent = CreatureEvent("TaskMonsterDeath")
function creatureEvent.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
	local targetMonster = killedCreature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	--print("Target: "..targetName.." LastHit: ".._lastHitKiller:getName().." Most Dmg: ".. mostDamageKiller:getName())
	--player:addAchievementProgress(3, 1000) -- action man (zabij 1000 potworow)

	local task = GetTaskByCreatureName(killedCreature:getName():lower())
	if not task then
		return
	end

	local damageMap = killedCreature:getDamageMap()
	local topKillers = GetTopKillers(damageMap, lastHitKiller)
	local playersGranted = 0
	for _, player in pairs(topKillers) do
		if playersGranted >= grantCreditToKillers then
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
