-- Terminology:
--  processing: The npc system is going through the npc dialogs and determines if player meets the requirements for a dialog
--  discarded: A dialog processing has been cancelled and another dialog will be processed. This means that player doesnt meet requirements for this dialog and there was no corresponding error message.
--  resolved: A dialog has been processed and no other dialog will be processed. This means the npc will say some text corresponding to this dialog (fail or success dialog)
--   resolved-success: Npc will say text that is supposed to be shown on success for this dialog. Actions on success (eg. rewards, special effects) will all be perfomed for this dialog
--   resolved-fail: Npc will say text that corresponds to the first failed requirement. Failing requirement withouh text on fail isnt resolved-fail, but discarded. Actions on success wont be performed for this dialog

local function exampleDialog(text, requiredTopic, requiredItems, removeRequiredItems, textNoRequiredItems, requiredState, requiredGlobalState, specialRequirements, requiredMoney, specialActionsOnSucess, rewards, spawnMonstersOnSuccess, outfitRewards, mountRewards, expReward, nextState, nextGlobalState, nextTopic, addDialogData)
	-- Important note: all text in dialogs (text on no required items, text on success, text on no required state etc.) is not conidered final text, but an identifier for the localizer.
	-- This means that all text will be translated based on player language and other context.
	-- sample locales file
	-- data-vaigu/locales/en/moneyquest.lua
	--[[
	return { 
		["WOULD_YOU_LIKE_TO_WITHDRAW"] = function(context)
			return T("Would you like to withdraw :amount:?", { amount = context.amount })
		end,
		["YOU_WITHDREW_MONEY"] = function(context)
			return T("Would you like to withdraw :amount:?", { amount = context.lastMessageData.amount })
		end,
	}
	]]

	---requiredTopic
	-- Topic required to resolve this dialog.
	-- Int:
	--	min = argument, Default: nil
	--  max = argument, Default: nil
	-- Table:
	--  min = argument.min, Default: 0
	--  max = argument.max, Default: 2^15
	-- General example:
	-- range
	requiredTopic = { min = JOB_TOPICS.someTopic, max = JOB_TOPICS.someOtherTopic }
	-- gte
	requiredTopic = { min = JOB_TOPICS.someTopic }
	-- lte
	requiredTopic = { max = JOB_TOPICS.someTopic }
	-- eq
	requiredTopic = QuestTopics.JOB_TOPICS.someTopic
	-- eq (alternative notation)
	requiredTopic = { min = JOB_TOPICS.someTopic, max = JOB_TOPICS.someTopic }
	-- Only use them to differentiate dialog paths. eg.: if you have more than two dialogs that have "yes" as keyword, then you should differentiate them using requiredState (most cases) or you can use requiredTopic
	-- Examples:
	local topics = {
		confirmBuyingCake = 1,
		confirmBuyingBread = 2,
	}
	local customDialogs = {
		[{ "cake" }] = {
			text = "Would you like to buy a cake?",
			nextTopic = topics.confirmBuyingCake,
		},
		[{ "bread" }] = {
			text = "Would you like to buy a bread?",
			nextTopic = topics.confirmBuyingBread,
		},
		[{ "yes" }] = {
			text = "Here you go",
			requiredMoney = 6,
			requiredTopic = topics.confirmBuyingCake,
			rewards = {
				{ id = 777 },
			},
		},
		[{ "yes" }] = {
			text = "Here you go",
			requiredMoney = 6,
			requiredTopic = topics.confirmBuyingBread,
			rewards = {
				{ id = 888 },
			},
		},
	}

	---keywords
	-- Use <> and [] to match word as variable
	-- <> means the variable is required
	-- [] means variable is optional
	-- Example:
	--	"withdraw <amount>" will put 'amount' field with value passed by user in ResolutionContext
	local dialogs2 = {
		[{ "withdraw <amount>" }] = {
			text = "WOULD_YOU_LIKE_TO_WITHDRAW",
			nextTopic = QuestTopics.JOB_TOPICS.confirmWithdrawing,
		},
		[{ "yes", "tak" }] = {
			text = "YOU_WITHDREW_MONEY",
		},
	}

	---nextTopic
	-- Specifies the topic to be set for this Dialog on success-resolve
	nextTopic = QuestTopics.JOB_TOPICS.confirmExchangeSoulorbToInfernalbolt

	---requiredState
	-- Specifies the required storage states for player to be able to success-resolve this dialog
	-- Functionality of this param depends on passed argument type:
	-- Int:
	--	min = argument
	--	max = defaultMaxState (global val) // Notice: default behavior differs from topic (gte, not eq)
	--	neq = nil
	-- Table:
	--	min = argument.min, Default: QUEST_NOT_STARTED
	--	max = argument.max, Default: defaultMaxState (global val)
	--  neq = argument.neq, Default: nil
	-- Example:
	requiredState = {
		-- eq
		[Storage.SomeQuest.TaskPoints] = 50,
		-- eq (alternative notation)
		[Storage.SomeQuest.SomeStorage3] = { max = 50, min = 50 },
		-- gte
		[Storage.SomeQuest.TaskPoints] = { min = 1 },
		-- neq
		[Storage.SomeQuest.SomeStorage1] = { neq = -1 },
		-- lte
		[Storage.SomeQuest.SomeStorage2] = { max = 1 },
		-- range
		[Storage.SomeQuest.AntelopeUnlocked] = { min = 9, max = 13 },
	}

	-- Default: Same as above, but for the global game storage (Game.getStorageValueByKey vs player:getStorageValueByKey())
	requiredGlobalState = {
		-- eq
		[Storage.SomeQuest.SomeStorage1] = 50,
		-- eq (alternative notation)
		[Storage.SomeQuest.SomeStorage1] = { max = 50, min = 50 },
		-- gte
		[Storage.SomeQuest.SomeStorage2] = { min = 1 },
		-- neq
		[Storage.SomeQuest.SomeStorage3] = { neq = -1 },
		-- lte
		[Storage.SomeQuest.SomeStorage4] = { max = 1 },
		-- range
		[Storage.SomeQuest.SomeStorage6] = { min = 9, max = 13 },
	}

	---requiredItems
	-- If player has the required items, they will be taken(assuming ALL other conditions for dialog are satisfied)
	-- id Required
	-- count Default: 1
	-- remove Defailt: true --set to false if item should not be removed on success, meaning player just has to have it by themselves
	-- take Default: automatically set to the count value (setting to TAKE_ALL_AVAILABLE will take all items with this id, eg. exchange empty potions for tickets)
	-- This param supports AST structure - "any" as table key mean that any one matching item will suffice. This can be nested multiple times.
	-- Default ast quantifier: all
	-- Example Take all:
	requiredItems = {
		-- if players has all items, all those items will be removed; else no item will be removed
		{ id = 3460, count = 2, remove = false },
		{ id = 3278, take = TAKE_ALL_AVAILABLE },
	}
	-- Example Take any:
	requiredItems = {
		-- If player has any of required items, the first matched item will be removed; else no item will be removed
		-- Third table requires all items inside that brackets (default all quantifier), meaning this dialog passes when player has two 3460, two 3459 or one of each
		any = {
			{ id = 3460, count = 2 },
			{ id = 3459, count = 2 },
			{
				{ id = 3460, count = 1 },
				{ id = 3459, count = 1 },
			},
		},
	}

	---removeRequiredItems
	-- You can use this param to not remove items on success-resolved dialog - just check if player holds something in their bags
	-- This is alternative to using 'remove' flag on items, especially if you want to reuse some items in different dialog, from which only one actually removes items
	-- true:
	--  no item will be removed
	-- false:
	--  each item's "remove" field is going to determine if its going to be removed
	-- Default: true
	removeRequiredItems = false

	---textNoRequiredItems
	-- If no match found for required items
	textNoRequiredItems = "Oh nooo, you dont have that item! :("

	---text
	-- 1st most common used field
	-- Npc will say it if the dialog is success-resolved
	text = "O tempora, {o mores}! What do you want from me?"

	---requiredMoney
	-- Specifies the money needed to success-resolve the Dialog
	-- Npc will say corresponding line when you dont have the money
	-- This money will only be removed if Dialog is sucess-resolved
	-- Counts money from backpack and the bank
	requiredMoney = 10

	---specialRequirements
	-- This param allows user to define special conditions required to success-resolve dialog
	-- Most of common conditions can be checked using decicated params (eg. requiredMoney, requiredState, requiredItems)
	-- Other conditions can be checked with special function, either declared by you or found in global function tables, eg. SPECIAL_REQUIREMENTS_GENERAL
	-- Structure: {condition, requiredOutcome, [textFailedRequirement,] [params...] }
	-- The context argument will contain everything declared on the right side (value) as well as other context things like player, npc, npcHandler, msg, etc.
	-- If condition function return value is not equal to requiredOutcome:
	--	If textFailedRequirement is not nil, npc will say the textFailedRequirement and fail-resolve dialog
	--	If textFailedRequirement is nil, this dialog is discarded, and system will try to resolve next dialog
	local playerHasLevel = function(context)
		local level = context.player:getLevel()
		local min = context.min or 0
		local max = context.max or 9999
		if level > min then
			return false
		end
		if level < max then
			return false
		end

		return true
	end
	specialRequirements = {
		{
			-- Callback function - Required
			requirement = playerHasLevel,
			-- Callback required value to be returned - Required
			requiredOutcome = true,
			-- Dont specify this text to discard this dialog on failing requiredOutcome
			textFailedRequirement = "Your level is not in range",
			-- Additional custom params
			minLevel = 20,
			maxLevel = 60,
		},
	}

	---specialActionsOnSucess
	-- This param allows user to define special actions to be performed when dialog success-resolved
	-- Most of common actions can be performed using decicated params (spawnMonstersOnSuccess, rewards, expReward etc.)
	-- Structure: { [func] = { [params...] } }
	-- The context will contain everything declared on the right side value as well as other context things like player, npc, npcHandler, msg, etc.
	local setGameTime = function(context)
		Game.setTime(context.nextTime)
	end
	local anotherFunction = function(context)
		--do something
	end
	-- Example:
	--[[
	in setGameTime, context contains nextTime, player, npc, playerWord, etc.
	in anotherFunction, context contains player, npc, playerWord, etc.
	]]

	specialActionsOnSucess = {
		[setGameTime] = { nextTime = "22:00" },
		[anotherFunction] = {},
	}

	---rewards
	-- Allows rewards to be distributed on success-resolution of dialog
	-- This is also de facto a requirement, as if player lacks cap/slots, npc will say according line and fail-resolve the dialog
	-- Item has to have id. Other attributes are optional
	-- id = argument, Required
	-- count = argument, Default: 1
	-- aid = argument, Default: 0
	-- showCustomDescOnAcquire = argument, Default: false
	-- desc = argument, Default = nil
	-- text = argument, Default = nil
	-- uid = argument, Default = nil //this will create an unmovable item in player inventory!
	-- addToStore = argument, Default: nil
	-- addToStore behavior:
	--	true:
	--   item will always go to store
	--	false:
	--   item will always go to bags
	--	nil:
	--	 item aith aid will go to store
	--	 ites without aid (or aid = 0) wll go to bags
	-- customAttribute1 = argument, Default = nil //Custom attributes will be set with setCustomAttribute method (player:setCustomAttribute(customAttriute1, argument))
	-- customAttribute2 = argument, Default = nil //Custom attribute is any argument with name not listed above (AddCustomItem might have more up to date definition)
	-- customAttribute3 = argument, Default = nil //You can specify any number of custom attributes
	rewards = {
		{
			--required
			id = 3460,

			--optional
			aid = Storage.SomeQuest.MagicalHammer,
			addToStore = false,

			--custom
			meow_o_meter = 5,
		},
		-- Will put all items in container 1949
		[1949] = {
			{ id = 269, count = 100 },
			{ id = 277, count = 5 },
		},
	}

	---spawnMonstersOnSuccess
	-- Specifies monsters to be spawned at player on success-resolve
	-- [MonsterName] = count
	spawnMonstersOnSuccess = {
		["Corym Charlatan"] = 3,
		["Corym Skirmisher"] = 1,
	}

	---outfitRewards
	-- Specifies outfit rewards to be granted on success-resolve
	outfitRewards = { { outfitId = 574, addon = 1 }, { outfitId = 575, addon = 1 } }

	---mountRewards
	-- Specifies mount rewards to be granted on success-resolve
	local antelopeId = 163
	local someOtherMountId = 174
	mountRewards = { antelopeId, someOtherMountId }

	---expReward
	-- Specifies exp reward to be granted on success-resolve
	expReward = 60 * 1000

	---nextState
	-- Updates player storages on sucess-resolve
	-- Use Integer to set storage value
	-- Use String with +/- to increment/decrement current storage value, eg.: "+1"
	nextState = {
		[Storage.SomeQuest.Questline] = 1,
		[Storage.SomeQuest.Mission01] = 1,
		[Storage.SomeQuest.Points] = "+1",
	}

	---nextGlobalState
	-- Updates the declared storages for global Game state
	-- Use integer to set to its value. eg.: 1
	-- Use String with +/- to increment/decrement, eg.: "+1"
	nextGlobalState = { [Storage.SomeQuest.MagicNumber] = 5 }

	---addDialogData
	-- If dialog is success-resolved, sets dialog context in the global table associated with player
	-- This can be used in later dialogs, including talking to other npcs
	-- This allows doing things like caching amount from previous message during money withdrawal/deposits
	-- Default: true
	addDialogData = false
