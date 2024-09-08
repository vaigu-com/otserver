dofile(DATA_DIRECTORY .. "/lib/core/quests.lua")

-- Vaigu custom
RegisterTasksInQuestsList()
RegisterDailyTasksInQuestsList()
if not LastQuestlogUpdate then
	LastQuestlogUpdate = {}
end

if not PlayerTrackedMissionsData then
	PlayerTrackedMissionsData = {}
end

-- Game functions

function Player.hasTrackingQuest(self, missionId)
	local trackedQuests = PlayerTrackedMissionsData[self:getId()]
	if trackedQuests then
		for _, mission in pairs(trackedQuests) do
			if mission and mission.missionId == missionId then
				return true
			end
		end
	end
	return false
end

function Player.getQuestDataByMissionId(self, missionId)
	for questId in pairs(Quests) do
		local quest = Game.getQuest(questId)
		if not quest then
			goto continue
		end
		if not quest.missions then
			goto continue
		end
		for i = 1, #quest.missions do
			local mission = quest.missions[i]
			if mission and mission.missionId == missionId then
				return self:Localizer(LOCALIZER_QUESTLOG):Context({ storageId = mission.storageId }):Get(quest.name), questId, i
			end
		end
		::continue::
	end
	return false
end

function Player.resetTrackedMissions(self, missionsIds)
	local maxAllowed = self:getAllowedTrackedQuestCount()
	PlayerTrackedMissionsData[self:getId()] = {}
	for _, missionId in pairs(missionsIds) do
		local questName, questId, missionIndex = self:getQuestDataByMissionId(missionId)
		if questName and questId and missionIndex then
			if self:missionIsStarted(questId, missionIndex) then
				local data = {
					missionId = missionId,
					questName = questName,
					missionName = self:getMissionName(questId, missionIndex),
					missionDesc = self:getMissionDescription(questId, missionIndex),
				}
				table.insert(PlayerTrackedMissionsData[self:getId()], data)
				if #PlayerTrackedMissionsData[self:getId()] >= maxAllowed then
					break
				end
			end
		end
	end

	self:sendTrackedQuests(maxAllowed - #PlayerTrackedMissionsData[self:getId()], PlayerTrackedMissionsData[self:getId()])
end

function Player.sendTrackedMissions(self)
	for questIndex, quest in pairs(Quests) do
		for missionIndex, mission in pairs(quest.missions) do
			if self:hasTrackingQuest(mission.missionId) then
				local data = {
					missionId = mission.missionId,
					missionName = self:getMissionName(questIndex, missionIndex),
					missionDesc = self:getMissionDescription(questIndex, missionIndex),
				}
				self:sendUpdateTrackedQuest(data)
			end
		end
	end
end

function Player.getAllowedTrackedQuestCount(self)
	return self:isPremium() and 25 or 10
end

function Game.isValidQuest(questId)
	return (Quests and Quests[questId])
end

function Game.isValidMission(questId, missionId)
	return (Game.isValidQuest(questId) and Quests[questId].missions and Quests[questId].missions[missionId])
end

function Game.getQuest(questId)
	if Game.isValidQuest(questId) then
		return Quests[questId]
	end
	return false
end

function Game.getQuestIdByName(name)
	for questId in pairs(Quests) do
		local quest = Game.getQuest(questId)
		if quest and quest.name:lower() == name:lower() then
			return questId
		end
	end
	return false
end

function Game.getMission(questId, missionId)
	if Game.isValidMission(questId, missionId) then
		return Quests[questId].missions[missionId]
	end
	return false
end

function Player.getMissionsData(self, storage)
	local missions = {}
	for questId in pairs(Quests) do
		local quest = Game.getQuest(questId)
		if quest and quest.missions then
			for missionId in pairs(quest.missions) do
				local started = self:missionIsStarted(questId, missionId)
				if started then
					local mission = quest.missions[missionId]
					if mission.storageId == storage then
						local data = {
							missionId = mission.missionId,
							missionName = self:getMissionName(questId, missionId),
							missionDesc = self:getMissionDescription(questId, missionId),
						}
						missions[#missions + 1] = data
					end
				end
			end
		end
	end
	return missions
end

function Game.isQuestStorage(key, value, oldValue)
	for questId in pairs(Quests) do
		local quest = Game.getQuest(questId)
		if not quest then
			return false
		end
		if quest.startStorageId == key and quest.startStorageValue == value then
			return true
		end

		if not quest.missions then
			return false
		end

		for missionId in pairs(quest.missions) do
			local mission = Game.getMission(questId, missionId)
			if mission then
				if mission.storageId == key and value >= mission.startValue and value <= mission.endValue then
					return mission.description or oldValue < mission.storageId or oldValue > mission.endValue
				end
			end
		end
	end
	return false
end

function Game.getQuestsCount(player)
	local count = 0
	if Quests then
		for id in pairs(Quests) do
			if player:questIsStarted(id) then
				count = count + 1
			end
		end
	end
	return count
end

function Game.getMissionsCount(player, questId)
	local quest = Game.getQuest(questId)
	local count = 0
	if quest then
		local missions = quest.missions
		if missions then
			for missionId in pairs(missions) do
				if player:missionIsStarted(questId, missionId) then
					count = count + 1
				end
			end
		end
	end
	return count
end

function Game.addQuest(quest)
	local findQuest = Game.getQuestIdByName(quest.name)
	if findQuest then
		Quests[findQuest] = quest
		return findQuest
	end

	local questId = #Quests + 1
	Quests[questId] = quest
	return questId
end

-- Player functions

function Player.questIsStarted(self, questId)
	local quest = Game.getQuest(questId)
	if quest and self:getStorageValue(quest.startStorageId) ~= -1 or self:getStorageValue(quest.startStorageId) >= quest.startStorageValue then
		return true
	end
	return false
end

function Player.missionIsStarted(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		local value = self:getStorageValue(mission.storageId)
		if value == -1 or value < mission.startValue or (not mission.ignoreendvalue and value > mission.endValue) then
			return false
		end

		return true
	end
	return false
end

function Player.questIsCompleted(self, questId)
	local quest = Game.getQuest(questId)
	if quest then
		local missions = quest.missions
		if missions then
			for missionId in pairs(missions) do
				if not self:missionIsCompleted(questId, missionId) then
					return false
				end
			end
		end
		return true
	end
	return false
end

function Player.missionIsCompleted(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		local value = self:getStorageValue(mission.storageId)
		if value == -1 then
			return false
		end

		if mission.ignoreendvalue then
			return value >= mission.endValue
		end

		return value == mission.endValue
	end
	return false
end

function Player.getMissionName(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	local result = ""
	if not mission then
		return result
	end

	local context = { player = self, questId = questId, missionId = missionId, storageId = mission.storageId, task = mission.task, dailyTask = mission.dailyTask }
	result = result .. self:Localizer(LOCALIZER_QUESTLOG):Context(context):Get(mission.name)
	if self:missionIsCompleted(questId, missionId) then
		local completedSuffix = self:Localizer(LOCALIZER_QUESTLOG):Get("QUEST_MISION_COMPLETE_SUFFIX")
		result = result .. completedSuffix
	end
	return result
end

function Player.getMissionId(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if mission then
		return mission.missionId
	end
	return 0
end

function Player.getMissionDescription(self, questId, missionId)
	local mission = Game.getMission(questId, missionId)
	if not mission then
		return "An error has occurred, please contact a gamemaster."
	end
	local context = { player = self, questId = questId, missionId = missionId, storageId = mission.storageId, task = mission.task, dailyTask = mission.dailyTask }
	local description = self:Localizer(LOCALIZER_QUESTLOG):Context(context):Get(mission.description)
	if description then
		return description
	end

	local value = self:getStorageValue(mission.storageId)
	local state = value

	if mission.ignoreendvalue and value > table.maxn(mission.states) then
		state = table.maxn(mission.states)
	end
	description = self:Localizer(LOCALIZER_QUESTLOG):Get(mission.states[state])
	return description
end

function Player.sendQuestLog(self)
	local msg = NetworkMessage()
	msg:addByte(0xF0)
	msg:addU16(Game.getQuestsCount(self))
	for questId in pairs(Quests) do
		if self:questIsStarted(questId) then
			msg:addU16(questId)
			local translatedQuestName = self:Localizer(LOCALIZER_QUESTLOG):Get(Quests[questId].name)
			if self:questIsCompleted(questId) then
				translatedQuestName = translatedQuestName .. " (completed)"
			end
			msg:addString(translatedQuestName)
			msg:addByte(self:questIsCompleted(questId))
		end
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendQuestLine(self, questId)
	local quest = Game.getQuest(questId)
	if quest then
		local missions = quest.missions
		local msg = NetworkMessage()
		msg:addByte(0xF1)
		msg:addU16(questId)
		msg:addByte(Game.getMissionsCount(self, questId))
		if missions then
			for missionId in pairs(missions) do
				if self:missionIsStarted(questId, missionId) then
					if self:getClient().version >= 1200 then
						msg:addU16(self:getMissionId(questId, missionId))
					end
					msg:addString(self:getMissionName(questId, missionId), "Player.sendQuestLine - self:getMissionName(questId, missionId)")
					msg:addString(self:getMissionDescription(questId, missionId), "Player.sendQuestLine - self:getMissionDescription(questId, missionId)")
				end
			end
		end

		msg:sendToPlayer(self)
		msg:delete()
	end
end

function Player.sendTrackedQuests(self, remainingQuests, missions)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x01)
	msg:addByte(remainingQuests)
	msg:addByte(#missions)
	for _, mission in ipairs(missions) do
		msg:addU16(mission.missionId)
		msg:addString(mission.questName, "Player.sendTrackedQuests - mission.questName")
		msg:addString(mission.missionName, "Player.sendTrackedQuests - mission.missionName")
		msg:addString(mission.missionDesc, "Player.sendTrackedQuests - mission.missionDesc")
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendUpdateTrackedQuest(self, mission)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x00)
	msg:addU16(mission.missionId)
	msg:addString(mission.missionName, "Player.sendUpdateTrackedQuest - mission.missionName")
	msg:addString(mission.missionDesc, "Player.sendUpdateTrackedQuest - mission.missionDesc")
	msg:sendToPlayer(self)
	msg:delete()
end

local function questUpdateIsAnnouncable(key, value, oldValue)
	if value == oldValue then
		return false
	end
	if GetTaskByStorage(key) and oldValue ~= TASK_FINISHED and oldValue ~= TASK_CAN_START_DESPITE_HIGHER_LEVEL then
		return false
	end
	if GetDailyTaskByStorage(key) and oldValue ~= DAILY_TASK_NOT_STARTED then
		return false
	end
	return true
end

function Player.updateStorage(self, key, value, oldValue, currentFrameTime)
	local playerId = self:getId()
	if LastQuestlogUpdate[playerId] ~= currentFrameTime and Game.isQuestStorage(key, value, oldValue) then
		LastQuestlogUpdate[playerId] = currentFrameTime
		if questUpdateIsAnnouncable(key, value, oldValue) then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end

	local missions = self:getMissionsData(key)
	for _, mission in pairs(missions) do
		if self:hasTrackingQuest(mission.missionId) then
			self:sendUpdateTrackedQuest(mission)
		end
	end
end

local function sendPrint(questId, index)
	logger.warn("[sendPrint] - Quest id:[{}]] mission:[{}]", questId, index)
end

for questId in pairs(Quests) do
	local quest = Game.getQuest(questId)
	if quest then
		for index, value in pairs(quest.missions) do
			if index then
				if not value.name then
					logger.error("Quest.load: Wrong mission name found")
					sendPrint(questId, index)
				end
				if not value.storageId then
					logger.error("Quest.load: Wrong mission storage found")
					sendPrint(questId, index)
				end
				if not value.missionId then
					logger.error("Quest.load: Wrong mission id found")
					sendPrint(questId, index)
				end
				if not value.startValue then
					logger.error("Quest.load: Wrong mission start value found")
					sendPrint(questId, index)
				end
				if not value.endValue then
					logger.error("Quest.load: Wrong mission end value found")
					sendPrint(questId, index)
				end
			end
		end
	end
end
