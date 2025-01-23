local lootLayerOrder = {
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

local function parseItemDesc(itemEx, shouldColor)
	local nameDesc = itemEx:getNameDescription()
	if shouldColor then
		local id = itemEx:getId()
		return T("{:id:|:nameDesc:}", { id = id, nameDesc = nameDesc })
	end
	return nameDesc
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

local function parseLayerDesc(lootTable, loot, layerName, corpse, shouldColor)
	local items = loot[layerName]
	if not items then
		return ""
	end

	local addedItems = corpse:AddItems(items)
	if #addedItems == 0 then
		return ""
	end

	local layerDesc = "	"
	local itemsDesc = ""
	for _, itemData in pairs(addedItems) do
		itemsDesc = itemsDesc .. parseItemDesc(itemData, shouldColor) .. ", "
	end
	itemsDesc = string.sub(itemsDesc, 1, -3)
	local layerSuffix = parseLayerSuffix(lootTable, layerName)
	layerDesc = layerDesc .. itemsDesc .. layerSuffix
	return layerDesc
end

local function parseLayersDesc(lootTable, corpse, shouldColor)
	local layersDesc = ""
	if lootTable:IsLowStamina() then
		return lowStaminaWarning
	end
	if lootTable:IsEmpty() then
		return isEmptyWarning
	end

	local loot = lootTable:Get()
	for _, layerName in pairs(lootLayerOrder) do
		layersDesc = layersDesc .. parseLayerDesc(lootTable, loot, layerName, corpse, shouldColor)
	end

	return layersDesc
end

function ContainerCorpseParseDesc(monster, corpse, shouldColor)
	local monsterDesc = monster:getNameDescription()

	local monsterId = monster:getId()
	local lootTable = LootTableRegistry:Get(monsterId)
	local layersDesc = parseLayersDesc(lootTable, corpse, shouldColor)

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
	for _, lootLayer in pairs(lootLayerOrder) do
		local items = lootTable[lootLayer]
		if items then
			corpse:addLoot(items)
		end
	end
end

callback:register()
