if not LastQuestlogUpdate then
	LastQuestlogUpdate = {}
end

PlayerTrackedMissionsData = {}

DONT_AUTOTRACK = false

-- Game functions
function Player.isTrackingMissionState(self, mission)
	local trackedQuests = PlayerTrackedMissionsData[self:getId()]
	if trackedQuests then
		for _, otherMission in pairs(trackedQuests) do
			if otherMission.missionId == mission.missionId then
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
	for _, quest in pairs(Questlog) do
		for _, otherMission in pairs(quest.missions) do
			if otherMission.missionId == mission.missionId then
				return quest
			end
		end
	end
end

NameToQuest = {}
function Game.getQuestByName(name)
	return NameToQuest[name]
end
IdToQuest = {}
function Game.getQuestById(id)
	return IdToQuest[id]
end
IdToMission = {}
function Game.getMissionById(id)
	return IdToMission[id]
end
StorageToMission = {}
function Game.getMissionByStorage(storage)
	return StorageToMission[storage]
end
local storageToLinkedMission = {}
function Game.getLinkedMissions(storage)
	return storageToLinkedMission[storage] or {}
end

--This allows to update mission (identified by missionStorage) text (in questlog and tracked quests) when updating another storage
-- Alternatively, you can do this when updating another storage
-- player:RefreshStorage(missionStorage)
-- player:IncrementStorage(anotherStorage, 1)
function Game.linkMissionToStorages(missionStorage, storages)
	local mission = Game.getMissionByStorage(missionStorage)
	if not mission then
		logger.error(T("[Game::linkMissionToStorages] storage :missionStorage: is not a mission!", { missionStorage = missionStorage }))
		return
	end

	for _, storage in pairs(storages) do
		storageToLinkedMission[storage] = storageToLinkedMission[storage] or {}
		table.insert(storageToLinkedMission[storage], mission)
	end
end

function Player:receivedCachedTrackedMissions()
	return true
end

function Player:getTrackedMissionIds()
	local trackedMissionStorages = self:getStorageValueByKey(Storage.TrackedMissionsStorages)
	local trackedMissionIds = {}
	if type(trackedMissionStorages) ~= "table" then
		return trackedMissionIds
	end
	for _, storage in pairs(trackedMissionStorages) do
		local mission = Game.getMissionByStorage(storage)
		if mission then
			table.insert(trackedMissionIds, mission.missionId)
		else
			logger.warn(T("[Player::getTrackedMissionIds] Trying to get nonexistant mission by storage :storage:", { storage = storage }))
		end
	end
	return trackedMissionIds
end

function Player.setMissionAsNotTracked(self, mission)
	local trackedMissionStorages = self:getStorageValueByKey(Storage.TrackedMissionsStorages)
	if type(trackedMissionStorages) ~= "table" then
		trackedMissionStorages = {}
	end

	trackedMissionStorages[mission.storage] = nil
	self:setStorageValueByKey(Storage.TrackedMissionsStorages, trackedMissionStorages)

	local playerId = self:getId()
	PlayerTrackedMissionsData[playerId] = PlayerTrackedMissionsData[playerId] or {}
	PlayerTrackedMissionsData[playerId][mission.missionId] = nil
end

function Player.setMissionAsTracked(self, mission)
	local trackedMissionStorages = self:getStorageValueByKey(Storage.TrackedMissionsStorages)
	if type(trackedMissionStorages) ~= "table" then
		trackedMissionStorages = {}
	end
	local currentlyTrackedCount = TableSize(trackedMissionStorages)
	if currentlyTrackedCount >= self:getAllowedTrackedQuestCount() then
		return
	end

	trackedMissionStorages[mission.storage] = mission.storage
	self:setStorageValueByKey(Storage.TrackedMissionsStorages, trackedMissionStorages)

	local missionData = {
		questId = mission.questId,
		missionId = mission.missionId,
		questName = self:getTranslatedQuestName(mission.questName, mission.localizer),
		missionName = self:getTranslatedMissionName(mission),
		missionDesc = self:getTranslatedMissionDescription(mission),
	}
	local playerId = self:getId()
	PlayerTrackedMissionsData[playerId] = PlayerTrackedMissionsData[playerId] or {}
	PlayerTrackedMissionsData[playerId][mission.missionId] = missionData
end

