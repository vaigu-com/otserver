dofile(DATA_DIRECTORY .. "/lib/core/quests.lua")

if not LastQuestlogUpdate then
	LastQuestlogUpdate = {}
end

if not PlayerTrackedMissionsData then
	PlayerTrackedMissionsData = {}
end

-- Game functions
function Player.isTrackingMission(self, mission)
	local trackedQuests = PlayerTrackedMissionsData[self:getId()]
	if trackedQuests then
		for _, otherMission in pairs(trackedQuests) do
			if otherMission.storage == mission.storage then
				return true
			end
		end
	end
	return false
end

function Game.getQuestByMission(mission)
	if not mission then
		return
	end
	for _, quest in pairs(Quests) do
		for _, otherMission in pairs(quest.missions) do
			if otherMission.storage == mission.storage then
				return quest
			end
		end
	end
end

function Game.getMissionByStorage(storage)
	for _, quest in pairs(Quests) do
		for _, otherMission in pairs(quest.missions) do
			if otherMission.storage == storage then
				return otherMission
			end
		end
	end
end

function Player.resetTrackedMissions(self, missionStorages)
	local maxAllowed = self:getAllowedTrackedQuestCount()
	PlayerTrackedMissionsData[self:getId()] = {}
	for _, storage in pairs(missionStorages) do
		local mission = Game.getMissionByStorage(storage)
		local quest = Game.getQuestByMission(mission)
		if Game.isQuestStorage(storage) and self:isMissionOngoing(mission) then
			local data = {
				storage = storage,
				questName = self:getTranslatedQuestName(quest),
				missionName = self:getTranslatedMissionName(mission),
				missionDesc = self:getTranslatedMissionDescription(mission),
			}
			table.insert(PlayerTrackedMissionsData[self:getId()], data)
			if #PlayerTrackedMissionsData[self:getId()] >= maxAllowed then
				break
			end
		end
	end

	local selfTrackedQuests = PlayerTrackedMissionsData[self:getId()]
	local remainingSlots = maxAllowed - #selfTrackedQuests
	self:sendTrackedQuests(remainingSlots, selfTrackedQuests)
end

function Player.sendTrackedMissions(self)
	for _, quest in pairs(Quests) do
		for _, mission in pairs(quest.missions) do
			if self:isTrackingMission(mission) then
				local translatedMission = {
					storage = mission.storage,
					missionName = self:getTranslatedMissionName(mission),
					missionDesc = self:getTranslatedMissionDescription(mission),
				}
				self:sendTrackedMission(translatedMission)
			end
		end
	end
end

function Player.getAllowedTrackedQuestCount(self)
	if self:isPremium() then
		return 25
	end
	return 10
end

function Game.isQuestStorage(storage)
	for _, quest in pairs(Quests) do
		if not quest.missions then
			goto continue
		end

		if quest.missions[storage] then
			return true
		end
		::continue::
	end
	return false
end

function Game.calculateOngoingQuestsCount(player)
	local count = 0
	for _, quest in pairs(Quests) do
		if player:isQuestOngoing(quest) then
			count = count + 1
		end
	end
	return count
end

function Game.calculateOngoingMissionsByQuest(player, quest)
	if not quest then
		return 0
	end
	if not quest.missions then
		return 0
	end

	local count = 0
	local missions = quest.missions
	for _, mission in pairs(missions) do
		if player:isMissionOngoing(mission) then
			count = count + 1
		end
	end
	return count
end

--#region Player functions
function Player.isQuestOngoing(self, quest)
	if not quest then
		return false
	end
	if not quest.missions then
		return false
	end

	for _, mission in pairs(quest.missions) do
		if self:isMissionOngoing(mission) then
			return true
		end
	end
	return false
end

function Player.isMissionOngoing(self, mission)
	if not mission then
		return false
	end

	local state = self:getStorageValue(mission.storage)
	if state == MISSION_NOT_STARTED and mission.states and mission.states[MISSION_NOT_STARTED] then
		return true
	end
	if state == MISSION_NOT_STARTED then
		return false
	end
	if state < mission.minState then
		return false
	end
	if state > mission.maxState then
		return false
	end

	return true
end

function Player.isQuestCompleted(self, quest)
	if not quest then
		return false
	end

	local missions = quest.missions
	for _, mission in pairs(missions) do
		if not self:isMissionCompleted(mission) then
			return false
		end
	end
	return true
end

