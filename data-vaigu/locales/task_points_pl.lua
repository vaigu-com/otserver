return {
	["YOU_CURRENTLY_HAVE_N_TASK_POINTS"] = function(context)
		local points = context.player:getStorageValue(Storage.taskPoints)
		return T("Aktualnie posiadasz :points: punktow taskow.  Mozesz wymienic je na kilka {trofeow}, {wierzchowca} oraz {mozliwosc} nasycania na najwyzszy poziom.", { points = points })
	end,
	["THIS_TROPHY_WILL_COST_YOU_N"] = function(context)
		return T("Ktore chcial bys zakupic? Kosztowac cie to bedzie :cost: punktow taskow: {bronze hunter trophy}, {silver hunter trophy}, {gold hunter trophy}, {gozzler trophy}, {hellflayer trophy} oraz {sea serpent doll}.", { cost = context.keywordConfig.cost })
	end,
	["YOU_WANT_TO_BUY_TROHPY_NAME"] = function(context)
		return T("Czy chcesz kupic :name: za :cost: punktow taskowych?", { name = context.msg:lower(), cost = context.keywordConfig.cost })
	end,
	["YOU_DONT_HAVE_ENOUGH_TASK_POINTS"] = function(context)
		local current = context.player:getStorageValue(Storage.taskPoints)
		local required = context.keywordConfig.cost or PlayerCustomDialogDataRegistry():Get(context.player).requiredTaskPoints
		local diff = required - current
		return T("Nie posiadasz odpowiedniej liczby punktow taskowych. Potrzebuejsz :required: punktow aby to kupic. Posiadasz :current: punktow, co oznacza, ze potrzebuejesz jeszcze :diff: punktow.", { current = current, required = required, diff = diff })
	end,
	["YOU_WANT_TO_BUY_ANTELOPE"] = function(context)
		return T("Czy chcesz wymienic :cost: punktow taskowych na na wierzchowca Antelope?", { cost = context.keywordConfig.cost })
	end,
	["LIST_IMBUING_NAMES"] = function()
		local translatedString = "Sprzedaje paczki z produktami, ktore umozliwiaja dokonanie nasycenia. Oto oferowane przeze rodzaje:"

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
		local bundleData = PlayerCustomDialogDataRegistry():Get(context.player).bundleData
		local imbuementName = bundleData.name
		return T("Jakim poziomem nasycenia :imbuementName: jestes zainteresowany : {basic}, {intricate}, {powerful}?", { imbuementName = imbuementName })
	end,
	["YOU_SELECTED_IMBUING_LEVEL"] = function(context)
		local bundleLevelData = PlayerCustomDialogDataRegistry():Get(context.player).bundleLevelData
		local levelName = bundleLevelData.levelName
		local imbuementName = bundleLevelData.name
		local moneyCost = bundleLevelData.moneyCost
		local taskPointsCost = bundleLevelData.taskPointsCost
		local message = T("Czy chcesz kupic :levelName: :imbuementName: za :moneyCost: zlota oraz :taskPointsCost: punktow taskowych?\nTa pazcka zawiera:", {
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
		return T("Czy chcesz kupic mozliwosc nasycania najwyzszego poziomu (powerful) za :cost: punktow taskowych?", { cost = context.keywordConfig.cost })
	end,
	["You already have this mount."] = "Juz posiadasz tego wierzchowca.",
	["I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}."] = "Posiadam paczki creature productow na kazdy z {imbuingow}. Kosztowac cie to bedzie troche zlota oraz {punktow}.",
	["You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues."] = "Nie posiadasz zadnych punktow. Otrzymasz je po wykonaniu ktoregos z taskow lub zadan z tablicy. Mozesz wymienic je na kilka {trofeow}, {wierzchowca} oraz {mozliwosc} nasycania na najwyzszy poziom.",
	["You already got it."] = "Juz to kupiles.",
	["Do you want to buy ability to make powerful imbues?"] = "Chcesz zakupic mozliwosc nasycania na najwyzszy trzeci poziom?",
	["You don't yet have the {ability} to buy this level of bundle yet."] = "Nie mozesz jeszcze nasycac tego poziomu. Zapytaj mnie o {mozliwosc} nasycania, to powiem ci co i jak.",
	["You dont have enough cap or slots for these items."] = "Nie masz miejsca w plecaku, albo nie bedziesz w stanie udzwignac tych przedmiotow.",
}
