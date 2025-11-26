SECONDS_PER_MINUTE = 60
SECONDS_PER_HOUR = 3600
SECONDS_PER_DAY = 86400
MAX_OFFLINE_TRAINING_DAYS = 21
MIN_REQUIRED_OFFLINE_MINUTES = 10
MAX_TRAINING_SECONDS = SECONDS_PER_DAY * 7

local function getOfflineTimeSeconds(player)
	local lastLogout = player:getLastLogout()
	if lastLogout == 0 then
		return 0
	end
	local elapsed = os.time() - lastLogout
	local maxSeconds = SECONDS_PER_DAY * MAX_OFFLINE_TRAINING_DAYS
	return math.min(elapsed, maxSeconds)
end

local function selectedAnySkill(player, offlineTimeSeconds)
	if player:getOfflineTrainingSkill() == SKILL_NONE then
		return false
	end

	player:addOfflineTrainingTime(offlineTimeSeconds * 1000)
	return true
end

local function trainedForMinimumTime(offlineTimeSeconds)
	if offlineTimeSeconds >= MIN_REQUIRED_OFFLINE_MINUTES * SECONDS_PER_MINUTE then
		return true
	end

	return false
end

local function getTrainingTimeSeconds(player, offlineTimeSeconds)
	local storedSeconds = player:getOfflineTrainingTime() / 1000
	local cappedSeconds = math.min(MAX_TRAINING_SECONDS, storedSeconds)
	return math.max(0, math.min(offlineTimeSeconds, cappedSeconds))
end

local function hasRemainingTrainingTime(trainingTimeSeconds)
	return trainingTimeSeconds >= SECONDS_PER_MINUTE
end

local function buildDurationText(trainingTimeSeconds)
	local hours = math.floor(trainingTimeSeconds / SECONDS_PER_HOUR)
	local minutes = math.floor((trainingTimeSeconds % SECONDS_PER_HOUR) / SECONDS_PER_MINUTE)
	local parts = {}

	if hours > 0 then
		if hours == 1 then
			table.insert(parts, T(":hours: hour", { hours = hours }))
		else
			table.insert(parts, T(":hours: hours", { hours = hours }))
		end
	end
	if minutes > 0 then
		if minutes == 1 then
			table.insert(parts, T(":minutes: minute", { minutes = minutes }))
		else
			table.insert(parts, T(":minutes: minutes", { minutes = minutes }))
		end
	end

	return T("During your absence you trained for :duration:.", {
		duration = table.concat(parts, " "),
	})
end

local function computeTrainingTries(player, trainingTimeSeconds, offlineTrainingSkill)
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	local topVocation = promotion or vocation

	if table.contains({ SKILL_CLUB, SKILL_SWORD, SKILL_AXE, SKILL_DISTANCE }, offlineTrainingSkill) then
		local attackSeconds = topVocation:getBaseAttackSpeed() / 1000
		local divisor = (offlineTrainingSkill == SKILL_DISTANCE) and 4 or 2
		return (trainingTimeSeconds / attackSeconds) / divisor
	end

	if offlineTrainingSkill == SKILL_MAGLEVEL then
		local ticks = topVocation:getManaGainTicks() / 1000
		if ticks == 0 then
			ticks = 1
		end
		return trainingTimeSeconds * (vocation:getManaGainAmount() / ticks)
	end

	return nil
end

local function applySkillTries(player, offlineTrainingSkill, trainingTimeSeconds)
	local tries = computeTrainingTries(player, trainingTimeSeconds, offlineTrainingSkill)
	if not tries then
		return
	end

	local rate = configManager.getFloat(configKeys.RATE_OFFLINE_TRAINING_SPEED)
	local updated = player:addOfflineTrainingTries(offlineTrainingSkill, tries * rate)

	if updated then
		player:addOfflineTrainingTries(SKILL_SHIELD, trainingTimeSeconds / 4)
	end
end

local offlineTraining = CreatureEvent("OfflineTraining")
function offlineTraining.onLogin(player)
	local offlineTimeSeconds = getOfflineTimeSeconds(player)
	if not selectedAnySkill(player, offlineTimeSeconds) then
		return true
	end
	if trainedForMinimumTime(offlineTimeSeconds) then
		player:sendTextMessage(MESSAGE_OFFLINE_TRAINING, T("You must be logged out for more than 10 minutes to start offline training."))
		return true
	end

	local trainingTimeSeconds = getTrainingTimeSeconds(player, offlineTimeSeconds)
	player:setOfflineTrainingSkill(SKILL_NONE)
	player:removeOfflineTrainingTime(trainingTimeSeconds * 1000)

	local remainderSeconds = offlineTimeSeconds - trainingTimeSeconds
	if remainderSeconds > 0 then
		player:addOfflineTrainingTime(remainderSeconds * 1000)
	end

	if not hasRemainingTrainingTime(trainingTimeSeconds) then
		return true
	end

	player:sendTextMessage(MESSAGE_OFFLINE_TRAINING, buildDurationText(trainingTimeSeconds))
	applySkillTries(player, player:getOfflineTrainingSkill(), trainingTimeSeconds)

	return true
end

offlineTraining:register()
