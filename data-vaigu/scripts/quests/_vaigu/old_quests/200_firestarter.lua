local quest = Quest(LOCALIZERS.Firestarter)

quest
	:Storage(function()
		Storage.Firestarter = {
			Mission01 = {},
			FirebugHaystack = {},
			HayStack = {},

			Mission02 = {},
			FirebugTree = {},
			Tree = {},

			Mission03 = {},
			FirebugFlowers = {},
			Flowers = {
				Flower01 = {},
				Flower02 = {},
				Flower03 = {},
				Flower04 = {},
			},
			-- 11012-11016 kwiatki
		}
		QuestState.Firestarter = {
			Mission01 = {
				BurnHayStack = 1,
				ReportToHymel = 2,
				AskForNewMission = 3,
			},
			Mission02 = {
				SetGuardTreeOnFire = 1,
				ReportToHymel = 2,
				AskForNewMission = 3,
			},
			Mission03 = {
				FindAndIgniteFlowers = 1,
				ReportToHymel = 2,
			},
		}
		QuestTopics.Firestarter = {
			AcceptGuardTreeQuest = NextTopic(),
			AcceptFlowerIgnitionQuest = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.Firestarter = {
			FirebugHaystack = { id = 5467, key = Storage.Firestarter.FirebugHaystack, desc = "Hymel's lighter. Use it on a stack of weed in his old house." },
			FirebugFlowers = { id = 5467, key = Storage.Firestarter.FirebugFlowers, desc = "Hymel's lighter. Set the guard tree on fire." },
			FirebugTree = { id = 5467, key = Storage.Firestarter.FirebugTree, desc = "Hymel's lighter. Use it to lit red weed flowers." },
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Firestarter",
			localizer = localizer,
			missions = {
				{
					name = "Mission 1: Fiery Beginnings",
					storage = Storage.Firestarter.Mission01,
					states = {
						[QuestState.Firestarter.Mission01.BurnHayStack] = "Hymel asked you to burn down the herbs he left on his house on north side of MikroTown.",
						[QuestState.Firestarter.Mission01.ReportToHymel] = "You burnt the herbs, now talk again with Hymel.",
						[QuestState.Firestarter.Mission01.AskForNewMission] = "Hymel gave you an incendiary firebug. Ask him for a new mission.",
						[MISSION_FINISHED] = "You finished this mission.",
					},
				},
				{
					name = "Mission 2: Little Treat",
					storage = Storage.Firestarter.Mission02,
					states = {
						[QuestState.Firestarter.Mission02.SetGuardTreeOnFire] = "Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp.",
						[QuestState.Firestarter.Mission02.ReportToHymel] = "You did it, the guards didn't even notice, go back and see Hymel.",
						[MISSION_FINISHED] = "In return for your help, Hymel gave you the staff of a real reefer.",
					},
				},
				{
					name = "Mission 3: How High",
					storage = Storage.Firestarter.Mission03,
					states = {
						[QuestState.Firestarter.Mission03.FindAndIgniteFlowers] = "Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug.",
						[QuestState.Firestarter.Mission03.ReportToHymel] = "The smell of weed is now around the whole city, you managed to burn all the flowers.",
						[MISSION_FINISHED] = "Hymel declared you a true pyromaniac and gave you his arsonist weapon.",
					},
				},
			},
		})
	end)
	:Mission(Storage.Firestarter.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Hymel", {
				[{ GREET }] = {
					text = "Yo, |PLAYERNAME|! You want to {smoke} some?",
				},
				[{ "zajrac", "smoke", "mission", "misja" }] = {
					text = "Ohh Yes, I would burn something, maybe those rats from Mirkotown? They evicted me for my pyrotechnic tendencies. ...\nWanna set somethin' on fire?",
				},
				[{ "yes", "tak" }] = {
					text = "If you want to play a little bit, go and burn some weed which I left in my house. Better for me if guards won't find it otherwise I'll have to run away. ...\n\nI can't show myself in the city, my cottage is located in the north of the city, you will recognize it immediately. ...\n\nHave this fire bug, you'll need it.",
					nextState = {
						[Storage.Firestarter.Mission01] = QuestState.Firestarter.Mission01.BurnHayStack,
					},
					rewards = {
						QuestKeyItems.Firestarter.FirebugHaystack,
					},
				},
			})
	end)
	:State(function()
		return QuestState.Firestarter.Mission01.BurnHayStack,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "Last time i checked, my house was at north gate of Mirkotown.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.Firestarter.Mission01] = QuestState.Firestarter.Mission01.ReportToHymel,
				}
				local hayStack = Action()

				function hayStack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					target:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
					player:NextState(nextState)
				end

				hayStack:key(Storage.Firestarter.FirebugHaystack)
				hayStack:register()
			end)
	end)
	:State(function()
		return QuestState.Firestarter.Mission01.ReportToHymel,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "It burns so nice, word. I'm hoping that guards won't get too high xD\nI see that you liked it, if you want to burn some more just {ask}. You can keep the lighter if it hasn't exploded yet.",
					nextState = {
						[Storage.Firestarter.Mission01] = QuestState.Firestarter.Mission01.AskForNewMission,
					},
					rewards = {
						{ id = 3731, count = 5 },
						QuestKeyItems.Firestarter.FirebugTree,
					},
					requiredItems = {
						QuestKeyItems.Firestarter.FirebugHaystack,
					},
					expReward = 2500,
				},
			})
	end)
	:State(function()
		return QuestState.Firestarter.Mission01.AskForNewMission,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "mission", "ask", "pytaj" }] = {
					text = "When I was still living in MirkoTown I've seen place where guards are going for a brake, they are sitting around campfire and rest there.\nSet the tree on fire near them, they will get mad for sure.\nAre you down for that?",
					nextTopic = QuestTopics.Firestarter.AcceptGuardTreeQuest,
				},
				[{ "yes", "tak" }] = {
					text = "Just don't go there during their lunch break, I don't have more beds xD.",
					requiredTopic = QuestTopics.Firestarter.AcceptGuardTreeQuest,
					nextState = {
						[Storage.Firestarter.Mission01] = MISSION_FINISHED,
						[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.SetGuardTreeOnFire,
					},
				},
			})
	end)
	:Mission(Storage.Firestarter.Mission02)
	:State(function()
		return QuestState.Firestarter.Mission02.SetGuardTreeOnFire,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "That tree is located near the west gate.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.ReportToHymel,
				}
				local hayStack = Action()

				function hayStack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					target:getPosition():sendMagicEffect(CONST_ME_FIREAREA)
					player:NextState(nextState)
				end

				hayStack:key(Storage.Firestarter.FirebugTree)
				hayStack:register()
			end)
	end)
	:State(function()
		return QuestState.Firestarter.Mission02.ReportToHymel,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "Too bad that I won't be seeing their faces when they will find out.\nYou're getting better. If you need more just come back! Take this staff that of the real smoker!",
					nextState = {
						[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.AskForNewMission,
					},
					expReward = 7000,
					rewards = {
						{ id = 7430 },
						{ id = 3731, count = 5 },
						QuestKeyItems.Firestarter.FirebugFlowers,
					},
					requiredItems = {
						QuestKeyItems.Firestarter.FirebugTree,
					},
				},
			})
	end)
	:State(function()
		return QuestState.Firestarter.Mission02.AskForNewMission,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "Once e and my fellas we were having fun and we planted some toxic flowers in Mirkotown, some of them were beyond city walls.\nSadly I am not able to tell you which ones exactly because they look like normal red flowers. \nIf you burn them the whole city will be high, would you do that?",
					nextTopic = QuestTopics.Firestarter.AcceptFlowerIgnitionQuest,
				},
				[{ "yes", "tak" }] = {
					text = "I knew i can count on you. Just be careful with that stuff!",
					requiredTopic = QuestTopics.Firestarter.AcceptFlowerIgnitionQuest,
					nextState = {
						[Storage.Firestarter.Mission02] = MISSION_FINISHED,
						[Storage.Firestarter.Mission03] = QuestState.Firestarter.Mission03.FindAndIgniteFlowers,
					},
				},
			})
	end)
	:Mission(Storage.Firestarter.Mission03)
	:State(function()
		return QuestState.Firestarter.Mission03.FindAndIgniteFlowers,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "We planted total of 5 flowers. You have o search in mirkotown and maybe in its closest vicinities.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local nextState = {
					[Storage.Firestarter.Mission03] = QuestState.Firestarter.Mission03.ReportToHymel,
				}
				local flowerId = 3657

				local flowerFirebug = Action()
				function flowerFirebug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					if target:getId() ~= flowerId then
						return false
					end

					local posIdentifier = toPosition:ToString()
					for key, flower in pairs(Storage.Firestarter.Flowers) do
						local state = player:getStorageValueByKey(flower)
						if state == posIdentifier then
							return false
						end
						if state ~= MISSION_NOT_STARTED then
							toPosition:sendMagicEffect(CONST_ME_FIREAREA)
							player:setStorageValueByKey(flower, posIdentifier)
							return true
						end
					end

					player:NextState(nextState)
				end
				flowerFirebug:key(Storage.Firestarter.FirebugFlowers)
				flowerFirebug:register()
			end)
	end)
	:State(function()
		return QuestState.Firestarter.Mission03.ReportToHymel,
			QuestFactory.Dialog("Hymel", {
				[{ "mission", "misja" }] = {
					text = "It was great! I already can see that smoke I'll be breathing in.\nTake this weapon for your achievements, you will be able to burn more stuff with it.\nThat was fun! See you!",
					expReward = 16000,
					rewards = {
						{ id = 3280 },
					},
					nextState = {
						[Storage.Firestarter.Mission03] = MISSION_FINISHED,
						[Storage.Finished.Firestarter] = MISSION_FINISHED,
					},
					requiredItems = {
						QuestKeyItems.Firestarter.FirebugFlowers,
					},
				},
			})
	end)
	:Register()
