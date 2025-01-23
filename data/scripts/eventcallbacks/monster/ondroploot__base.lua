local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.base

local callback = EventCallback("MonsterOnDropLootBaseEvent")
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

	local totalLoot = GenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
	if not player:canReceiveLoot() then
		LootTableRegistry:LowStamina(monsterId)
	end
end

callback:register()
