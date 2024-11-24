local TO_BE_CALCULATED = 1

local lootbagsData = {
	[12413] = {
		lootTable = {
			{ weight = 2165, id = 14084, count = 10 },
			{ weight = 2076, id = 3035, count = 2 },
			{ weight = 1953, id = 3027, count = 2 },
			{ weight = 1953, id = 239, count = 2 },
			{ weight = 1674, id = 238, count = 2 },
			{ weight = 100, id = 9058, count = 1 },
			{ weight = 67, id = 14143, count = 1 },
			{ weight = 11, id = 14089, count = 1 },
		},
		effect = CONST_ME_HITBYPOISON,
		totalWeight = 0,
		rollToItem = {},
	},
}

local function appendAuxillaryData()
	for key, lootbagData in pairs(lootbagsData) do
		local totalWeight = 0
		for _, item in pairs(lootbagData.lootTable) do
			totalWeight = totalWeight + item.weight
		end
		lootbagsData[key].totalWeight = totalWeight
	end

	for key, lootbagData in pairs(lootbagsData) do
		for _, item in pairs(lootbagData.lootTable) do
			local simpleItemData = { id = item.id, count = item.count or 1 }
			for i = 1, item.weight do
				table.insert(item.rollToItem, simpleItemData)
			end
		end
	end
end
appendAuxillaryData()

local randomItems = Action()

function randomItems.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local usedLootbagData = lootbagsData[item:getId()]
	if not usedLootbagData then
		return false
	end

	local roll = math.random(1, usedLootbagData.totalWeight)
	local receivedItemData = usedLootbagData.rollToItem[roll]

	if receivedItemData and (not receivedItemData.id or receivedItemData.id == 0) then
		player:say("You found nothing useful.", TALKTYPE_MONSTER_SAY)
		return true
	end

	if not receivedItemData then
		logger.debug("[randomItems.onUse] item :id: has no loot table", { id = item:getId() })
		return false
	end

	player:AddCustomItem(receivedItemData)
	return true
end

for itemId, data in pairs(lootbagsData) do
	randomItems:id(itemId)
end

randomItems:register()
