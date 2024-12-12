local quest = Quest(LOCALIZERS.TopChef)

local function saidDishName(context)
	local msg = context.msg
	return COOKING_DISH_NAMES[msg:lower()] ~= nil
end

local function getPlayerCurrentDish(player)
	local state = player:getStorageValue(Storage.TopChef.State)
	local dishData = COOKING_INGREDIENT_DATA[state] or PlayerCustomDialogDataRegistry():Get(player).dishData
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

quest
	:Storage(function()
		Storage.TopChef = {
			State = NextStorage(),
			CanMakeAllDishes = NextStorage(),
		}
		QuestState.TopChef = {
			TakingCourse = 1,
			FinishedCourse_AskForBook = 2,
			CanMakeAllDishes = MISSION_FINISHED,
		}
		QuestTopics.TopChef = {
			AskedForKitchen = NextTopic(),
			AcceptStartOfYourTraining = NextTopic(),
			AskedForRecipe = NextTopic(),
			ConfirmMakingAnyDish = NextTopic(),
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Top Chef",
			missions = {
				[Storage.TopChef.State] = {
					name = "Top Chef",
					states = {
						[QuestState.TopChef.TakingCourse] = "TOP_CHEF_COURSE_DESCRIPTION",
						[QuestState.TopChef.FinishedCourse_AskForBook] = "You finished the cooking course. Ask Pewter for your next directions.",
						[QuestState.TopChef.CanMakeAllDishes] = "Pewter provided you with his cookbooks and you can craft any food now.",
					},
				},
			},
		}
	end)
	:Mission(PH_MISSION)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Pewter", {
			[{ GREET }] = {
				text = "Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?",
			},
			[{ "cook", "kuchnia", "kucharz", "kuchni", "kitchen" }] = {
				text = "I cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. ",
				nextTopic = QuestTopics.TopChef.AskedForKitchen,
			},
			[{ "recipe", "recipes", "menu", "przepis", "przepisami" }] = {
				text = "Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you sign up for this?",
				requiredTopic = QuestTopics.TopChef.AskedForKitchen,
				nextTopic = QuestTopics.TopChef.AcceptStartOfYourTraining,
			},
			[{ "yes", "tak" }] = {
				text = "Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them.",
				nextState = { [Storage.TopChef.State] = 1 },
				requiredTopic = QuestTopics.TopChef.AcceptStartOfYourTraining,
			},
		})
	)
	:State(
		{ min = QuestState.TopChef.RotwormStew, max = QuestState.TopChef.SweetMangonaiseElixir },
		QuestFactory.Dialog("Pewter", {
			[{ "recipe", "menu", "przepis", "przepisami", "mission" }] = {
				text = "DESCRIBE_CURRENT_DISH",
				nextTopic = QuestTopics.TopChef.AskedForRecipe,
			},
			[{ GREET }] = {
				text = "HAVE_YOU_PREPARED_INGREDIENTS_FOR_CURRENT_DISH",
				nextTopic = QuestTopics.TopChef.AskedForRecipe,
			},
			[{ "yes", "tak" }] = {
				text = "Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish.",
				requiredTopic = QuestTopics.TopChef.AskedForRecipe,
				specialConditions = {
					{
						condition = canRemoveIngredients,
						requiredOutcome = true,
						textNoRequiredCondition = "Make sure you have all the required ingredients.",
					},
					{
						condition = canAddDish,
						requiredOutcome = true,
						textNoRequiredCondition = "You dont have either cap or bags slots for this dish.",
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
				nextState = { [Storage.TopChef.State] = "+1" },
			},
			[{ "no", "nie" }] = {
				text = "Come back when you are ready.",
				requiredTopic = QuestTopics.TopChef.AskedForRecipe,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Pewter", {
			[{ ANY_MESSAGE }] = {
				text = "Congratulations, you finished my training program. These are my books on cooking. Please, take them.",
				rewards = { { id = 11541 }, { id = 9093 } },
				nextState = {
					[Storage.TopChef.State] = Storage.TopChef.CanMakeAllDishes,
					[Storage.Finished.MistrzKuchni] = 1,
				},
			},
		})
	)
	:State(
		QuestState.TopChef.CanMakeAllDishes,
		QuestFactory.Dialog("Pewter", {
			[{ GREET }] = {
				text = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Now that you are a professional chef, what dish would you like to prepare now?",
			},
			[{ ANY_MESSAGE }] = {
				text = "Do you have all the necessary ingredients?",
				specialConditions = {
					{
						condition = saidDishName,
						requiredOutcome = true,
						textNoRequiredCondition = "Just tell me any dish name from the recipe books.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_COOK.setDishData },
				},
				nextTopic = QuestTopics.TopChef.ConfirmMakingAnyDish,
			},
			[{ "yes", "tak" }] = {
				text = "Lets begin then!\nBit of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish!",
				specialConditions = {
					{
						condition = canRemoveIngredients,
						requiredOutcome = true,
						textNoRequiredCondition = "Make sure you have all the required ingredients.",
					},
					{
						condition = canAddDish,
						requiredOutcome = true,
						textNoRequiredCondition = "You dont have either cap or bags slots for this dish.",
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
	)
