MAX_CHARGES = -1

NO_REWARD = -1

---@class LootboxDataRegistry
LootboxDataRegistry = {}
LootboxDataRegistry.__index = LootboxDataRegistry
LootboxDataRegistry.registry = {}

---@param lootboxData LootboxData
---@return LootboxDataRegistry
function LootboxDataRegistry:Add(lootboxData)
	self.registry[lootboxData:GetLootboxId()] = lootboxData
	return self
end

---@param lootboxId number
---@return LootboxData
function LootboxDataRegistry:Get(lootboxId)
	return self.registry[lootboxId]
end

---@return LootboxData[]
function LootboxDataRegistry:GetAll()
	return self.registry
end

---@class LootboxData
---@field lootboxId number
---@field rewards LootboxReward[]
---@field effect number|nil
---@field rollToRewardIndex table<number, number>
LootboxData = {}
LootboxData.__index = LootboxData
function LootboxData.New(context)
	local newObj = {
		lootboxId = context.lootboxId,
		rewards = context.rewards,
		effect = context.effect,
	}
	if not newObj.lootboxId then
		logger.warn(debug.traceback("[Lootbox::New] No lootboxId specified for the Lootbox."))
		return
	end
	if not newObj.rewards then
		logger.warn(debug.traceback("[Lootbox::New] No rewards specified for the Lootbox."))
		return
	end

	local maxRewardWeight = 0
	local maxWeightRewardData = {}
	for _, reward in pairs(newObj.rewards) do
		local rewardWeight = ItemType(reward.rewardItemId):getWeight() * (reward.count or 1)
		if rewardWeight > maxRewardWeight then
			maxRewardWeight = rewardWeight
			maxWeightRewardData = { rewardItemId = reward.rewardItemId, count = reward.count }
		end
	end
	newObj.maxWeightRewardData = maxWeightRewardData

	setmetatable(newObj, LootboxData)
	newObj:InitializeRollMap()
	return newObj
end
setmetatable(LootboxData, {
	__call = function(_, ...)
		return LootboxData.New(...)
	end,
})

---@return number
function LootboxData:GetLootboxId()
	return self.lootboxId
end

---@return LootboxReward|nil
function LootboxData:GetRandomReward()
	local randomRewardId = table.random(self.rollToRewardIndex)
	local randomReward = self.rewards[randomRewardId]

	if not randomReward then
		logger.warn(debug.traceback(T("[lootboxUse.onUse] Could not generate a random item from Lootbox :lootboxId:.", { lootboxId = self.lootboxId })))
		return nil
	end
	if randomReward.rewardItemId == NO_REWARD then
		return nil
	end
	return randomReward
end

---@return LootboxData
function LootboxData:InitializeRollMap()
	local rollToRewardIndex = {}
	for index, reward in ipairs(self.rewards) do
		for _ = 1, reward.weight do
			table.insert(rollToRewardIndex, index)
		end
	end

	self.rollToRewardIndex = rollToRewardIndex
	return self
end

---@class LootboxReward
---@field rewardItemId number
---@field weight number
---@field count number
LootboxReward = {}
LootboxReward.__index = LootboxReward
function LootboxReward.New(context)
	local newObj = {
		rewardItemId = context.rewardItemId,
		weight = context.weight,
		count = context.count,
	}
	if not newObj.rewardItemId then
		logger.warn(debug.traceback("[Lootbox::New] No rewardItemId specified for the LootboxReward."))
		return
	end
	if not newObj.weight then
		logger.warn(debug.traceback("[Lootbox::New] No weight specified for the LootboxReward."))
		return
	end

	if newObj.count == MAX_CHARGES then
		local maxDefaultCharges = ItemType(newObj.rewardItemId):getCharges()
		newObj.count = maxDefaultCharges
	end

	if not newObj.count then
		logger.warn(debug.traceback("[Lootbox::New] No count specified for the LootboxReward"))
	end

	setmetatable(newObj, LootboxReward)
	return newObj
end
setmetatable(LootboxReward, {
	__call = function(_, ...)
		return LootboxReward.New(...)
	end,
})

