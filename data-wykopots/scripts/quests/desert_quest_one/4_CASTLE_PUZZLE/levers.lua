local lever = Action()

function lever.onUse(cid, item, fromPosition, itemEx, toPosition)
	item:transform(DESERT_QUEST_ONE_CASTLE_SWAP_LIST[item:getId()])

	local items = DESERT_QUEST_ONE_CASTLE_LEVER_GROUPS[item:getActionId()]
	for j = 1, #items do
		local index = items[j]
		local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_CASTLE_LEVER_POS_ITEMS[index].offPos)

		local id = DESERT_QUEST_ONE_CASTLE_LEVER_POS_ITEMS[index].id
		local swapid = DESERT_QUEST_ONE_CASTLE_SWAP_LIST[id]

		local tile = Tile(pos):getItemById(id)
		local swaptile = Tile(pos):getItemById(swapid)

		if tile then
			tile:remove()
			Game.createItem(swapid, 1, pos)
		elseif swaptile then
			swaptile:remove()
			Game.createItem(id, 1, pos)
		elseif not swaptile and not tile then
			Game.createItem(id, 1, pos)
		end
	end
	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever1)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever2)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever3)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever4)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever5)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever6)
lever:aid(Storage.DesertQuestOne.Puzzles.CastlePuzzle.Lever7)
lever:register()

-- crateitem(id, count, pos)