function Player.isMissionCompleted(self, mission)
	if not mission then
		return false
	end

	local state = self:getStorageValue(mission.storage)
	if state == mission.finishedState then
		return true
	end
	if state == MISSION_FINISHED then
		return true
	end

	return false
end

function Player.getTranslatedQuestName(self, quest)
	if not quest then
		return "[Player::getTranslatedQuestName] An error has occurred, please contact a gamemaster."
	end
	local result = ""

	local context = { player = self }
	result = result .. self:Localizer(quest.localizer):Context(context):Get(quest.name)
	if self:isQuestCompleted(quest) then
		local completedSuffix = self:Localizer(LOCALIZERS.Universal):Get("QUEST_MISSION_COMPLETE_SUFFIX")
		result = result .. completedSuffix
	end
	return result
end

function Player.getTranslatedMissionName(self, mission)
	if not mission then
		return "[Player::getTranslatedMissionName] An error has occurred, please contact a gamemaster."
	end
	local result = ""

	local context = { player = self, storage = mission.storage, task = mission.task, dailyTask = mission.dailyTask }
	result = result .. self:Localizer(mission.localizer):Context(context):Get(mission.name)
	if self:isMissionCompleted(mission) then
		local completedSuffix = self:Localizer(LOCALIZERS.Universal):Get("QUEST_MISSION_COMPLETE_SUFFIX")
		result = result .. completedSuffix
	end
	return result
end

function Player.getTranslatedMissionDescription(self, mission)
	if not mission then
		return "[Player::getTranslatedMissionDescription] An error has occurred, please contact a gamemaster."
	end

	local context = { player = self, storage = mission.storage, task = mission.task, dailyTask = mission.dailyTask }
	local state = self:getStorageValue(mission.storage)
	local description = mission.description
	if mission.states and mission.states[state] then
		description = mission.states[state]
	end
	local translatedDescription = self:Localizer(mission.localizer):Context(context):Get(description)
	return translatedDescription
end

function Player.sendQuestLogMainPage(self)
	local msg = NetworkMessage()
	msg:addByte(0xF0)
	msg:addU16(Game.calculateOngoingQuestsCount(self))
	for questId, quest in pairs(Quests) do
		if self:isQuestOngoing(quest) then
			msg:addU16(questId)
			local translatedQuestName = self:Localizer(quest.localizer):Get(quest.name)
			if self:isQuestCompleted(quest) then
				translatedQuestName = translatedQuestName .. " (completed)"
			end
			msg:addString(translatedQuestName)
			msg:addByte(self:isQuestCompleted(quest))
		end
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendQuestline(self, questId)
	local quest = Quests[questId]
	if not quest then
		return
	end

	local missions = quest.missions
	local msg = NetworkMessage()
	msg:addByte(0xF1)
	msg:addU16(questId)
	msg:addByte(Game.calculateOngoingMissionsByQuest(self, quest))
	for _, mission in pairs(missions) do
		if self:isMissionOngoing(mission) then
			if self:getClient().version >= 1200 then
				msg:addU16(mission.storage)
			end
			msg:addString(self:getTranslatedMissionName(mission), "Player.sendQuestline - self:getMissionName(questId, missionId)")
			msg:addString(self:getTranslatedMissionDescription(mission), "Player.sendQuestline - self:getMissionDescription(questId, missionId)")
		end
	end

	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendTrackedQuests(self, remainingQuests, missions)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x01)
	msg:addByte(remainingQuests)
	msg:addByte(#missions)
	for _, mission in ipairs(missions) do
		msg:addU16(mission.storage)
		msg:addString(mission.questName, "Player.sendTrackedQuests - mission.questName")
		msg:addString(mission.missionName, "Player.sendTrackedQuests - mission.missionName")
		msg:addString(mission.missionDesc, "Player.sendTrackedQuests - mission.missionDesc")
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendTrackedMission(self, mission)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x00)
	msg:addU16(mission.storage)
	msg:addString(mission.missionName, "Player.sendTrackedMission - mission.missionName")
	msg:addString(mission.missionDesc, "Player.sendTrackedMission - mission.missionDesc")
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

function Player.updateStorage(self, storage, value, oldValue, currentFrameTime)
	local playerId = self:getId()
	if LastQuestlogUpdate[playerId] ~= currentFrameTime and Game.isQuestStorage(storage) then
		LastQuestlogUpdate[playerId] = currentFrameTime
		if questUpdateIsAnnouncable(storage, value, oldValue) then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end

	self:sendTrackedMissions()
end
