	:Script(function(storageToRequiredState)
local config = {
	["saplingsNotWatered"] = "If you wanna proceed further, you need to water every sapling.",
	["youHaveOneMinute"] = "You have one minute to go through portal.",
	["gateIsOpened"] = "Passage is already open.",
}

local function areAllTreesWatered()
	return ItemsArePresentOnPositions(DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_positions, DESERT_QUEST_ONE_ANCHOR)
end

local function SwapItemsList(positionsList, fromId, toId, anchor)
	if not ItemsArePresentOnPositions(positionsList, anchor) then
		return false
	end
	for _, item in pairs(positionsList) do
		local pos = item.offPos or item.pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local tile = Tile(pos)
		tile:getItemById(fromId):transform(toId)
	end
	return true
end

local function drenchAllTrees()
	SwapItemsList(DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_positions, DESERT_QUEST_ONE_WATER_FLOW.vivid_tree_id, DESERT_QUEST_ONE_WATER_FLOW.dead_tree_id, DESERT_QUEST_ONE_ANCHOR)
end

local function gateIsOpened()
	return not ItemsArePresentOnPositions(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
end

local function openGateTemporarily()
	RemoveItems(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
	addEvent(function()
		CreateItems(DESERT_QUEST_ONE_WATER_FLOW.final_gate, DESERT_QUEST_ONE_ANCHOR)
		local portalPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_WATER_FLOW.final_gate[1].offPos)
		local item = Tile(Position(portalPos)):getItemById(1949)
		item:moveTo(portalPos:Moved(-1, 0, 0))
		item:moveTo(portalPos)
	end, 60 * 1000)
end

local tree_branch = Action()

function tree_branch.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local message = ""
	if not areAllTreesWatered() then
		message = "saplingsNotWatered"
	elseif gateIsOpened() then
		message = "gateIsOpened"
	else
		message = "youHaveOneMinute"
		drenchAllTrees()
		openGateTemporarily()
	end

	player:say(player:Localizer(Storage.DesertQuestOne.Questline):Get(config[message]), TALKTYPE_MONSTER_SAY)
	return false
end

tree_branch:aid(Storage.DesertQuestOne.Puzzles.WaterFlowPuzzle.TreeLever)
tree_branch:register()
end)
