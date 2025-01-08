local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.boosted

local callback = EventCallback()
function callback.monsterOnDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player then
		return
	end

	if not monster:isBoosted() then
		return
	end

	local mType = monster:getType()
	if not mType then
		return
	end
	if mType:isRewardBoss() then
		return
	end

	local totalLoot = GenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end
callback:register()
