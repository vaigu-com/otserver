local function playerStaredThisTask(player, dailyTask)
	local dailyTaskProgress = player:getStorageValueByKey(dailyTask.storage)
	if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then
		return true
	end
	return false
end

local function isDailytaskReadyToTurnIn(player, dailyTask)
	local state = player:getStorageValueByKey(dailyTask.storage)
	return state == REPORT_TASK_TO_NPC
end

function Player:CanAddDailyTaskKill(dailyTask)
	if not playerStaredThisTask(self, dailyTask) then
		return false
	end
	if isDailytaskReadyToTurnIn(self, dailyTask) then
		return false
	end
	return true
end

---@param dailyTask table
---@return boolean
function Player:AddDailyTaskKill(dailyTask)
	self:IncrementStorage(dailyTask.currentKills)
	self:RefreshStorage(dailyTask.storage)

	local currentKillsString = self:Localizer(LOCALIZERS.DailyTasks):Context({ dailyTask = dailyTask }):Get("DAILY_TASK_CURRENT_KILLS")
	self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

	if self:getStorageValueByKey(dailyTask.currentKills) >= dailyTask.requiredKills then
		self:setStorageValueByKey(dailyTask.storage, REPORT_TASK_TO_NPC)
		self:setStorageValueByKey(dailyTask.currentKills, dailyTask.requiredKills)

		local translatedMessageWhenFinished = self:Localizer(LOCALIZERS.DailyTasks):Context({ dailyTask = dailyTask }):Get("DAILY_TASK_READY_TO_TURN_IN")
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessageWhenFinished)
	end
	return true
end

function Player:AddKillToAnyDailyTask(dailyTask)
	if self:CanAddDailyTaskKill(dailyTask) then
		self:AddDailyTaskKill(dailyTask)
		return true
	end
	return false
end

local grantCreditToKillers = 2
local dailyTaskMonsterDeath = CreatureEvent("DailyTaskMonsterDeath")
function dailyTaskMonsterDeath.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
	local targetMonster = killedCreature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local dailyTask = GetDailyTaskByCreatureName(killedCreature:getName():lower())
	if not dailyTask then
		return
	end

	local damageMap = killedCreature:getDamageMap()
	local topKillers = GetTopKillers(damageMap, lastHitKiller)
	local playersGranted = 0
	for _, player in pairs(topKillers) do
		if playersGranted >= grantCreditToKillers then
			return
		end
		if player:AddKillToAnyDailyTask(dailyTask) then
			playersGranted = playersGranted + 1
		end
	end
	return true
end
dailyTaskMonsterDeath:register()

local dailyTaskMonsterDeathStartup = GlobalEvent("DailyTaskMonsterDeathStartup")
function dailyTaskMonsterDeathStartup.onStartup()
	local monsterNames = {}
	for _, task in pairs(GetAllDailyTasks()) do
		for _, monsterName in pairs(task.creatures) do
			monsterNames[monsterName:lower()] = true
		end
	end

	for monsterName in pairs(monsterNames) do
		local mType = MonsterType(monsterName)
		if not mType then
			logger.error("[TaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monsterName)
		else
			mType:registerEvent("DailyTaskMonsterDeath")
		end
	end
end
dailyTaskMonsterDeathStartup:register()
