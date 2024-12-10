local quest = Quest(LOCALIZERS)

quest
	:Storage(function()
		Storage.LocalSupport = {
			Discernment = 11019,
			VendorsAsked = {
				TrollskyAsked = 11020,
				FstabAsked = 11021,
				LebesgueAsked = 11022,
				PostmanAsked = 11023,
				MadameAsked = 11024,
				WalmartAsked = 11025,
				KomorAsked = 11026,
				DiggerAsked = 11027,
				JackAsked = 11028,
				GypsyAsked = 11029,
			},

			WoodDelivery = 11030,
			NarroStages = 11031,
			
			FreakingRats = 11046,
			PoisonedCheese = 11047,

			BudgetRecycling = 11045,

			LostCrystalBall = 11072,

			Biodegradable = 11084,
			Parcel = 11085,

			UnwantedGuests = 11076,
			OldManFrostPickaxe = 11077,

			TwoMarlinQuest = 2050,

			OcellatusXD = 11041,
			Ticket = 11042,
		}
		QuestState.LocalSupport = {
			OcellatusXD = {
				Mission01 = {
					FindTicket = 1,
					BringTicketToOcellatus = 2,
					AskOcellatusForNewMission = 3,
					BringFoodToOcellatus = 4,
					Finished = 5,
				},
			},
		}
	end)
	:Constant(function() end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Local Support",
			missions = {
				[Storage.StickyBeginning.Discernment] = {
					name = "Discernment",
					states = {
						[1] = "Find Commissioner Fisher and ask for a mission.",
						[2] = "VISIT_DEALERS_STATUS",
						[3] = "You visited all dealers in mirkotown and got rewarded by the Commissioner.",
					},
				},
				[Storage.StickyBeginning.WoodDelivery] = {
					name = "Wood Delivery",
					states = {
						[1] = "Go to Knurowo's port and find out what happened to the wood delivery.",
						[2] = "Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this.",
						[3] = "Woody asked you to investigate the bandit camp.",
						[4] = "Tell Ryba that Waski and his mafia stole all of the wood delivery.",
						[5] = "Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Narro's mafia.",
						[6] = "Waski gave up, and he is going to let Officer Ryba take the wood back. Report back to Ryba.",
						[7] = "Your merits earned you a special reward. Officer Ryba sent you to Trollsky, where you can receive your reward.",
					},
				},
				[Storage.LocalSupport.FreakingRats] = {
					name = "Freaking Rats",
					states = {
						[1] = "Walmart wishes she knew how to repel rats. Find out where Gertrude lives. She should know how to craft a rat poison.",
						[2] = "Gertrude asked you to bring her one mouldy cheese.",
						[3] = "The cheese has been poisoned. Bring it to Walmart, so she can repel the rats.",
						[4] = "Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift.",
					},
				},
				[Storage.LocalSupport.BudgetRecycling] = {
					name = "Cheap Recycling",
					states = {
						[1] = "Malkin asked you to bring her 1 piece of cloth of every color.",
						[2] = "Madame Malkin is grateful for your effort, and from now on you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth.",
					},
				},
				[Storage.LocalSupport.LostCrystalBall] = {
					name = "Broken Orb",
					states = {
						[1] = "Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly.",
						[2] = "The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing.",
					},
				},
				[Storage.LocalSupport.Biodegradable] = {
					name = "Biodegradable",
					states = {
						[1] = "Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west.",
						[2] = "You found the package for Old Postman. Return to him now.",
						[3] = "You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also box of fish bait to Anon's father.",
						[4] = "You took the box from Old Postman, which you should deliver to Anon's father.",
					},
				},
				[Storage.LocalSupport.UnwantedGuests] = {
					name = "Unwanted Guests",
					states = {
						[1] = "Bring Brutetamers Staff and Fur Boots to Old Man Frost.",
						[2] = "You completed Old Man Frosts's request.",
					},
				},
				[Storage.LocalSupport.TwoMarlinQuest] = {
					name = "Two Marlins",
					states = {
						[1] = "You delivered two marlins to Fisherman son and were rewarded for it.",
					},
				},
				[Storage.OcellatusXD] = {
					name = "Ocellatus Xddd",
					states = {
						[1] = "Recover the match tickets that have been stolen from Ocellatus.",
						[2] = "You found the Tickets in a bandit tent.",
						[3] = "You gave tickets back to Ocellatus. Ask him for new mission.",
						[4] = "Ocellatus asks you to bring him soup and wings. Ask Pewter for help.",
						[5] = "You brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat.",
					},
				},
			},
		}
	end)
	:Mission(Storage.LocalSupport.Discernment)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Commissioner Fisher", {
			[{ ANY_MESSAGE }] = {
				text = "New recruit? Great! Another cannon fodd.. I mean potential soldier.\nAt your first mission, visit all of the main sellers in MirkoTown and ask them if they need some help, after that come back to me to report.\nDon't do anything without consulting me. And now go, there's no time to lose.",
				nextState = {
					[Storage.LocalSupport.Discernment] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Trollsky", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "Well I do in fact need some help. Wood delivery from Knurow is already delayed by two days.quest I can't check on that myself as im busy doing my business here..",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.TrollskyAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.TrollskyAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Fstab", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "Everything is fine, but some journeyman could come in handy. Id say that you look promising.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.FstabAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.FstabAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Lebesgue the Philosopher", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "Everything is in perfect order, only if you could check what is going on with this wood delivery.. I'm almost out of my stock, I don't want to disappoint my customers.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.LebesgueAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.LebesgueAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Old Postman", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "There's something I need help with. One of the recent packages from the monks has gone missing. It probably got stuck while flowing along the {route} waterway.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.PostmanAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.PostmanAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Madame Malkin", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "I dont need any help, but I would be glad if you bring me one piece of {cloth} of each color. I will definitely pay back for that.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.MadameAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.MadameAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Walmart007", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.WalmartAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.WalmartAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Komor", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "Wood, wood delivery. It was supposed to arrive two days ago. Probably another riots in Knurow that blocked the road.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.KomorAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.KomorAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Grave Digger", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "I need help, but not in areas that Fisher would suspect me of. But if you want to be useful, please contact me.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.DiggerAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.DiggerAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Jack of all Swindles", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "I dont need any help, thanks. But you can always check my offer.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.JackAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.JackAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Gypsy", {
			[{ "mission", "misja", "help", "pomoc" }] = {
				text = "Ball! My fortune telling {ball} has stolen.",
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.GypsyAsked] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.VendorsAsked.GypsyAsked] = MISSION_FINISHED,
				},
			},
		}),
		QuestFactory.Dialog("Commissioner Fisher", {
			[{ ANY_MESSAGE }] = {
				text = "Gypsy fortune telling ball? He was a clumsy one ever since.\nThree people are complaining about wood deficiency? It has to be checked as soon as possible. Make your way to Knurowo and ask in about the delivery at the city pier.\nFollow the road at the west of the city and you will find it. I'll give you some potions supply, you may need them.",
				nextState = {
					[Storage.LocalSupport.Discernment] = MISSION_FINISHED,
					[Storage.LocalSupport.WoodDelivery] = _38f,
				},
				requiredState = {
					[Storage.LocalSupport.VendorsAsked.TrollskyAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.FstabAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.LebesgueAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.PostmanAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.MadameAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.WalmartAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.KomorAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.DiggerAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.JackAsked] = MISSION_FINISHED,
					[Storage.LocalSupport.VendorsAsked.GypsyAsked] = MISSION_FINISHED,
				},
				expReward = 6500,
				rewards = {
					{ id = 268, addToStore = true },
				},
			},
		})
	)
	:Mission(Storage.LocalSupport.WoodDelivery)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Woody", { [{ "drewno", "dostawa", "wood", "delivery", "mission", "misja" }] = {
			text = "What?! What do you mean the wood is missing? Three days ago I sent a caravan by myself... Something must have happened on its way, could you investigate that?",
			nextState = {
				[Storage.LocalSupport.WoodDelivery] = _38f,
			},
		} })
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Narro", {
			[{ "drewno", "dostawa", "misja", "mission", "wood" }] = {
				text = "What? Are you looking for the wood? Now thats my wood. You can tell Commissioner Fisher that he'll never get it back.",
				nextState = {
					[Storage.LocalSupport.WoodDelivery] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Commissioner Fisher", {
			text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you a better shield because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
			nextState = {
				[Storage.IKEAForTheBold.State] = _38f,
				[Storage.LocalSupport.WoodDelivery] = _38f,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Narro", {
			[{ "drewno", "dostawa", "misja", "mission", "wood" }] = {
				text = "Huh, hes a badass? I am the only badass here.\nNow YOU tell ME: am I the only badass in this bitch!?",
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer, effect = CONST_ME_YELLOWENERGY },
				},
				nextTopic = topics.confirmNarroIsBadass,
			},
			[{ "yes", "tak" }] = {
				text = "Thats right! And my mafia is badass too?",
				requiredTopic = topics.confirmNarroIsBadass,
				nextTopic = topics.confirmMafiaIsBadass,
			},
			[{ "yes", "tak" }] = {
				text = "Thats right, you are catching up quickly.",
				requiredTopic = topics.confirmNarroIsBadass,
				nextTopic = topics.confirmMafiaIsBadass,
			},
			[{ "no", "nie" }] = {
				text = "We'll see who's right soon enough!",
				requiredState = {
					[Storage.LocalSupport.NarroStages] = MISSION_NOT_STARTED,
				},
				nextState = {
					[Storage.LocalSupport.NarroStages] = 1,
				},
				spawnMonstersOnSuccess = {
					{ name = "Bandit", count = 5 },
					{ name = "Valkyrie", count = 1 },
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.endDialog },
				},
			},
			[{ "no", "nie" }] = {
				text = "Not this time.",
				requiredState = {
					[Storage.LocalSupport.NarroStages] = 1,
				},
				nextState = {
					[Storage.LocalSupport.NarroStages] = 2,
				},
				spawnMonstersOnSuccess = {
					{ name = "Assassin", count = 2 },
					{ name = "Valkyrie", count = 2 },
					{ name = "Hunter", count = 3 },
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.endDialog },
				},
			},
			[{ "no", "nie" }] = {
				text = "You thought thats gonna be this easy?!",
				requiredState = {
					[Storage.LocalSupport.NarroStages] = 2,
				},
				nextState = {
					[Storage.LocalSupport.NarroStages] = 3,
				},
				spawnMonstersOnSuccess = {
					{ name = "Hunter", count = 3 },
					{ name = "Assassin", count = 2 },
					{ name = "Bandit", count = 2 },
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.endDialog },
				},
			},
			[{ "no", "nie" }] = {
				text = "Okay, stop! Tell Commissioner Fisher that he can have his wood back.",
				requiredState = {
					[Storage.LocalSupport.NarroStages] = 3,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Commissioner Fisher", {
			text = "Very good, go speak with Trollsky about your reward, from now on you are a certified warrior of MirkoTown.",
			expReward = 55000,
			nextState = {
				[Storage.LocalSupport.WoodDelivery] = _38f,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Trollsky", {
			[{ "mission", "misja", "nagroda", "reward" }] = {
				text = "Yeah! You deserve some reward for helping us. You can choose one from the following: {Axe}, {sword}, {club}, {spellbook}, {bolts} and {arrows}.",
			},
			[{ "topor", "axe" }] = {
				text = "Here is your axe. You should also visit Fstab, he should provide you some supplies.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 3344 } },
			},
			[{ "miecz", "sword" }] = {
				text = "Here is your sword. You should also visit Fstab, he should provide you some supplies.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 2117 } },
			},
			[{ "obuch", "club" }] = {
				text = "Here is your club. You should also visit Fstab, he should provide you some supplies.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 7387 } },
			},
			[{ "spellbook", "ksiazka" }] = {
				text = "Here is your spellbook. You should also visit Fstab, he should provide you some supplies.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 7387 } },
			},
			[{ "belty", "bolts", "strzaly", "arrows" }] = {
				text = "Visit Lebesgue for this reward, and then meet Fstab. He should provide you some supplies.",
			},
		}),
		QuestFactory.Dialog("Lebesgue the Philosopher", {
			[{ "nagroda", "reward" }] = {
				text = "Trollsky sent you there? What you prefer to get, {bolts} or {arrows}?",
				textNoRequiredState = "You got your reward already, visit Fstab for a potion supply.",
			},
			[{ "belty", "bolts" }] = {
				text = "Here are bolts for you. You should visit Fstab for a potion supply.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 7364, count = 300 } },
			},
			[{ "strzaly", "arrows" }] = {
				text = "Here are arrows for you. You should visit Fstab for a potion supply.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = _38f },
				rewards = { { id = 7364, count = 300 } },
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Fstab", {
			[{ "nagroda", "reward" }] = {
				text = "Well, thank you on behalf of our City for your help, get some of these potions.",
				nextState = { [Storage.StickyBeginning.RewardState] = 4 },
				rewards = { { id = 268, count = 40 }, { id = 268, count = 5 } },
			},
		})
	)
	:Mission(Storage.LocalSupport.FreakingRats)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Walmart007", {
			[{ "help", "pomoc", "mission", "misja" }] = {
				text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
				requiredState = {
					[Storage.StickyBeginning.WalmartAsked] = 1,
				},
			},
			[{ "szczur", "szczurow", "rat", "rats" }] = {
				text = "I still have rats in the warehouse. I need some poison to get rid of them.",
				requiredState = {
					[Storage.StickyBeginning.WalmartAsked] = 1,
				},
				nextState = {
					[Storage.LocalSupport.FreakingRats] = 1,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog(
			"Gertrude",
			{ [{ "szczur", "szczury", "trutka", "ser", "rat", "rats" }] = {
				text = "Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night.",
				nextState = { [Storage.LocalSupport.FreakingRats] = 2 },
			} }
		)
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Gertrude", {
			[{ "szczur", "szczury", "trutka", "ser", "rat", "rats" }] = {
				text = "What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard.",
				textNoRequiredItems = "Bring me some mouldy cheese.",
				rewards = {
					{ id = 3210, aid = Storage.LocalSupport.PoisonedCheese, desc = "A deadly gas can be sensed coming from inside the cheese." },
				},
				requiredItems = {
					{ id = 3120 },
				},
				nextState = {
					[Storage.LocalSupport.FreakingRats] = 3,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Walmart007", {
			[{
				"mission",
				"misja",
				"szczur",
				"pomoc",
				"rat",
				"help",
				"trucizna",
				"trutka",
			}] = {
				text = "Are you sure it will work? Thanks for your help. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it.",
				rewards = { { id = 9087 }, { id = 36734 }, { id = 6392 } },
				expReward = 150000,
				requiredItems = { { id = 3120 } },
				nextState = { [Storage.LocalSupport.FreakingRats] = MISSION_FINISHED },
			},
		})
	)
	:Mission(Storage.LocalSupport.BudgetRecycling)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Madame Malkin", {
			[{ "mission", "misja", "tkaninie", "cloth", "tailor" }] = {
				text = "I like to sew something when I am bored but slowly I am lack of colorful fabrics.",
			},
			[Storage.LocalSupport.BudgetRecycling] = _38f,
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Madame Malkin", {
			[{ "mission", "misja", "tkaninie", "cloth", "tailor" }] = {
				text = "Thank you, the quality is not cutting edge but in the end I am Madame Malkin. I can replace your mystic turbans, red robes and green tunics for pieces of cloth from now on.",
				textNoRequiredItems = "I think you missed some colour, bring me all six",
				nextState = {
					[Storage.LocalSupport.BudgetRecycling] = MISSION_FINISHED,
				},
				requiredItems = {
					{ id = 5909 },
					{ id = 5910 },
					{ id = 5911 },
					{ id = 5912 },
					{ id = 5913 },
					{ id = 5914 },
				},
			},
		})
	)
	:Mission(Storage.LocalSupport.LostCrystalBall)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Gypsy", {
			[{ "mission", "misja", "kula", "ball", "kule" }] = {
				text = "My fortune telling ball! Probably it got stolen, maybe youll help me to find a new one? Come back to show me if you find any.",
				nextState = {
					[Storage.LocalSupport.LostCrystalBall] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Gypsy", {
			[{ "kula", "ball", "kule" }] = {
				text = "Well, the previous one was better, but this one is fine too. Thank you!\nYou can exchange your red gems for a ring of healing from now on.",
			},
		})
	)
	:Mission(Storage.LocalSupport.Biodegradable)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Old Postman", {
			[{ "szlakiem", "pass", "route", "mision", "misja" }] = {
				text = "The waterway begins at their rock to the west. Then it flows under the bridge, passes by the orc fortress, and enters a larger lake. From that lake, it flows to the Syn Anona. Somewhere along this waterway, my shipment got stuck.",
				nextState = {
					[Storage.LocalSupport.Biodegradable] = 1,
				},
				requiredState = {
					[Storage.StickyBeginning.PostmanAsked] = MISSION_FINISHED,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Old Postman", { [{ "misja", "mission", "przesylka", "parcel" }] = {
			text = "Come back when you find my shipment.",
		} })
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Old Postman", {
			[{ "misja", "mission", "przesylka", "parcel" }] = {
				text = "Were you able to find my {shipment}?",
			},
			[{ "przesylke", "parcel", "shipment", "paczka", "yes", "tak" }] = {
				text = "This parcel was delayed for a few weeks, and I was beginning to worry that alibaba was trying to trick me. Here's your reward for your help. I found something inside that Stary Anona ordered, probably a {bait} for fish. If you're passing by, deliver it to him. He will surely reward you.",
				requiredItems = {
					{ id = 3504, aid = Storage.LocalSupport.Parcel },
				},
				expReward = 15000,
				rewards = {
					{ id = 7290 },
				},
				nextState = {
					[Storage.Biodegradable.State] = 3,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("", {
			[{ "mission", "misja" }] = {
				text = "Could you take this package to Anon's father? He's surely getting impatient, so he'll reward you for your help.",
			},
			[{ "zaneta", "bait", "yes", "tak" }] = {
				text = "Here, please, this box. Anon's father hangs around a pond near the {barracks}.",
				nextState = {
					[Storage.Biodegradable.State] = 4,
					[Storage.SettledDownFishmonger.Mission01] = 1,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Old Postman", { [{ "koszary", "koszarow", "barracks" }] = {
			text = "Commissioner Fisher's barracks are in the southwest part of the city. He sent you here himself, are you drunk?",
		} }),
		QuestFactory.Dialog("Anon's Father", {})
	)
	:Mission(Storage.LocalSupport.UnwantedGuests)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Old Man Frost", {
			[{ "mission", "misja" }] = {
				text = "Few years ago it was peaceful here, but now it is difficult to live with barbarians roaming around.\nTry to take care of them. I know it's going to be hard to get everyone out, but even a few less of their kind will be a success.\nFor proof of defeating a few of them, bring me Brutetamers Staff and Fur Boots, this is their basic equipment.\nSo, would you like to help me?",
				nextTopic = topics.confirmBarbarianQuest,
			},
			[{ "yes", "tak" }] = {
				text = "Great, I'll give you a special pickaxe as a reward. I'll tell you what to do with it for later.",
				requiredTopic = topics.confirmBarbarianQuest,
				nextState = {
					[Storage.LocalSupport.UnwantedGuests] = _38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Old Man Frost", {
			[{ "mission", "misja" }] = {
				text = "Very well, let them die. I could use the cane, but you can keep the shoes. Take this pickaxe, just like we agreed.\nAbout this pickaxe - you can use it to smash icicles, for example, or some of the crystals on the island. The magic in this pickaxe is very faint and it only allows you to use it once a week.",
				requiredItems = {
					{ id = 7379 },
					{ id = 7457, remove = false },
				},
				expReward = 100000,
				rewards = {
					{ id = 4872, aid = Storage.LocalSupport.OldManFrostPickaxe },
				},
			},
		}),
		QuestFactory.Script(function()
			local icicleIds = {
				[6966] = true,
				[6707] = true,
				[6708] = true,
				[6711] = true,
				[6710] = true,
				[6709] = true,
				[6713] = true,
				[6714] = true,
			}
			local charmPoints = 10

			local oldManFrostPickaxe = Action()
			function oldManFrostPickaxe.onUse(player, item, fromPosition, target, toPosition, isHotkey)
				if not icicleIds[target:getId()] then
					return false
				end

				local cooldownExpiry = player:getStorageValue(Storage.LocalSupport.OldManFrostPickaxe)
				local now = os.time()
				if cooldownExpiry > now then
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Magic effects of this pickaxe have dissipated. It should be ready to use in few days.")
					return false
				end

				cooldownExpiry = GetNextWednesdayEpochTime()
				player:setStorageValue(cooldownExpiry)
				player:addCharmPoints(charmPoints)
				local bonusExp = player:ExpForNextlevel() * 0.25 + 50000
				AddExperienceWithAnnouncement(player, bonusExp)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You received :points: charm points.", { points = charmPoints }))
			end
			oldManFrostPickaxe:aid(Storage.LocalSupport.OldManFrostPickaxe)
			oldManFrostPickaxe:register()
		end)
	)
	:Mission(Storage.LocalSupport.TwoMarlinQuest)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Fisherman Son", {
			[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
				text = "Wow! You have merlin! Will I get this fish from you if we agree that I will make a nice trophy for you from second one you bring me?",
				requiredItems = {
					{ id = 901, remove = false },
				},
				nextTopic = 1,
			},
			[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
				text = "Yeah! Lets see.. <bonk blonk> Here you go. Hope you are satisfied",
				nextState = {
					[Storage.TwoMarlinQuest] = 1,
				},
				rewards = {
					{ id = 902 },
				},
				expReward = 17000,
				requiredTopic = 1,
				requiredItems = {
					{ id = 901, count = 2 },
				},
				textNoRequiredCondition = "Bring me exactly two marlins",
			},
		})
	)
	:State(
		MISSION_FINISHED,
		QuestFactory.Dialog("Fisherman Son", { [{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
			text = "Thank you for that marlin. It looks great by the fireplace.",
		} })
	)
	:Mission(Storage.LocalSupport.OcellatusXD)
	:State(
		MISSION_NOT_STARTED,
		QuestFactory.Dialog("Ocellatus", {
			[{ "mission", "misja" }] = {
				text = "You are probably not a football devotee like me, but I wanted to go to the {match}. However, someone disrupted my plans.",
				nextTopic = topics.acceptBringTicketQuest,
			},
			[{ "match", "mecz", "legia", "legii" }] = {
				text = "Well, I was supposed to go to my favourite team's match, but the nationalists came up and they ripped the from my hands. Could you help me get it back?",
				requiredTopic = topics.acceptBringTicketQuest,
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Ocellatus", { [{ "mission", "misja" }] = {
			text = "I hope that you'll find this ticket.",
		} })
		--38f script
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Ocellatus", {
			[{ "mission", "misja" }] = {
				text = "Thanks a lot! Can't wait to see the match. But there's something more, I'm stuck on this shithole and running low on food.\nWould you mind fixing some food for me?",
				expReward = 15000,
				requiredItems = {
					{ id = 28818, aid = Storage.OcellatusXD.Ticket },
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Ocellatus", {
			[{ "mission", "misja" }] = {
				text = "I'm stuck on this shithole and running low on food.\nWould you mind fixing some food for me?",
				nextTopic = topics.acceptBringFood,
			},
			[{ "yes", "tak" }] = {
				text = "I love {rotworm stew} and {roasted dragon wings} from Mickey Dicks. If you make this for me, I will certainly pay you back.",
				requiredTopic = topics.acceptBringFood,
				nextState = {
					[Storage.OcellatusXD.Mission01] = QuestState.OcellatusXD.Mission01._38f,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Ocellatus", {
			[{ "mission", "misja", "food", "soup", "order", "zupa" }] = {
				text = "Fantastic, thanks! Nevermind about the soup. Just the wings will suffice. You can use my boat whenever you want and take this soccer T-shirt. The size doesn't fit me anyway.",
				textNoRequiredItems = "Come back with the food.",
				expReward = 350000,
				requiredItems = {
					{ id = 9081 },
					{ id = 9079, remove = false },
				},
				outfitRewards = {
					{ outfit = 619, addons = 0 },
					{ outfit = 620, addons = 0 },
				},
				nextState = {
					[Storage.OcellatusXD.Mission01] = QuestState.OcellatusXD.Mission01._38f,
					[Storage.Finished.Ocellatus] = 1,
				},
			},
		})
	)
	:State(
		PH_STATE,
		QuestFactory.Dialog("Ocellatus", { [{ "mission", "misja" }] = {
			text = "That's all, thanks for your help.",
		} })
	)
	:Register()
