local quest = Quest(LOCALIZERS.EnterTheDrunkTank)

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
			Mission01 = {},
			GlowingWaterVial = {},
			FilledVial = {},
			BullSpoogeChurn = {},
			FilledChurn = {},
			Hallucinogen = {},
			Bookcase = {},

			MediumManaPotion = {},
			GreatManaPotion = {},
			UltimateManaPotion = {},
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
		local vocationToMission = {
			[VOCATION.BASE_ID.DRUID] = Storage.EnterTheDrunkTankChamberlain.UltimateManaPotion,
			[VOCATION.BASE_ID.KNIGHT] = Storage.EnterTheDrunkTankChamberlain.MediumManaPotion,
			[VOCATION.BASE_ID.SORCERER] = Storage.EnterTheDrunkTankChamberlain.UltimateManaPotion,
			[VOCATION.BASE_ID.PALADIN] = Storage.EnterTheDrunkTankChamberlain.GreatManaPotion,
		}
		QuestKeyItems.EnterTheDrunkTankChamberlain = {
			GlowingWaterVial = { id = 21766, key = Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial },
			BullSpoogeChurn = { id = 32011, key = Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn },
			FilledVial = { id = 2874, key = Storage.EnterTheDrunkTankChamberlain.FilledVial },
			FilledChurn = { id = 32198, key = Storage.EnterTheDrunkTankChamberlain.FilledChurn },
			Hallucinogen = { id = 31350, key = Storage.EnterTheDrunkTankChamberlain.Hallucinogen },
		}
		QuestActions.EnterTheDrunkTankChamberlain = {
			grantVocationPotionAccess = function(context)
				local missionStorage = vocationToMission[context.player:getVocation():getBase():getId()]
				context.player:setStorageValueByKey(missionStorage, ACCESS_GRANTED)
			end,
		}
	end)
	:Questlog(function()
		table.insert(Quests, {
			name = "Enter the Drunk Tank Chamberlain",
			missions = {
				{
					name = "Iron Stomach",
					storage = Storage.EnterTheDrunkTankChamberlain.Mission01,
					states = {
						[QuestState.EnterTheDrunkTankChamberlain.Mission01.AskVislavAboutTask] = "Commissioner Fisher told you to ask Vislav Shivka about a tactical task.",
						[QuestState.EnterTheDrunkTankChamberlain.Mission01.CollectWaterAndMilk] = "Collect glowing naga water and bull spooge then report to Vislav.",
						[QuestState.EnterTheDrunkTankChamberlain.Mission01.UseHallucinogenInCatacombs] = "Take hallucinogen and step through the sealed doors in Orshaawa catacombs.",
						[QuestState.EnterTheDrunkTankChamberlain.Mission01.ReportToVislav] = "You learned how to drink even stronger potions than before. Report to Vislav.",
						[MISSION_FINISHED] = "Vislav commended you for a job well-done.",
					},
				},
			},
		})
	end)
	:Mission(Storage.EnterTheDrunkTankChamberlain.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
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
						[Storage.EnterTheDrunkTankChamberlain.Mission01] = QuestState.EnterTheDrunkTankChamberlain.Mission01.AskVislavAboutTask,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTankChamberlain.Mission01.AskVislavAboutTask,
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "tactical task", "zadanie bojowe", "mission", "misja" }] = {
					text = "Even strongers potions? Life is not a game, my friend. But if Fisher vouched for you, i suppose i can {teach} you then.",
				},
				[{ "teach", "nauczyc" }] = {
					text = "I learned how to safely drink potions thanks to my excessive drinking habits. You can probably reach same results in 10-15 years. But i suppose you are looking for a faster {method}.",
				},
				[{ "method", "sposobu" }] = {
					text = "This metod was devised by my mentor, sensei Sy-Fu. You have visit the floating naga temple. Its rumored that they keep their special glowing water there. The temple is located halfway between our city and Hurgaha. You will also need churn of bull's spooge. You can find it at bulltaur canteen. Take this vial and churn, you will need it to store those liquids. Both of those ingredients will be needed for the next step. Come back when you are done with your task.",
					rewards = {
						QuestKeyItems.EnterTheDrunkTankChamberlain.GlowingWaterVial,
						QuestKeyItems.EnterTheDrunkTankChamberlain.BullSpoogeChurn,
					},
					nextState = {
						[Storage.EnterTheDrunkTankChamberlain.Mission01] = QuestState.EnterTheDrunkTankChamberlain.Mission01.CollectWaterAndMilk,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTankChamberlain.Mission01.CollectWaterAndMilk,
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
					player:AddCustomItem({ id = 2874, key = Storage.EnterTheDrunkTankChamberlain.FilledVial })
				end
				glowingVial:key(Storage.EnterTheDrunkTankChamberlain.GlowingWaterVial)
				glowingVial:register()
			end),
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
					player:AddCustomItem({ id = 32198, key = Storage.EnterTheDrunkTankChamberlain.FilledChurn, name = "churn of bull's 'milk'" })
				end
				spoogeChurn:key(Storage.EnterTheDrunkTankChamberlain.BullSpoogeChurn)
				spoogeChurn:register()
			end),
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "mission", "misja" }] = {
					text = "Yes, there are ingredients i was talking about. Now, let me use my ferment-o-matic to instantly create this concoction for you. Take it to the Orshaawa catacombs. When you are there, stand before the door, drink this potion, and the following delirium should allow you to hallucinate yourself going through that door. Inside you shall find what you need to complete your training.",
					requiredItems = {
						QuestKeyItems.EnterTheDrunkTankChamberlain.FilledVial,
						QuestKeyItems.EnterTheDrunkTankChamberlain.FilledChurn,
					},
					rewards = {
						QuestKeyItems.EnterTheDrunkTankChamberlain.Hallucinogen,
					},
					nextState = {
						[Storage.EnterTheDrunkTankChamberlain.Mission01] = QuestState.EnterTheDrunkTankChamberlain.Mission01.UseHallucinogenInCatacombs,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTankChamberlain.Mission01.UseHallucinogenInCatacombs,
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
				hallucinogen:key(Storage.EnterTheDrunkTankChamberlain.Hallucinogen)
				hallucinogen:register()
			end),
			QuestFactory.StartupItems({
				{
					id = 2438,
					key = Storage.EnterTheDrunkTankChamberlain.Bookcase,
					requiredItems = {
						QuestKeyItems.EnterTheDrunkTankChamberlain.Hallucinogen,
					},
					actionsOnSuccess = {
						{ action = QuestActions.EnterTheDrunkTankChamberlain.grantVocationPotionAccess },
					},
					nextState = {
						[Storage.EnterTheDrunkTankChamberlain.Mission01] = QuestState.EnterTheDrunkTankChamberlain.Mission01.ReportToVislav,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTankChamberlain.Mission01.ReportToVislav, QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Good job! Hope you find your new drinking skills useful.",
				expReward = 1000000,
				nextState = {
					[Storage.EnterTheDrunkTankChamberlain.Mission01] = MISSION_FINISHED,
				},
			},
		})
	end)
	:Register()