Storage.TrackedMissionsStorages = {}
function Player.onRequestedMissions(self, missionIds)
	local trackedMissions = {}
	local trackedMissionStorages = {}
	local maxAllowedTrackedCount = self:getAllowedTrackedQuestCount()

	for _, missionId in pairs(missionIds) do
		local mission = Game.getMissionById(missionId)
		if not mission then
			logger.warn(T("[Player::onRequestedMissions] Player :name: is sending missionId of non-existant missionId: :missionId:,", { name = self:getName(), missionId = missionId }))
			break
		end
		if Game.isQuestStorage(mission.storage) and self:isMissionOngoing(mission) then
			table.insert(trackedMissionStorages, mission.storage)
			local data = {
				questId = mission.questId,
				missionId = mission.missionId,
				questName = self:getTranslatedQuestName(mission.questName, mission.localizer),
				missionName = self:getTranslatedMissionName(mission),
				missionDesc = self:getTranslatedMissionDescription(mission),
			}
			table.insert(trackedMissions, data)
			if #trackedMissions >= maxAllowedTrackedCount then
				break
			end
		end
	end

	PlayerTrackedMissionsData[self:getId()] = trackedMissions
	local playersTrackedCount = #trackedMissions
	local remainingSlots = maxAllowedTrackedCount - playersTrackedCount
	if remainingSlots < 0 then
		logger.warn(T("[Player.send] Player :name: is tracking more quests that maximum allowed amount!", { name = self:getName() }))
	end

	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x01)
	msg:addByte(remainingSlots)
	msg:addByte(#trackedMissions)
	for _, trackedMission in ipairs(trackedMissions) do
		msg:addU16(trackedMission.missionId)
		msg:addU16(0x01)
		msg:addString(trackedMission.questName, "Player.sendTrackedQuests - mission.questName")
		msg:addString(trackedMission.missionName, "Player.sendTrackedQuests - mission.missionName")
		msg:addString(trackedMission.missionDesc, "Player.sendTrackedQuests - mission.missionDesc")
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.getAllowedTrackedQuestCount(self)
	if self:isPremium() then
		return 25
	end
	return 10
end

function Game.isQuestStorage(storage)
	return Game.getMissionByStorage(storage)
end

function Game.calculateOngoingQuestsCount(player)
	local count = 0
	for _, quest in pairs(Questlog) do
		if player:isQuestOngoing(quest) then
			count = count + 1
		end
	end
	return count
end

function Game.countOngoingMissionsByQuest(player, quest)
	local count = 0
	if not quest then
		return count
	end
	if not quest.missions then
		return count
	end

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

	local state = self:getStorageValueByKey(mission.storage)
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

	local state = self:getStorageValueByKey(mission.storage)
	if state == mission.finishedState then
		return true
	end
	if state == MISSION_FINISHED then
		return true
	end

	return false
end

function Player.getTranslatedQuestName(self, questName, localizer)
	if not questName then
		return "[Player::getTranslatedQuestName] An error has occurred, please contact a gamemaster."
	end

	local result = ""
	local context = { player = self }
	result = result .. self:Localizer(localizer):Context(context):Get(questName)
	return result
end

completedSuffix = " (completed)"

function Player.getTranslatedMissionName(self, mission)
	if not mission then
		return "[Player::getTranslatedMissionName] An error has occurred, please contact a gamemaster."
	end
	local result = ""

	local context = { player = self, storage = mission.storage, task = mission.task, dailyTask = mission.dailyTask }
	result = result .. self:Localizer(mission.localizer):Context(context):Get(mission.name)
	if self:isMissionCompleted(mission) then
		result = result .. completedSuffix
	end
	return result
end

function Player.getTranslatedMissionDescription(self, mission)
	if not mission then
		return "[Player::getTranslatedMissionDescription] An error has occurred, please contact a gamemaster."
	end

	local context = { player = self, storage = mission.storage, task = mission.task, dailyTask = mission.dailyTask }
	local state = self:getStorageValueByKey(mission.storage)
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
	for _, quest in pairs(Questlog) do
		if self:isQuestOngoing(quest) then
			local translatedQuestName = self:Localizer(quest.localizer):Get(quest.name)
			local completedByte = 0x00
			if self:isQuestCompleted(quest) then
				completedByte = 0x01
			end

			msg:addU16(quest.questId)
			msg:addString(translatedQuestName)
			msg:addByte(completedByte)
		end
	end
	msg:sendToPlayer(self)
	msg:delete()
end

function Player.sendQuestline(self, questId)
	local quest = Game.getQuestById(questId)
	if not quest then
		return
	end

	local missions = quest.missions
	local msg = NetworkMessage()
	msg:addByte(0xF1)
	msg:addU16(questId)
	msg:addByte(Game.countOngoingMissionsByQuest(self, quest))
	for _, mission in pairs(missions) do
		if self:isMissionOngoing(mission) then
			if self:getClient().version >= 1200 then
				msg:addU16(mission.missionId)
			end
			msg:addString(self:getTranslatedMissionName(mission), "Player.sendQuestline - self:getMissionName(questId, missionId)")
			msg:addString(self:getTranslatedMissionDescription(mission), "Player.sendQuestline - self:getMissionDescription(questId, missionId)")
		end
	end

	msg:sendToPlayer(self)
	msg:delete()
end

function Player.updateTrackedMissions(self)
	for _, quest in pairs(Questlog) do
		for _, mission in pairs(quest.missions) do
			self:updateMissionIfTracking(mission)
		end
	end
end

function Player.updateMissionIfTracking(self, mission)
	if self:isTrackingMissionState(mission) then
		local translatedMission = {
			questId = mission.questId,
			missionId = mission.missionId,
			questName = self:getTranslatedQuestName(mission.questName, mission.localizer),
			missionName = self:getTranslatedMissionName(mission),
			missionDesc = self:getTranslatedMissionDescription(mission),
		}
		self:updateMission(translatedMission)
	end
end

function Player.updateMission(self, mission)
	local msg = NetworkMessage()
	msg:addByte(0xD0)
	msg:addByte(0x00)
	msg:addU16(mission.missionId)
	msg:addU16(mission.questId)
	msg:addString(mission.questName, "Player.updateMission - quest.questName")
	msg:addString(mission.missionName, "Player.updateMission - mission.missionName")
	msg:addString(mission.missionDesc, "Player.updateMission - mission.missionDesc")
	msg:sendToPlayer(self)
	msg:delete()
end

local function questUpdateIsAnnouncable(key, value, oldValue)
	if value == oldValue then
		return false
	end
	if GetTaskByStorage(key) and oldValue ~= TASK_CANT_START_BECAUSE_HIGHER_LEVEL and oldValue ~= TASK_CAN_START_DESPITE_HIGHER_LEVEL then
		return false
	end
	if GetDailyTaskByStorage(key) and oldValue ~= DAILY_TASK_NOT_STARTED then
		return false
	end
	return true
end

function Player.tryAutoTrackMission(self, mission, oldValue, nextValue)
	if mission.autoTrack == DONT_AUTOTRACK then
		return
	end
	if not self:isMissionOngoing(mission) then
		return
	end
	if self:isTrackingMissionState(mission) then
		return
	end
	if oldValue ~= MISSION_NOT_STARTED then
		return
	end
	if nextValue == MISSION_NOT_STARTED then
		return
	end

	self:setMissionAsTracked(mission)
end

function Player.trySendQuestlogUpdatedText(self, storage, nextValue, oldValue, currentFrameTime)
	local playerId = self:getId()
	if LastQuestlogUpdate[playerId] ~= currentFrameTime and Game.isQuestStorage(storage) then
		LastQuestlogUpdate[playerId] = currentFrameTime
		if questUpdateIsAnnouncable(storage, nextValue, oldValue) then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
		end
	end
end

function Player.updateStorage(self, storage, nextValue, oldValue, currentFrameTime)
	self:trySendQuestlogUpdatedText(storage, nextValue, oldValue, currentFrameTime)

	local linkedMissions = Game.getLinkedMissions(storage)
	for _, linkedMission in pairs(linkedMissions) do
		if self:isMissionOngoing(linkedMission) then
			self:updateMissionIfTracking(linkedMission)
		end
	end

	local mission = Game.getMissionByStorage(storage)
	if not mission then
		return
	end

	self:tryAutoTrackMission(mission, oldValue, nextValue)

	if nextValue == MISSION_NOT_STARTED then
		self:setMissionAsNotTracked(mission)
	end

	if self:isMissionOngoing(mission) then
		self:updateMissionIfTracking(mission)
	end

	-- self:sendQuestLogMainPage()
end
