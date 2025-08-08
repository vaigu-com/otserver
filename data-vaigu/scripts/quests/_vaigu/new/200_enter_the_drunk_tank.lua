local quest = Quest(LOCALIZERS.EnterTheDrunkTank)

quest
	:Storage(function()
		Storage.EnterTheDrunkTank = {
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
		QuestState.EnterTheDrunkTank = {
			Mission01 = {
				AskVislavAboutTask = 1,
				CollectWaterAndMilk = 2,
				UseHallucinogenInCatacombs = 3,
				ReportToVislav = 4,
			},
		}
		QuestTopics.EnterTheDrunkTank = {
			AcceptTacticalTask = NextTopic(),
			ConfirmWantToLearnMethod = NextTopic(),
		}
	end)
	:Constant(function()
		QuestConstants.EnterTheDrunkTank = {
			PotionAccessLevel = 200
		}
		local vocationToMission = {
			[VOCATION.BASE_ID.DRUID] = Storage.EnterTheDrunkTank.UltimateManaPotion,
			[VOCATION.BASE_ID.KNIGHT] = Storage.EnterTheDrunkTank.MediumManaPotion,
			[VOCATION.BASE_ID.SORCERER] = Storage.EnterTheDrunkTank.UltimateManaPotion,
			[VOCATION.BASE_ID.PALADIN] = Storage.EnterTheDrunkTank.GreatManaPotion,
		}
		QuestKeyItems.EnterTheDrunkTank = {
			GlowingWaterVial = { id = 21766, key = Storage.EnterTheDrunkTank.GlowingWaterVial },
			BullSpoogeChurn = { id = 32011, key = Storage.EnterTheDrunkTank.BullSpoogeChurn },
			FilledVial = { id = 21766, key = Storage.EnterTheDrunkTank.FilledVial, name = "vial of glowing water" },
			FilledChurn = { id = 32198, key = Storage.EnterTheDrunkTank.FilledChurn, name = "churn of bull's 'milk'" },
			Hallucinogen = { id = 31350, key = Storage.EnterTheDrunkTank.Hallucinogen },
		}
		QuestActions.EnterTheDrunkTank = {
			grantVocationPotionAccess = function(context)
				local missionStorage = vocationToMission[context.player:getVocation():getBase():getId()]
				context.player:setStorageValueByKey(missionStorage, ACCESS_GRANTED)
			end,
		}
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Enter the Drunk Tank",
			localizer = localizer,
			missions = {
				{
					name = "Iron Stomach",
					storage = Storage.EnterTheDrunkTank.Mission01,
					states = {
						[QuestState.EnterTheDrunkTank.Mission01.AskVislavAboutTask] = "Commissioner Fisher told you to ask Vislav Shivka about a tactical task.",
						[QuestState.EnterTheDrunkTank.Mission01.CollectWaterAndMilk] = "Collect glowing naga water and bull spooge then report to Vislav.",
						[QuestState.EnterTheDrunkTank.Mission01.UseHallucinogenInCatacombs] = "Take hallucinogen and step through the sealed doors in Orshaawa catacombs.",
						[QuestState.EnterTheDrunkTank.Mission01.ReportToVislav] = "You learned how to drink even stronger potions than before. Report to Vislav.",
						[MISSION_FINISHED] = "Vislav commended you for a job well-done.",
					},
				},
			},
		})
	end)
	:Mission(Storage.EnterTheDrunkTank.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ GREET }] = {
					text = "I see you have made a great effort to help our city people. For that I would like to thank you personally. Please visit Vislav Shivka, he has a {tactical task} for you, if you know what i mean.",
					specialRequirements = {
						{
							requirement = function(context)
								local finishedCount = 0
								local leeway = 1
								local player = context.player
								for _, storage in pairs(QuestConstants.LocalSupport.LocalSupportMissionStorages) do
									local state = player:getStorageValueByKey(storage)
									if state == MISSION_FINISHED then
										finishedCount = finishedCount + 1
									end
								end

								return (finishedCount + leeway) >= TableSize(QuestConstants.LocalSupport.LocalSupportMissionStorages)
							end,
							requiredOutcome = true,
						},
					},
					nextTopic = QuestTopics.EnterTheDrunkTank.AcceptTacticalTask,
				},
				[{ "tactical task", "zadanie bojowe" }] = {
					text = "If you would like to expand your vocation expertise, you should meet Vislav Shivka. While he is a master imbiber of magical elixirs himself, he is also capable of teaching his 'craft' to others. Ask him about tactical task and he will surely guide you. Tell him that i sent u there or he might not want to share this knowledge with you. Also take this experience as your reward.",
					expReward = 1000000,
					requiredTopic = QuestTopics.EnterTheDrunkTank.AcceptTacticalTask,
					nextState = {
						[Storage.EnterTheDrunkTank.Mission01] = QuestState.EnterTheDrunkTank.Mission01.AskVislavAboutTask,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTank.Mission01.AskVislavAboutTask,
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "tactical task", "zadanie bojowe" }] = {
					text = "Even strongers potions? Life is not a game, my friend. But if Fisher vouched for you, i suppose i can {teach} you then.",
				},
				[{ "teach", "nauczyc" }] = {
					text = "I learned how to safely drink potions thanks to my excessive drinking habits. You can probably reach same results in 10-15 years. But i suppose you are looking for a faster {method}.",
					nextTopic = QuestTopics.EnterTheDrunkTank.ConfirmWantToLearnMethod,
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerHasLevel,
							minLevel = QuestConstants.EnterTheDrunkTank.PotionAccessLevel,
							requiredOutcome = true,
							textOnFail = "I see that Fisher vouched for you, but i cannot teach you yet. Come back when you are at least level 200.",
						},
					},
				},
				[{ "method", "sposobu" }] = {
					text = "This method was devised by my mentor, sensei Sy-Fu. You have to visit the floating naga temple. Its rumored that they keep their special glowing water there. The temple is located somehwere within unchareted waters.\n\nYou will also need churn of bull's spooge. You can find it at bulltaur canteen.\n\nTake this vial and churn, you will need it to store those liquids. Both of those ingredients will be needed for the next step. Come back when you are done with your task.",
					requiredTopic = QuestTopics.EnterTheDrunkTank.ConfirmWantToLearnMethod,
					rewards = {
						QuestKeyItems.EnterTheDrunkTank.GlowingWaterVial,
						QuestKeyItems.EnterTheDrunkTank.BullSpoogeChurn,
					},
					nextState = {
						[Storage.EnterTheDrunkTank.Mission01] = QuestState.EnterTheDrunkTank.Mission01.CollectWaterAndMilk,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTank.Mission01.CollectWaterAndMilk,
			QuestFactory.Script(function(missionState)
				local glowingVial = Action()
				function glowingVial.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end
					if target == nil or target:getKey() ~= Storage.EnterTheDrunkTank.GlowingWaterVial then
						return false
					end

					toPosition:sendMagicEffect(CONST_ME_POFF)
					item:remove()
					player:AddCustomItem(QuestKeyItems.EnterTheDrunkTank.FilledVial)
				end
				glowingVial:key(Storage.EnterTheDrunkTank.GlowingWaterVial)
				glowingVial:register()
			end),
			QuestFactory.Script(function(missionState)
				local spoogeChurn = Action()
				function spoogeChurn.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					if target == nil or target:getKey() ~= Storage.EnterTheDrunkTank.BullSpoogeChurn then
						return false
					end

					toPosition:sendMagicEffect(CONST_ME_POFF)
					item:remove()
					player:AddCustomItem(QuestKeyItems.EnterTheDrunkTank.FilledChurn)
				end
				spoogeChurn:key(Storage.EnterTheDrunkTank.BullSpoogeChurn)
				spoogeChurn:register()
			end),
			QuestFactory.Dialog("Vislav Shivka", {
				[{ "mission", "misja" }] = {
					text = "Yes, there are ingredients i was talking about. Now, let me use my ferment-o-matic to instantly create this concoction for you. Take it to the Orshaawa catacombs. When you are there, stand before the door, drink this potion, and the following delirium should allow you to hallucinate yourself going through that door. Inside you shall find what you need to complete your training.",
					requiredItems = {
						QuestKeyItems.EnterTheDrunkTank.FilledVial,
						QuestKeyItems.EnterTheDrunkTank.FilledChurn,
					},
					rewards = {
						QuestKeyItems.EnterTheDrunkTank.Hallucinogen,
					},
					nextState = {
						[Storage.EnterTheDrunkTank.Mission01] = QuestState.EnterTheDrunkTank.Mission01.UseHallucinogenInCatacombs,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTank.Mission01.UseHallucinogenInCatacombs,
			QuestFactory.Script(function()
				local poison = Condition(CONDITION_POISON)
				poison:setParameter(CONDITION_PARAM_DELAYED, 1)
				poison:addDamage(25, 3000, -45)

				local beforeDoor = Position(7645, 1832, 12)
				local inside = Position(7643, 1832, 12)

				local hallucinogen = Action()
				function hallucinogen.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					local usePosition = player:getPosition()
					if usePosition ~= beforeDoor then
						return false
					end

					player:addCondition(poison)
					usePosition:sendMagicEffect(CONST_ME_POFF)
					player:teleportTo(inside)
					inside:sendMagicEffect(CONST_ME_TELEPORT)
				end
				hallucinogen:key(Storage.EnterTheDrunkTank.Hallucinogen)
				hallucinogen:register()
			end),
			QuestFactory.OnUseDeclarations({
				{
					key = Storage.EnterTheDrunkTank.Bookcase,
					requiredItems = {
						QuestKeyItems.EnterTheDrunkTank.Hallucinogen,
					},
					rewards = {
						{ id = 43948 },
					},
					actionsOnSuccess = {
						{ action = QuestActions.EnterTheDrunkTank.grantVocationPotionAccess },
					},
					nextState = {
						[Storage.EnterTheDrunkTank.Mission01] = QuestState.EnterTheDrunkTank.Mission01.ReportToVislav,
					},
				},
			})
	end)
	:State(function()
		return QuestState.EnterTheDrunkTank.Mission01.ReportToVislav, QuestFactory.Dialog("Vislav Shivka", {
			[{ "mission", "misja" }] = {
				text = "Good job! Hope you find your new drinking skills useful.",
				expReward = 1000000,
				nextState = {
					[Storage.EnterTheDrunkTank.Mission01] = MISSION_FINISHED,
					[Storage.Finished.EnterTheDrunkTank] = MISSION_FINISHED,
				},
			},
		})
	end)
	:Register()
