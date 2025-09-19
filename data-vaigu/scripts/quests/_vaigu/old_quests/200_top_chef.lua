local quest = Quest(LOCALIZERS.TopChef)

local function saidDishName(context)
	local msg = context.msg
	return COOKING_DISH_NAMES[msg:lower()] ~= nil
end

local function getPlayerCurrentDish(player)
	local state = player:getStorageValueByKey(Storage.TopChef.Mission01)
	local dishData = COOKING_INGREDIENT_DATA[state] or PlayerCustomDialogDataRegistry:Get(player).dishData
	return dishData
end

local function canRemoveIngredients(context)
	local player = context.player
	local dishData = getPlayerCurrentDish(player)
	if not dishData then
		return false
	end
	return player:HasItems(dishData.items)
end

local function canAddDish(context)
	local player = context.player
	local dishData = getPlayerCurrentDish(player)
	if not dishData then
		return false
	end
	return player:CanAddItems({ { id = ItemType(dishData.dishName):getId() } })
end

local function removeIngredients(context)
	local player = context.player
	local dishData = getPlayerCurrentDish(player)
	if not dishData then
		return false
	end
	player:RemoveItems(dishData.items)
end

local function addDish(context)
	local player = context.player
	local dishData = getPlayerCurrentDish(player)
	if not dishData then
		return false
	end
	player:AddItems({ { id = ItemType(dishData.dishName):getId() } })
end

local function grantExpForDish(context)
	local player = context.player
	local questState = player:getStorageValueByKey(Storage.TopChef.Mission01)
	local nextState = math.max(questState, 0) + 1

	local grantedExp = 100000 * 1.3 ^ nextState
	AddExperienceWithAnnouncement(player, grantedExp)
end

