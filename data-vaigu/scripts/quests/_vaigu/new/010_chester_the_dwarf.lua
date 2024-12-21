local quest = Quest(LOCALIZERS.ChesterTheDwarf)

quest
	:Storage(function()
		Storage.ChesterTheDwarf = {
			Mission01 = NextStorage(),
			Mission02 = NextStorage(),
			Mission03 = NextStorage(),
			Mission04 = NextStorage(),
			ChesterHouseStairs = NextStorage(),
			Document = NextStorage(),
			CaveTile = NextStorage(),
			GandalfBag = NextStorage(),
			DoorToChesterCompartment = NextStorage(),
		}
		QuestState.ChesterTheDwarf = {
			Mission01 = {
				BringMagicItemsToChester = 1,
				Finished = 2,
			},
			Mission02 = {
				AskChesterForMission = 1,
				ObtainDocuments = 2,
				BringDocumentsToChester = 3,
				Finished = 4,
			},
			Mission03 = {
				AskChesterForMission = 1,
				FindCave = 2,
				ReportToChester = 3,
				Finished = 4,
			},
			Mission04 = {
				FindChester = 1,
				ReturnToGandalf = 2,
				Finished = 3,
			},
		}
	end)
	:Constant(function()
		QuestKeyItems.ChesterTheDwarf = {
			IdentityDocument = {
				id = 19074,
				aid = Storage.ChesterTheDwarf.Document,
				desc = "Identity Document",
				text = "SURNAME\n\nBeefbottom\nNAME\nJohn\n\nCITIZENSHIP\nBoland\n\nFAMILY NAME\nAssman\n\nPARENTS NAMES\nAdam Eevee\n\nDate of Birth\n4.20.1969",
			},
			GandalfBag = {
				id = 13429,
				aid = Storage.ChesterTheDwarf.GandalfBag,
				desc = "This bag is sealed with the power of light. Gandalf is the only one who can reach into it.",
			},
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Chester the Dwarf",
			missions = {
				[Storage.ChesterTheDwarf.Mission01] = {
					name = "Fortune Teller 3000",
					states = {
						[QuestState.ChesterTheDwarf.Mission01.BringMagicItemsToChester] = "You agreed to help Chester become a TV fortune teller. He will need the following items for his profession: Magic Light Wand, Empty Goldfish Bowl, Magician's Robe, Life Crystal.",
						[QuestState.ChesterTheDwarf.Mission01.Finished] = "Chester the Dwarf has become a fortune teller, and you received his pickaxe as a reward.",
					},
				},
				[Storage.ChesterTheDwarf.Mission02] = {
					name = "Chester the Turf Accountant",
					states = {
						[QuestState.ChesterTheDwarf.Mission02.AskChesterForMission] = "You helped Chester the Dwarf with his TV fortune teller career. Ask him later if he needs help in another field.",
						[QuestState.ChesterTheDwarf.Mission02.ObtainDocuments] = "Chester the Dwarf entrusted you with a very discreet task. Obtain a new set of documents for him. He directed you to Moustachilles, the leader of the bandits at the camp near Mirkotown.",
						[QuestState.ChesterTheDwarf.Mission02.BringDocumentsToChester] = "You obtained the documents from Ornuld. Now, deliver them to Chester the Dwarf.",
						[QuestState.ChesterTheDwarf.Mission02.Finished] = "You acquired new documents for Chester the Dwarf, and he rewarded you for it.",
					},
				},
				[Storage.ChesterTheDwarf.Mission03] = {
					name = "Mirko Train Simulator",
					states = {
						[QuestState.ChesterTheDwarf.Mission03.AskChesterForMission] = "You helped Chester the Dwarf change his identity. Ask him later if he needs help in another field.",
						[QuestState.ChesterTheDwarf.Mission03.FindCave] = "Chester the Dwarf wants to sail away from the continent on his steamship. Find the entrance to the shaft leading to his ship.",
						[QuestState.ChesterTheDwarf.Mission03.ReportToChester] = "You found the cave that Chester the Dwarf was looking for. Now, return to him with the good news.",
						[QuestState.ChesterTheDwarf.Mission03.Finished] = "You helped Chester the Dwarf with his life problems. He has started packing to begin anew far, far away from here.",
					},
				},
				[Storage.ChesterTheDwarf.Mission04] = {
					name = "To the Labour Exchange in a Business Class",
					states = {
						[QuestState.ChesterTheDwarf.Mission04.FindChester] = "Chester the Dwarf has disappeared from the continent. Or has he? Maybe he hasn't managed to start the steamship underground yet. If possible, catch up to him and stop him.",
						[QuestState.ChesterTheDwarf.Mission04.ReturnToGandalf] = "Chester gave you Gandalf's lost item. Now, return to the mighty wizard and return his property.",
						[QuestState.ChesterTheDwarf.Mission04.Finished] = "Gandalf rewarded you for recovering his bag.",
					},
				},
			},
		}
	end)
	:Mission(Storage.ChesterTheDwarf.Mission01)
	:State(
		QuestState.ChesterTheDwarf.Mission01.BringMagicItemsToChester,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ GREET }] = {
				text = "Hello, hello. Have you already acquired all the items I requested?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "Thanks. I'm heading for the casting soon. Here's your reward, my pickaxe.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission01] = QuestState.ChesterTheDwarf.Mission01.Finished,
					[Storage.ChesterTheDwarf.Mission02] = QuestState.ChesterTheDwarf.Mission02.AskChesterForMission,
				},
				requiredItems = {
					{ id = 3046 },
					{ id = 7991 },
					{ id = 5928 },
					{ id = 3061 },
				},
				textNoRequiredItems = "Come back when you've collected all the items.",
				expReward = 60000,
				outfitRewards = {
					{ outfitId = 574, addon = 1 },
					{ outfitId = 575, addon = 1 },
				},
			},
		})
	)
	:Mission(Storage.ChesterTheDwarf.Mission02)
	:State(
		QuestState.ChesterTheDwarf.Mission02.AskChesterForMission,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "My career as a TV fortune teller was going well. Some time ago, I took out a loan to start my own business, which turned out to be a scam, of course. I went to the turf accountant and bet on RKS Huwdu winning. Those failures of a human decided to lose, and I ended up with a payday loan with 69% interest! The deadline for the first loan installment is approaching. I don't want the bailiff to seize my house. Try asking Moustachilles about my problem. They always manage to avoid the law and responsibility.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = QuestState.ChesterTheDwarf.Mission02.ObtainDocuments,
				},
			},
		})
	)
	:State(
		QuestState.ChesterTheDwarf.Mission02.ObtainDocuments,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Moustachilles has its bandit shithole located on east of mirkotown.",
			},
		}),
		QuestFactory.Dialog("Moustachilles", {
			[{ "tozsamosc", "dokument", "document", "identity", "czeslaw", "chester" }] = {
				text = "So, you want to know how to obtain a new identity? Oh, you're asking for a friend? Sure.. Have a chat with Ornuld in the jungle, he specializes in such matters...\nYou might need something to write with and paper, preferably from a very common book, and, of course, the payment...\nIf silence is gold, then forging documents is crystal. What the hell am I saying... Anyway, have a crystal coin with you.",
			},
		}),
		QuestFactory.Dialog("Ornuld", {
			[{ "mission", "misja", "document", "documents", "dokument", "identity", "tozsamosc" }] = {
				text = "As usual: Fairly good quality paper, may be a spellbook. Additionally an inkwell and a fee of 10,000 gp. Do you already have all {materials} and the payment?",
			},
			[{ "yes", "tak", "materials", "skladniki" }] = {
				text = "Here's the document for you.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = QuestState.ChesterTheDwarf.Mission02.BringDocumentsToChester,
				},
				requiredItems = {
					{ id = 3059 },
					{ id = 3509 },
				},
				requiredMoney = 1000 * 10,
				textNoRequiredItems = "Get back when you get all the items.",
				textNoRequiredMoney = "Get back when you get all the items.",
			},
		})
	)
	:State(
		QuestState.ChesterTheDwarf.Mission02.BringDocumentsToChester,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Thanks for your help. Now I'll be able to set up my office properly. Please take my mining helmet as a reward. As for the costs, I didn't expect such a high amount. I only have 70 platinum with me. I'll try to cover the rest in the future.",
				requiredItems = {
					QuestKeyItems.ChesterTheDwarf.IdentityDocument,
				},
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = QuestState.ChesterTheDwarf.Mission02.Finished,
					[Storage.ChesterTheDwarf.Mission03] = QuestState.ChesterTheDwarf.Mission03.AskChesterForMission,
				},
				outfitRewards = {
					{ outfitId = 574, addon = 3 },
					{ outfitId = 575, addon = 3 },
				},
				rewards = { { id = 3035, count = 70 } },
				expReward = 250000,
				textNoRequiredItems = "Don't you have a new document for me yet? I'll wait then.",
			},
		})
	)
	:Mission(Storage.ChesterTheDwarf.Mission03)
	:State(
		QuestState.ChesterTheDwarf.Mission03.AskChesterForMission,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "You still need to help me with one more thing. I accidentally burned my cover, and the officials will seize my house soon. For financial scams, evading the authorities and other frauds, I'll get at least 15 years. I'm too old for that. I won't even survive that long. I thought about escaping from this continent. Somewhere in the desert, deep underground, I parked my steamboat. It was a long time ago, so I don't remember where the entrance to the cave is where I keep the steam engine. All I remember is that the entrance is boarded up. Just find that place and come back to me to mark it on the map.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission03] = QuestState.ChesterTheDwarf.Mission03.FindCave,
				},
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 6660, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
			{ pos = { 6661, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
			{ pos = { 6662, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
		})
	)
	:State(
		QuestState.ChesterTheDwarf.Mission03.FindCave,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission", "entrance", "wejscie" }] = {
				text = "Come to think of it, I might have encountered some gargoyles while exploring around the cave.",
			},
		}),
		QuestFactory.Script(function(missionState)
			local updateStorages = {
				[Storage.ChesterTheDwarf.Mission03] = QuestState.ChesterTheDwarf.Mission03.ReportToChester,
			}

			local tile = MoveEvent()

			function tile.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if not player:HasExactMissionState(missionState) then
					return true
				end

				player:UpdateStorages(updateStorages)
				player:say(player:Localizer(Storage.ChesterTheDwarf.Questline):Get("This just might be the place Chester was talking about"), TALKTYPE_MONSTER_SAY)
				return true
			end

			tile:aid(Storage.ChesterTheDwarf.CaveTile)
			tile:type("stepin")
			tile:register()
		end)
	)
	:State(
		QuestState.ChesterTheDwarf.Mission03.ReportToChester,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Are you sure that's the place? All right, here are the keys to my mole. I don't remember where I parked it, but actually, any mole will do. One more thing: I heard that my travel companion, Gandalf, is still alive. We used to steal from a certain library where we found a prophecy about the resurrection of the Crypt King. If that moment ever comes, I think Gandalf will count on the help of the bravest warriors like you. If you want to befriend him, it's worth remembering this secret passphrase: {aside from that people}. Meanwhile, I'm heading out of here. Goodbye.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission03] = QuestState.ChesterTheDwarf.Mission03.Finished,
					[Storage.ChesterTheDwarf.DoorToChesterCompartment] = ACCESS_GRANTED,
				},
				expReward = 30000,
				rewards = { { id = 27605 } },
			},
		}),
		QuestFactory.StartupItems({
			{ pos = { 6438, 1125, 14 }, id = 9567, aid = Storage.ChesterTheDwarf.DoorToChesterCompartment },
			{ pos = { 7049, 826, 7 }, id = 5258, aid = Storage.ChesterTheDwarf.ChesterHouseStairs },
		})
	)
	:State(
		QuestState.ChesterTheDwarf.Mission03.Finished,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "oprocz tego ludzie", "aside from that people" }] = {
				text = "Yeah, its our key.",
			},
		}),
		QuestFactory.Script(function(missionState)
			local tile = MoveEvent()

			function tile.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:getStorageValue(Storage.ChesterTheDwarf.Mission03) == QuestState.ChesterTheDwarf.Mission03.Finished then
					player:teleportTo(fromPosition, true)
					player:say(player:Localizer(Storage.ChesterTheDwarf.Questline):Get("Chester's house is vacant right now. Therefore it would be impolite to tresspass."), TALKTYPE_MONSTER_SAY)
				end
				return true
			end

			tile:aid(Storage.ChesterTheDwarf.ChesterHouseStairs)
			tile:type("stepin")
			tile:register()
		end)
	)
	:Mission(Storage.ChesterTheDwarf.Mission04)
	:State(
		QuestState.ChesterTheDwarf.Mission04.FindChester,
		QuestFactory.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Found, not stolen. But due to our acquaintance, I can return what I took from Gandalf. Here's his camo backpack that I couldn't open. I won't lie, I'd like to know what's inside. Besides that, I have some stuff from WotE and this strange bag.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission04] = QuestState.ChesterTheDwarf.Mission04.ReturnToGandalf,
				},
				rewards = {
					[10326] = {
						{ id = 10343 },
						{ id = 11695 },
						{ id = 3035, count = 100 },
						{ id = 3043, count = 10 },
						{ id = 5882, count = 10 },
						{ id = 9058, count = 5 },
						{ id = 3027, count = 10 },
						{ id = 3041 },
						{ id = 5801 },
					},
					QuestKeyItems.ChesterTheDwarf.GandalfBag,
					{ id = 11698 },
					{ id = 27565 },
				},
			},
		})
	)
	:State(
		QuestState.ChesterTheDwarf.Mission04.ReturnToGandalf,
		QuestFactory.Dialog("Gandalf", {
			[{ "mission" }] = {
				text = "In this bag i kept an item from the WotE quest. I completed it on the *REDACTED* server. Do you remember was item it was?",
			},
			[{ "Royal Draken Mail" }] = {
				requiredItems = { QuestKeyItems.ChesterTheDwarf.GandalfBag },
				text = "Right, it was the Royal Draken Mail. Here's your reward.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission04] = QuestState.ChesterTheDwarf.Mission04.Finished,
					[Storage.Finished.ChesterTheDwarf] = 1,
				},
				rewards = { { id = 11686 } },
			},
			[{ "Royal Scale Robe" }] = {
				requiredItems = { QuestKeyItems.ChesterTheDwarf.GandalfBag },
				text = "Right, it was the Royal Scale Robe. Here's your reward.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission04] = QuestState.ChesterTheDwarf.Mission04.Finished,
					[Storage.Finished.ChesterTheDwarf] = 1,
				},
				rewards = { { id = 11687 } },
			},
			[{ "Elite Draken Helmet" }] = {
				requiredItems = { QuestKeyItems.ChesterTheDwarf.GandalfBag },
				text = "Right, it was the Elite Draken Helmet. Here's your reward.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission04] = QuestState.ChesterTheDwarf.Mission04.Finished,
					[Storage.Finished.ChesterTheDwarf] = 1,
				},
				rewards = { { id = 11689 } },
				textNoRequiredItems = "Lost the bag? Come back when you  it.",
			},
		})
	)
	:Register()
