	:Script(function(storageToRequiredState)
local stonePos = DESERT_QUEST_TWO_ANCHOR:Moved(41, -6, 0)
local moaPos = DESERT_QUEST_TWO_ANCHOR:Moved(45, -17, 0)

local lever = Action()
function lever.onUse(creature, _, _, _, _, _)
	print("MOA LEVER USE")
	local player = creature:getPlayer()
	if not player then
		return false
	end
	local stone = Tile(stonePos):getItemById(1791)
	if not stone then
		return
	end
	local creature = Tile(moaPos):getTopCreature()
	if not creature then
		return
	end
	if not creature:getName():lower() == "fast moa" then
		return
	end

	stone:moveTo(stonePos:Moved(-1, 0, 0))
	addEvent(function()
		stone:moveTo(stonePos)
	end, 60 * 2 * 1000)
	return false
end

lever:aid(Storage.DesertQuestTwo.Puzzles.FastMoaLever)
lever:register()

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:say("meow")
	return true
end
action:aid(6969)
action:register()

local look = Look()
function look.onLook(player, item, fromPosition, target, toPosition)
	player:say("meow")
	return true
end
look:aid(6969)
look:position({ x = 6585, y = 557, z = 9 })
look:register()
end)
