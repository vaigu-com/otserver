local containersData = {
	{
		containerPosition = Position(33703, 32185, 5),
		rewardItemId = 29993,
	},
	{
		containerPosition = Position(33663, 32192, 7),
		rewardItemId = 30009,
	},
	{
		containerPosition = Position(33671, 32203, 7),
		rewardItemId = 29991,
	},
	{
		containerPosition = Position(33683, 32125, 6),
		rewardItemId = 29989,
	},
	{
		containerPosition = Position(31996, 31981, 13),
		rewardItemId = 30147,
	},
	{
		containerPosition = Position(32017, 31981, 14),
		rewardItemId = 29988,
	},
	{
		containerPosition = Position(32054, 31936, 13),
		rewardItemId = 29990,
	},
	{
		containerPosition = Position(32006, 32002, 14),
		rewardItemId = 29992,
	},
}

local dailyGuaranteedSilverToken = GlobalEvent("InitializeDreamCourtsContainers")
function dailyGuaranteedSilverToken.onStartup()
	for _, containerData in pairs(containersData) do
		local topItem = containerData.containerPosition:GetTopItem()
		if not topItem then
			logger.warn("[InitializeDreamCourtsContainers] top item not found at " .. containerData.containerPosition:ToString())
		end
		local key = containerData.containerPosition:ToString()

		topItem:setKey(key)
		local containerUse = Action()
		function containerUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			player:AddCustomItem({ id = containerData.rewardItemId })
			return true
		end
		containerUse:key(key)
		containerUse:register()
	end
end
dailyGuaranteedSilverToken:register()
