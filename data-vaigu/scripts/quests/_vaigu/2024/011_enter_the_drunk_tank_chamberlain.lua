local quest = Quest(LOCALIZERS.EnterTheDrunkTankChamberlain)

local localSupportFinished = {
	[Storage.LocalSupport.Discernment] = MISSION_FINISHED,
	[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
	[Storage.LocalSupport.FreakingRats] = MISSION_FINISHED,
	[Storage.LocalSupport.BudgetRecycling] = MISSION_FINISHED,
	[Storage.LocalSupport.LostCrystalBall] = MISSION_FINISHED,
	[Storage.LocalSupport.Biodegradable] = MISSION_FINISHED,
	[Storage.LocalSupport.UnwantedGuests] = MISSION_FINISHED,
	[Storage.LocalSupport.TwoMarlinQuest] = MISSION_FINISHED,
	[Storage.LocalSupport.OcellatusXD] = MISSION_FINISHED,
	[Storage.LocalSupport.IKEAForTheBold] = MISSION_FINISHED,
	[Storage.LocalSupport.SettledDownFishmonger] = MISSION_FINISHED,
}

quest
	:Storage(function()
		Storage.EnterTheDrunkTankChamberlain = {
			PuzzlesDoneStateBinary = NextStorage(),
			GlowingWaterVial = NextStorage(),
			FilledVial = NextStorage(),
			BullSpoogeChurn = NextStorage(),
			FilledChurn = NextStorage(),
			Hallucinogen = NextStorage(),
			Bookcase = NextStorage(),

			MediumManaPotion = NextStorage(),
			GreatManaPotion = NextStorage(),
			UltimateManaPotion = NextStorage(),
		}
		QuestState.EnterTheDrunkTankChamberlain = {
			Mission01 = {
				AskVislavAboutTask = 1,
				CollectWaterAndMilk = 2,
				UseHallucinogenInCatacombs = 3,
				ReportToVislav = 4,
			},
		}
		QuestTopics.EnterTheDrunkTankChamberlain = {
			AcceptTacticalTask = NextTopic(),
		}
	end)
	:Constant(function()
		QuestGlobalData.EnterTheDrunkTankChamberlain = {
			vocationToMission = {
				[VOCATION.BASE_ID.DRUID] = Storage.EnterTheDrunkTankChamberlain.UltimateManaPotion,
				[VOCATION.BASE_ID.KNIGHT] = Storage.EnterTheDrunkTankChamberlain.MediumManaPotion,
				[VOCATION.BASE_ID.SORCERER] = Storage.EnterTheDrunkTankChamberlain.UltimateManaPotion,
				[VOCATION.BASE_ID.PALADIN] = Storage.EnterTheDrunkTankChamberlain.GreatManaPotion,
			},
		}
		QuestFunctions.EnterTheDrunkTankChamberlain = {
			grantVocationPotionAccess = function(context)
				local missionStorage = QuestGlobalData.EnterTheDrunkTankChamberlain.vocationToMission[context.player:getVocation():getBase():getId()]
				context.player:setStorageValue(missionStorage, ACCESS_GRANTED)
			end,
		}
	end)
	:Questlog(function()
		Quests[NextQuestId] = {
			name = "Enter the Drunk Tank Chamberlain",
			missions = {
				[Storage.EnterTheDrunkTankChamberlain] = {
					name = "Iron Stomach",
					states = {
						[1] = "Comissioner Fisher told you to ask Vislav Shivka about a tactical task.",
						[2] = "Collect glowing naga water and bull spooge then report to Vislav.",
						[3] = "Take hallucinogen and step through the sealed doors in Orshaawa catacombs.",
						[4] = "You learned how to drink even stronger potions than before. Report to Vislav.",
						[MISSION_FINISHED] = "Vislav commended you for a job well-done.",
					},
				},
			},
		}
	end)
	:Mission(Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Commissioner Fisher", {
			[{ GREET }] = {
				text = "I see you have made a great effort to help our city people. For that I would like to thank you personally. Please visit Vislav Shivka, he has a {tactical task} for you, if you know what i mean.",
				requiredState = localSupportFinished,
				nextTopic = QuestTopics.EnterTheDrunkTankChamberlain.AcceptTacticalTask,
			},
			[{ "tactical task", "zadanie bojowe" }] = {
				text = "If you would like to expand your vocation expertise, you should meet Vislav Shivka. While he is a master imbiber of magical elixirs himself, he is also capable of teaching his 'craft' to others. Ask him about tactical task and he will surely guide you. Tell him that i sent u there or he might not want to share this knowledge with you.",
				requiredTopic = QuestTopics.EnterTheDrunkTankChamberlain.AcceptTacticalTask,
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "tactical task", "zadanie bojowe", "mission", "misja" }] = {
				text = "Even strongers potions? Life is not a game, my friend. But if Fisher vouched for you, i suppose i can {teach} you then.",
			},
			[{ "teach", "nauczyc" }] = {
				text = "I learned how to safely drink potions thanks to my excessive drinking habits. You can probably reach same results in 10-15 years. But i suppose you are looking for a faster {method}.",
			},
			[{ "method", "sposob" }] = {
				text = "This metod was devised by my mentor, sensei Sy-Fu. You have visit the floating naga temple. Its rumored that they keep their special glowing water there. The temple is located halfway between our city and Hurgaha. You will also need churn of bull's spooge. You can find it at bulltaur canteen. Take this vial and churn, you will need it to store those liquids. Both of those ingredients will be needed for the next step. Come back when you are done with your task.",
				rewards = {
					{ id = 21766, aid = Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial },
					{ id = 32011, aid = Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn },
				},
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Yes, there are ingredients i was talking about. Now, let me use my ferment-o-matic to instantly create this concoction for you. Take it to the Orshaawa catacombs. When you are there, stand before the door, drink this potion, and the following delirium should allow you to hallucinate yourself going through that door. Inside you shall find what you need to complete your training.",
				requiredItems = {
					{ id = 2874, aid = Storage.EnterTheDrunkTankChamberlain.FilledVial },
					{ id = 32198, aid = Storage.EnterTheDrunkTankChamberlain.FilledChurn },
				},
				rewards = {
					{ id = 31350, aid = Storage.EnterTheDrunkTankChamberlain.Hallucinogen },
				},
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary] = _38f,
				},
			},
		}),
		QuestFactory.Script(function(missionState)
			local glowingVial = Action()
			function glowingVial.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return false
				end
				if target == nil or target:getId() ~= 38526 or target:getActionId() ~= Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial then
					return false
				end

				toPosition:sendMagicEffect(CONST_ME_POFF)
				item:remove()
				player:AddCustomItem({ id = 2874, aid = Storage.EnterTheDrunkTankChamberlain.FilledVial })
			end
			glowingVial:aid(Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial)
			glowingVial:register()
		end),
		QuestFactory.StartupItems({
			{ id = 38526, pos = { 6284, 1420, 1 }, aid = Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial },
		}),
		QuestFactory.Script(function(missionState)
			local spoogeChurn = Action()
			function spoogeChurn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not player:HasExactMissionState(missionState) then
					return false
				end

				if target == nil or target:getId() ~= 38526 or target:getActionId() ~= Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn then
					return false
				end

				toPosition:sendMagicEffect(CONST_ME_POFF)
				item:remove()
				player:AddCustomItem({ id = 32198, aid = Storage.EnterTheDrunkTankChamberlain.FilledChurn, name = "churn of bull's 'milk'" })
			end
			spoogeChurn:aid(Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn)
			spoogeChurn:register()
		end),
		QuestFactory.StartupItems({
			{ id = 2531, pos = { 7392, 1332, 7 }, aid = Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn },
			{ id = 2533, pos = { 7392, 1333, 7 }, aid = Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn },
			{ id = 2532, pos = { 7393, 1332, 7 }, aid = Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn },
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Script(function()
			local poison = Condition(CONDITION_POISON)
			poison:setParameter(CONDITION_PARAM_DELAYED, 1)
			poison:addDamage(25, 3000, -45)

			local beforeDoor = Position(7645, 1832, 12)
			local inside = Position(7643, 1832, 12)

			local hallucinogen = Action()
			function hallucinogen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				player:addCondition(poison)

				if fromPosition ~= beforeDoor then
					return false
				end

				fromPosition:sendMagicEffect(CONST_ME_POFF)
				player:teleportTo(inside)
				inside:sendMagicEffect(CONST_ME_TELEPORT)
			end
			hallucinogen:aid(Storage.EnterTheDrunkTankChamberlain.Hallucinogen)
			hallucinogen:register()
		end),
		QuestFactory.StartupItems({
			{
				id = 2438,
				position = { 7642, 1832, 12 },
				aid = Storage.EnterTheDrunkTankChamberlain.Bookcase,
				requiredItems = {
					{ id = 31350, aid = Storage.EnterTheDrunkTankChamberlain.Hallucinogen },
				},
				actionsOnSuccess = {
					{ action = QuestFunctions.EnterTheDrunkTankChamberlain.grantVocationPotionAccess },
				},
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary] = PH_STATE,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Good job! Hope you find your new drinking skills useful.",
				expReward = 100000,
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.PuzzlesDoneStateBinary] = MISSION_FINISHED,
				},
			},
		})
	)
	:Register()
