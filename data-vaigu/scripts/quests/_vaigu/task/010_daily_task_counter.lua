local function playerStaredThisTask(player, storage)
	local dailyTaskProgress = player:getStorageValue(storage)
	if dailyTaskProgress ~= DAILY_TASK_NOT_STARTED then
		return true
	end
	return false
end

local function isDailyTaskFinished(player, dailyTask)
	local currentKills = player:getStorageValue(dailyTask.storage)
	local requiredKills = dailyTask.requiredKills
	return currentKills >= requiredKills
end

function Player:CanAddDailyTaskKill(dailyTask)
	local storage = dailyTask.storage
	if not playerStaredThisTask(self, storage) then
		return false
	end
	if isDailyTaskFinished(self, dailyTask) then
		return false
	end
	return true
end

function Player:AddDailyTaskKill(dailyTask)
	self:IncrementStorage(dailyTask.storage, 1)
	local currentKillsString = self:Localizer(Storage.DailyTasks.DailyTaskInfo):Context({ taskConfig = dailyTask }):Get("DAILY_TASK_CURRENT_KILLS")
	self:sendTextMessage(MESSAGE_EXPERIENCE, currentKillsString)

	if isDailyTaskFinished(self, dailyTask) then
		local translatedMessageWhenFinished = self:Localizer(Storage.DailyTasks.DailyTaskInfo):Context({ dailyTask = dailyTask }):Get("DAILY_TASK_READY_TO_TURN_IN")
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
local dailyKill = CreatureEvent("DailyTasksCounter")
function dailyKill.onDeath(killedCreature, corpse, lastHitKiller, mostDamageKiller)
	local targetMonster = killedCreature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	--print("Target: "..targetName.." LastHit: ".._lastHitKiller:getName().." Most Dmg: ".. mostDamageKiller:getName())
	--player:addAchievementProgress(3, 1000) -- action man (zabij 1000 potworow)
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
dailyKill:register()

-- Setup onDeath events
local serverstartup = GlobalEvent("DailyTaskMonsterDeathStartup")
function serverstartup.onStartup()
	local monsters = Set({}, { insensitive = true })
	for _, dailyTask in pairs(GetAllDailyTasks()) do
		monsters = monsters:union(dailyTask.creatures)
	end

	for monster in monsters:iter() do
		local mType = MonsterType(monster)
		if not mType then
			logger.error("[DailyTaskMonsterDeathStartup] monster with name {} is not a valid MonsterType", monster)
		else
			mType:registerEvent("DailyTasksCounter")
		end
	end
end
serverstartup:register()
