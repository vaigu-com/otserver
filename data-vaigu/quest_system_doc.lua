do return end
-- Terminology:
--  processing: The npc system is going through all npc dialogs and determines if player meets the requirement for the dialogs
--  discarded: A dialog processing has been cancelled and another dialog will be processed
--  resolved: A dialog has been processed and no other dialog will be processed. This means the npc will say some text corresponding to this dialog (fail or success dialog)
--   success-resolved: Npc will say text that is supposed to be shown on success for this dialog. Actions on success (eg. rewards, special effects) will all be perfomed for this dialog
--   fail-resolved: Npc will say text that corresponds to the reason of this dialog fail. Actions on success wont be performed for this dialog

local function exampleDialog(text, requiredTopic, requiredItems, removeRequiredItems, textNoRequiredItems, requiredState, requiredGlobalState, specialConditions, requiredMoney, specialActionsOnSucess, rewards, spawnMonstersOnSuccess, outfitRewards, mountRewards, expReward, nextState, nextGlobalState, nextTopic, addDialogData)
	-- Topic required to resolve this dialog.
	-- Int:
	--	min = argument, Default: nil
	--  max = argument, Default: nil
	-- Table:
	--  min = argument.min, Default: 0
	--  max = argument.max, Default: 2^15
	-- General example:
	-- range
	requiredTopic = { min = 1, max = 4 }
	-- gte
	requiredTopic = { min = 1 }
	-- lte
	requiredTopic = { max = 2 }
	-- eq
	requiredTopic = 1
	-- eq, alternative
	requiredTopic = { min = 1, max = 1 }
	-- Only use them to differentiate dialog paths: if you have more than two dialogs that have "yes" as keyword, then you should differentiate them using requiredState (most cases) or requiredTopic
	-- Functionality of this param depends on passed argument type:
	-- Example:
	local topics = {
		confirmBuyingCake = 1,
		confirmBuyingBread = 2,
	}
	local dialogs = {
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
	-- Use <> and [] to match word as variable
	-- <> means the variable is required
	-- [] means variable is optional
	-- Example:
	--	"withdraw <amount>" will put amount field with value passed by user in ResolutionContext
	local dialogs2 = {
		[{ "withdraw <amount>" }] = {
			text = "WOULD_YOU_LIKE_TO_WITHDRAW",
			nextTopic = JOB_TOPICS.confirmWithdrawing,
		},
		[{"yes","tak"}] = {
			text = "YOU_WITHDREW_MONEY",
		}
	}
	translationTable = {
		["WOULD_YOU_LIKE_TO_WITHDRAW"] = function(context)
			return T("Would you like to withdraw :amount:?", { amount = context.amount })
		end,
		["YOU_WITHDREW_MONEY"] = function (context)
			return T("Would you like to withdraw :amount:?", { amount = context.lastMessageData.amount })
		end
	}

	-- Specifies the topic to be set for this Dialog on success-resolve
	nextTopic = 1

	-- Specifies the required storage states for player to be able to success-resolve this dialog
	-- Its worth noting that default behavior when the argument passed was int, is to allow storage values GREATER THAN or equal to argument. This differs from the topic default behavior
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
		-- gte
		[Storage.SomeQuest.TaskPoints] = 50,
		-- gte, alternative way
		[Storage.SomeQuest.TaskPoints] = { min = 50 },
		-- neq
		[Storage.SomeQuest.SomeStorage1] = { neq = -1 },
		-- lte
		[Storage.SomeQuest.SomeStorage2] = { max = 1 },
		-- eq
		[Storage.SomeQuest.SomeStorage3] = { max = 1, min = 1 },
		-- range
		[Storage.SomeQuest.AntelopeUnlocked] = { min = 9, max = 13 },
	}

	-- Default: Same as above, but for the global game storage (Game.getStorageValue vs player:getStorageValue())
	requiredGlobalState = {
		-- gte
		[Storage.SomeQuest.SomeStorage1] = 50,
		-- gte, alternative way
		[Storage.SomeQuest.SomeStorage2] = { min = 50 },
		-- neq
		[Storage.SomeQuest.SomeStorage3] = { neq = -1 },
		-- lte
		[Storage.SomeQuest.SomeStorage4] = { max = 1 },
		-- eq
		[Storage.SomeQuest.SomeStorage5] = { max = 1, min = 1 },
		-- range
		[Storage.SomeQuest.SomeStorage6] = { min = 9, max = 13 },
	}

	-- If player has the required items, then this will take those items (assuming ALL other conditions for dialog are satisfied)
	-- count = argument, Default: 1
	-- remove = argument, Defailt: true
	-- take = argumen, Default: count (set to TAKE_ALL_AVAILABLE if u want to take all those items, eg. exchange empty potions for tickets)
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
		any = {
			{ id = 3460, count = 2 },
			{ id = 3459, count = 2 },
			{
				{ id = 3460, count = 1 },
				{ id = 3459, count = 1 },
			},
		},
	}

	-- You can use this param to not remove items on success-resolved dialog - just check if player holds something in their bags
	-- true:
	--  no item will be removed
	-- false:
	--  each item's "remove" field is going to determine if its going to be removed
	-- Default: true
	removeRequiredItems = false

	-- If no match found for required items
	-- ToDo: text for each unmatched item
	textNoRequiredItems = "Oh nooo, you dont have that item! :("

	-- Npc will say it if Dialog i success-resolved
	text = "O tempora, {o mores}! What do you want from me?"

	-- Specifies the money needed to success-resolve the Dialog
	-- Npc will say corresponding line when you dont have the money
	-- This money will only be removed if Dialog is sucess-resolved
	-- Counts money from backpack and the bank
	requiredMoney = 10

	-- This param allows user to define special conditions required to success-resolve dialog
	-- Most of common conditions can be checked using decicated params (eg. requiredMoney, requiredState, requiredItems)
	-- Other conditions can be checked with special function, either declared by you or found in global function tables, eg. SPECIAL_CONDITIONS_GENERAL
	-- Structure: {condition, requiredOutcome, [textNoRequiredCondition,] [params...] }
	-- The context argument will contain everything declared on the right side (value) as well as other context things like player, npc, npcHandler, msg, etc.
	-- If condition function return value is not equal to requiredOutcome:
	--	If textNoRequiredCondition is not nil, npc will say the textNoRequiredCondition and fail-resolve dialog
	--	If textNoRequiredCondition is nil, this dialog is discarded, and system will try to resolve next dialog
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
	specialConditions = {
		{
			-- Callback function - Required
			condition = playerHasLevel,
			-- This field is required
			requiredOutcome = true,
			-- Dont specify it to discard this dialog on failed requiredOutcome
			textNoRequiredCondition = "Your level is not in range",
			-- Additional custom params
			minLevel = 20,
			maxLevel = 60,
		},
	}

	-- This param allows user to define special actions to be invoked when dialog success-resolved
	-- Most of common actions can be invoked using decicated params (spawnMonstersOnSuccess, rewards, expRewards etc.)
	-- Structure: { [func] = { [params...] } }
	-- The context will contain everything declared on the right side value as well as other context things like player, npc, npcHandler, msg, etc.
	local setGameTime = function(context)
		Game.setTime(context.nextTime)
	end
	local anotherFunction = function(context)
		--do something
	end
	specialActionsOnSucess = {
		[setGameTime] = { nextTime = "22:00" },
		[anotherFunction] = {},
	}

	-- Allows rewards to be distributed on success-resolution of dialog
	-- If player lacks cap/slots, npc will say according line, and fail-resolve the dialog
	-- Set key to
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
	-- customAttribute1 = argument, Default = nil //Custom attributes will be set with setCustomAttribute method
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

	-- Specifies monsters to be spawned at player on success-resolve
	-- [MonsterName] = count
	spawnMonstersOnSuccess = {
		["Corym Charlatan"] = 3,
		["Corym Skirmisher"] = 1,
	}

	-- Specifies outfit rewards to be granted on success-resolve
	outfitRewards = { { outfitId = 574, addon = 1 }, { outfitId = 575, addon = 1 } }

	-- Specifies mount rewards to be granted on success-resolve
	local antelopeId = 163
	local someOtherMountId = 174
	mountRewards = { antelopeId, someOtherMountId }

	-- Specifies exp reward to be granted on success-resolve
	expReward = 60 * 1000

	-- Updates player storages on sucess-resolve
	-- Use integer to set storage value
	-- Use String with +/- to increment/decrement current storage value, eg.: "+1"
	-- ToDo: also allow change value based on function
	nextState = {
		[Storage.SomeQuest.Questline] = 1,
		[Storage.SomeQuest.Mission01] = 1,
		[Storage.SomeQuest.Points] = "+1",
	}

	-- Updates the declared storages for global Game state
	-- Use integer to set to its value. eg.: 1
	-- Use String with +/- to increment/decrement, eg.: "+1"
	-- ToDo: also allow change value based on function
	nextGlobalState = { [Storage.SomeQuest.MagicNumber] = 5 }

	-- If dialog is success-resolved, sets dialog context in the global variable associated with player
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
	---3: if message type is greet/farewell/walkaway, the default corresponding message is set and dialog i success-resolved
	---4: anything but LOCALIZER_UNIVERSAL dialogs, with player message set to ANY_MESSAGE
	---5: LOCALIZER_UNIVERSAL dialog, with player message set to ANY_MESSAGE
	---6: default "INCOMPREHENSIBLE" is used and dialog is success-resolved

	-- Dialog structure is split into two categories: requirements and actions
	-- If all requirements are met, all actions will be executed and dialog is success-resolved
	-- If a requirements is not met, then either:
	--  If this requirements has text on fail(eg. textNoRequiredCondition, textNoRequiredState, textNoRequiredItems), then the npc will say it and dialog is fail-resolved
	--  Else This dialog will be discarded and quest system will try to process the next dialog
	--ToDo: rename textNoRequiredCondition to textNoRequiredCondition
	local dialogs = {
		[LOCALIZER_UNIVERSAL] = {
			-- This dialog can always be accessed. In case of conflicting keywords you should use topic to differentiate
			[{ "secret code" }] = { text = "okkk" },
		},
		-- Quest dialogs main storage that determines required state
		[Storage.CatBranchman.Questline] = {
			-- Main questline requirements are different to the ones in requiredState table - player state has to be exactly the key
			-- This requires player storage: Storage.CatBranchman.Questline to be exacly QUEST_NOT_STARTED (-1)
			[QUEST_NOT_STARTED] = {
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
					specialConditions = {
						{
							condition = SPECIAL_CONDITIONS_UNIVERSAL.playerHasLevel,
							requiredOutcome = true,
							textNoRequiredCondition = "I cannot tell such things to an underage person!",
							minLevel = 18,
						},
					},
				},
			},
		},
	}

	local function greetCallback(npc, creature, type, message)
		InitializeResponses(creature, dialogs, npcHandler, npc)
		return true
	end

	local function creatureSayCallback(npc, creature, type, msg)
		if not npcHandler:checkInteraction(npc, creature) then
			return false
		end
		return TryResolveDialog(creature, msg, dialogs, npcHandler, npc)
	end

	npcHandler:setCallback(CALLBACK_GREET, greetCallback)
	npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

	npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
	npcType:register(npcConfig)
