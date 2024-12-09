local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.ToCarryThePigs = {
			BeLikeSchwarzenegger = 11033,
			ArniNecklace = 11034,

			HalfTurnKick = 11035,
			SmugglingList = 11036,
			SmuggledLegs = 11037,

			BalancedDiet = 11037,
			EcoCarrot = 11038,

			KitzDominando = 11039,
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "To Carry the Pigs",
			missions = {
				[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = {
					name = "To be like the Schwarzenegger",
					states = {
						[1] = "Collect these items for me: 5 orc tooth, 5 carrion worm fangs, and 1 vampire teeth.",
						[2] = "Arni glanced at these teeth, and asked you to find someone who can make them into necklace.",
						[3] = "Madame Malkin gladly made this necklace for Arni.",
						[4] = "In exchange for the teeth necklace, Arni gave u his old armour and a ring.",
					},
				},
				[Storage.ToCarryThePigs.HalfTurnKick] = {
					name = "Half turn Kick",
					states = {
						[1] = "Cordell Walker is suspecting bandits of commissioning illegal transactions in their encampment.",
						[2] = "He was right. Now go to the Price Kebab and ask Shivganesh for translation.",
						[3] = "It wasn't hard at all for Shivganesh. Take the list and translation back to Cordell Walker.",
						[4] = "You have received MirkoTown guard hat for your help.",
					},
				},
				[Storage.ToCarryThePigs.BalancedDiet] = {
					name = "A Balanced Diet",
					states = {
						[1] = "Collect 1 slimming carrot for fat Mirek.",
						[2] = "The carrot was dogshit, and u received chocolate slush in for your effort.",
					},
				},
				[Storage.ToCarryThePigs.KitzDominando] = {
					name = "Kitz's Dominando",
					states = {
						[1] = "Arrange a special bow from elf adobe.",
						[2] = "You have received the item from Legolas. Go give it to Kitz.",
						[3] = "Turns out elvish bow sucks. Kitz now wishes to rook the elves. In return for your efforts you received his old bow.",
					},
				},
			},
		}
	end)
	:Mission(Storage.ToCarryThePigs.BeLikeSchwarzenegger)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Arni", {
			[{ "mission", "misja" }] = {
				text = "Mission? I would love to go on some mission, like Schwarzenegger did. He was the man. Do you think that I look as jacked as he did?\nIf you want to help me, you can do me a favour. Unfortunately, I can't leave this place and I miss a few things to become even a more badass.\nI always wanted to show off with my teeth necklace. I need 5 orc teeth, 5 rotworm teeth and maybe some of the vampire. Would you get them for me?",
				textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
				requiredState = {
					[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
				},
				nextTopic = topics.acceptTeethNecklaceQuest,
			},
			[{ "yes", "tak", "necklace", "naszyjnik" }] = {
				text = "Great.",
				requiredTopic = topics.acceptTeethNecklaceQuest,
				nextState = {
					[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = _38,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Arni", {
			[{ "mission", "misja", "necklace", "naszyjnik" }] = {
				text = "Thats awesome! Only if I knew how to make a necklace of that.. Please, find someone that will be able  to weave one of those teeths. I would be really greateful.",
				requiredItems = {
					{ id = 10196, count = 5 },
					{ id = 10275, count = 5 },
					{ id = 9685, count = 1 },
				},
				requiredItemsRemove = false,
			},
		}),
		QuestFactory.Dialog("Madaem Malkin", {
			[{ "mission", "misja", "necklace", "naszyjnik" }] = {
				text = "Oohh, from Arnie? For sure, he is so handsome. I will spray them with my perfumes. Greet him from me and take this necklace.",
				textNoRequiredItems = "I'm not able to make any necklace out of that..",
				requiredItems = {
					{ id = 10196, count = 5 },
					{ id = 10275, count = 5 },
					{ id = 9685, count = 1 },
				},
				rewards = {
					{ id = 7754, aid = Storage.ToCarryThePigs.ArniNecklace },
				},
				nextState = {
					[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = _38,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Arni", {
			[{ "mission", "misja" }] = {
				text = "Thank you! Wooah, and it even smells nice. Madame Malkin did a great job. Take this as your reward.",
				expReward = 30000,
				requiredItems = {
					{ id = 7754, aid = Storage.ToCarryThePigs.ArniNecklace },
				},
				rewards = {
					[9605] = {
						{ id = 3370 },
						{ id = 3098, count = 3 },
					},
				},
				nextState = {
					[Storage.ToCarryThePigs.BeLikeSchwarzenegger] = _38f,
				},
			},
		})
	)
	:Mission(Storage.ToCarryThePigs.HalfTurnKick)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Cordell Walker", {
			[{ "mission", "misja" }] = {
				text = "Of course I have a mission for you. You will become the soldier of MirkoTown, like I am.\nRecently, I have heard rumors of some illegal business conduted in a bandit village. Someone has not gotten fucked around for a long time.\nCheck it out, the village is to the east. Apparently they are smuggling using their basement tunnels.",
				textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
				requiredState = {
					[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
				},
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.StartupItems({
			{
				id = 405,
				pos = { 6014, 1455, 10 },
				rewards = {
					{ id = 22160, aid = Storage.ToCarryThePigs.SmugglingList },
				},
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Cordell Walker", {
			[{ "mission", "misja" }] = {
				text = "You managed to get in there, great. Hmm, but what's this language? I think that I know someone that will be able to translate it.\nYou should ask my close friend Shivganesh, who works in Prince Kebab in Hurghada.",
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Shivganesh", { [{ "mission", "misja" }] = {
			text = "Ah that's really simple. I will write down the translation on this piece of paper. Say hi to Walker from me.",
			nextState = {
				[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
			},
		} })
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Cordell Walker", {
			[{ "mission", "misja" }] = {
				text = "Thats very intereseting. From what Shivganesh wrote here, it would seem that they made some deal with the dwarves from the lignite mines. Hmm.. looks like they they sold them the legendary dragon scale legs. Investigate this, but be careful, as dwarves are much stronger than humans.",
				expReward = 130000,
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
				},
				requiredItems = {
					{ id = 22160, aid = Storage.ToCarryThePigs.SmugglingList, remove = false },
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.StartupItems({
			{
				id = 28462,
				pos = { 6088, 1215, 9 },
				rewards = {
					{ id = 24404, aid = Storage.ToCarryThePigs.SmuggledLegs },
				},
				nextState = {
					[Storage.ToCarryThePigs.HalfTurnKick] = _38f,
				},
				spawnMonstersOnSuccess = {
					{ name = "Lost Basher" },
					{ name = "Lost Husher", count = 2 },
				},
			},
		})
	)
	:State(
		PH_STATE,
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
				},
				requiredItems = {
					{ id = 24404, aid = Storage.ToCarryThePigs.SmuggledLegs },
				},
			},
		})
	)
	:Mission(Storage.ToCarryThePigs.BalancedDiet)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Fat Myrrus", {
			[{ "mission", "misja" }] = {
				text = "I need to finally lose weight. I heard that somewhere to the south, witches grow huge carrots that help with slimming. ...\nYou should leave MirkoTown through the southern gate and then head to the swamps. That's where you should find those carrots. Just bring me one.",
				textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
				requiredState = {
					[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
				},
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.StartupItems({
			{
				id = 15639,
				pos = { 5917, 1811, 8 },
				rewards = {
					{ id = 3250, aid = Storage.ToCarryThePigs.EcoCarrot },
				},
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = _38f,
				},
				requiredState = {},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Fat Myrrus", {
			[{ "mission", "misja" }] = {
				text = "Arrgh, that's gross! I definitely prefer hamburgers, but well, take this lump of chocolate dough. I tried to make a chocolate cake, but something went wrong. Also take my old knight legs, I don't fit in them anymore anyway.",
				textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = _38f,
				},
				rewards = {
					{ id = 8018 },
					{ id = 3371 },
				},
				requiredItems = {
					{ id = 3250, aid = Storage.ToCarryThePigs.EcoCarrot },
				},
				expReward = 30000,
				requiredState = {
					[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
				},
			},
		})
	)
	:Mission(Storage.ToCarryThePigs.KitzDominando)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("[SOLID] Kitz", {
			[{ "mission", "misja" }] = {
				text = "I have ordered a special bow from the Elves to make my dominando.\nHowever, I could not go there. Could you please get it and bring it to me?",
				textNoRequiredState = "Help Commissioner Fisher first, I cant trust you now.",
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = _38f,
				},
				requiredState = {
					[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Legolas", {
			[{ "mission", "misja" }] = {
				text = "Keep this special bow created with my elvish magic",
				textNoRequiredItems = "To craft this bow I'll need a lyre, 3 holy orchids, a red rose and a rope.",
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = _38f,
				},
				requiredItems = {
					{ id = 2949 },
					{ id = 5922, count = 3 },
					{ id = 3658 },
					{ id = 3003 },
				},
				rewards = {
					{ id = 9378, aid = Storage.ToCarryThePigs.NewBow },
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog(
			"[SOLID] Kitz",
			{ [{ "mission", "misja" }] = {
				text = "Is that THIS bow? Guess I got played by the elves. I will make them regret..\nBut thanks, you finished your mission. Here, keep my old bow in return.",
				nextState = {
					[Storage.ToCarryThePigs.BalancedDiet] = MISSION_FINISHED,
				},
				requiredItems = {
					{ id = 9378, aid = Storage.ToCarryThePigs.NewBow },
				},
			} }
		)
	)
