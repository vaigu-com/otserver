return {
	["YOU_CURRENTLY_HAVE_N_TASK_POINTS"] = function(context)
		local points = context.player:getStorageValue(Storage.taskPoints)
		return T("Currently you have :points: task points. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues.", { points = points })
	end,
	["WOULD_YOU_LIKE_TO_BUY_ANY_TROPHY"] = function(context)
		return T("Which one would you like to buy? It will cost you 25 task points: {bronze hunter trophy}, {silver hunter trophy}, {gold hunter trophy}, {gozzler trophy}, {hellflayer trophy} and {sea serpent doll}.", { cost = context.keywordConfig.cost })
	end,
	["YOU_WANT_TO_BUY_TROHPY_NAME"] = function(context)
		return T("Would you like to buy :name: for :cost: Task Poins?", { name = context.msg:lower(), cost = context.keywordConfig.cost })
	end,
	["YOU_DONT_HAVE_ENOUGH_TASK_POINTS"] = function(context)
		local current = context.player:getStorageValue(Storage.taskPoints)
		local required = context.keywordConfig.cost or PlayerCustomDialogDataRegistry:Get(context.player).requiredTaskPoints
		local diff = required - current
		return T("You dont have enough points. You need :required: points to buy that. You currently have :current: points meaning you need to accumulate :diff: more points.", { current = current, required = required, diff = diff })
	end,
	["YOU_WANT_TO_BUY_ANTELOPE"] = function(context)
		return T("Do you want to exchange :cost: points for Antelope mount?", { cost = context.keywordConfig.cost })
	end,
	["LIST_IMBUING_NAMES"] = function()
		local translatedString = "I can sell creature product bundles for the following imbuings:"

		local categories = GetImbuingCategories()
		for _, category in pairs(categories) do
			translatedString = translatedString .. T("\n:categoryName:: ", { categoryName = category.categoryName })
			for _, imbuementName in pairs(category.imbuements) do
				translatedString = translatedString .. T("{:imbuementName:}, ", { imbuementName = imbuementName })
			end
		end
		translatedString = string.sub(translatedString, 1, -3) .. "."
		return translatedString
	end,
	["YOU_SELECTED_IMBUING_NAME"] = function(context)
		local bundleData = PlayerCustomDialogDataRegistry:Get(context.player).bundleData
		local imbuementName = bundleData.name
		return T("What level of :imbuementName: imbuement are you interested in: {basic}, {intricate}, {powerful}?", { imbuementName = imbuementName })
	end,
	["YOU_SELECTED_IMBUING_LEVEL"] = function(context)
		local bundleLevelData = PlayerCustomDialogDataRegistry:Get(context.player).bundleLevelData
		local levelName = bundleLevelData.levelName
		local imbuementName = bundleLevelData.name
		local moneyCost = bundleLevelData.moneyCost
		local taskPointsCost = bundleLevelData.taskPointsCost
		local message = T("Do you want to buy :levelName: :imbuementName: for :moneyCost: gold and :taskPointsCost: task points?\nThis bundle contains:", {
			levelName = levelName,
			imbuementName = imbuementName,
			moneyCost = moneyCost,
			taskPointsCost = taskPointsCost,
		})
		for _, item in pairs(bundleLevelData.items) do
			local itemName = ItemType(item.id):getName()
			local count = item.count
			message = message .. T("\n:count: :itemName:", { itemName = itemName, count = count })
		end
		return message
	end,
	["YOU_WANT_BUY_ABILITY_POWEFUL_IMBUEMENT"] = function(context)
		return T("Do you want to buy ability to make powerful imbues? It's gonna cost you :cost: task points.", { cost = context.keywordConfig.cost })
	end,
	["You already have this mount."] = "You already have this mount.",
	["I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}."] = "I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}.",
	["You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues."] = "You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues.",
	["You already got it."] = "You already got it.",
	["Do you want to buy ability to make powerful imbues?"] = "Do you want to buy ability to make powerful imbues?",
	["You don't yet have the {ability} to buy this level of bundle yet."] = "You don't yet have the {ability} to buy this level of bundle yet.",
	["You dont have enough cap or slots for these items."] = "You dont have enough cap or slots for these items.",
}
