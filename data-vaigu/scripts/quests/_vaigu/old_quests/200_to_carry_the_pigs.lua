local quest = Quest(LOCALIZERS.ToCarryThePigs)

quest
	:Storage(function()
		Storage.ToCarryThePigs = {
			BeLikeSchwarzenegger = {},
			ArniNecklace = {},

			HalfTurnKick = {},
			SmugglingListChest = {},
			SmugglingList = {},
			SmuggledLegsChest = {},
			SmuggledLegs = {},

			BalancedDiet = {},
			EcoCarrot = {},
			CarrotChest = {},

			KitzDominando = {},
		}
		QuestState.ToCarryThePigs = {
			BeLikeSchwarzenegger = {
				CollectTeeth_CreateNecklace = 1,
				BringNecklaceToArni = 2,
			},
			HalfTurnKick = {
				InvestigateHeroCaves = 1,
				BringDocumentToCordell = 2,
				AskShivganeshForTranslation = 3,
				BringTranslationToCordell = 4,
				InvestigateDwarfs = 5,
				ReportFounterfeitLegs = 6,
			},
			BalancedDiet = {
				FindAndBringCarrotToFatMyrrus = 1,
			},
			KitzDominando = {
				ArrangeBowFromLegolas = 1,
				GiveBowToKitz = 2,
			},
		}
		QuestTopics.ToCarryThePigs = {
			AcceptTeethNecklaceQuest = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.ToCarryThePigs = {
			ArniNecklace = { id = 7754, key = Storage.ToCarryThePigs.ArniNecklace },
			SmugglingList = { id = 22160, key = Storage.ToCarryThePigs.SmugglingList },
			SmuggledLegs = { id = 24404, key = Storage.ToCarryThePigs.SmuggledLegs },
			EcoCarrot = { id = 3250, key = Storage.ToCarryThePigs.EcoCarrot },
			NewBow = { id = 9378, key = Storage.ToCarryThePigs.NewBow },
		}
	end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "To Carry the Pigs",
			localizer = localizer,
			missions = {
				{
					name = "To be like the Schwarzenegger",
					storage = Storage.ToCarryThePigs.BeLikeSchwarzenegger,
					states = {
						[QuestState.ToCarryThePigs.BeLikeSchwarzenegger.CollectTeeth_CreateNecklace] = "Arni asks you to collect the following items: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth.",
						[QuestState.ToCarryThePigs.BeLikeSchwarzenegger.BringNecklaceToArni] = "Madame Malkin gladly made this necklace for Arni. Report to Arni.",
						[MISSION_FINISHED] = "In exchange for the teeth necklace, Arni gave u his old armour and a ring.",
					},
				},
				{
					name = "Half turn Kick",
					storage = Storage.ToCarryThePigs.HalfTurnKick,
					states = {
						[QuestState.ToCarryThePigs.HalfTurnKick.InvestigateHeroCaves] = "Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment.",
						[QuestState.ToCarryThePigs.HalfTurnKick.BringDocumentToCordell] = "You found a some weird document in Hero hideout. Report to Cordell.",
						[QuestState.ToCarryThePigs.HalfTurnKick.AskShivganeshForTranslation] = "He was right. Now go to the Price Kebab and ask Shivganesh for translation.",
						[QuestState.ToCarryThePigs.HalfTurnKick.BringTranslationToCordell] = "It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker.",
						[QuestState.ToCarryThePigs.HalfTurnKick.InvestigateDwarfs] = "Cordell asked you to investigate further. Look for the legendary dragon scale legs in lost caves.",
						[QuestState.ToCarryThePigs.HalfTurnKick.ReportFounterfeitLegs] = "You found disfigured legs. Report your finding to Cordell.",
						[MISSION_FINISHED] = "Cordell rewarded you for your help.",
					},
				},
				{
					name = "A Balanced Diet",
					storage = Storage.ToCarryThePigs.BalancedDiet,
					states = {
						[QuestState.ToCarryThePigs.BalancedDiet.FindAndBringCarrotToFatMyrrus] = "Collect 1 slimming carrot and bring it to Fat Myrrus.",
						[MISSION_FINISHED] = "The carrot was dogshit, and u received chocolate slush in for your effort.",
					},
				},
				{
					name = "Kitz's Dominando",
					storage = Storage.ToCarryThePigs.KitzDominando,
					states = {
						[QuestState.ToCarryThePigs.KitzDominando.ArrangeBowFromLegolas] = "Arrange a special elvish bow for Kitz.",
						[QuestState.ToCarryThePigs.KitzDominando.GiveBowToKitz] = "You have received the bow from Legolas. Go give it to Kitz.",
						[MISSION_FINISHED] = "Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow.",
					},
				},
			},
		})
	end)
	:Mission(Storage.ToCarryThePigs.BeLikeSchwarzenegger)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Arni", {
				[{ "mission", "misja" }] = {
					text = "Mission? I would love to go on some mission, like Schwarzenegger did. He was the man. Do you think that I look as jacked as he did?\nIf you want to help me, you can do me a favour. Unfortunately, I can't leave this place and I miss a few things to become even a more badass.\nI always wanted to show off with my teeth necklace. I need 3 orc teeth, 3 rotworm teeth and maybe some of the vampire. Would you get them for me?",
					textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
					requiredState = {
						[Storage.LocalSupport.WoodDelivery] = { min = QuestState.LocalSupport.WoodDelivery.TakeTrollskyReward },
					},
					nextTopic = QuestTopics.ToCarryThePigs.AcceptTeethNecklaceQuest,
				},
				[{ "yes", "tak", "necklace", "naszyjnik" }] = {
					text = "Great.",
					requiredTopic = QuestTopics.ToCarryThePigs.AcceptTeethNecklaceQuest,
					nextState = {
						[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = QuestState.ToCarryThePigs.BeLikeSchwarzenegger.CollectTeeth_CreateNecklace,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.BeLikeSchwarzenegger.CollectTeeth_CreateNecklace,
			QuestFactory.Dialog("Arni", {
				[{ "mission", "misja", "necklace", "naszyjnik" }] = {
					text = "Thats awesome! Only if I knew how to make a necklace of that.. Please, find someone that will be able to weave one of those teeths. I would be really greateful.",
					requiredItems = {
						{ id = 10196, count = 3 },
						{ id = 10275, count = 3 },
						{ id = 9685, count = 1 },
					},
					removeRequiredItems = false,
				},
			}),
			QuestFactory.Dialog("Madame Malkin", {
				[{ "mission", "misja", "necklace", "naszyjnik" }] = {
					text = "Oohh, from Arnie? For sure, he is so handsome. I will spray them with my perfumes. Greet him from me and take this necklace.",
					textNoRequiredItems = "I'm not able to make any necklace out of that..",
					requiredItems = {
						{ id = 10196, count = 5 },
						{ id = 10275, count = 5 },
						{ id = 9685, count = 1 },
					},
					rewards = {
						QuestKeyItems.ToCarryThePigs.ArniNecklace,
					},
					nextState = {
						[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = QuestState.ToCarryThePigs.BeLikeSchwarzenegger.BringNecklaceToArni,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.BeLikeSchwarzenegger.BringNecklaceToArni,
			QuestFactory.Dialog("Arni", {
				[{ "mission", "misja" }] = {
					text = "Thank you! Wooah, and it even smells nice. Madame Malkin did a great job. Take this as your reward.",
					expReward = 40000,
					requiredItems = {
						QuestKeyItems.ToCarryThePigs.ArniNecklace,
					},
					rewards = {
						[9605] = {
							{ id = 3370 },
							{ id = 3098, count = 3 },
						},
					},
					nextState = {
						[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = MISSION_FINISHED,
						[Storage.Finished.BeLikeSchwarzenegger] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.ToCarryThePigs.HalfTurnKick)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Cordell Walker", {
				[{ "mission", "misja" }] = {
					text = "Of course I have a mission for you. You will become the soldier of MirkoTown, like I am.\nRecently, I have heard rumors of some illegal business conduted in a bandit village. Someone has not gotten fucked around for a long time.\nCheck it out, the village is to the east. Apparently they are smuggling using their basement tunnels.",
					textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
					requiredState = {
						[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
					},
					nextState = {
						[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.InvestigateHeroCaves,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.InvestigateHeroCaves, QuestFactory.OnUseDeclarations({
			{
				id = 405,
				key = Storage.ToCarryThePigs.SmugglingListChest,

				rewards = {
					QuestKeyItems.ToCarryThePigs.SmugglingList,
				},
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.BringDocumentToCordell,
				},
			},
		})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.BringDocumentToCordell,
			QuestFactory.Dialog("Cordell Walker", {
				[{ "mission", "misja" }] = {
					text = "You managed to get in there, great. Hmm, but what's this language? I think that I know someone that will be able to translate it.\nYou should ask my close friend Shivganesh, who works in Prince Kebab in Hurghada.",
					nextState = {
						[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.AskShivganeshForTranslation,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.AskShivganeshForTranslation,
			QuestFactory.Dialog("Shivganesh", { [{ "mission", "misja" }] = {
				text = "Ah that's really simple. I will write down the translation on this piece of paper. Say hi to Walker from me.",
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.BringTranslationToCordell,
				},
			} })
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.BringTranslationToCordell,
			QuestFactory.Dialog("Cordell Walker", {
				[{ "mission", "misja" }] = {
					text = "Thats very intereseting. From what Shivganesh wrote here, it would seem that they made some deal with the dwarves from the lignite mines. Hmm.. looks like they they sold them the legendary dragon scale legs. Investigate this, but be careful, as dwarves are much stronger than humans.",
					expReward = 130000,
					nextState = {
						[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.InvestigateDwarfs,
					},
					requiredItems = {
						QuestKeyItems.ToCarryThePigs.SmugglingList,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.InvestigateDwarfs,
			QuestFactory.OnUseDeclarations({
				{
					id = 28462,
					key = Storage.ToCarryThePigs.SmuggledLegsChest,
					rewards = {
						QuestKeyItems.ToCarryThePigs.SmuggledLegs,
					},
					nextState = {
						[Storage.ToCarryThePigs.HalfTurnKick] = QuestState.ToCarryThePigs.HalfTurnKick.ReportFounterfeitLegs,
					},
					spawnMonstersOnSuccess = {
						{ name = "Lost Basher" },
						{ name = "Lost Husher", count = 2 },
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.HalfTurnKick.ReportFounterfeitLegs,
			QuestFactory.Dialog("Cordell Walker", {
				[{ "mission", "misja" }] = {
					text = "Looks like they have been scammed. You can keep those legs, and please this hat as your reward. I'll whisper a word about you to the Commissioner.",
					expReward = 370000,
					rewards = {
						{ id = 9103 },
						{ id = 6299 },
						{ id = 24404 },
					},
					nextState = {
						[Storage.ToCarryThePigs.HalfTurnKick] = MISSION_FINISHED,
						[Storage.Finished.HalfTurnKick] = MISSION_FINISHED,
					},
					requiredItems = {
						QuestKeyItems.ToCarryThePigs.SmuggledLegs,
					},
				},
			})
	end)
	:Mission(Storage.ToCarryThePigs.BalancedDiet)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Fat Myrrus", {
				[{ "mission", "misja" }] = {
					text = "I need to finally lose weight. I heard that somewhere to the south, witches grow huge carrots that help with slimming. ...\nYou should leave MirkoTown through the southern gate and then head to the swamps. That's where you should find those carrots. Just bring me one.",
					textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
					requiredState = {
						[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
					},
					nextState = {
						[Storage.ToCarryThePigs.BalancedDiet] = QuestState.ToCarryThePigs.BalancedDiet.FindAndBringCarrotToFatMyrrus,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.BalancedDiet.FindAndBringCarrotToFatMyrrus,
			QuestFactory.OnUseDeclarations({
				{
					id = 15639,
					key = Storage.ToCarryThePigs.CarrotChest,
					rewards = {
						QuestKeyItems.ToCarryThePigs.EcoCarrot,
					},
					nextState = {
						[Storage.ToCarryThePigs.BalancedDiet] = QuestState.ToCarryThePigs.BalancedDiet.FindAndBringCarrotToFatMyrrus,
					},
					requiredState = {},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.BalancedDiet.FindAndBringCarrotToFatMyrrus,
			QuestFactory.Dialog("Fat Myrrus", {
				[{ "mission", "misja" }] = {
					text = "Arrgh, that's gross! I definitely prefer hamburgers, but well, take this lump of chocolate dough. I tried to make a chocolate cake, but something went wrong. Also take my old knight legs, I don't fit in them anymore anyway.",
					textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
					nextState = {
						[Storage.ToCarryThePigs.BalancedDiet] = MISSION_FINISHED,
						[Storage.Finished.BalancedDiet] = MISSION_FINISHED,
					},
					rewards = {
						{ id = 8018 },
						{ id = 3371 },
					},
					requiredItems = {
						QuestKeyItems.ToCarryThePigs.EcoCarrot,
					},
					expReward = 30000,
					requiredState = {
						[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.ToCarryThePigs.KitzDominando)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("[SOLID] Kitz", {
				[{ "mission", "misja" }] = {
					text = "I have ordered a special bow from the Elves to make my dominando.\nHowever, I could not go there. Could you please get it and bring it to me?",
					textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
					nextState = {
						[Storage.ToCarryThePigs.KitzDominando] = QuestState.ToCarryThePigs.KitzDominando.ArrangeBowFromLegolas,
					},
					requiredState = {
						[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.KitzDominando.ArrangeBowFromLegolas,
			QuestFactory.Dialog("Legolas", {
				[{ "mission", "misja" }] = {
					text = "Keep this special bow created with my elvish magic",
					textNoRequiredItems = "To craft this bow I'll need a lyre, 3 holy orchids, a red rose and a rope.",
					nextState = {
						[Storage.ToCarryThePigs.KitzDominando] = QuestState.ToCarryThePigs.KitzDominando.GiveBowToKitz,
					},
					requiredItems = {
						{ id = 2949 },
						{ id = 5922, count = 3 },
						{ id = 3658 },
						{ id = 3003 },
					},
					rewards = {
						QuestKeyItems.ToCarryThePigs.NewBow,
					},
				},
			})
	end)
	:State(function()
		return QuestState.ToCarryThePigs.KitzDominando.GiveBowToKitz,
			QuestFactory.Dialog(
				"[SOLID] Kitz",
				{
					[{ "mission", "misja" }] = {
						text = "Is that THIS bow? Guess I got played by the elves. I will make them regret..\nBut thanks, you finished your mission. Here, keep my old bow in return.",
						nextState = {
							[Storage.ToCarryThePigs.KitzDominando] = MISSION_FINISHED,
							[Storage.Finished.KitzDominando] = MISSION_FINISHED,
						},
						requiredItems = {
							QuestKeyItems.ToCarryThePigs.NewBow,
						},
					},
				}
			)
	end)
	:Register()
