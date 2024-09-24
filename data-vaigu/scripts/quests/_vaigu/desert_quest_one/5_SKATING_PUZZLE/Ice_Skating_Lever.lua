	:Script(function(storageToRequiredState)
local skating_id = DESERT_QUEST_ONE_ICE_SKATING.skating_floor.id
local black_marble_id = DESERT_QUEST_ONE_ICE_SKATING.black_marble.id

local lever = Action()

function lever.onUse(creature, item, fromPosition, itemEx, toPosition)
	local player = creature:getPlayer()
	if not player:isPlayer() then
		return false
	end

	local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_ICE_SKATING.stone.pos)
	local id = DESERT_QUEST_ONE_ICE_SKATING.stone.id
	if Tile(pos):getItemById(id) then
		return false
	end

	if not PlayersPresentAtAllPositions(DESERT_QUEST_ONE_ICE_SKATING.players_pos, DESERT_QUEST_ONE_ANCHOR) then
		return false
	end

	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)

	local stone = Game.createItem(id, 1, pos)
	local tile = Tile(pos):getItemById(skating_id)
	tile:transform(black_marble_id)
	addEvent(function()
		stone:remove()
		tile:transform(skating_id)
	end, 1000 * 60)

	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.SkatingPuzzle.Lever)
lever:register()
end)