end

-- Example of npc that is generated using this npc-specific dialogs (quests etc.) combined with template job
-- In this example the JOB_FOOD is used, so npc will have all dialgues and shop offer defined in JOB_FOOD template
-- Dialogs defined in "local dialogs" can override the template dialogs in case of conflicts. Example of overriding a greet message below
local function exampleNpcFromGenerator()
	local dialogs = {
		[LOCALIZER_UNIVERSAL] = {
			-- Warning! This wont override the greet dialog from template
			-- Set "context.greetJob" below to nil if you dont want that job greet and define it yourself like below
			[{ GREET }] = {
				text = "Hello, my name is walmart007",
			},
		},
		[Storage.TrudnePoczatki.BiedronkaAsked] = {
			[-1] = {
				[{ "help", "pomoc" }] = {
					text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
					requiredState = { [Storage.TrudnePoczatki.Rozeznanie] = 2 },
					nextState = {
						[Storage.TrudnePoczatki.BiedronkaAsked] = 1,
						[Storage.TrudnePoczatki.Rozeznanie] = "+1",
					},
					textNoRequiredState = "It's alright, I don't need any help.",
				},
			},
		},
		[Storage.PomocMiejscowym.PrzekleteSzczury] = {
			[-1] = {
				[{ "help", "pomoc" }] = {
					text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
					requiredState = {
						[Storage.TrudnePoczatki.BiedronkaAsked] = 1,
					},
				},
				[{ "szczur", "szczurow", "rat", "rats" }] = {
					text = "I still have rats in the warehouse. I need some poison to get rid of them.",
					requiredState = {
						[Storage.TrudnePoczatki.BiedronkaAsked] = 1,
					},
					nextState = { [Storage.PomocMiejscowym.PrzekleteSzczury] = 1 },
				},
			},
			[{ min = 1, max = 3 }] = {
				[{ "help", "pomoc" }] = {
					text = "Well, I'm waiting for this poison that will help me exterminate the rats.",
				},
			},
			[3] = {
				[{
					"szczur",
					"szczury",
					"pomoc",
					"rat",
					"rats",
					"help",
					"trucizna",
					"trutka",
				}] = {
					text = "Are you sure if it works? Thanks for the memory, though. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it.",
					rewards = {
						{ id = 9087 },
						{ id = 25732 },
						{ id = 6392 },
					},
					experienceReward = 50000,
					requiredItems = { { id = 3120 } },
					nextState = { [Storage.PomocMiejscowym.PrzekleteSzczury] = 4 },
				},
			},
			[{ min = 4 }] = {
				[{ "help", "pomoc" }] = {
					text = "It's alright, I don't need any help.",
				},
			},
			[4] = {
				[{ "szczur", "szczurow", "rat", "rats" }] = {
					text = "Rats are gone, thanks again.",
				},
				[{ "flaszke", "flaszka", "flask" }] = {
					text = "I heard that it brings you luck, if you catch one of fireflies from magical tree into that.",
				},
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
		dialogs = dialogs,
		voices = voices,
	}

	local npcType, npcConfig = CreateNpcDefinition(context)
	npcType:register(npcConfig)
end

exampleDialog()
exampleNpc()
exampleNpcFromGenerator()
