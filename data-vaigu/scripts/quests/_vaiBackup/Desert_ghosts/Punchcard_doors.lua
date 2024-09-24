local punchcard = Action()

function punchcard.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end
	if item:getActionId() and not (item:getActionId() == Storage.CaveExplorerOnShield.Misc.Punchcard) then
		return false
	end
	if target:getActionId() and not (target:getActionId() == Storage.CaveExplorerOnShield.Misc.Punchcard) then
		return false
	end
	if not (target:getId() == 8342) then
		return false
	end
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end

	local pos = target:getPosition()
	pos.y = pos.y - 1
	pos.x = pos.x + 1

	pos:sendMagicEffect(CONST_ME_SMOKE)
	addEvent(function()
		pos:sendMagicEffect(CONST_ME_SMOKE)
	end, 500 * 1)
	addEvent(function()
		pos:sendMagicEffect(CONST_ME_SMOKE)
	end, 1000 * 1)
	addEvent(function()
		RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
		RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
	end, 2000 * 1)
	return true
end

punchcard:aid(Storage.CaveExplorerOnShield.Misc.Punchcard)
punchcard:register()

local doorPos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED[1].offPos)
local safePos = doorPos:Moved(-1, 0, 0)

local tile = MoveEvent()
function tile.onStepIn(player, item, toPosition, fromPosition)
	if not ItemsArePresentOnPositions(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end
	if not player:isPlayer() then
		return false
	end
	if item.itemid == CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.punchcard.id then
		return false
	end
	if not Tile(toPosition):getItemById(355) then
		return false
	end

	local pos = item:getPosition()
	pos.y = pos.y - 1

	pos:sendMagicEffect(CONST_ME_SMOKE)

	addEvent(function()
		doorPos:MoveThings(safePos)
		RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
		RemoveItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_OPEN, DESERT_QUEST_ONE_ANCHOR)
		CreateItems(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, DESERT_QUEST_ONE_ANCHOR)
		ChangeItemsActionId(DESERT_QUEST_ONE_PUNCHCARD_DOOR_CLOSED, Storage.CaveExplorerOnShield.Misc.Punchcard, DESERT_QUEST_ONE_ANCHOR)
	end, 1000 * 1)
end

tile:aid(Storage.CaveExplorerOnShield.Misc.Punchcard)
tile:type("stepin")
tile:register()
