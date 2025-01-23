local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.atelier

local callback = EventCallback("MonsterOnDropLootGemAtelier")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end
	local player = Player(corpse:getCorpseOwner())

	local totalLoot = GenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter)
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end

callback:register()
