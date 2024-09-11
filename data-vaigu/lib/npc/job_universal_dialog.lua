local topicsWildcard = { sayingWildcardNumber = 1, confirmingNwildcards = 2 }

NPC_UNIVERSAL_DIALOGS = {
	[JOB_SOULORB] = {
		[{ "soul orb", "soul orbs", "soul" }] = {
			text = "I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?",
			nextTopic = 1,
		},
		[{ "yes", "tak" }] = {
			text = "You're welcome! Use them wisely.",
			requiredTopic = JOB_TOPICS.exchangingSoulorbToInfernalbolts,
			requiredItems = { { id = 5944, take = TAKE_ALL_AVAILABLE } },
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_SOULORB.soulOrbToInfernalBolt },
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
			requiredTopic = topicsWildcard.sayingWildcardNumber,
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_UNIVERSAL.SetCustomDialogDataAsNumber, key = "orderedCards" },
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.saidPositiveInteger,
					requiredOutcome = true,
					textNoRequiredCondition = "You need to tell me the number of wildcards you'd like to buy.",
				},
			},
			nextTopic = topicsWildcard.confirmingNwildcards,
		},
		[{ "yes", "tak" }] = {
			text = "Here are your wildcards!",
			nextTopic = 0,
			requiredTopic = topicsWildcard.confirmingNwildcards,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_WILDCARD.hasMoneyForWildcards,
					requiredOutcome = true,
					textNoRequiredCondition = "You dont have enough money.",
				},
			},
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_WILDCARD.addWilcard },
				{ action = SPECIAL_ACTIONS_WILDCARD.removeMoneyPreycards },
			},
		},
	},
	[JOB_SOFT_BOOTS_RECHARGE] = {
		[{ "soft boots" }] = {
			text = "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.",
			nextTopic = JOB_TOPICS.buyingSoftBootsRecharge,
		},
		[{ "worn soft boots" }] = {
			text = "Here you are. There are your soft boots.",
			requiredTopic = JOB_TOPICS.buyingSoftBootsRecharge,
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6530 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "What?! I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "doladowac", "charge" }] = {
			text = "Here are your soft boots.",
			requiredTopic = JOB_TOPICS.buyingSoftBootsRecharge,
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6529 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "medicine", "belongings" }] = {
			text = "You have medicine pouch for me?",
			nextTopic = JOB_TOPICS.confirmMedicinepouchExchance,
			requiredItems = { { id = 12517, remove = false } },
			textNoRequiredItems = "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.",
		},
	},
	[JOB_JEWELLER] = {
		[{ "life crystal", "life ring", "life" }] = {
			text = "I can exchange your life crystals for a life rings. Is that what youre interested in?",
			nextTopic = JOB_TOPICS.confirmLifecrystalExchange,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			requiredTopic = JOB_TOPICS.confirmLifecrystalExchange,
			requiredItems = { { id = 3061, min = 1 } },
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_JEWELER.exchangeLifeCrystal },
			},
			textNoRequiredItems = "Im sorry, but you dont have such crystal. Only life crystal counts.",
		},
	},
	[JOB_TASKS] = {
		[{ "zadanie", "zadania", "nagroda", "wykonane", "reward" }] = {
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.hasDoneAnyTask,
					requiredOutcome = true,
					textNoRequiredCondition = "Finish one of {tasks}, then we can talk about reward.",
				},
			},
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_TASKS.grantTaskRewards,
				},
			},
		},
		[{ "tasks", "taski", "biore", "task", "taskow" }] = {
			text = "",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.canTakeAnotherTask,
					requiredOutcome = true,
					textNoRequiredCondition = "YOU_HAVE_MAX_ONGOING_TASKS",
				},
			},
			specialActionsOnSuccess = { { action = SPECIAL_ACTIONS_TASKS.openTaskWindow } },
		},
		[{ "zakoncz", "koniec", "cancel", "anuluj", "Anuluj" }] = {
			text = "",
			specialActionsOnSuccess = { { action = SPECIAL_ACTIONS_TASKS.openTaskCancelWindow } },
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.hasAnyOngoingTask,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
				},
			},
		},
	},
	[JOB_IMBUING] = {
		[{ "imbuing", "imbuings" }] = {
			text = "LIST_IMBUING_NAMES",
			nextTopic = JOB_TOPICS.chooseImbuingName,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_NAME",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.saidImbuingName,
					requiredOutcome = true,
				},
			},
			requiredTopic = JOB_TOPICS.chooseImbuingName,
			nextTopic = JOB_TOPICS.chooseImbuingLevel,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_LEVEL",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.saidImbuingLevels,
					requiredOutcome = true,
				},
			},
			requiredTopic = JOB_TOPICS.chooseImbuingLevel,
			nextTopic = JOB_TOPICS.confirmBuyingImbuing,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			nextTopic = TOPIC_DEFAULT,
			requiredTopic = JOB_TOPICS.confirmBuyingImbuing,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.canPurchaseThisImbuingLevel,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't yet have the {ability} to buy this level of bundle yet.",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughTaskPoints,
					requiredOutcome = true,
					textNoRequiredCondition = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughMoney,
					requiredOutcome = true,
					textNoRequiredCondition = "You dont have enough money.",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughCapSlots,
					requiredOutcome = true,
					NOT_ENOUGH_CAP_OR_SLOTS,
				},
			},
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_IMBUING.removeTaskPointsByImbuing },
			},
		},
	},
	[JOB_DAILYTASK] = {
		[{ "anuluj", "zrezygnowac", "cancel" }] = {
			specialActionsOnSuccess = { { SPECIAL_ACTIONS_DAILY_TASK.openDailyTaskCancelWindow } },
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_DAILY_TASK.hasAnyOngoingDailyTask,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them.",
				},
			},
		},
		[{ "ogloszenie", "task", "nagroda", "reward" }] = {
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_DAILY_TASK.grantDailyTaskRewards,
				},
			},
		},
	},
}
