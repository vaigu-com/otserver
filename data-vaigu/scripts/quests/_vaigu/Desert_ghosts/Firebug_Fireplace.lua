	:Script(function(storageToRequiredState)
local function movePlayersFromArea(topLeft, downRight, safePos)
	CreatureList():Area(topLeft, downRight):FilteredByPlayer():MovedToPos(safePos)
end

local topLeft = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -42, y = 55, z = 3 })
local downRight = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 72, z = 3 })
local passage_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -26, y = 67, z = 3 })
local portal_pos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = -33, y = 60, z = 3 })

local function tryUseFrozenFireplace(fireplace)
	local unlit = 1997
	local lit = 22077
	local start = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PORTALS[Storage.DesertQuestOne.Portals.IceRoomStart])

	fireplace:transform(lit)

	local tile = Tile(passage_pos)
	if tile:getItemById(2129) then
		tile:getItemById(2129):remove()
	else
		return false
	end

	movePlayersFromArea(topLeft, downRight, start)

	local portal = Game.createItem(1949, 1, portal_pos)
	portal:setActionId(Storage.DesertQuestOne.Portals.IceRoomReward)

	addEvent(function()
		fireplace:transform(unlit)
	end, 1000 * 28)

	addEvent(function()
		passage_pos:MoveThings(start)
		movePlayersFromArea(topLeft, downRight, start)
		portal:remove()
		Game.createItem(2129, 1, passage_pos)
	end, 1000 * 30)

	return true
end

local ghost_name = "Ghost of Germi the Journeyman"
local ghostPos = DESERT_QUEST_ONE_ANCHOR:Moved({ x = 82, y = 52, z = -2 })
local floorEffect = 8827
local unlit = 2001
local lit = 22076
local function tryUseGermiFireplace(fireplace)
	fireplace:transform(lit)

	local npc = Game.createNpc(ghost_name, ghostPos)

	local floorEffectItem = Game.createItem(floorEffect, 1, ghostPos)
	floorEffectItem:setUniqueId(1000)

	addEvent(function()
		npc:remove()
		floorEffectItem:remove()
		fireplace:transform(unlit)
		fireplace:setActionId(Storage.CaveExplorerOnShield.Misc.FirebugFireplace)
	end, 1000 * 120 * 2)

	return true
end

local fireBugId = 5467
local ghost_fireplace_pos = Position(DESERT_QUEST_ONE_ANCHOR:Moved({ x = 77, y = 53, z = -2 }))
local frozen_fireplace_pos = Position(DESERT_QUEST_ONE_ANCHOR:Moved({ x = -25, y = 66, z = 3 }))

local function playerIsUsingBugOnFireplace(item, fireplace)
	if item:getId() ~= fireBugId then
		return false
	end
	if fireplace:getActionId() ~= Storage.CaveExplorerOnShield.Misc.FirebugFireplace then
		return false
	end
	return true
end
local firebug = Action()
function firebug.onUse(player, item, fromPosition, fireplace, toPosition, isHotkey)
	if not playerIsUsingBugOnFireplace(item, fireplace) then
		return false
	end

	if toPosition == ghost_fireplace_pos and fireplace.itemid == 2001 then
		tryUseGermiFireplace(fireplace)
	elseif toPosition == frozen_fireplace_pos and fireplace.itemid == 1997 then
		tryUseFrozenFireplace(fireplace)
	end

	return true
end

firebug:aid(Storage.CaveExplorerOnShield.Misc.FirebugFireplace)
firebug:register()
end)
