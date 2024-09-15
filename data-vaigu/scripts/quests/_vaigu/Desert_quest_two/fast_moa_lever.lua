-- require("lldebuggr").start()

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

local item2 = Look()
function item2.onLook(a, b, c, d, e, f)
	print("MOA LEVER LOOK")
	print(a, b, c, d, e, f)
	return true
end
item2:aid(Storage.DesertQuestTwo.Puzzles.FastMoaLever)
item2:register()
