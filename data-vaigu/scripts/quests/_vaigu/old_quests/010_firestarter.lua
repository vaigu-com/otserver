local quest = Quest(LOCALIZERS.Firestarter)

local topics = {
	acceptGuardTreeQuest = NextTopic(),
	acceptFlowerIgnitionQuest = NextTopic(),
}
quest
	:Storage(function()
		Storage.Firestarter = {
			Mission01 = 11009,
			FirebugHaystack = 11010,
			HayStack = 11013,

			Mission02 = 11011,
			FirebugTree = 11012,
			Tree = 11013,

			Mission03 = 11014,
			FirebugFlowers = 11015,
			Flowers = {
				Flower01 = 11016,
				Flower02 = 11017,
				Flower03 = 11018,
				Flower04 = 11019,
			},
			-- 11012-11016 kwiatki
		}
		QuestState.Firestarter = {
			Mission01 = {
				BurnHayStack = 1,
				ReportToHymel = 2,
				AskForNewMission = 3,
				Finished = 4,
			},
			Mission02 = {
				SetGuardTreeOnFire = 1,
				ReportToHymel = 2,
				Finished = 3,
			},
			Mission03 = {
				FindAndIgniteFlowers = 1,
				ReportToHymel = 2,
				Finished = 3,
			},
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Firestarter",
			missions = {
				[Storage.Firestarter.Mission01] = {
					name = "Mission 1: Fiery Beginnings",
					states = {
						[1] = "Hymel asked you to burn down the herbs he left on his house on north side of MikroTown.",
						[2] = "You burnt the herbs, now talk again with Hymel.",
						[3] = "Hymel gave you an incendiary firebug. From now on you can buy more firebugs from him.",
					},
				},
				[Storage.Firestarter.Mission02] = {
					name = "Mission 2: Little Treat",
					states = {
						[1] = "Hymel want to mischief the local guards, by setting an old tree on fire. You can find it near their resting camp.",
						[2] = "You did it, the guards didn't even notice, go back and see Hymel.",
						[3] = "In return for your help, Hymel gave you the staff of a real reefer.",
					},
				},
				[Storage.Firestarter.Mission03] = {
					name = "Mission 3: How High",
					states = {
						[1] = "Hymel told you about how he and his mates once sowed 5 mysterious herbs all around MirkoTown. Unfortunately he doesn't remember where exactly they did sow them. They look like usual red flowers. Find them and set them ablaze with firebug.",
						[2] = "The smell of weed is now around the whole city, you managed to burn all the flowers.",
						[3] = "Hymel declared you a true pyromaniac and gave you his arsonist weapon.",
					},
				},
			},
		}
	end)
	:Mission(Storage.Firestarter.Mission01)
	:State(
		MISSION_NOT_STARTED,
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
					{ id = 5467, aid = Storage.Firestarter.FirebugHaystack },
				},
			},
		})
	)
	:State(
		QuestState.Firestarter.Mission01.BurnHayStack,
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
				player:UpdateStorages(nextState)
			end

			hayStack:aid(Storage.Firestarter.FirebugHaystack)
			hayStack:register()
		end),
		QuestFactory.StartupItems({
			{ id = 5546, pos = { 5916, 1483, 7 }, aid = Storage.Firestarter.HayStack },
		})
	)
	:State(
		QuestState.Firestarter.Mission01.ReportToHymel,
		QuestFactory.Dialog("Hymel", {
			[{ "mission", "misja" }] = {
				text = "It burns so nice, word. I'm hoping that guards won't get too high xD\nI see that you liked it, if you want to burn some more just {ask}. You can keep the lighter if it hasn't exploded yet.",
				nextState = {
					[Storage.Firestarter.Mission01] = QuestState.Firestarter.Mission01.AskForNewMission,
				},
				rewards = {
					{ id = 3731, count = 5 },
					{ id = 5467, aid = Storage.Firestarter.FirebugTree },
				},
				requiredItems = {
					{ id = 5467, aid = Storage.Firestarter.FirebugHaystack },
				},
				expReward = 12000,
			},
		})
	)
	:State(
		QuestState.Firestarter.Mission01.AskForNewMission,
		QuestFactory.Dialog("Hymel", {
			[{ "mission", "mission", "ask", "pytaj" }] = {
				text = "When I was still living in MirkoTown I've seen place where guards are going for a brake, they are sitting around campfire and rest there.\nSet the tree on fire near them, they will get mad for sure.\nAre you down for that?",
				nextTopic = topics.acceptGuardTreeQuest,
			},
			[{ "yes", "tak" }] = {
				text = "Just don't go there during their lunch break, I don't have more beds xD.",
				requiredTopic = topics.acceptGuardTreeQuest,
				nextState = {
					[Storage.Firestarter.Mission01] = QuestState.Firestarter.Mission01.Finished,
					[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.SetGuardTreeOnFire,
				},
			},
		})
	)
	:Mission(Storage.Firestarter.Mission02)
	:State(
		QuestState.Firestarter.Mission02.SetGuardTreeOnFire,
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
				player:UpdateStorages(nextState)
			end

			hayStack:aid(Storage.Firestarter.FirebugTree)
			hayStack:register()
		end),
		QuestFactory.StartupItems({
			{ id = 3954, pos = { 5817, 1537, 7 }, aid = Storage.Firestarter.Tree },
		})
	)
	:State(
		QuestState.Firestarter.Mission02.ReportToHymel,
		QuestFactory.Dialog("Hymel", {
			[{ "mision", "misja" }] = {
				text = "Too bad that I won't be seeing their faces when they will find out.\nYou're getting better. If you need more just come back! Take this staff that of the real smoker!",
				nextState = {
					[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.AskForNewMission,
				},
				expReward = 16000,
				rewards = {
					{ id = 7430 },
					{ id = 3731, count = 5 },
					{ id = 5467, aid = Storage.Firestarter.FirebugFlowers },
				},
				requiredItems = {
					{ id = 5467, aid = Storage.Firestarter.FirebugTree },
				},
			},
		})
	)
	:State(
		QuestState.Firestarter.Mission02.AskForNewMission,
		QuestFactory.Dialog("Hymel", {
			[{ "mision", "misja" }] = {
				text = "Once e and my fellas we were having fun and we planted some toxic flowers in Mirkotown, some of them were beyond city walls.\nSadly I am not able to tell you which ones exactly because they look like normal red flowers. \nIf you burn them the whole city will be high, would you do that?",
				nextTopic = topics.acceptFlowerIgnitionQuest,
			},
			[{ "yes", "tak" }] = {
				text = "I knew i can count on you. Just be careful with that stuff!",
				requiredTopic = topics.acceptFlowerIgnitionQuest,
				nextState = {
					[Storage.Firestarter.Mission02] = QuestState.Firestarter.Mission02.Finished,
					[Storage.Firestarter.Mission03] = QuestState.Firestarter.Mission03.FindAndIgniteFlowers,
				},
			},
		})
	)
	:Mission(Storage.Firestarter.Mission03)
	:State(
		QuestState.Firestarter.Mission03.FindAndIgniteFlowers,
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
					local state = player:getStorageValue(flower)
					if state == posIdentifier then
						return false
					end
					if state ~= MISSION_NOT_STARTED then
						toPosition:sendMagicEffect(CONST_ME_FIREAREA)
						player:setStorageValue(flower, posIdentifier)
						return true
					end
				end

				player:UpdateStorages(nextState)
			end
			flowerFirebug:aid(Storage.Firestarter.FirebugFlowers)
			flowerFirebug:register()
		end)
	)
	:State(
		QuestState.Firestarter.Mission03.ReportToHymel,
		QuestFactory.Dialog("Hymel", {
			[{ "mission", "misja" }] = {
				text = "It was great! I already can see that smoke I'll be breathing in.\nTake this weapon for your achievements, you will be able to burn more stuff with it.\nThat was fun! See you!",
				expReward = 60000,
				nextState = {
					[Storage.Firestarter.Mission03] = QuestState.Firestarter.Mission03.Finished,
					[Storage.Finished.Firestarter] = 1,
				},
			},
		})
	)
	:Register()
--end of new definition for npc hymel
