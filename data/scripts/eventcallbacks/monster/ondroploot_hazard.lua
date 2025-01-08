local lootFactor = 1.0
local lootLayer = MONSTER_LOOT_LAYER.hazard

local callback = EventCallback()
function callback.monsterOnDropLoot(monster, corpse)
	if not monster:hazard() then
		return
	end
	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end
	local mType = monster:getType()
	if not mType then
		return
	end

	local chance = (2 * player:getHazardSystemPoints() * configManager.getNumber(configKeys.HAZARD_LOOT_BONUS_MULTIPLIER))
	local rolls = chance / 100
	if math.random(0, 100) < (rolls % 1) * 100 then
		rolls = math.ceil(rolls)
	else
		rolls = math.floor(rolls)
	end

	local totalLoot = {}
	for _ = 1, rolls do
		totalLoot = table.merged(totalLoot, GenerateLootRoll(lootLayer, monster, player, lootFactor, applyGut, filter))
	end
	local monsterId = monster:getId()
	LootTableRegistry:Append(totalLoot, monsterId, lootLayer)
end
callback:register()