NO_LOOTBOX_ID = 0
local realLootboxData = {
	LootboxData({
		lootboxId = ItemId.BELONGINGS_OF_A_DECEASED, -- belonging of a deceased
		rewards = {
			LootboxReward({ rewardItemId = 14084, weight = 191, count = 5 }),
			LootboxReward({ rewardItemId = 5890, weight = 488, count = 1 }),
			LootboxReward({ rewardItemId = 3606, weight = 168, count = 1 }),
			LootboxReward({ rewardItemId = 5899, weight = 424, count = 1 }),
			LootboxReward({ rewardItemId = 5894, weight = 401, count = 1 }),
			LootboxReward({ rewardItemId = 5902, weight = 299, count = 1 }),
			LootboxReward({ rewardItemId = 3083, weight = 100, count = MAX_CHARGES }),
			LootboxReward({ rewardItemId = 12787, weight = 57, count = 1 }),
			LootboxReward({ rewardItemId = 3026, weight = 79, count = 1 }),
			LootboxReward({ rewardItemId = 5879, weight = 72, count = 1 }),
			LootboxReward({ rewardItemId = 2995, weight = 66, count = 1 }),
			LootboxReward({ rewardItemId = 12786, weight = 59, count = 1 }),
			LootboxReward({ rewardItemId = 9646, weight = 54, count = 1 }),
			LootboxReward({ rewardItemId = 5895, weight = 38, count = 1 }),
			LootboxReward({ rewardItemId = 5880, weight = 38, count = 1 }),
			LootboxReward({ rewardItemId = 12519, weight = 31, count = 1 }),
			LootboxReward({ rewardItemId = 3079, weight = 9, count = 1 }),
		},
		effect = CONST_ME_POFF,
	}),
	LootboxData({
		lootboxId = ItemId.GOOEY_MASS, -- gooey mass
		rewards = {
			LootboxReward({ rewardItemId = NO_REWARD, weight = 2, count = 1 }),
			LootboxReward({ rewardItemId = 14084, weight = 2165, count = 10 }),
			LootboxReward({ rewardItemId = 3035, weight = 2076, count = 2 }),
			LootboxReward({ rewardItemId = 3027, weight = 1953, count = 2 }),
			LootboxReward({ rewardItemId = 9058, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 14143, weight = 67, count = 1 }),
			LootboxReward({ rewardItemId = 14089, weight = 11, count = 1 }),
		},
		effect = CONST_ME_HITBYPOISON,
	}),
	LootboxData({
		lootboxId = ItemId.SHAGGY_OGRE_BAG, -- shaggy ogre bag
		rewards = {
			LootboxReward({ rewardItemId = 22187, weight = 840, count = 5 }),
			LootboxReward({ rewardItemId = 22191, weight = 594, count = 1 }),
			LootboxReward({ rewardItemId = 22184, weight = 636, count = 1 }),
			LootboxReward({ rewardItemId = 22194, weight = 815, count = 5 }),
			LootboxReward({ rewardItemId = 22193, weight = 611, count = 5 }),
			LootboxReward({ rewardItemId = 3406, weight = 529, count = 1 }),
			LootboxReward({ rewardItemId = 22183, weight = 324, count = 1 }),
			LootboxReward({ rewardItemId = 22172, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 22171, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 3443, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 3560, weight = 329, count = 1 }),
			LootboxReward({ rewardItemId = 22192, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 7413, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 7452, weight = 323, count = 1 }),
			LootboxReward({ rewardItemId = 5668, weight = 322, count = 1 }),
		},
		effect = CONST_ME_CRAPS,
	}),
	LootboxData({
		lootboxId = ItemId.MYSTERIOUS_REMAINS, -- mysterious remains
		rewards = {
			LootboxReward({ rewardItemId = 2995, weight = 594, count = 1 }),
			LootboxReward({ rewardItemId = 5880, weight = 315, count = 1 }),
			LootboxReward({ rewardItemId = 3044, weight = 751, count = 1 }),
			LootboxReward({ rewardItemId = 5879, weight = 600, count = 1 }),
			LootboxReward({ rewardItemId = 6570, weight = 529, count = 1 }),
			LootboxReward({ rewardItemId = 5882, weight = 465, count = 1 }),
			LootboxReward({ rewardItemId = 15698, weight = 354, count = 1 }),
			LootboxReward({ rewardItemId = 22194, weight = 804, count = 5 }),
			LootboxReward({ rewardItemId = 8899, weight = 600, count = 1 }),
			LootboxReward({ rewardItemId = 2958, weight = 279, count = 1 }),
			LootboxReward({ rewardItemId = 22763, weight = 125, count = 1 }),
			LootboxReward({ rewardItemId = 3037, weight = 111, count = 1 }),
			LootboxReward({ rewardItemId = 3036, weight = 89, count = 1 }),
			LootboxReward({ rewardItemId = 9304, weight = 89, count = 1 }),
			LootboxReward({ rewardItemId = 36810, weight = 99, count = 1 }),
			LootboxReward({ rewardItemId = 9058, weight = 157, count = 2 }),
			LootboxReward({ rewardItemId = 22737, weight = 136, count = 1 }),
			LootboxReward({ rewardItemId = 23536, weight = 129, count = 1 }),
			LootboxReward({ rewardItemId = 22731, weight = 143, count = 1 }),
		},
		effect = CONST_ME_CRAPS,
	}),
	LootboxData({
		lootboxId = ItemId.SURPRISE_JAR, -- surprise jar
		rewards = {
			LootboxReward({ rewardItemId = 3041, weight = 2501, count = 1 }),
			LootboxReward({ rewardItemId = 3036, weight = 2101, count = 1 }),
			LootboxReward({ rewardItemId = 22721, weight = 1667, count = 1 }),
			LootboxReward({ rewardItemId = 22516, weight = 1668, count = 1 }),
			LootboxReward({ rewardItemId = 27653, weight = 2766, count = 1 }),
		},
		effect = CONST_ME_CRAPS,
	}),
	LootboxData({
		lootboxId = ItemId.FLASK_OF_DEMONIC_BLOOD, -- concentrated demonic blood
		rewards = {
			LootboxReward({ rewardItemId = 236, weight = 3000, count = 1 }),
			LootboxReward({ rewardItemId = 237, weight = 5000, count = 1 }),
		},
		effect = CONST_ME_DRAWBLOOD,
	}),
	LootboxData({
		lootboxId = ItemId.GLOOTH_BAG, -- glooth bag
		rewards = {
			LootboxReward({ rewardItemId = 21158, weight = 1675, count = 2 }),
			LootboxReward({ rewardItemId = 21183, weight = 1544, count = 20 }),
			LootboxReward({ rewardItemId = 21178, weight = 1516, count = 2 }),
			LootboxReward({ rewardItemId = 21180, weight = 1465, count = 2 }),
			LootboxReward({ rewardItemId = 21179, weight = 1433, count = 2 }),
			LootboxReward({ rewardItemId = 21295, weight = 334, count = 1 }),
			LootboxReward({ rewardItemId = 21143, weight = 214, count = 10 }),
			LootboxReward({ rewardItemId = 21144, weight = 395, count = 10 }),
			LootboxReward({ rewardItemId = 21146, weight = 354, count = 10 }),
			LootboxReward({ rewardItemId = 21186, weight = 71, count = 1 }),
		},
		effect = CONST_ME_HITBYPOISON,
	}),
	LootboxData({
		lootboxId = ItemId.GNOMISH_SUPPLY_PACKAGE, -- gnomish supply package
		rewards = {
			LootboxReward({ rewardItemId = 7643, weight = 700, count = 10 }),
			LootboxReward({ rewardItemId = 237, weight = 800, count = 20 }),
			LootboxReward({ rewardItemId = 238, weight = 800, count = 15 }),
			LootboxReward({ rewardItemId = 239, weight = 800, count = 15 }),
			LootboxReward({ rewardItemId = 7443, weight = 900, count = 1 }),
			LootboxReward({ rewardItemId = 7439, weight = 200, count = 1 }),
			LootboxReward({ rewardItemId = 3035, weight = 500, count = 10 }),
			LootboxReward({ rewardItemId = 5911, weight = 500, count = 1 }),
			LootboxReward({ rewardItemId = 7440, weight = 500, count = 1 }),
			LootboxReward({ rewardItemId = 16165, weight = 50, count = 1 }),
			LootboxReward({ rewardItemId = 3039, weight = 200, count = 1 }),
			LootboxReward({ rewardItemId = 3043, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 3037, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 3041, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 3038, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 16257, weight = 100, count = 1 }),
			LootboxReward({ rewardItemId = 16254, weight = 101, count = 1 }),
		},
		effect = CONST_ME_CRAPS,
	}),
	LootboxData({
		lootboxId = ItemId.UNREALIZED_DREAM, -- unrealized dream
		rewards = {
			LootboxReward({ rewardItemId = 2995, weight = 288, count = 1 }),
			LootboxReward({ rewardItemId = 5929, weight = 371, count = 1 }),
			LootboxReward({ rewardItemId = 20271, weight = 208, count = 1 }),
			LootboxReward({ rewardItemId = 22516, weight = 219, count = 1 }),
			LootboxReward({ rewardItemId = 20272, weight = 204, count = 1 }),
			LootboxReward({ rewardItemId = 20270, weight = 192, count = 1 }),
			LootboxReward({ rewardItemId = 20062, weight = 431, count = 1 }),
			LootboxReward({ rewardItemId = 7459, weight = 62, count = 1 }),
			LootboxReward({ rewardItemId = 20275, weight = 52, count = 1 }),
			LootboxReward({ rewardItemId = 20273, weight = 52, count = 1 }),
			LootboxReward({ rewardItemId = 3242, weight = 41, count = 1 }),
		},
		effect = CONST_ME_BUBBLES,
	}),
	LootboxData({
		lootboxId = ItemId.SURPRISE_NEST,
		rewards = {
			LootboxReward({ rewardItemId = 6541, weight = 1184, count = 10 }),
			LootboxReward({ rewardItemId = 6542, weight = 1281, count = 10 }),
			LootboxReward({ rewardItemId = 6543, weight = 1235, count = 10 }),
			LootboxReward({ rewardItemId = 6544, weight = 1244, count = 10 }),
			LootboxReward({ rewardItemId = 6545, weight = 1242, count = 10 }),
			LootboxReward({ rewardItemId = 6569, weight = 835, count = 10 }),
			LootboxReward({ rewardItemId = 6574, weight = 798, count = 1 }),
			LootboxReward({ rewardItemId = 4839, weight = 168, count = 1 }),
			LootboxReward({ rewardItemId = 6570, weight = 101, count = 1 }),
			LootboxReward({ rewardItemId = 6571, weight = 63, count = 1 }),
			LootboxReward({ rewardItemId = 3215, weight = 6, count = 1 }),
		},
	}),
	LootboxData({
		lootboxId = ItemId.SURPRISE_BAG_BLUE,
		rewards = {
			LootboxReward({ rewardItemId = 6572, weight = 111, count = 1 }),
			LootboxReward({ rewardItemId = 6569, weight = 105, count = 3 }),
			LootboxReward({ rewardItemId = 6279, weight = 99, count = 1 }),
			LootboxReward({ rewardItemId = 6576, weight = 104, count = 1 }),
			LootboxReward({ rewardItemId = 6393, weight = 95, count = 1 }),
			LootboxReward({ rewardItemId = 2995, weight = 89, count = 1 }),
			LootboxReward({ rewardItemId = 6578, weight = 84, count = 1 }),
			LootboxReward({ rewardItemId = 6574, weight = 79, count = 1 }),
			LootboxReward({ rewardItemId = 3598, weight = 70, count = 10 }),
		},
	}),
	LootboxData({
		lootboxId = ItemId.SURPRISE_BAG_RED,
		rewards = {
			LootboxReward({ rewardItemId = 6576, weight = 3228, count = 1 }),
			LootboxReward({ rewardItemId = 6393, weight = 1411, count = 1 }),
			LootboxReward({ rewardItemId = 6574, weight = 769, count = 1 }),
			LootboxReward({ rewardItemId = 6578, weight = 700, count = 1 }),
			LootboxReward({ rewardItemId = 2995, weight = 347, count = 1 }),
			LootboxReward({ rewardItemId = 3036, weight = 117, count = 1 }),
			LootboxReward({ rewardItemId = 5944, weight = 107, count = 1 }),
			LootboxReward({ rewardItemId = 3039, weight = 24, count = 1 }),
			LootboxReward({ rewardItemId = 2993, weight = 15, count = 1 }),
			LootboxReward({ rewardItemId = 3420, weight = 12, count = 1 }),
			LootboxReward({ rewardItemId = 5080, weight = 13, count = 1 }),
			LootboxReward({ rewardItemId = 3079, weight = 10, count = 1 }),
			LootboxReward({ rewardItemId = 3386, weight = 10, count = 1 }),
			LootboxReward({ rewardItemId = 3392, weight = 8, count = 1 }),
			LootboxReward({ rewardItemId = 3057, weight = 6, count = 1 }),
			LootboxReward({ rewardItemId = 5791, weight = 4, count = 1 }),
		},
	}),
	LootboxData({
		lootboxId = ItemId.SUSPICIOUS_SURPRISE_BAG,
		rewards = {
			LootboxReward({ rewardItemId = NO_REWARD, weight = 249, count = 1 }),
			LootboxReward({ rewardItemId = 2397, weight = 133, count = 1 }),
			LootboxReward({ rewardItemId = 651, weight = 136, count = 1 }),
			LootboxReward({ rewardItemId = 2995, weight = 108, count = 1 }),
			LootboxReward({ rewardItemId = 6574, weight = 62, count = 1 }),
			LootboxReward({ rewardItemId = 6393, weight = 41, count = 1 }),
			LootboxReward({ rewardItemId = 7377, weight = 15, count = 1 }),
			LootboxReward({ rewardItemId = 123, weight = 2, count = 1 }),
			LootboxReward({ rewardItemId = 8778, weight = 1, count = 1 }),
		},
	}),
	LootboxData({
		lootboxId = ItemId.PIRATE_S_SURPRISE,
		rewards = {
			LootboxReward({ rewardItemId = 3581, weight = 74, count = 1 }),
			LootboxReward({ rewardItemId = 3273, weight = 74, count = 1 }),
			LootboxReward({ rewardItemId = 10302, weight = 56, count = 1 }),
			LootboxReward({ rewardItemId = 5928, weight = 52, count = 1 }),
			LootboxReward({ rewardItemId = 9642, weight = 52, count = 1 }),
			LootboxReward({ rewardItemId = 3123, weight = 50, count = 1 }),
			LootboxReward({ rewardItemId = 9205, weight = 8, count = 1 }),
			LootboxReward({ rewardItemId = 6096, weight = 4, count = 1 }),
			LootboxReward({ rewardItemId = 5926, weight = 4, count = 1 }),
			LootboxReward({ rewardItemId = 5917, weight = 2, count = 1 }),
			LootboxReward({ rewardItemId = 6095, weight = 2, count = 1 }),
			LootboxReward({ rewardItemId = 5813, weight = 2, count = 1 }),
			LootboxReward({ rewardItemId = 5461, weight = 1, count = 1 }),
			LootboxReward({ rewardItemId = 6097, weight = 1, count = 1 }),
			LootboxReward({ rewardItemId = 2995, weight = 1, count = 1 }),
			LootboxReward({ rewardItemId = 5918, weight = 1, count = 1 }),
		},
	}),
}
for _, lootboxData in pairs(realLootboxData) do
	LootboxDataRegistry:Add(lootboxData)
end

local lootboxUse = Action()
function lootboxUse.onUse(player, lootbox, fromPosition, target, toPosition, isHotkey)
	local lootboxData = LootboxDataRegistry:Get(lootbox:getId())
	if not lootboxData then
		return true
	end
	if not player:CanAddItems({ lootboxData.maxWeightRewardData, lootboxData.maxWeightRewardData }) then
		return false
	end

	local rewardData = lootboxData:GetRandomReward()
	if rewardData then
		local itemData = { id = rewardData.rewardItemId, count = rewardData.count }
		player:AddCustomItem(itemData)
	else
		player:say("You found nothing useful.", TALKTYPE_MONSTER_SAY)
	end

	if lootboxData.effect then
		lootbox:getPosition():sendMagicEffect(lootboxData.effect)
	end

	lootbox:remove(1)
	return true
end
for lootboxId in pairs(LootboxDataRegistry:GetAll()) do
	lootboxUse:id(lootboxId)
end
lootboxUse:register()
