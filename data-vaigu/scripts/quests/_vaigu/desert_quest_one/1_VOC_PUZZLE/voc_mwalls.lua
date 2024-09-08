local config = { ["SUCCESS"] = "One of the magic walls disappeared", ["FAIL"] = "You cannot use this yet" }

local lever = Action()

local MWALL = 2129

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local aid = item.actionid
	local pos = DESERT_QUEST_ONE_ANCHOR:Moved(DESERT_QUEST_ONE_PERSONAL_MWALLS[aid])
	local tile = Tile(pos):getItemById(MWALL)

	if tile then
		item:transform(DESERT_QUEST_ONE_LEVER_SWAP_LIST[item.itemid])

		tile:remove()
		player:say(config["SUCCESS"], TALKTYPE_MONSTER_SAY)
		addEvent(function()
			Game.createItem(MWALL, 1, pos)
		end, 1000 * 60)
	else
		player:say(config["FAIL"], TALKTYPE_MONSTER_SAY)
	end

	return true
end

lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EkLever)
lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.EdLever)
lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.MsLever)
lever:aid(Storage.DesertQuestOne.Puzzles.VocPuzzle.RpLever)
lever:register()
