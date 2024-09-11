local trophyNameToId = {
	["bronze hunter trophy"] = { 32754 },
	["silver hunter trophy"] = { 32755 },
	["gold hunter trophy"] = { 32756 },
	["gozzler trophy"] = { 32751 },
	["hellflayer trophy"] = { 32753 },
	["sea serpent doll"] = { 32752 },
}
local trophyCost = 25
local antelopeCost = 50
local antelopeMountId = 163
local powerfulImbueUnlockCost = 15
local function buyTrophy(context)
	local player = context.player
	local trophyName = PlayerDialogDataRegistry:Get(player):Latest().msg
	local trophyId = trophyNameToId[trophyName]
	local decoKitName = ItemType(trophyId):getName()

	local decoKit = {
		id = 23398,
		addToStore = true,
		unwrapId = trophyId,
		[ITEM_ATTRIBUTE_DESCRIPTION] = T("Unwrap it in your own house to create a :name:.", { name = decoKitName }),
	}

	player:AddCustomItem(decoKit)
	player:IncrementStorage(Storage.taskPoints, -trophyCost)
end

NPC_STATE_DIALOGS = {
	[JOB_TASKS] = {
		[Storage.Tasks.TaskInfo] = {
			[-1] = {
				[{ GREET }] = {
					text = "Hello, I have some {tasks} for you. You can also ask for {trade}, if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
					nextState = {
						[Storage.Tasks.TaskInfo] = 1,
						[Storage.taskPoints] = 0,
					},
				},
			},
		},
		[Storage.taskPoints] = {
			[{ max = 0 }] = {
				[{ "punkt", "point", "punktow", "points", "punkty" }] = {
					text = "You don't have any points. You'll get some after finishing the {tasks}. You can exchange them for {trophies}, {mount} and {ability} to make powerful imbues.",
				},
			},
			[{ min = 1 }] = {
				[{ "punkt", "point", "punktow", "points", "punkty" }] = {
					text = "YOU_CURRENTLY_HAVE_N_TASK_POINTS",
				},
			},
			[{ min = -1 }] = {
				[{ "creature product" }] = {
					text = "I can sell you creature product bundles for each of {imbuings}. They will cost you some gold and {points}.",
				},
			},
			[{ min = -1, max = trophyCost - 1 }] = {
				[{ "trofeow", "trophies", "trofeum", "trophy" }] = {
					text = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
					cost = trophyCost,
				},
			},
			[{ min = -1, max = antelopeCost - 1 }] = {
				[{ "wierzchowca", "mount" }] = {
					text = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
					cost = antelopeCost,
				},
			},
			[{ min = trophyCost }] = {
				[{ "trofeow", "trophies", "trofeum", "trophy" }] = {
					text = "THIS_TROPHY_WILL_COST_YOU_N",
					cost = trophyCost,
					nextTopic = JOB_TOPICS.buyingTropies,
				},
				[{
					"bronze hunter trophy",
					"silver hunter trophy",
					"gold hunter trophy",
					"gozzler trophy",
					"hellflayer trophy",
					"sea serpent doll",
				}] = {
					text = "YOU_WANT_TO_BUY_TROHPY_NAME",
					requiredTopic = JOB_TOPICS.buyingTropies,
					nextTopic = JOB_TOPICS.confirmTrophyBuy,
					cost = trophyCost,
				},
				[{ "yes", "tak" }] = {
					text = "Here you are.",
					requiredTopic = JOB_TOPICS.confirmTrophyBuy,
					specialActionsOnSuccess = { { action = buyTrophy } },
				},
			},
			[{ min = antelopeCost }] = {
				[{ "wierzchowca", "mount" }] = {
					text = "YOU_WANT_TO_BUY_ANTELOPE",
					cost = antelopeCost,
					nextTopic = JOB_TOPICS.confirmAntelopeBuy,
				},
				[{ "yes", "tak" }] = {
					text = "Here you are.",
					requiredTopic = JOB_TOPICS.confirmAntelopeBuy,
					mountRewards = { antelopeMountId },
					nextState = {
						[Storage.taskPoints] = T("-:cost:", { cost = tostring(antelopeCost) }),
					},
					specialConditions = {
						{
							condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMount,
							requiredOutcome = false,
							mountId = antelopeMountId,
							textNoRequiredCondition = "You already have this mount.",
						},
					},
				},
			},
		},
	},
	[JOB_IMBUING] = {
		[Storage.powerfulImbue] = {
			[{ max = 0 }] = {
				[{ "yes", "tak" }] = {
					text = "Here you are.",
					requiredTopic = JOB_TOPICS.confirmPowerfulimbueUnlock,
					requiredState = {
						[Storage.taskPoints] = powerfulImbueUnlockCost,
					},
					nextState = {
						[Storage.powerfulImbue] = 1,
						[Storage.taskPoints] = "-" .. tostring(powerfulImbueUnlockCost),
					},
					textNoRequiredState = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
					cost = powerfulImbueUnlockCost,
				},
				[{ "mozliwosc", "ability" }] = {
					text = "YOU_WANT_BUY_ABILITY_POWEFUL_IMBUEMENT",
					nextTopic = JOB_TOPICS.confirmPowerfulimbueUnlock,
					cost = powerfulImbueUnlockCost,
				},
			},
			[{ min = 1 }] = {
				[{ "yes", "tak" }] = {
					text = "You already got it.",
					requiredTopic = JOB_TOPICS.confirmPowerfulimbueUnlock,
				},
				[{ "mozliwosc", "ability" }] = { text = "You already got it." },
			},
		},
	},
	[JOB_GOLDENOUTFIT] = {
		[Storage.GoldenOutfit] = {
			[{ max = 999 }] = {
				[{ "outfit", "addon", "stroj" }] = {
					text = "In exchange for a truly generous donation, I will offer a special outfit. Do you want to make a donation?",
					nextTopic = 1,
				},
				[{ "yes", "tak" }] = {
					text = "Excellent! Now, let me explain. If you donate 20.000.000 gold pieces, you will be entitled to wear a unique outfit.\nYou will be entitled to wear the {armor} for 10.000.000 gold pieces, {helmet} for an additional 5.000.000 and the {boots} for another 5.000.000 gold pieces.\nWhat will it be?",
					requiredTopic = { min = 1, max = 1 },
					nextTopic = 2,
				},
			},
			-- nothing bought
			[-1] = {
				[{ "armor", "armour", "zbroje", "zbroje" }] = {
					text = "So you would like to donate 10.000.000 gold pieces which in return will entitle you to wear a unique armor?",
					nextTopic = 3,
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "helmet", "helm" }] = {
					text = "You need to donate for {armor} outfit first.",
				},
				[{ "boots", "buty" }] = {
					text = "You need to donate for {helmet} outfit first.",
				},
				[{ "yes", "tak" }] = {
					text = "Take this armor as a token of great gratitude. Let us forever remember this day, my friend!",
					requiredMoney = 10 * 10 ^ 6,
					textNoRequiredMoney = "You dont have enough money.",
					requiredTopic = { min = 3, max = 3 },
					nextState = { [Storage.GoldenOutfit] = 1 },
					rewards = {
						{
							id = 23398,
							addToStore = true,
							unwrapId = 31510,
							[ITEM_ATTRIBUTE_DESCRIPTION] = T(
								"Unwrap it in your own house to create a :name:.",
								{ name = ItemType(31510):getName() }
							),
						},
					},
					outfitRewards = {
						{ outfitId = 1211, addon = 0 },
						{ outfitId = 1210, addon = 0 },
					},
				},
			},
			-- has armor bought
			[1] = {
				[{ "armor", "zbroje" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "helmet", "helm" }] = {
					text = "So you would like to donate 5.000.000 gold pieces which in return will entitle you to wear a unique helmet?",
					requiredTopic = { min = 1, max = 2 },
					nextTopic = 4,
				},
				[{ "boots", "buty" }] = {
					text = "You need to donate for {helmet} outfit first.",
				},
				[{ "yes", "tak" }] = {
					text = "Take this helmet as a token of great gratitude. Let us forever remember this day, my friend!",
					requiredMoney = 5 * 10 ^ 6,
					textNoRequiredMoney = "You dont have enough money.",
					requiredTopic = { min = 4, max = 4 },
					nextState = { [Storage.GoldenOutfit] = 2 },
					outfitRewards = {
						{ outfitId = 1211, addon = 2 },
						{ outfitId = 1210, addon = 2 },
					},
				},
			},
			-- has armor and helmet bought
			[2] = {
				[{ "armor", "zbroje" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "helmet", "helm" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "boots", "buty" }] = {
					text = "So you would like to donate 5.000.000 gold pieces which in return will entitle you to wear a unique pair of boots?",
					nextTopic = 5,
				},
				[{ "yes", "tak" }] = {
					text = "Take these boots as a token of great gratitude. Let us forever remember this day, my friend!",
					requiredMoney = 5 * 10 ^ 6,
					textNoRequiredMoney = "You dont have enough money.",
					requiredTopic = { min = 5, max = 5 },
					nextState = { [Storage.GoldenOutfit] = 3 },
					outfitRewards = {
						{ outfitId = 1211, addon = 3 },
						{ outfitId = 1210, addon = 3 },
					},
				},
			},
			-- has pieces bought
			[3] = {
				[{ "armor", "zbroje" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "helmet", "helm" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
				[{ "boots", "buty" }] = {
					text = "You already have that addon.",
					requiredTopic = { min = 1, max = 2 },
				},
			},
		},
	},
}