end

--Example npc with dialogs
local function exampleNpc()
	local internalNpcName = "example npc"
	local npcType = Game.createNpcType(internalNpcName)
	local npcConfig = {}

	npcConfig.name = internalNpcName
	npcConfig.description = internalNpcName

	npcConfig.health = 100
	npcConfig.maxHealth = npcConfig.health
	npcConfig.walkInterval = 3000
	npcConfig.walkRadius = 2

	npcConfig.outfit = {
		lookType = 144,
		lookHead = 59,
		lookBody = 115,
		lookLegs = 58,
		lookFeet = 97,
		lookAddons = 0,
	}

	npcConfig.flags = { floorchange = false }

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

	local topics = {
		CatBranchman = {
			wantToKnowBranchLocation = 1,
			confirmingHavingBranch = 2,
		},
	}

	-- Order of processing dialogs:
	---1: anything but LOCALIZER_UNIVERSAL dialogs
	---2: LOCALIZER_UNIVERSAL dialogs
	---3: if message type is greet/farewell/walkaway, the default corresponding message is set and dialog is success-resolved
	---4: anything but LOCALIZER_UNIVERSAL dialogs, with player message set to ANY_MESSAGE
	---5: LOCALIZER_UNIVERSAL dialog, with player message set to ANY_MESSAGE
	---6: default "INCOMPREHENSIBLE" text is sent and dialog is success-resolved

	-- Dialog structure is split into two categories: requirements and actions
	-- If all requirements are met, all actions will be executed and dialog is considered success-resolved
	-- If a requirement is not met, then either:
	--  If this failed requirement has text on fail(eg. textFailedRequirement, textNoRequiredState, textNoRequiredItems), then the npc will say it and dialog is considered fail-resolved
	--  Else if this requirement has no text on fail, dialog will be discarded and quest system will try to process the next dialog.
	local customDialogs = {
		[LOCALIZERS.Universal] = {
			-- This dialog can always be accessed, regardless of main quest state. This means it will be processed lasd (Order of processing dialogs)
			-- In case of conflicting keywords you should use topic to differentiate
			[{ "secret code" }] = { text = "okkk" },
			[{ GREET }] = { text = "Hello." },
		},
		-- Quest localizer used to
		[LOCALIZERS.CatBranchman] = {
			-- Quest dialogs main storage that determines required state
			[Storage.CatBranchman.Questline] = {
				-- Main questline requirements are different to the ones in requiredState table - player state has to be exactly the key
				-- This requires player storage: Storage.CatBranchman.Questline to be exacly QUEST_NOT_STARTED (-1)
				[MISSION_NOT_STARTED] = {
					-- This is possible candidate dialog to be resolved when a player says "hi" if player hadnt started the quest
					-- WARNING: if player has multiple matching states (from other quests) then its undeterministic which one will be chosen. This is true only for greet message, as other messages can be deterministically reached using topics
					[{ GREET }] = { text = "*Muttering* i dont know you, meow!" },
					[{ "mission", "misja" }] = {
						text = "I have a mission for you, do you want to try helping me?",
					},
					[{ "yes", "sure" }] = {
						text = "Alright, bring me a heavy {branch}",
						nextState = {
							[Storage.CatBranchman.Questline] = 1,
							[Storage.CatBranchman.Mission01] = 1,
							[Storage.CatBranchman.Points] = "+3",
						},
					},
				},
				-- Requires questline state to be exactly 1
				[1] = {
					-- ANY_MESSAGE means any word, excluding the reserved words (hi, bye, trade, etc.)
					[{ ANY_MESSAGE }] = { text = "What do you want from me?" },
					[{ "branch" }] = {
						text = "Yeah, you know, the big old branch. Do you want to know where to find one?",
						nextTopic = topics.CatBranchman.wantToKnowBranchLocation,
					},
					[{ "mission" }] = {
						text = "Do you have the branch i asked for?",

						nextTopic = topics.CatBranchman.confirmingHavingBranch,
					},
					-- Use topic to differentiate between dialogs with exact same keywords
					[{ "yes", "tak" }] = {
						text = "You can find branch in the cat shop.",
						requiredTopic = {
							min = topics.CatBranchman.wantToKnowBranchLocation,
							max = topics.CatBranchman.wantToKnowBranchLocation,
						},
					},
					[{ "yes", "tak" }] = {
						text = "Thanks for your help, take these eggs and this magical hammer. Now you can ask me for {cat} trivia. I also have another {mission} for you!",
						requiredTopic = topics.CatBranchman.confirmingHavingBranch,
						requiredItems = {
							any = {
								{ id = 7752, count = 1 },
								{ id = 6488, take = TAKE_ALL_AVAILABLE },
							},
						},
						rewards = {
							{ id = 3606, count = 2 },
							{ id = 3460, aid = Storage.CatBranchman.MagicalHammer },
						},
						nextState = {
							[Storage.CatBranchman.Questline] = 2,
							[Storage.CatBranchman.Mission01] = 2,
							[Storage.CatBranchman.Mission02] = 1,
							[Storage.CatBranchman.Points] = "+10",
						},
					},
				},
				-- Requires questline state to be exactly 2
				[2] = {
					[{ "mission" }] = {
						text = "Here goes another mission.",
						nextState = {
							[Storage.CatBranchman.Questline] = 3,
							[Storage.CatBranchman.Mission02] = 2,
							[Storage.CatBranchman.Points] = "+3",
						},
					},
				},
				-- Requires Questline state to be at least 2
				[{ min = 2 }] = {
					[{ "cats" }] = {
						text = "Cats have four legs.",
						-- removes money from bank only
						specialActionsOnSucess = {
							[SPECIAL_ACTIONS_UNIVERSAL.removeMoneyBank] = { price = 10 },
						},
						-- removes money from backpacks and then from bank if its not enoug
						requiredMoney = 10,
						specialRequirements = {
							{
								requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerHasLevel,
								requiredOutcome = true,
								textFailedRequirement = "I cannot tell such things to an underage person!",
								minLevel = 18,
							},
						},
					},
				},
			},
		},
	}
	local outfit = {
		lookType = 136,
		lookHead = 20,
		lookBody = 100,
		lookLegs = 50,
		lookFeet = 99,
		lookAddons = 3,
	}

	local context = {
		name = "Cat Branchman",
		greetJob = JOB_FOOD,
		jobs = { JOB_FOOD },
		outfit = outfit,
		customDialogs = customDialogs,
		voices = voices,
	}
	RegisterNpcDefinition(context)
