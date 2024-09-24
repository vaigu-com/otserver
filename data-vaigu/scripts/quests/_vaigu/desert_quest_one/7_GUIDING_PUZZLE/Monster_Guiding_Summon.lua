	:Script(function(storageToRequiredState)
local function createSubstituteMonster(top_left, down_right, spawn_pos, name)
	local z = top_left.z
	for x = top_left.x, down_right.x do
		for y = top_left.y, down_right.y do
			local pos = Position(x, y, z)
			if Tile(pos):getTopCreature() then
				Tile(pos):getTopCreature():remove()
				break
			end
		end
	end
	Game.createMonster(name, spawn_pos)
	return true
end

local gpAltar = MoveEvent()

function gpAltar.onAddItem(moveitem, tileitem, position)
	if not moveitem then
		return false
	else
		if moveitem.itemid ~= 3031 then
			return false
		end
	end
	moveitem:remove()
	createSubstituteMonster(DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.top_left), DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.down_right), DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.monster.spawn_pos), DESERT_QUEST_ONE_MONSTER_GUIDING.monster.name)
	return true
end

gpAltar:type("additem")
gpAltar:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeGp)
gpAltar:register()

local wispAltar = MoveEvent()
function wispAltar.onStepIn(creature, item, toPosition, fromPosition)
	if creature:isPlayer() then
		return false
	end

	local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.fence.pos)
	local id = DESERT_QUEST_ONE_MONSTER_GUIDING.fence.id

	if Tile(pos):getItemById(id) then
		local monster_pressure_plate_pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_MONSTER_GUIDING.monster.pressure_plate_pos)
		Tile(monster_pressure_plate_pos):getTopCreature():remove()
		Position(pos):removeItem(id)
		Position(pos):sendMagicEffect(CONST_ME_MAGIC_BLUE)
		Position(monster_pressure_plate_pos):sendMagicEffect(CONST_ME_FIREATTACK)
		addEvent(function()
			Game.createItem(id, 1, pos)
		end, 1000 * 60)
	end
	return true
end

wispAltar:aid(Storage.DesertQuestOne.Puzzles.GuidingPuzzle.SacrificeWisp)
wispAltar:type("stepin")
wispAltar:register()
end)
