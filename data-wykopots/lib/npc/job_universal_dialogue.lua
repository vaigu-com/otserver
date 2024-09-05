local baseBoltsPerOrb = 1
local additionalBoltsChance = 0.1
local additionalBoltsNumber = 6
local averageAdditionalBoltsMultiplier = (additionalBoltsChance * additionalBoltsNumber) + (1 - additionalBoltsChance) * baseBoltsPerOrb

local topicsWildcard = { sayingWildcardNumber = 1, confirmingNwildcards = 2 }

NPC_UNIVERSAL_DIALOGUES = {
	[JOB_SOULORB] = {
		[{ "soul orb", "soul orbs", "soul" }] = {
			text = "I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?",
			nextTopic = 1,
		},
		[{ "yes", "tak" }] = {
			text = "You're welcome! Use them wisely.",
			requiredTopic = { min = 1, max = 1 },
			requiredItems = { { id = 5944, take = TAKE_ALL_AVAILABLE } },
			specialActionsOnSuccess = {
				[function(context)
					local player = context.player
					local count = player:CountItem(5944, 0)
					local totalBoltsGranted = (count - count % additionalBoltsNumber) * averageAdditionalBoltsMultiplier
					local uncertainBolts = count - totalBoltsGranted
					for _ = 1, uncertainBolts do
						if math.random(1, 100) < additionalBoltsChance * 100 then
							totalBoltsGranted = totalBoltsGranted + additionalBoltsNumber
						else
							totalBoltsGranted = totalBoltsGranted + baseBoltsPerOrb
						end
					end
					player:AddCustomItem({ id = 6528, count = totalBoltsGranted })
				end] = {},
			},
			textNoRequiredItems = "I can see you don't have them! I can only craft infernal bolts from {soul orb}.",
		},
	},
	[JOB_WILDCARD] = {
		[{ "wildcard", "card", "prey wildcard", "prey", "karta" }] = {
			text = "WILDCARD_COST_QUESTION",
			nextTopic = topicsWildcard.sayingWildcardNumber,
		},
		[{ ANY_MESSAGE }] = {
			text = "WILDCARD_CHOSEN_COUNT",
			requiredTopic = {
				min = topicsWildcard.sayingWildcardNumber,
				max = topicsWildcard.sayingWildcardNumber,
			},
			specialActionsOnSuccess = {
				[function(context)
					context.player:SetCustomConversationData(tonumber(context.msg))
				end] = {},
			},
			specialConditions = {
				[SPECIAL_CONDITIONS_GENERAL.saidPositiveInteger] = {
					requiredOutcome = true,
					textOnFailedCondition = "You need to tell me the number of wildcards you'd like to buy.",
				},
			},
			nextTopic = topicsWildcard.confirmingNwildcards,
		},
		[{ "yes", "tak" }] = {
			text = "Here are your wildcards!",
			nextTopic = 0,
			requiredTopic = {
				min = topicsWildcard.confirmingNwildcards,
				max = topicsWildcard.confirmingNwildcards,
			},
			specialConditions = {
				[function(context)
					local player = context.player
					local orderedCards = context.player:GetCustomConversationData()
					local requiredMoney = player:GetWildcardPrice() * orderedCards
					local playerMoney = player:GetTotalMoney()
					return playerMoney >= requiredMoney
				end] = {
					requiredOutcome = true,
					textOnFailedCondition = "You dont have enough money.",
				},
			},
			specialActionsOnSuccess = {
				[function(context)
					local player = context.player
					local orderedCards = context.player:GetCustomConversationData()
					player:addPreyCards(orderedCards)
				end] = {},
				[function(context)
					local player = context.player
					local orderedCards = context.player:GetCustomConversationData()
					local requiredMoney = player:GetWildcardPrice() * orderedCards
					player:removeMoney(requiredMoney)
				end] = {},
			},
		},
	},
	[JOB_SOFT_BOOTS_RECHARGE] = {
		[{ "soft boots" }] = {
			text = "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.",
			nextTopic = 1,
		},
		[{ "worn soft boots" }] = {
			text = "Here you are. There are your soft boots.",
			requiredTopic = { min = 1, max = 1 },
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6530 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "What?! I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "doladowac", "charge" }] = {
			text = "Here are your soft boots.",
			requiredTopic = { min = 1, max = 1 },
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6529 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "medicine", "belongings" }] = {
			text = "You have medicine pouch for me?",
			nextTopic = 6,
			requiredItems = { { id = 12517, remove = false } },
			textNoRequiredItems = "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.",
		},
		[{ "yes", "tak" }] = {
			text = "Here you are. There are your soft boots.",
			requiredItems = { { id = 12517 } },
			rewards = { { id = 12413 } },
			textNoRequiredItems = "You dont have that.",
		},
	},
	[JOB_JEWELER] = {
		[{ "life crystal", "life ring", "life" }] = {
			text = "I can exchange your life crystals for a life rings. Is that what youre interested in?",
			nextTopic = 1,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			requiredItems = { { id = 3061, min = 1 } },
			specialActionsOnSuccess = {
				[function(context)
					local player = context.player
					local crystalCount = player:CountItem(3051, 0)
					player:AddCustomItem({ id = 3052, count = crystalCount })
				end] = {},
			},
			textNoRequiredItems = "Im sorry, but you dont have such crystal. Only life crystal counts.",
		},
	},
	[JOB_TASKS] = {
		[{ "zadanie", "zadania", "nagroda", "wykonane", "reward" }] = {
			specialConditions = {
				[TASK_SPECIAL_CONDITIONS.hasDoneAnyTask] = {
					requiredOutcome = true,
					textOnFailedCondition = "Finish one of {tasks}, then we can talk about reward.",
				},
			},
			specialActionsOnSuccess = {
				[TASK_SPECIAL_ACTIONS.grantTaskRewards] = {},
			},
		},
		[{ "tasks", "taski", "biore", "task", "taskow" }] = {
			text = "",
			specialActionsOnSuccess = { [OpenTaskWindow] = {} },
			specialConditions = {
				[TASK_SPECIAL_CONDITIONS.canTakeAnotherTask] = {
					requiredOutcome = true,
					textOnFailedCondition = "YOU_HAVE_MAX_ONGOING_TASKS",
				},
			},
		},
		[{ "zakoncz", "koniec", "cancel", "anuluj", "Anuluj" }] = {
			text = "",
			specialActionsOnSuccess = { [OpenTaskCancelWindow] = {} },
			specialConditions = {
				[TASK_SPECIAL_CONDITIONS.hasAnyOngoingTask] = {
					requiredOutcome = true,
					textOnFailedCondition = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
				},
			},
		},
	},
	[JOB_IMBUING] = {
		[{ "imbuing", "imbuings" }] = {
			text = "LIST_IMBUING_NAMES",
			nextTopic = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingName,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_NAME",
			specialConditions = {
				[function(context)
					local bundleData = GetImbuingBundleByName(context.msg)
					if type(bundleData) == "table" then
						context.player:SetCustomConversationData(bundleData)
						return true
					end
					return false
				end] = { requiredOutcome = true },
			},
			requiredTopic = {
				min = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingName,
				max = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingName,
			},
			nextTopic = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingLevel,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_LEVEL",
			specialConditions = {
				[function(context)
					local bundleData = context.player:GetCustomConversationData()
					local bundleLevelData = bundleData[context.msg]
					if type(bundleLevelData) == "table" then
						context.player:SetCustomConversationData(bundleLevelData)
						return true
					end
					return false
				end] = { requiredOutcome = true },
			},
			requiredTopic = {
				min = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingLevel,
				max = JOB_TOPICS[JOB_TASKS_IMBUING].chooseImbuingLevel,
			},
			nextTopic = JOB_TOPICS[JOB_TASKS_IMBUING].confirmBuyingImbuing,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			nextTopic = TOPIC_DEFAULT,
			requiredTopic = {
				min = JOB_TOPICS[JOB_TASKS_IMBUING].confirmBuyingImbuing,
				max = JOB_TOPICS[JOB_TASKS_IMBUING].confirmBuyingImbuing,
			},
			specialConditions = {
				[function(context)
					local bundleData = context.player:GetCustomConversationData()
					local level = bundleData.levelName
					if level ~= "powerful" then
						return true
					end
					return context.player:getStorageValue(Storage.powerfulImbue) >= 1
				end] = {
					requiredOutcome = true,
					textOnFailedCondition = "You don't yet have the {ability} to buy this level of bundle yet.",
				},
				[function(context)
					local bundleData = context.player:GetCustomConversationData()
					local requiredTaskPoints = bundleData.taskPointsCost
					local playerTaskPoints = context.player:getStorageValue(Storage.taskPoints)
					local playerHasPoints = playerTaskPoints >= requiredTaskPoints
					if not playerHasPoints then
						context.player:SetCustomConversationData(requiredTaskPoints)
					end
					return playerHasPoints
				end] = {
					requiredOutcome = true,
					textOnFailedCondition = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
				},
				[function(context)
					local bundleData = context.player:GetCustomConversationData()
					local requiredMoney = bundleData.moneyCost
					local playerMoney = context.player:GetTotalMoney()
					return playerMoney >= requiredMoney
				end] = {
					requiredOutcome = true,
					textOnFailedCondition = "You dont have enough money.",
				},
				[function(context)
					local bundleData = context.player:GetCustomConversationData()
					return context.player:CanAddItems(bundleData.items)
				end] = { requiredOutcome = true, NOT_ENOUGH_CAP_OR_SLOTS },
			},
			specialActionsOnSuccess = {
				[function(context)
					local bundleData = context.player:GetCustomConversationData()

					local player = context.player
					player:AddItems(bundleData.items)
					player:removeMoney(bundleData.moneyPrice)
					player:IncrementStorage(Storage.taskPoints, -bundleData.taskPointsCost)
				end] = {},
			},
		},
	},
	[JOB_DAILYTASK] = {
		[{ "anuluj", "zrezygnowac", "cancel" }] = {
			specialActionsOnSuccess = { [OpenDailyTaskCancelWindow] = {} },
			specialConditions = {
				[DAILY_TASK_SPECIAL_CONDITIONS.hasAnyOngoingDailyTask] = {
					requiredOutcome = true,
					textOnFailedCondition = "You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them.",
				},
			},
		},
		[{ "ogloszenie", "task", "nagroda", "reward" }] = {
			specialActionsOnSuccess = {
				[DAILY_TASK_SPECIAL_ACTIONS.grantDailyTaskRewards] = {},
			},
		},
	},
}
