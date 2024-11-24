local quest = Quest("chester_the_dwarf")
quest
	:Storage(function()
		Storage.ChesterTheDwarf = {
			Questline = NextStorage(),
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
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Chester the Dwarf",
			startStorageId = Storage.ChesterTheDwarf.Questline,
			startStorageValue = QUEST_STARTED,
			missions = {
				[1] = {
					name = "Fortune Teller 3000",
					storageId = Storage.ChesterTheDwarf.Mission01,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 2,
					states = {
						[1] = "You agreed to help Chester become a TV fortune teller. He will need the following items for his profession: Magic Light Wand, Empty Goldfish Bowl, Magician's Robe, Life Crystal.",
						[2] = "Chester the Dwarf has become a fortune teller, and you received his pickaxe as a reward.",
					},
				},
				[2] = {
					name = "Chester the Turf Accountant",
					storageId = Storage.ChesterTheDwarf.Mission02,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "You helped Chester the Dwarf with his TV fortune teller career. Ask him later if he needs help in another field.",
						[2] = "Chester the Dwarf entrusted you with a very discreet task. Obtain a new set of documents for him. He directed you to Moustachilles, the leader of the bandits at the camp near Mirkotown.",
						[3] = "You obtained the documents from Ornuld. Now, deliver them to Chester the Dwarf.",
						[4] = "You acquired new documents for Chester the Dwarf, and he rewarded you for it.",
					},
				},
				[3] = {
					name = "Mirko Train Simulator",
					storageId = Storage.ChesterTheDwarf.Mission03,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 4,
					states = {
						[1] = "You helped Chester the Dwarf change his identity. Ask him later if he needs help in another field.",
						[2] = "Chester the Dwarf wants to sail away from the continent on his steamship. Find the entrance to the shaft leading to his ship.",
						[3] = "You found the cave that Chester the Dwarf was looking for. Now, return to him with the good news.",
						[4] = "You helped Chester the Dwarf with his life problems. He has started packing to begin anew far, far away from here.",
					},
				},
				[4] = {
					name = "Business Class to the Labour Exchange",
					storageId = Storage.ChesterTheDwarf.Mission04,
					missionId = NextMissionId(),
					startValue = 0,
					endValue = 3,
					states = {
						[1] = "Chester the Dwarf has disappeared from the continent. Or has he? Maybe he hasn't managed to start the steamship underground yet. If possible, catch up to him and stop him.",
						[2] = "Chester gave you Gandalf's lost item. Now, return to the mighty wizard and return his property.",
						[3] = "Gandalf rewarded you for recovering his bag.",
					},
				},
			},
		}
	end)
	:Mission(Storage.ChesterTheDwarf.Mission01)
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ GREET }] = {
				text = "Hello, hello. Have you already acquired all the items I requested?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "Thanks. I'm heading for the casting soon. Here's your reward, my pickaxe.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission01] = 2,
					[Storage.ChesterTheDwarf.Mission02] = 1,
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
	:Mission()
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "My career as a TV fortune teller was going well. Some time ago, I took out a loan to start my own business, which turned out to be a scam, of course. I went to the turf accountant and bet on RKS Huwdu winning. Those failures of a human decided to lose, and I ended up with a payday loan with 69% interest! The deadline for the first loan installment is approaching. I don't want the bailiff to seize my house. Try asking Moustachilles about my problem. They always manage to avoid the law and responsibility.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = 2,
				},
			},
		})
	)
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Moustachilles has its bandit shithole located on east of mirkotown.",
			},
		}),
		Quest.Dialog("Moustachilles", {
			[{ "tozsamosc", "dokument", "document", "identity", "czeslaw", "chester" }] = {
				text = "So, you want to know how to obtain a new identity? Oh, you're asking for a friend? Sure.. Have a chat with Ornuld in the jungle, he specializes in such matters...\nYou might need something to write with and paper, preferably from a very common book, and, of course, the payment...\nIf silence is gold, then forging documents is crystal. What the hell am I saying... Anyway, have a crystal coin with you.",
			},
		}),
		Quest.Dialog("Ornuld", {
			[{ "mission", "misja", "document", "documents", "dokument", "identity", "tozsamosc" }] = {
				text = "As usual: Fairly good quality paper, may be a spellbook. Additionally an inkwell and a fee of 10,000 gp. Do you already have all {materials} and the payment?",
			},
			[{ "yes", "tak", "materials", "skladniki" }] = {
				text = "Here's the document for you.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = 3,
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
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Thanks for your help. Now I'll be able to set up my office properly. Please take my mining helmet as a reward. As for the costs, I didn't expect such a high amount. I only have 70 platinum with me. I'll try to cover the rest in the future.",
				requiredItems = {
					CZESLAW_KRANSOLUD_KEY_ITEMS.identityDocument,
				},
				nextState = {
					[Storage.ChesterTheDwarf.Mission02] = 4,
					[Storage.ChesterTheDwarf.Mission03] = 1,
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
	:Mission()
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "You still need to help me with one more thing. I accidentally burned my cover, and the officials will seize my house soon. For financial scams, evading the authorities and other frauds, I'll get at least 15 years. I'm too old for that. I won't even survive that long. I thought about escaping from this continent. Somewhere in the desert, deep underground, I parked my steamboat. It was a long time ago, so I don't remember where the entrance to the cave is where I keep the steam engine. All I remember is that the entrance is boarded up. Just find that place and come back to me to mark it on the map.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission03] = 2,
				},
			},
		}),
		Quest.StartupItems({
			{ pos = { 6660, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
			{ pos = { 6661, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
			{ pos = { 6662, 1139, 7 }, id = 231, aid = Storage.ChesterTheDwarf.CaveTile },
		})
	)
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission", "entrance", "wejscie" }] = {
				text = '"Come to think of it, I might have encountered some gargoyles while exploring around the cave.',
			},
			Quest.Script(function(missionState)
				local updateStorages = {
					[Storage.ChesterTheDwarf.Mission03] = 3,
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
			end),
		})
	)
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Are you sure that's the place? All right, here are the keys to my mole. I don't remember where I parked it, but actually, any mole will do. One more thing: I heard that my travel companion, Gandalf, is still alive. We used to steal from a certain library where we found a prophecy about the resurrection of the Crypt King. If that moment ever comes, I think Gandalf will count on the help of the bravest warriors like you. If you want to befriend him, it's worth remembering this secret passphrase: {aside from that people}. Meanwhile, I'm heading out of here. Goodbye.",
				nextState = {
					[Storage.ChesterTheDwarf.Mission03] = 4,
					[Storage.ChesterTheDwarf.DoorToChesterCompartment] = 1,
				},
				expReward = 30000,
				rewards = { { id = 27605 } },
			},
		}),
		Quest.StartupItems({
			{ pos = { 6438, 1125, 14 }, id = 9567, aid = Storage.ChesterTheDwarf.DoorToChesterCompartment },
			{ pos = { 7049, 826, 7 }, id = 5258, aid = Storage.ChesterTheDwarf.ChesterHouseStairs },
		})
	)
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "oprocz tego ludzie", "aside from that people" }] = {
				text = "Yeah, its our key.",
			},
		}),
		Quest.Script(function(missionState)
			local tile = MoveEvent()

			function tile.onStepIn(creature, item, toPosition, fromPosition)
				local player = creature:getPlayer()
				if not player then
					return true
				end

				if player:getStorageValue(Storage.ChesterTheDwarf.Mission03) >= 8 then --38f 8->finished?
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
	:Mission()
	:State(
		PH_STATE,
		Quest.Dialog("Chester the Dwarf", {
			[{ "mission" }] = {
				text = "Found, not stolen. But due to our acquaintance, I can return what I took from Gandalf. Here's his camo backpack that I couldn't open. I won't lie, I'd like to know what's inside. Besides that, I have some stuff from WotE and this strange bag.",
				nextState = {
					[Storage.ChesterTheDwarf.Questline] = 10,
					[Storage.ChesterTheDwarf.Mission04] = 2,
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
					CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag,
					{ id = 11698 },
					{ id = 27565 },
				},
			},
		})
	)
