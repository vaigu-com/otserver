local chests = {
	["FirstHouse"] = { id = 2478, pos = DESERT_QUEST_TWO_ANCHOR:Moved(0, 25, -2), bitProgress = 2 ^ 0, permanent = true },
	["FifteenPuzzle"] = { id = 11520, pos = DESERT_QUEST_TWO_ANCHOR:Moved(6, 7, 0), bitProgress = 2 ^ 1 },
	["RubiksCube"] = { id = 2471, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-10, -38, -1), bitProgress = 2 ^ 2 },
	["FireWall"] = { id = 2459, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-41, 9, 2), bitProgress = 2 ^ 3, permanent = true },
	["Maze"] = { id = 4073, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-3, -8, 2), bitProgress = 2 ^ 4, permanent = true },
	["UnderWheat"] = { id = 2473, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-5, -28, -1), bitProgress = 2 ^ 5, permanent = true },
	["RGB"] = { id = 14243, pos = DESERT_QUEST_TWO_ANCHOR:Moved(18, -12, 1), bitProgress = 2 ^ 6 },
	["Pipes"] = { id = 14245, pos = DESERT_QUEST_TWO_ANCHOR:Moved(23, -55, 1), bitProgress = 2 ^ 7 },
	["Moa"] = { id = 2481, pos = DESERT_QUEST_TWO_ANCHOR:Moved(40, -5, 0), bitProgress = 2 ^ 8, permanent = true },
	["IdenticalRooms"] = { id = 27896, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-93, -18, 1), bitProgress = 2 ^ 9, permanent = true },
	["Orbs"] = { id = 2472, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-21, -57, -1), bitProgress = 2 ^ 10, permanent = true },
	["BehindTree"] = { id = 2474, pos = DESERT_QUEST_TWO_ANCHOR:Moved(-13, 10, -3), bitProgress = 2 ^ 11, permanent = true },
}
local chestIdToBitProgress = {}
local idChestIsSpawned = {}

function TrySpawnDQ2progressChest(name, permament)
	if idChestIsSpawned[name] then
		return
	end

	local config = chests[name]
	local chest = Game.createItem(config.id, 1, config.pos)
	chest:setActionId(Storage.DesertQuestTwo.ProgressChests)
	chest:setUniqueId(1000)
	idChestIsSpawned[name] = true

	if not permament then
		addEvent(function()
			chest:remove()
			idChestIsSpawned[name] = false
		end, 60 * 2 * 1000)
	end
end

function InitializeDQ2chests()
	for name, chest in pairs(chests) do
		chestIdToBitProgress[chest.id] = chest.bitProgress
		idChestIsSpawned[chest.id] = true
		if chest.permanent then
			TrySpawnDQ2progressChest(name, true)
		end
	end
end

function GetDQ2completedPuzzleCount(player)
	local storageVal = player:getStorageValue(Storage.DesertQuestTwo.Mission01)
	local result = 0
	while storageVal > 0 do
		result = result + (bit.band(storageVal, 1))
		storageVal = bit.rshift(storageVal, 1)
	end
	return result, TableSize(chests)
end

local chestItem = Action()
function chestItem.onUse(creature, item, fromPosition, target, toPosition, isHotkey)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	local oldValue = player:getStorageValue(Storage.DesertQuestTwo.Mission01)
	if oldValue == -1 then
		oldValue = 0
	end
	
	local newValue = bit.bor(oldValue, chestIdToBitProgress[item:getId()])
	if newValue == oldValue then
		return true
	end

	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:setStorageValue(Storage.DesertQuestTwo.Mission01, newValue)

	local puzzlesCompleted, puzzlesCount = GetDQ2completedPuzzleCount(player)
	local finalString = puzzlesCompleted .. "/" .. puzzlesCount
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, finalString)
	return true
end

chestItem:aid(Storage.DesertQuestTwo.ProgressChests)
chestItem:register()
