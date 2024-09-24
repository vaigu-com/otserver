local internalNpcName = "Pewter"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 146,
	lookHead = 95,
	lookBody = 97,
	lookLegs = 95,
	lookFeet = 116,
	lookAddons = 1,
}

npcConfig.flags = { floorchange = 0 }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function saidDishName(context)
	local msg = context.msg
	return COOKING_DISH_NAMES[msg:lower()] ~= nil
end

local function getPlayerCurrentDish(player)
	local state = player:getStorageValue(Storage.TopChef.Questline)
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

local topics = {
	askedForKitchen = 1,
	confirmingTrainingStart = 2,
	askedForRecipe = 3,
	confirmMakingAnyDish = 4,
}

local dialogs = {
	[LOCALIZER_UNIVERSAL] = {
		[GREET] = {
			text = "Hello, welcome to my {kitchen} again, |PLAYERNAME|! Did you visit me again to be taught cooking skills by the best chef around? Ask me for a {recipe} if you wish to continue your training.",
		},
		[{ "bug milk" }] = {
			text = "My friend from this village can provide you wih it.",
		},
		[{ "coconut milk" }] = {
			text = "You have to squeeze a coconut to extract its milk.",
		},
		[{ "mead" }] = {
			text = "Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels.",
		},
		[{ "hydra tongue" }] = {
			text = "You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside.",
		},
		[{ "kulka ryzowa", "rice ball" }] = {
			text = "My friend Namir can prepare those for you.",
		},
		[{ "ksiazka kucharska", "cookbook" }] = {
			text = "Every professional chef writes their own book with their best recipes.",
		},
		["WALKAWAY"] = { text = "Hope you will come again, |PLAYERNAME|" },
	},
	[Storage.TopChef.Questline] = {
		[-1] = {
			[{ GREET }] = {
				text = "Hello and welcome to my {kitchen}. What are you looking for, |PLAYERNAME|? Perhaps this beautiful aroma lured you there?",
			},
			[{ "cook", "kuchnia", "kucharz", "kuchni", "kitchen" }] = {
				text = "I cooking and experimenting with new dishes. I work at an Italian restaurant as a head chef, where i devote myself to this passion.\nI love sharing my {recipes}, so i invite you to experiment abit under my supervision. ",
				nextTopic = topics.askedForKitchen,
			},
			[{ "recipe", "recipes", "menu", "przepis", "przepisami" }] = {
				text = "Are you intereseted? Well, no doubt, you can't buy they anywhere. However I can guide you become a cooking pro. Do you sign up for this?",
				requiredTopic = {
					min = topics.askedForKitchen,
					max = topics.askedForKitchen,
				},
				nextTopic = topics.confirmingTrainingStart,
			},
			[{ "yes", "tak" }] = {
				text = "Well, you look promising. Ask me for a {recipe}, and i will try to provide you with all necessary infomration. Some ingredients are tougher to find than others, so you might wanna ask me about where to find them.",
				nextState = { [Storage.TopChef.Questline] = 1 },
				requiredTopic = {
					min = topics.confirmingTrainingStart,
					max = topics.confirmingTrainingStart,
				},
				nextTopic = 0,
			},
		},
		[{ min = 1, max = LAST_TOP_CHEF_DISH_INDEX }] = {
			[{ "recipe", "menu", "przepis", "przepisami", "mission" }] = {
				text = "DESCRIBE_CURRENT_DISH",
				nextTopic = topics.askedForRecipe,
			},
			[{ ANY_MESSAGE }] = {
				text = "HAVE_YOU_PREPARED_INGREDIENTS_FOR_CURRENT_DISH",
				nextTopic = topics.askedForRecipe,
			},
			[{ "yes", "tak" }] = {
				text = "Lets begin then!\nA sprinkle of this.. Mince that.. Add this..\nHere it is!\nI think it was all clear. There is your dish! Ask me for {recipe} if you are ready to prepare the next dish.",
				requiredTopic = {
					min = topics.askedForRecipe,
					max = topics.askedForRecipe,
				},
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
				nextState = { [Storage.TopChef.Questline] = "+1" },
			},
			[{ "no", "nie" }] = {
				text = "Come back when you are ready.",
				requiredTopic = {
					min = topics.askedForRecipe,
					max = topics.askedForRecipe,
				},
			},
		},
		[{ min = LAST_TOP_CHEF_DISH_INDEX + 1, max = LAST_TOP_CHEF_STATE - 1 }] = {
			[{ ANY_MESSAGE }] = {
				text = "Congratulations, you finished my training program. These are my books on cooking. Please, take them.",
				rewards = { { id = 11541 }, { id = 9093 } },
				nextState = {
					[Storage.TopChef.Questline] = "+1",
					[Storage.TopChef.CanMakeAllDishes] = 1,
					[Storage.Finished.MistrzKuchni] = 1,
				},
			},
		},
	},
	[Storage.TopChef.CanMakeAllDishes] = {
		[{ min = 1 }] = {
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
				nextTopic = topics.confirmMakingAnyDish,
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
				nextTopic = 0,
				requiredTopic = {
					min = topics.confirmMakingAnyDish,
					max = topics.confirmMakingAnyDish,
				},
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialog, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, dialog, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
