local itemTierClassifications = {
	-- Upgrade classification 1
	[1] = {
		-- Update tier 0
		[1] = { price = 15000, core = 1 },
		[2] = { price = 30000, core = 1 },
	},
	-- Upgrade classification 2
	[2] = {
		-- Update tier 0
		[1] = { price = 50000, core = 1 },
		[2] = { price = 100000, core = 1 },
		[3] = { price = 200000, core = 2 },
	},
	-- Upgrade classification 3
	[3] = {
		[1] = { price = 75000, core = 1 },
		[2] = { price = 150000, core = 1 },
		[3] = { price = 300000, core = 2 },
		[4] = { price = 600000, core = 2 },
		[5] = { price = 1000000, core = 3 },
	},
	-- Upgrade classification 4
	[4] = {
		[1] = { price = 200000, core = 1 },
		[2] = { price = 400000, core = 1 },
		[3] = { price = 800000, core = 2 },
		[4] = { price = 1000000, core = 5 },
		[5] = { price = 1500000, core = 7 },
		[6] = { price = 2000000, core = 10 },
		[7] = { price = 3000000, core = 15 },
		[8] = { price = 5000000, core = 20 },
		[9] = { price = 7500000, core = 25 },
		[10] = { price = 10000000, core = 30 },
	},
}

-- Item tier with gold price for uprading it
for classificationId, classificationTable in ipairs(itemTierClassifications) do
	local itemClassification = Game.createItemClassification(classificationId)
	local classification = {}

	-- Registers table for register_item_tier.lua interface
	classification.Upgrades = {}
	for tierId, tierTable in ipairs(classificationTable) do
		if tierId and tierTable.price and tierTable.core ~= nil then
			table.insert(classification.Upgrades, { TierId = tierId - 1, Price = tierTable.price, Core = tierTable.core })
		end
	end
	-- Create item classification and register classification table
	itemClassification:register(classification)
end
