LOOT_LAYER_ORDER = {
	MONSTER_LOOT_LAYER.base,
	MONSTER_LOOT_LAYER.charmPseudo,
	MONSTER_LOOT_LAYER.boosted,
	MONSTER_LOOT_LAYER.prey,
	MONSTER_LOOT_LAYER.wealthDuplex,
	MONSTER_LOOT_LAYER.hazard,
	MONSTER_LOOT_LAYER.atelier,
	MONSTER_LOOT_LAYER.raidSilver,
}
local lootLayerSuffix = {
	[MONSTER_LOOT_LAYER.base] = " (base)",
	[MONSTER_LOOT_LAYER.charmPseudo] = " (gut charm)",
	[MONSTER_LOOT_LAYER.boosted] = " (boosted loot)",
	[MONSTER_LOOT_LAYER.prey] = " (active prey bonus)",
	[MONSTER_LOOT_LAYER.wealthDuplex] = " (active wealth duplex)",
	[MONSTER_LOOT_LAYER.hazard] = " (hazard system)",
	[MONSTER_LOOT_LAYER.atelier] = " (atelier)",
	[MONSTER_LOOT_LAYER.raidSilver] = " (raid)",
}

local lowStaminaWarning = " nothing (due to low stamina)"
local isEmptyWarning = " nothing"

local function parseItemDesc(item, shouldColor)
	local itemEx = Game.createItem(item.id, item.count)
	local nameDesc = itemEx:getNameDescription()
	local itemDesc = ""
	if shouldColor then
		itemDesc = T("{:id:|:nameDesc:}", { id = item.id, nameDesc = nameDesc })
	else
		itemDesc = nameDesc
	end
	itemEx:remove()
	return itemDesc
end

local function parseLayerSuffix(lootTable, layerName)
	if layerName == MONSTER_LOOT_LAYER.base then
		if lootTable:HasNonBaseLayerLoot() then
			return lootLayerSuffix[layerName]
		else
			return ""
		end
	end
	return lootLayerSuffix[layerName]
end

local function parseLayerDesc(lootTable, layerName, shouldColor)
	local itemData = lootTable:Get()[layerName]
	if not itemData or TableSize(itemData) == 0 then
		return ""
	end

	local layerDesc = "	"
	local itemsDesc = ""
	for _, item in pairs(itemData) do
		itemsDesc = itemsDesc .. parseItemDesc(item, shouldColor) .. ", "
	end
	itemsDesc = string.sub(itemsDesc, 1, -3)
	local layerSuffix = parseLayerSuffix(lootTable, layerName)
	layerDesc = layerDesc .. itemsDesc .. layerSuffix
	return layerDesc
end

function ParseLayersDesc(monster, shouldColor, lootTableRegistryIdentifier)
	local lootTable = LootTableRegistry:Get(lootTableRegistryIdentifier or monster:getId())

	local layersDesc = ""
	if lootTable:IsLowStamina() then
		return lowStaminaWarning
	end
	if lootTable:IsEmpty() then
		return isEmptyWarning
	end

	for _, layerName in pairs(LOOT_LAYER_ORDER) do
		layersDesc = layersDesc .. parseLayerDesc(lootTable, layerName, shouldColor)
	end

	return layersDesc
end

function RewardbossLootParseDesc(monster, rewardChest, shouldColor, lootTableRegistryIdentifier)
	local name = monster:getNameDescription()
	local layersDesc = ParseLayersDesc(rewardChest, shouldColor, lootTableRegistryIdentifier)

	local message = T("The following items dropped by :name: are available in your reward chest: :layersDesc:.", { name = name, layersDesc = layersDesc })
	return message
end

function MonsterLootParseDesc(monster, corpse, shouldColor)
	local monsterDesc = monster:getNameDescription()
	local layersDesc = ParseLayersDesc(monster, shouldColor)

	local message = T("Loot of :monsterDesc:::layersDesc:.", { monsterDesc = monsterDesc, layersDesc = layersDesc })
	return message
end

local callback = EventCallback()
function callback.monsterPostDropLoot(monster, corpse)
	local player = Player(corpse:getCorpseOwner())
	if not player then
		return
	end
	if not player:canReceiveLoot() then
		return
	end

	local lootTable = LootTableRegistry:Get(monster:getId()):Get()
	for _, lootLayer in pairs(LOOT_LAYER_ORDER) do
		local items = lootTable[lootLayer]
		if items then
			corpse:addLoot(items)
		end
	end
end

callback:register()
