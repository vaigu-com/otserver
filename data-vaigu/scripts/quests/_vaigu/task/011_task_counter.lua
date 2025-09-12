local function taskRewardCanBeClaimed(player, task)
	local state = player:getStorageValueByKey(task.storage)
	return state == REPORT_TASK_TO_NPC
end

---@param task table
---@return boolean
function Player:AddTaskKill(task)
	self:IncrementStorage(task.currentKills)
	self:RefreshStorage(task.storage)

	local currentKillsString = self:Localizer(LOCALIZERS.Tasks):Context({ task = task }):Get("TASK_CURRENT_KILLS")
	self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

	if self:getStorageValueByKey(task.currentKills) >= task.requiredKills then
		self:setStorageValueByKey(task.storage, REPORT_TASK_TO_NPC)
		self:setStorageValueByKey(task.currentKills, task.requiredKills)

		local translatedMessageWhenFinished = self:Localizer(LOCALIZERS.Tasks):Context({ task = task }):Get("TASK_READY_TO_TURN_IN")
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)

		local bossAdmits = math.max(self:getStorageValueByKey(task.bossAdmitCounter), 0)
		local nextBossAdmits = bossAdmits + 1
		self:setStorageValueByKey(task.bossAdmitCounter, nextBossAdmits)
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
	if state == TASK_CANT_START_BECAUSE_HIGHER_LEVEL then
		return false
	end
	if taskRewardCanBeClaimed(self, task) then
		return false
	end
	if state >= REPORT_TASK_TO_NPC then
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

---@param damageMap table
---@param lastHitKiller nil|Creature
---@return table topKillers
function GetTopKillers(damageMap, lastHitKiller)
	if not (lastHitKiller and lastHitKiller:getPlayer()) then
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
local taskMonsterDeath = CreatureEvent("TaskMonsterDeath")
function taskMonsterDeath.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
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
taskMonsterDeath:register()

local taskMonsterDeathStartup = GlobalEvent("TaskMonsterDeathStartup")
function taskMonsterDeathStartup.onStartup()
	local monsterNames = {}
	for _, task in pairs(GetAllTasks()) do
		for _, monsterName in pairs(task.creatures) do
			monsterNames[monsterName:lower()] = true
		end
	end

	for monsterName in pairs(monsterNames) do
		local mType = MonsterType(monsterName)
		if not mType then
			logger.error("[TaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monsterName)
		else
			mType:registerEvent("TaskMonsterDeath")
		end
	end
end
taskMonsterDeathStartup:register()