quest
	:Storage(function()
		Storage.TopChef = {
			Mission01 = {},
			CanMakeAllDishes = {},
			MeadVial = {},
		}
		QuestState.TopChef = {
			RotwormStew = 1,
			HydraTongueSalad = 2,
			RoastedDragonWings = 3,
			TropicalFriedTerrorbird = 4,
			BananaChocolateShake = 5,
			VeggieCasserole = 6,
			FilledJalapenoPeppers = 7,
			BlessedSteak = 8,
			NorthernFishburger = 9,
			CarrotCake = 10,
			CoconutShrimpBake = 11,
			PotofBlackjack = 12,
			DemonicCandyBall = 13,
			SweetMangonaiseElixir = 14,

			FinishedCourse_AskForBook = 15,
			CanMakeAllDishes = MISSION_FINISHED,
		}
		QuestTopics.TopChef = {
			AskedForKitchen = NextTopic(),
			AcceptStartOfYourTraining = NextTopic(),
			AskedForRecipe = NextTopic(),
			ConfirmMakingAnyDish = NextTopic(),
		}
	end)
	:Constant(function()
		COOKING_INGREDIENT_DATA = {
			[QuestState.TopChef.RotwormStew] = { dishName = "Rotworm Stew", items = { { id = 3577, count = 2 }, { id = 8010, count = 20 }, { id = 8015, count = 1 }, { id = 8197, count = 1 }, { id = 3603, count = 5 }, { id = 2874, count = 2, fluidType = 3 } } },
			[QuestState.TopChef.HydraTongueSalad] = { dishName = "Hydra Tongue Salad", items = { { id = 7250, count = 2 }, { id = 3596, count = 2 }, { id = 8014, count = 1 }, { id = 3606, count = 2 }, { id = 3741, count = 1 }, { id = 2874, count = 1, fluidType = 2 } } },
			[QuestState.TopChef.RoastedDragonWings] = { dishName = "Roasted Dragon Wings", items = { { id = 4363, count = 1 }, { id = 8016, count = 3 }, { id = 3602, count = 5 }, { id = 3606, count = 2 }, { id = 3739, count = 1 }, { id = 3724, count = 5 } } },
			[QuestState.TopChef.TropicalFriedTerrorbird] = { dishName = "Tropical Fried Terrorbird", items = { { id = 4330, count = 1 }, { id = 8013, count = 2 }, { id = 3586, count = 2 }, { id = 5096, count = 2 }, { id = 2874, count = 2, fluidType = 15 }, { id = 3735, count = 1 } } },
			[QuestState.TopChef.BananaChocolateShake] = { dishName = "Banana Chocolate Shake", items = { { id = 6574, count = 1 }, { id = 6393, count = 1 }, { id = 3587, count = 2 }, { id = 2874, count = 2, fluidType = 9 }, { id = 3738, count = 1 }, { id = 3736, count = 1 } } },
			[QuestState.TopChef.VeggieCasserole] = { dishName = "Veggie Casserole", items = { { id = 3595, count = 2 }, { id = 3596, count = 2 }, { id = 3597, count = 2 }, { id = 8014, count = 2 }, { id = 8015, count = 1 }, { id = 8197, count = 1 }, { id = 3607, count = 1 }, { id = 3723, count = 20 }, { id = 3725, count = 5 } } },
			[QuestState.TopChef.FilledJalapenoPeppers] = { dishName = "Filled Jalapeno Peppers", items = { { id = 8016, count = 10 }, { id = 3607, count = 2 }, { id = 3741, count = 1 }, { id = 3740, count = 1 }, { id = 7141, count = 1 }, { id = 3606, count = 2 } } },
			[QuestState.TopChef.BlessedSteak] = { dishName = "Blessed Steak", items = { { id = 3582, count = 1 }, { id = 8011, count = 5 }, { id = 8015, count = 1 }, { id = 8017, count = 2 }, { id = 3594, count = 1 }, { id = 8016, count = 2 } } },
			[QuestState.TopChef.NorthernFishburger] = { dishName = "Northern Fishburger", items = { { id = 3580, count = 1 }, { id = 7158, count = 1 }, { id = 7159, count = 1 }, { id = 3581, count = 5 }, { id = 3601, count = 2 }, { id = 3737, count = 1 } } },
			[QuestState.TopChef.CarrotCake] = { dishName = "Carrot Cake", items = { { id = 3595, count = 5 }, { id = 2874, count = 1, fluidType = 9 }, { id = 8013, count = 1 }, { id = 3603, count = 10 }, { id = 3606, count = 2 }, { id = 3598, count = 10 }, { id = 841, count = 2 } } },
			[QuestState.TopChef.CoconutShrimpBake] = { dishName = "Coconut Shrimp Bake", items = { { id = 2874, count = 5, fluidType = 15 }, { id = 3725, count = 5 }, { id = 3724, count = 5 }, { id = 10329, count = 10 }, { id = 3581, count = 10 } } },
			[QuestState.TopChef.PotofBlackjack] = { dishName = "Pot of Blackjack", items = { { id = 10456, count = 5 }, { id = 2874, count = 2, fluidType = 1 }, { id = 3595, count = 20 }, { id = 8010, count = 10 }, { id = 8016, count = 3 } } },
			[QuestState.TopChef.DemonicCandyBall] = { dishName = "Demonic Candy Ball", items = { { id = 6569, count = 3 }, { id = 3599, count = 3 }, { id = 6574, count = 2 }, { id = 6500, count = 15 }, { id = 6558, count = 1 } } },
			[QuestState.TopChef.SweetMangonaiseElixir] = { dishName = "Sweet Mangonaise Elixir", items = { { id = 3606, count = 40 }, { id = 5096, count = 20 }, { id = 5902, count = 10 }, { id = 8758, count = 1 }, { id = 5942, count = 1 } } },
		}

		COOKING_DISH_NAMES = {}

		FLUID_ENUM_TO_NAME = {
			[FLUID_NONE] = "void",
			[FLUID_WATER] = "water",
			[FLUID_WINE] = "wine",
			[FLUID_BEER] = "beer",
			[FLUID_MUD] = "mud",
			[FLUID_BLOOD] = "blood",
			[FLUID_SLIME] = "slime",
			[FLUID_OIL] = "oil",
			[FLUID_URINE] = "urine",
			[FLUID_MILK] = "milk",
			[FLUID_MANA] = "mana",
			[FLUID_LIFE] = "life",
			[FLUID_LEMONADE] = "lemonade",
			[FLUID_RUM] = "rum",
			[FLUID_FRUITJUICE] = "fruit juice",
			[FLUID_COCONUTMILK] = "coconut milk",
			[FLUID_MEAD] = "mead",
			[FLUID_TEA] = "tea",
		}

		LAST_TOP_CHEF_DISH_INDEX = QuestState.TopChef.SweetMangonaiseElixir
		LAST_TOP_CHEF_STATE = 16 --ehh

		local ingredientStrings = {
			[QuestState.TopChef.RotwormStew] = "",
			[QuestState.TopChef.HydraTongueSalad] = "",
			[QuestState.TopChef.RoastedDragonWings] = "",
			[QuestState.TopChef.TropicalFriedTerrorbird] = "",
			[QuestState.TopChef.BananaChocolateShake] = "",
			[QuestState.TopChef.VeggieCasserole] = "",
			[QuestState.TopChef.FilledJalapenoPeppers] = "",
			[QuestState.TopChef.BlessedSteak] = "",
			[QuestState.TopChef.NorthernFishburger] = "",
			[QuestState.TopChef.CarrotCake] = "",
			[QuestState.TopChef.CoconutShrimpBake] = "",
			[QuestState.TopChef.PotofBlackjack] = "",
			[QuestState.TopChef.DemonicCandyBall] = "",
			[QuestState.TopChef.SweetMangonaiseElixir] = "",
		}

		function IngredientsToString(dishData)
			return ingredientStrings[dishData.storage]
		end

		local cookBook = Action()
		function cookBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local fullText = {}
			for _, dishText in pairs(ingredientStrings) do
				table.insert(fullText, dishText)
			end
			player:showTextDialog(item.itemid, table.concat(fullText))
			return true
		end
		cookBook:id(9093)
		cookBook:register()

		local function generateCookingAuxillaryData()
			for storage, dishData in pairs(COOKING_INGREDIENT_DATA) do
				local requiredItemsString = ""
				for _, item in pairs(dishData.items) do
					local id = item.id
					local count = item.count
					local name = ItemType(id):getName()
					requiredItemsString = requiredItemsString .. T("\n:count: :name:", { name = name, count = count })

					local fluidType = item.fluidType
					local fluidName = FLUID_ENUM_TO_NAME[fluidType]
					if fluidType then
						requiredItemsString = requiredItemsString .. T(" of :fluidName:", { fluidName = fluidName })
					end
				end
				ingredientStrings[storage] = requiredItemsString
				COOKING_INGREDIENT_DATA[storage].storage = storage
				COOKING_DISH_NAMES[dishData.dishName] = storage
				COOKING_DISH_NAMES[dishData.dishName:lower()] = storage
			end
		end
		local cooking = GlobalEvent("generateCookingAuxillaryData")
		function cooking.onStartup()
			generateCookingAuxillaryData()
		end
		cooking:register()
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Top Chef",
			localizer = localizer,
			missions = {
				{
					name = "Top Chef",
					storage = Storage.TopChef.Mission01,
					states = {
						[QuestState.TopChef.RotwormStew] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.HydraTongueSalad] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.RoastedDragonWings] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.TropicalFriedTerrorbird] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.BananaChocolateShake] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.VeggieCasserole] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.FilledJalapenoPeppers] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.BlessedSteak] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.NorthernFishburger] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.CarrotCake] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.CoconutShrimpBake] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.PotofBlackjack] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.DemonicCandyBall] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.SweetMangonaiseElixir] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.FinishedCourse_AskForBook] = "You finished the cooking course. Ask Pewter for your next directions.",
						[QuestState.TopChef.CanMakeAllDishes] = "Pewter provided you with his cookbooks and you can craft any food now.",
					},
				},
			},
		})
	end)
	:Mission(Storage.TopChef.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Script(function()
				local cooldownSeconds = 22 * 3600
				local meadHorn = Action()
				function meadHorn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if target.uid == 8000 and item.itemid == 7140 then
						if player:getStorageValueByKey(Storage.MeadVial) >= os.time() then
							player:say("Ehh, its been emptied already.", TALKTYPE_MONSTER_SAY)
							return false
						end

						item:remove()
						player:AddCustomItem({ id = 7141 })
						player:setStorageValueByKey(Storage.MeadVial, os.time() + cooldownSeconds)
						toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
					end
					return true
				end
				meadHorn:id(7140)
				meadHorn:register()
			end),
			QuestFactory.Dialog("Pewter", {
				[{ GREET }] = {
					text = "Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?",
				},
				[{ "cook", "kuchnia", "kucharz", "kuchni", "kitchen", "yes", "tak" }] = {
					text = "Im cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. ",
					nextTopic = QuestTopics.TopChef.AskedForKitchen,
				},
				[{ "recipe", "recipes", "menu", "przepis", "przepisami" }] = {
					text = "Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you {sign} up for this?",
					requiredTopic = QuestTopics.TopChef.AskedForKitchen,
					nextTopic = QuestTopics.TopChef.AcceptStartOfYourTraining,
				},
				[{ "sign", "piszesz" }] = {
					text = "Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them.",
					nextState = { [Storage.TopChef.Mission01] = QuestState.TopChef.RotwormStew },
					requiredTopic = QuestTopics.TopChef.AcceptStartOfYourTraining,
				},
			})
	end)
	:State(function()
		return { min = QuestState.TopChef.RotwormStew, max = QuestState.TopChef.SweetMangonaiseElixir },
			QuestFactory.Dialog("Pewter", {
				[{ "recipe", "menu", "przepis", "przepisami", "mission" }] = {
					text = "DESCRIBE_CURRENT_DISH",
				},
				[{ GREET }] = {
					text = "HAVE_YOU_PREPARED_INGREDIENTS_FOR_CURRENT_DISH",
				},
				[{ "yes", "tak", "przyrzadzic", "done" }] = {
					text = "Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish.",
					specialRequirements = {
						{
							requirement = canRemoveIngredients,
							requiredOutcome = true,
							textFailedRequirement = "Make sure you have all the required ingredients.",
						},
						{
							requirement = canAddDish,
							requiredOutcome = true,
							textFailedRequirement = "You dont have either cap or bags slots for this dish.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = removeIngredients,
						},
						{
							action = addDish,
						},
						{
							action = grantExpForDish,
						},
					},
					nextState = { [Storage.TopChef.Mission01] = "+1" },
				},
				[{ "no", "nie" }] = {
					text = "Come back when you are ready.",
				},
			})
	end)
	:State(function()
		return QuestState.TopChef.FinishedCourse_AskForBook,
			QuestFactory.Dialog("Pewter", {
				[{ ANY_MESSAGE }] = {
					text = "Congratulations, you finished my training program. These are my books on cooking. Please, take them.",
					rewards = { { id = 11541 }, { id = 9093 } },
					nextState = {
						[Storage.TopChef.Mission01] = Storage.TopChef.CanMakeAllDishes,
						[Storage.Finished.TopChef] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.TopChef.CanMakeAllDishes,
			QuestFactory.Dialog("Pewter", {
				[{ GREET }] = {
					text = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Now that you are a professional chef, what dish would you like to prepare now?",
				},
				[{ ANY_MESSAGE }] = {
					text = "Do you have all the necessary ingredients?",
					specialRequirements = {
						{
							requirement = saidDishName,
							requiredOutcome = true,
							textFailedRequirement = "Just tell me any dish name from the recipe books.",
						},
					},
					specialActionsOnSuccess = {
						{ action = SPECIAL_ACTIONS_COOK.setDishData },
					},
					nextTopic = QuestTopics.TopChef.ConfirmMakingAnyDish,
				},
				[{ "yes", "tak" }] = {
					text = "Lets begin then!\nBit of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish!",
					specialRequirements = {
						{
							requirement = canRemoveIngredients,
							requiredOutcome = true,
							textFailedRequirement = "Make sure you have all the required ingredients.",
						},
						{
							requirement = canAddDish,
							requiredOutcome = true,
							textFailedRequirement = "You dont have either cap or bags slots for this dish.",
						},
					},
					specialActionsOnSuccess = {
						{
							action = removeIngredients,
						},
						{
							action = addDish,
						},
					},
					requiredTopic = QuestTopics.TopChef.ConfirmMakingAnyDish,
				},
			})
	end)
	:Register()