end

-- Example of npc that is generated using this npc-specific dialogs (quests etc.) combined with job from a template
-- In this example the JOB_FOOD is used, so npc will have all dialogs and shop offer defined in JOB_FOOD template
-- Dialogs defined in "local customDialogs = {" cannot override the job's template dialogs in case of conflicts. Example of overcoming this below
local function exampleNpcFromGenerator()
	local customDialogs = {
		[LOCALIZERS.Universal] = {
			-- Warning! This wont override the greet dialog from template
			-- Set context.greetJob below to nil if you want custom greet and define it yourself like below
			[{ GREET }] = {
				text = "Hello, my name is walmart007", --Default job greeting can be something like "Hello, would you like to nab some groceries?"
			},
		},
	}
	local voices = {
		interval = 15000,
		chance = 50,
		{ text = "Damn lidl.. they always try to take my customers" },
	}

	local outfit = {
		lookType = 136,
		lookHead = 20,
		lookBody = 100,
		lookLegs = 50,
		lookFeet = 99,
		lookAddons = 3,
	}
	local context = {
		name = "Walmart007",
		greetJob = JOB_FOOD,
		jobs = { JOB_FOOD },
		outfit = outfit,
		customDialogs = customDialogs,
		voices = voices,
	}

	RegisterNpcDefinition(context)
end

-- ide highlighting; ignore
exampleDialog()
exampleNpc()
exampleNpcFromGenerator()
