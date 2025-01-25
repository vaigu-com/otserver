local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.charmPseudo

local callback = EventCallback()
function callback.monsterOnDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player then
		return
	end

	local mType = monster:getType()
	if not mType then
		logger.warning(debug.traceback("monsterOnDropLoot: monster has no type"))
		return
	end

	local charm = player and player:getCharmMonsterType(CHARM_GUT)
	local applyGut = charm and charm:raceId() == mType:raceId()
	if not charm then
		return
	end

	local totalLoot = TryGenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end

callback:register()
