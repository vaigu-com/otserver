local quest = Quest(LOCALIZERS.LocalSupport)

quest
	:Storage(function()
		Storage.LocalSupport = {
			Discernment = NextStorage(),
			VendorsAsked = {
				TrollskyAsked = NextStorage(),
				FstabAsked = NextStorage(),
				LebesgueAsked = NextStorage(),
				PostmanAsked = NextStorage(),
				MadameAsked = NextStorage(),
				WalmartAsked = NextStorage(),
				KomorAsked = NextStorage(),
				DiggerAsked = NextStorage(),
				JackAsked = NextStorage(),
				GypsyAsked = NextStorage(),
			},

			WoodDelivery = NextStorage(),
			NarroStages = NextStorage(),

			FreakingRats = NextStorage(),
			PoisonedCheese = NextStorage(),

			BudgetRecycling = NextStorage(),

			LostCrystalBall = NextStorage(),

			Biodegradable = NextStorage(),
			FishBait = NextStorage(),
			Parcel = NextStorage(),

			UnwantedGuests = NextStorage(),
			OldManFrostPickaxe = NextStorage(),

			TwoMarlinQuest = NextStorage(),

			OcellatusXD = NextStorage(),
			Ticket = NextStorage(),

			IKEAForTheBold = NextStorage(),
			SpawnDominoUndergroundChest = NextStorage(),
			BookChest = NextStorage(),
			BookOfContraband = NextStorage(),
			UpstairsRoom = NextStorage(),
			MilesAsked = NextStorage(),
			TileBeforeHawser = NextStorage(),
			ShoreCaveChest = NextStorage(),
			LumberjackBoatAccess = NextStorage(),

			SettledDownFishmonger = NextStorage(),
			FishmongerFloat = NextStorage(),
			FishmongerReel = NextStorage(),
			FishmongerStool = NextStorage(),
			FishermanSonBoat = NextStorage(),
		}
		QuestState.LocalSupport = {
			Discernment = {
				VisitDealers = 1,
			},
			WoodDelivery = {
				TalkWithWoody = 1,
				InvestigateCamp = 2,
				TellCommissionerAboutMafia = 3,
				DealWithNarroMafia = 4,
				ReportToCommissioner = 5,
				TakeTrollskyReward = 6,
				TakeFstabReward = 7,
			},
			NarroFight = {
				DefeatedFirstWave = 1,
				DefeatedSecond = 2,
				DefeatedThirdWave = 3,
			},
			FreakingRats = {
				AskGertrudeForRepellant = 1,
				BringMouldyCheeseToGertrude = 2,
				BringPoisonedChesseToWalmart = 3,
			},
			BudgetRecycling = {
				BringPieceOfEachClothToMadame = 1,
			},
			LostCrystalBall = {
				FindBallForGypsy = 1,
			},
			Biodegradable = {
				FindPostmanPackage = 1,
				ReturnPackageToPostman = 2,
				AskForNewMission = 3,
			},
			UnwantedGuests = {
				BringOldManFrostItems = 1,
			},
			TwoMarlinQuest = {
				--none
			},
			OcellatusXD = {
				FindTicket = 1,
				BringTicketToOcellatus = 2,
				AskOcellatusForNewMission = 3,
				BringFoodToOcellatus = 4,
			},
			IKEAForTheBold = {
				OfferHelpToKomor = 1,
				AskGypsy = 2,
				FindThiefInSewers = 3,
				SearchDominoUndergroundHideout = 4,
				BringStolenItemListToKomor = 5,
				ConsultCommissioner = 6,
				AskNearbyPeople_FindMoustachilles = 7,
				AskMoustachillesAboutDomino = 8,
				FindAndKillDominoShore = 9,
				SearchDominoShoreHideout = 10,
				ReportToCommissioner = 11,
			},
			SettledDownFishmonger = {
				DeliverAnonFatherPackage = 1,
				FindAndDevilerAnonFatherMissingItems = 2,
				BringSoupToAnonFather = 3,
				AskFishermanSonForReward = 4,
			},
		}
		SpawnLocks.LocalSupport = {
			IKEAForTheBold = {
				DominoUnderground = SpawnLock(),
				DominoShore = SpawnLock(),
			},
		}
		QuestTopics.LocalSupport = {
			AcceptBringTicketQuest = NextTopic(),
			AcceptBringFoodQuest = NextTopic(),
			ConfirmUnwatedGuestsQuest = NextTopic(),
			ConfirmNarroIsBadass = NextTopic(),
			ConfirmMafiaIsBadass = NextTopic(),
			ConfirmHavingpackage = NextTopic(),
			ConfirmBuyingShimmerSwimmer = NextTopic(),
			ConfirmTradeInTwomarlins = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.LocalSupport = {
			PoisonedCheese = { id = 3210, aid = Storage.LocalSupport.PoisonedCheese, desc = "A deadly gas can be sensed coming from inside the cheese." },
			Parcel = { id = 3504, aid = Storage.LocalSupport.Parcel },
			OldManFrostPickaxe = { id = 4872, aid = Storage.LocalSupport.OldManFrostPickaxe },
			Ticket = { id = 28818, aid = Storage.LocalSupport.Ticket },
			BookOfContraband = { id = 2816, aid = Storage.LocalSupport.BookOfContraband, text = "DOMINO_BOOK_OF_CONTRABAND_TEXT" },
			FishBait = { id = 15817, aid = Storage.LocalSupport.FishBait },
			FishmongerFloat = { id = 6126, aid = Storage.LocalSupport.FishmongerFloat },
			FishmongerReel = { id = 3224, aid = Storage.LocalSupport.FishmongerReel },
			FishmongerStool = { id = 3107, aid = Storage.LocalSupport.FishmongerStool },
		}
	end)
	:Questlog(function()
		Quests[NextQuestId()] = {
			name = "Local Support",
			missions = {
				[Storage.LocalSupport.Discernment] = {
					name = "Discernment",
					states = {
						[MISSION_NOT_STARTED] = "Commissioner fisher wants to see you, the new recruit, so he can show you your way around the city. Find his quarters in the southern west part of this city, the Mirkotown.",
						[1] = "VISIT_DEALERS_STATUS",
						[2] = "VISIT_DEALERS_STATUS",
						[3] = "VISIT_DEALERS_STATUS",
						[4] = "VISIT_DEALERS_STATUS",
						[5] = "VISIT_DEALERS_STATUS",
						[6] = "VISIT_DEALERS_STATUS",
						[7] = "VISIT_DEALERS_STATUS",
						[8] = "VISIT_DEALERS_STATUS",
						[9] = "VISIT_DEALERS_STATUS",
						[10] = "VISIT_DEALERS_STATUS",
						[MISSION_FINISHED] = "You visited all dealers in mirkotown and got rewarded by the Commissioner.",
					},
				},
				[Storage.LocalSupport.WoodDelivery] = {
					name = "Wood Delivery",
					states = {
						[QuestState.LocalSupport.WoodDelivery.TalkWithWoody] = "Go to Knurowo's port and find out what happened to the wood delivery.",
						[QuestState.LocalSupport.WoodDelivery.InvestigateCamp] = "Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this.",
						[QuestState.LocalSupport.WoodDelivery.TellCommissionerAboutMafia] = "Tell Ryba that Narro and his mafia stole all of the wood delivery.",
						[QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia] = "Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Narro's mafia.",
						[QuestState.LocalSupport.WoodDelivery.ReportToCommissioner] = "Narro gave up, and he is going to let Commissioner take the wood back. Report back to Commissioner.",
						[QuestState.LocalSupport.WoodDelivery.TakeTrollskyReward] = "Your merits earned you a special reward. Commissioner sent you to Trollsky, where you can receive your reward.",
						[QuestState.LocalSupport.WoodDelivery.TakeFstabReward] = "3af",
						[MISSION_FINISHED] = "3af",
					},
				},
				[Storage.LocalSupport.FreakingRats] = {
					name = "Freaking Rats",
					states = {
						[QuestState.LocalSupport.FreakingRats.AskGertrudeForRepellant] = "Walmart wishes she knew how to repel rats. Find out where Gertrude lives. She should know how to craft a rat poison.",
						[QuestState.LocalSupport.FreakingRats.BringMouldyCheeseToGertrude] = "Gertrude asked you to bring her one mouldy cheese.",
						[QuestState.LocalSupport.FreakingRats.BringPoisonedChesseToWalmart] = "The cheese has been poisoned. Bring it to Walmart, so she can repel the rats.",
						[MISSION_FINISHED] = "Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift.",
					},
				},
				[Storage.LocalSupport.BudgetRecycling] = {
					name = "Cheap Recycling",
					states = {
						[QuestState.LocalSupport.BudgetRecycling.BringPieceOfEachClothToMadame] = "Malkin asked you to bring her 1 piece of cloth of every color.",
						[MISSION_FINISHED] = "Madame Malkin is grateful for your effort, and from now on you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth.",
					},
				},
				[Storage.LocalSupport.LostCrystalBall] = {
					name = "Broken Orb",
					states = {
						[QuestState.LocalSupport.LostCrystalBall.FindBallForGypsy] = "Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly.",
						[MISSION_FINISHED] = "The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing.",
					},
				},
				[Storage.LocalSupport.Biodegradable] = {
					name = "Biodegradable",
					states = {
						[QuestState.LocalSupport.Biodegradable.FindPostmanPackage] = "Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west.",
						[QuestState.LocalSupport.Biodegradable.ReturnPackageToPostman] = "You found the package for Old Postman. Return to him now.",
						[QuestState.LocalSupport.Biodegradable.AskForNewMission] = "You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also box of fish bait to Anon's father.",
						[MISSION_FINISHED] = "You took the box from Old Postman, which you should deliver to Anon's father.",
					},
				},
				[Storage.LocalSupport.UnwantedGuests] = {
					name = "Unwanted Guests",
					states = {
						[QuestState.LocalSupport.UnwantedGuests.BringOldManFrostItems] = "Bring Brutetamers Staff and Fur Boots to Old Man Frost.",
						[MISSION_FINISHED] = "You completed Old Man Frost's request.",
					},
				},
				[Storage.LocalSupport.TwoMarlinQuest] = {
					name = "Two Marlins",
					states = {
						[MISSION_FINISHED] = "You delivered two marlins to Fisherman son and were rewarded for it.",
					},
				},
				[Storage.LocalSupport.OcellatusXD] = {
					name = "Ocellatus Xddd",
					states = {
						[QuestState.LocalSupport.OcellatusXD.FindTicket] = "Recover the match tickets that have been stolen from Ocellatus.",
						[QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus] = "You found the Tickets in a bandit tent.",
						[QuestState.LocalSupport.OcellatusXD.AskOcellatusForNewMission] = "You gave tickets back to Ocellatus. Ask him for new mission.",
						[QuestState.LocalSupport.OcellatusXD.BringFoodToOcellatus] = "Ocellatus asks you to bring him soup and wings. Ask Pewter for help.",
						[MISSION_FINISHED] = "You brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat.",
					},
				},
				[Storage.LocalSupport.IKEAForTheBold] = {
					name = "IKEA for the BOLD",
					states = {
						[QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor] = "Commissioner Fisher has mentioned that Komor needs help.",
						[QuestState.LocalSupport.IKEAForTheBold.AskGypsy] = "Komor suggested you to Gypsy whether he knows anything about the theft of the furniture.",
						[QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers] = "Try to find the thief; he's possibly hiding in the sewers.",
						[QuestState.LocalSupport.IKEAForTheBold.SearchDominoUndergroundHideout] = "You found the thief, but he managed to get away. Try to look around his hideout.",
						[QuestState.LocalSupport.IKEAForTheBold.BringStolenItemListToKomor] = "You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list.",
						[QuestState.LocalSupport.IKEAForTheBold.ConsultCommissioner] = "Komor asked you to consult Commissioner Fisher about the thief.",
						[QuestState.LocalSupport.IKEAForTheBold.AskNearbyPeople_FindMoustachilles] = "Fisher asked you to track down the thief. Perhaps someone from nearby saw where he ran away?",
						[QuestState.LocalSupport.IKEAForTheBold.AskMoustachillesAboutDomino] = "Ask the bandit leader about the furniture thief.",
						[QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore] = "The thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now.",
						[QuestState.LocalSupport.IKEAForTheBold.SearchDominoShoreHideout] = "You have defeated the Lumberjack Domino, look around his hiding place.",
						[QuestState.LocalSupport.IKEAForTheBold.ReportToCommissioner] = "From now on, you can use Domino's boat. Report to Commissioner Fisher.",
						[MISSION_FINISHED] = "You prematurely ended the efforts of Lumberjack Domino. From now on you can sail his boat from the bandit camp to the south of the steppes.",
					},
				},
				[Storage.LocalSupport.SettledDownFishmonger] = {
					name = "Settled down Fishmonger",
					states = {
						[QuestState.LocalSupport.SettledDownFishmonger.DeliverAnonFatherPackage] = "Anon's father is waiting for his order.",
						[QuestState.LocalSupport.SettledDownFishmonger.FindAndDevilerAnonFatherMissingItems] = "Anon's father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items.",
						[QuestState.LocalSupport.SettledDownFishmonger.BringSoupToAnonFather] = "Anon's father received his table in a deplorable state, ask how you can improve his mood.",
						[QuestState.LocalSupport.SettledDownFishmonger.AskFishermanSonForReward] = "You helped Anon's father with all the troubles. Now, go to his son for your reward.",
						[MISSION_FINISHED] = "You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer.",
					},
				},
			},
		}
	end)
	:Mission(Storage.LocalSupport.Discernment)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ ANY_MESSAGE }] = {
					text = "New recruit? Great! Another cannon fodd.. I mean potential soldier.\nAt your first mission, visit all of the main sellers in MirkoTown and ask them if they need some help, after that come back to me to report.\nDon't do anything without consulting me. And now go, there's no time to lose.",
					nextState = {
						[Storage.LocalSupport.Discernment] = QuestState.LocalSupport.Discernment.VisitDealers,
					},
				},
				[{ GREET }] = {
					text = "New recruit? Great! Another cannon fodd.. I mean potential soldier.\nAt your first mission, visit all of the main sellers in MirkoTown and ask them if they need some help, after that come back to me to report.\nDon't do anything without consulting me. And now go, there's no time to lose.",
					nextState = {
						[Storage.LocalSupport.Discernment] = QuestState.LocalSupport.Discernment.VisitDealers,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.Discernment.VisitDealers,
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
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TalkWithWoody,
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
	end)
	:Mission(Storage.LocalSupport.WoodDelivery)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.TalkWithWoody,
			QuestFactory.Dialog(
				"Woody",
				{ [{ "drewno", "dostawa", "wood", "delivery", "mission", "misja" }] = {
					text = "What?! What do you mean the wood is missing? Three days ago I sent a caravan by myself... Something must have happened on its way, could you investigate that?",
					nextState = {
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.InvestigateCamp,
					},
				} }
			)
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.InvestigateCamp,
			QuestFactory.Dialog("Narro", {
				[{ "drewno", "dostawa", "misja", "mission", "wood" }] = {
					text = "What? Are you looking for the wood? Now thats my wood. You can tell Commissioner Fisher that he'll never get it back.",
					nextState = {
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TellCommissionerAboutMafia,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.TellCommissionerAboutMafia,
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ "narro", "waski", "mission", "misja", "wood", "drewno" }] = {
					text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you a better shield because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
			QuestFactory.Dialog("Narro", {
				[{ "drewno", "dostawa", "misja", "mission", "wood" }] = {
					text = "Huh, hes a badass? I am the only badass here.\nNow YOU tell ME: am I the only badass in this bitch!?",
					specialActionsOnSuccess = {
						{ action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffectPlayer, effect = CONST_ME_YELLOWENERGY },
					},
					nextTopic = QuestTopics.LocalSupport.ConfirmNarroIsBadass,
				},
				[{ "yes", "tak" }] = {
					text = "Thats right! And my mafia is badass too?",
					requiredTopic = QuestTopics.LocalSupport.ConfirmNarroIsBadass,
					nextTopic = QuestTopics.LocalSupport.ConfirmMafiaIsBadass,
				},
				[{ "yes", "tak" }] = {
					text = "Thats right, you are catching up quickly.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmNarroIsBadass,
				},
				[{ "no", "nie" }] = {
					text = "We'll see who's right soon enough!",
					requiredState = {
						[Storage.LocalSupport.NarroStages] = MISSION_NOT_STARTED,
					},
					nextState = {
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedFirstWave,
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
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedFirstWave,
					},
					nextState = {
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedSecondWave,
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
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedSecondWave,
					},
					nextState = {
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedThirdWave,
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
						[Storage.LocalSupport.NarroStages] = QuestState.LocalSupport.NarroFight.DefeatedThirdWave,
					},
					nextState = {
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.ReportToCommissioner,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.ReportToCommissioner,
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ "mission", "misja" }] = {
					text = "Very good, go speak with Trollsky about your reward, from now on you are a certified warrior of MirkoTown.",
					expReward = 55000,
					nextState = {
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeTrollskyReward,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.TakeTrollskyReward,
			QuestFactory.Dialog("Trollsky", {
				[{ "mission", "misja", "nagroda", "reward" }] = {
					text = "Yeah! You deserve some reward for helping us. You can choose one from the following: {Axe}, {sword}, {club}, {spellbook}, {bolts} and {arrows}.",
				},
				[{ "topor", "axe" }] = {
					text = "Here is your axe. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 3344 } },
				},
				[{ "miecz", "sword" }] = {
					text = "Here is your sword. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 2117 } },
				},
				[{ "obuch", "club" }] = {
					text = "Here is your club. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 7387 } },
				},
				[{ "spellbook", "ksiazka" }] = {
					text = "Here is your spellbook. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
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
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 7364, count = 300 } },
				},
				[{ "strzaly", "arrows" }] = {
					text = "Here are arrows for you. You should visit Fstab for a potion supply.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 7364, count = 300 } },
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.TakeFstabReward, QuestFactory.Dialog("Fstab", {
			[{ "nagroda", "reward" }] = {
				text = "Well, thank you on behalf of our City for your help, get some of these potions.",
				nextState = { [Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED },
				rewards = { { id = 268, count = 40 }, { id = 268, count = 5 } },
			},
		})
	end)
	:Mission(Storage.LocalSupport.FreakingRats)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Walmart007", {
				[{ "help", "pomoc", "mission", "misja" }] = {
					text = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
					requiredState = {
						[Storage.LocalSupport.VendorsAsked.WalmartAsked] = MISSION_FINISHED,
					},
				},
				[{ "szczur", "szczurow", "rat", "rats" }] = {
					text = "I still have rats in the warehouse. I need some poison to get rid of them.",
					requiredState = {
						[Storage.LocalSupport.VendorsAsked.WalmartAsked] = MISSION_FINISHED,
					},
					nextState = {
						[Storage.LocalSupport.FreakingRats] = QuestState.LocalSupport.FreakingRats.AskGertrudeForRepellant,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.FreakingRats.AskGertrudeForRepellant,
			QuestFactory.Dialog("Gertrude", {
				[{ "szczur", "szczury", "trutka", "ser", "rat", "rats" }] = {
					text = "Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night.",
					nextState = { [Storage.LocalSupport.FreakingRats] = QuestState.LocalSupport.FreakingRats.BringMouldyCheeseToGertrude },
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.FreakingRats.BringMouldyCheeseToGertrude,
			QuestFactory.Dialog("Gertrude", {
				[{ "szczur", "szczury", "trutka", "ser", "rat", "rats" }] = {
					text = "What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard.",
					textNoRequiredItems = "Bring me some mouldy cheese.",
					rewards = {
						QuestKeyItems.LocalSupport.PoisonedCheese,
					},
					requiredItems = {
						{ id = 3120 },
					},
					nextState = {
						[Storage.LocalSupport.FreakingRats] = QuestState.LocalSupport.FreakingRats.BringPoisonedChesseToWalmart,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.FreakingRats.BringPoisonedChesseToWalmart,
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
					requiredItems = {
						QuestKeyItems.LocalSupport.PoisonedCheese,
					},
					nextState = { [Storage.LocalSupport.FreakingRats] = MISSION_FINISHED },
				},
			})
	end)
	:Mission(Storage.LocalSupport.BudgetRecycling)
	:State(function()
		return MISSION_NOT_STARTED, QuestFactory.Dialog("Madame Malkin", {
			[{ "mission", "misja", "tkaninie", "cloth", "tailor" }] = {
				text = "I like to sew something when I am bored but slowly I am lack of colorful fabrics.",
				nextState = {
					[Storage.LocalSupport.BudgetRecycling] = QuestState.LocalSupport.BudgetRecycling.BringPieceOfEachClothToMadame,
				},
			},
		})
	end)
	:State(function()
		return QuestState.LocalSupport.BudgetRecycling.BringPieceOfEachClothToMadame,
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
	end)
	:Mission(Storage.LocalSupport.LostCrystalBall)
	:State(function()
		return MISSION_NOT_STARTED, QuestFactory.Dialog("Gypsy", {
			[{ "mission", "misja", "kula", "ball", "kule" }] = {
				text = "My fortune telling ball! Probably it got stolen, maybe youll help me to find a new one? Come back to show me if you find any.",
				nextState = {
					[Storage.LocalSupport.LostCrystalBall] = QuestState.LocalSupport.LostCrystalBall.FindBallForGypsy,
				},
			},
		})
	end)
	:State(function()
		return QuestState.LocalSupport.LostCrystalBall.FindBallForGypsy, QuestFactory.Dialog("Gypsy", {
			[{ "kula", "ball", "kule" }] = {
				text = "Well, the previous one was better, but this one is fine too. Thank you!\nYou can exchange your red gems for a ring of healing from now on.",
			},
		})
	end)
	:Mission(Storage.LocalSupport.Biodegradable)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Old Postman", {
				[{ "szlakiem", "pass", "route", "mision", "misja" }] = {
					text = "The waterway begins at their rock to the west. Then it flows under the bridge, passes by the orc fortress, and enters a larger lake. From that lake, it flows to the Syn Anona. Somewhere along this waterway, my shipment got stuck.",
					nextState = {
						[Storage.LocalSupport.Biodegradable] = QuestState.LocalSupport.Biodegradable.FindPostmanPackage,
					},
					requiredState = {
						[Storage.LocalSupport.VendorsAsked.PostmanAsked] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.Biodegradable.FindPostmanPackage,
			QuestFactory.Dialog("Old Postman", { [{ "misja", "mission", "przesylka", "parcel" }] = {
				text = "Come back when you find my shipment.",
			} }),
			QuestFactory.StartupItems({
				{ id = 11520, pos = { 5748, 1633, 7 }, aid = Storage.LocalSupport.Parcel, rewards = { QuestKeyItems.LocalSupport.Parcel }, nextState = { [Storage.LocalSupport.Biodegradable] = QuestState.LocalSupport.Biodegradable.ReturnPackageToPostman } },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.Biodegradable.ReturnPackageToPostman,
			QuestFactory.Dialog("Old Postman", {
				[{ "misja", "mission", "przesylka", "parcel" }] = {
					text = "Were you able to find my {shipment}?",
				},
				[{ "przesylke", "parcel", "shipment", "paczka", "yes", "tak" }] = {
					text = "This parcel was delayed for a few weeks, and I was beginning to worry that alibaba was trying to trick me. Here's your reward for your help. I found something inside that Stary Anona ordered, probably a {bait} for fish. If you're passing by, deliver it to him. He will surely reward you.",
					requiredItems = {
						QuestKeyItems.LocalSupport.Parcel,
					},
					expReward = 15000,
					rewards = {
						{ id = 7290 },
					},
					nextState = {
						[Storage.LocalSupport.Biodegradable] = QuestState.LocalSupport.Biodegradable.AskForNewMission,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.Biodegradable.AskForNewMission,
			QuestFactory.Dialog("Old Postman", {
				[{ "mission", "misja" }] = {
					text = "Could you take this package to Anon's father? He's surely getting impatient, so he'll reward you for your help.",
				},
				[{ "zaneta", "bait", "yes", "tak" }] = {
					text = "Here, please, this box. Anon's father hangs around a pond near the {barracks}.",
					nextState = {
						[Storage.LocalSupport.Biodegradable] = MISSION_FINISHED,
						[Storage.LocalSupport.SettledDownFishmonger] = QuestState.LocalSupport.SettledDownFishmonger.DeliverAnonFatherPackage,
					},
					rewards = {
						QuestKeyItems.LocalSupport.FishBait,
					},
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Old Postman", { [{ "koszary", "koszarow", "barracks" }] = {
			text = "Commissioner Fisher's barracks are in the southwest part of the city. He sent you here himself, are you drunk?",
		} })
	end)
	:Mission(Storage.LocalSupport.UnwantedGuests)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Old Man Frost", {
				[{ "mission", "misja" }] = {
					text = "Few years ago it was peaceful here, but now it is difficult to live with barbarians roaming around.\nTry to take care of them. I know it's going to be hard to get everyone out, but even a few less of their kind will be a success.\nFor proof of defeating a few of them, bring me Brutetamers Staff and Fur Boots, this is their basic equipment.\nSo, would you like to help me?",
					nextTopic = QuestTopics.LocalSupport.ConfirmUnwatedGuestsQuest,
				},
				[{ "yes", "tak" }] = {
					text = "Great, I'll give you a special pickaxe as a reward. I'll tell you what to do with it for later.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmUnwatedGuestsQuest,
					nextState = {
						[Storage.LocalSupport.UnwantedGuests] = QuestState.LocalSupport.UnwantedGuests.BringOldManFrostItems,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.UnwantedGuests.BringOldManFrostItems,
			QuestFactory.Dialog("Old Man Frost", {
				[{ "mission", "misja" }] = {
					text = "Very well, let them die. I could use the cane, but you can keep the shoes. Take this pickaxe, just like we agreed.\nAbout this pickaxe - you can use it to smash icicles, for example, or some of the crystals on the island. The magic in this pickaxe is very faint and it only allows you to use it once a week.",
					requiredItems = {
						{ id = 7379 },
						{ id = 7457, remove = false },
					},
					expReward = 100000,
					rewards = {
						QuestKeyItems.LocalSupport.OldManFrostPickaxe,
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

					local nextCooldownExpiry = GetNextWednesdayEpochTime()
					player:setStorageValue(nextCooldownExpiry)
					player:addCharmPoints(charmPoints)
					local bonusExp = player:ExpForNextlevel() * 0.15 + 50000
					AddExperienceWithAnnouncement(player, bonusExp)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You received :points: charm points.", { points = charmPoints }))
				end
				oldManFrostPickaxe:aid(Storage.LocalSupport.OldManFrostPickaxe)
				oldManFrostPickaxe:register()
			end)
	end)
	:StartupItems({
		{
			position = Position(7508, 292, 7),
			id = 7176,
			aid = Storage.OldManFrostMammoth,
			onLook = function(context)
				context.player:removeMoneyBank(50)
			end,
		},
	})
	:Mission(Storage.LocalSupport.TwoMarlinQuest)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Fisherman Son", {
				[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
					text = "Wow! You have merlin! Will I get this fish from you if we agree that I will make a nice trophy for you from second one you bring me?",
					requiredItems = {
						{ id = 901, remove = false },
					},
					nextTopic = QuestTopics.LocalSupport.ConfirmTradeInTwomarlins,
				},
				[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
					text = "Yeah! Lets see.. <bonk blonk> Here you go. Hope you are satisfied",
					nextState = {
						[Storage.LocalSupport.TwoMarlinQuest] = MISSION_FINISHED,
					},
					rewards = {
						{ id = 902 },
					},
					expReward = 17000,
					requiredTopic = QuestTopics.LocalSupport.ConfirmTradeInTwomarlins,
					requiredItems = {
						{ id = 901, count = 2 },
					},
					textNoRequiredCondition = "Bring me exactly two marlins",
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Fisherman Son", { [{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
			text = "Thank you for that marlin. It looks great by the fireplace.",
		} })
	end)
	:Mission(Storage.LocalSupport.OcellatusXD)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "You are probably not a football devotee like me, but I wanted to go to the {match}. However, someone disrupted my plans.",
					nextTopic = QuestTopics.LocalSupport.AcceptBringTicketQuest,
				},
				[{ "match", "mecz", "legia", "legii" }] = {
					text = "Well, I was supposed to go to my favourite team's match, but the nationalists came up and they ripped the from my hands. Could you help me get it back?",
					requiredTopic = QuestTopics.LocalSupport.AcceptBringTicketQuest,
					nextState = {
						[Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.FindTicket,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.FindTicket,
			QuestFactory.Dialog("Ocellatus", { [{ "mission", "misja" }] = {
				text = "I hope that you'll find this ticket.",
			} }),
			QuestFactory.StartupItems({
				{ id = 256, pos = { 5993, 1420, 7 }, aid = Storage.LocalSupport.Ticket, rewards = { QuestKeyItems.LocalSupport.Ticket }, nextState = { [Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus } },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "Thanks a lot! Can't wait to see the match. But there's something more, I'm stuck on this shithole and running low on food.\nWould you mind fixing some food for me?",
					expReward = 15000,
					requiredItems = {
						QuestKeyItems.LocalSupport.Ticket,
					},
					nextState = {
						[Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.AskOcellatusForNewMission,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.AskOcellatusForNewMission,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "I'm stuck on this shithole and running low on food.\nWould you mind fixing some food for me?",
					nextTopic = QuestTopics.LocalSupport.AcceptBringFoodQuest,
				},
				[{ "yes", "tak" }] = {
					text = "I love {rotworm stew} and {roasted dragon wings} from Mickey Dicks. If you make this for me, I will certainly pay you back.",
					requiredTopic = QuestTopics.LocalSupport.AcceptBringFoodQuest,
					nextState = {
						[Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.BringFoodToOcellatus,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.BringFoodToOcellatus,
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
						[Storage.LocalSupport.OcellatusXD] = MISSION_FINISHED,
						[Storage.Finished.Ocellatus] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Ocellatus", { [{ "mission", "misja" }] = {
			text = "That's all, thanks for your help.",
		} })
	end)
	:Mission(Storage.LocalSupport.IKEAForTheBold)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
			QuestFactory.Dialog("Komor", {
				[{ "misja", "mission" }] = {
					text = "There is one problem with which you could help me. Some furniture started to disappear from my storages.\nI know for sure that it wasnt Narro's mafia, because they are using wood for different purposes, they are not interested in my products.\nDo you want to help me the one responsible for stealing my furniture?",
				},
				[{ "yes", "tak" }] = {
					text = "Thanks that you agreed to {help}. I hope that its not another mafia.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.AskGypsy,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.AskGypsy, QuestFactory.Dialog("Komor", { [{ "misja", "mission", "help", "pomoc" }] = {
			text = "Maybe Gypsy knows something about furniture thief, people like him stick together...",
			nextState = {
				[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers,
			},
		} })
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers,
			QuestFactory.StartupItems({
				{
					id = 11809,
					pos = { 5832, 1597, 11 },
					aid = Storage.LocalSupport.SpawnDominoUndergroundChest,
				},
			}),
			QuestFactory.Script(function(missionState)
				local undergroundChest = Action()
				function undergroundChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					if SpawnLocks.LocalSupport.DominoUnderground:IsSet() then
						return false
					end

					Game.createMonster("Lumberjack Domino Underground", toPosition)
					SpawnLocks.LocalSupport.DominoUnderground:Set()
				end
				undergroundChest:aid(Storage.LocalSupport.SpawnDominoUndergroundChest)
				undergroundChest:register()
			end)
	end)
	:MonsterEvent(function()
		local dominoUnderground = CreatureEvent("LumberjackDominoUndergroundDeath")
		function dominoUnderground.onDeath(creature)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			SpawnLocks.LocalSupport.DominoUnderground:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.LocalSupport.IKEAForTheBold) == QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers then
					player:setStorageValue(Storage.LocalSupport.IKEAForTheBold, QuestState.LocalSupport.IKEAForTheBold.SearchDominoUndergroundHideout)
				end
			end)
			return true
		end
		dominoUnderground:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Lumberjack Domino Underground")
		local monster = {}

		monster.name = "Lumberjack Domino"
		monster.description = "a lumberjack domino"
		monster.experience = 1400
		monster.outfit = {
			lookType = 143,
			lookHead = 114,
			lookBody = 116,
			lookLegs = 116,
			lookFeet = 114,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 1000
		monster.maxHealth = 1000
		monster.race = "blood"
		monster.corpse = 0
		monster.speed = 60
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 5000,
			chance = 0,
		}

		monster.strategiesTarget = {
			nearest = 70,
			health = 10,
			damage = 10,
			random = 10,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 200,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = false,
			canWalkOnFire = false,
			canWalkOnPoison = false,
			pet = false,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, skill = 40, attack = 65 },
		}

		monster.defenses = {
			defense = 9,
			armor = 9,
			{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		monster.events = {
			"LumberjackDominoUndergroundDeath",
		}

		mType:register(monster)
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.SearchDominoUndergroundHideout,
			QuestFactory.StartupItems({
				{
					id = 2471,
					pos = { 5840, 1588, 11 },
					aid = Storage.LocalSupport.BookChest,
					rewards = {
						{ id = 3076 },
						QuestKeyItems.LocalSupport.BookOfContraband,
					},
					nextState = { [Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.BringStolenItemListToKomor },
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.BringStolenItemListToKomor,
			QuestFactory.Dialog("Komor", {
				[{ "misja", "mission" }] = {
					text = "Thank you for finding perpetrator. Your reward is upstairs, in my drawers.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds. [...] I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.ConsultCommissioner,
						[Storage.LocalSupport.UpstairsRoom] = ACCESS_GRANTED,
					},
					requiredItems = {
						QuestKeyItems.LocalSupport.BookOfContraband,
					},
					rewards = {
						{ id = 2972, actionid = 5008 }, --ehhhhhhh
					},
					expReward = 30000,
				},
			}),
			QuestFactory.StartupItems({
				{ id = 9363, pos = { 5840, 1561, 6 }, aid = Storage.LocalSupport.UpstairsRoom },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.ConsultCommissioner,
			QuestFactory.Dialog("Komor", {
				[{ "all", "wszystko" }] = {
					text = "Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher and tell him about it. Also ask him if he knows something about that thief.",
				},
			}),
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ "mission", "misja" }] = {
					text = "We must stop this thief as fast as possible. He might be scheming how to get back unnoticed and take back his loot. Ask people around, maybe someone saw where he ran to.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.AskNearbyPeople_FindMoustachilles,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.AskNearbyPeople_FindMoustachilles,
			QuestFactory.Dialog("Anons Father", {
				[{ "thief", "zlodziej" }] = {
					text = "Mister, I'm just fishing here quietly, and all of the sudden I see a man emerging on the surface. You're saying that he is a thief? - he ran that way, to the east.",
				},
			}),
			QuestFactory.Dialog("Miles the Guard", {
				[{ "thief", "zlodziej" }] = {
					text = "I saw someone run past the city gate and then to the east. Maybe he went to the bandit's {camp}?",
				},
			}),
			QuestFactory.Dialog("xXxTurdstinxXx", {
				[{ "thief", "zlodziej" }] = {
					text = "This ain't the opp block, pipe down.",
				},
			}),
			QuestFactory.Dialog("Moustachilles", {
				[{ "thief", "zlodziej" }] = {
					text = "Please, you don't think that I am giving any {information} about my - ekhem - contractors just like that.",
				},
				[{ "informacje", "info", "information", "informations" }] = {
					text = "Guards! This man got to go, show him where we throw out carcasses.",
					spawnMonstersOnSuccess = {
						{ name = "bandit", count = 2 },
						{ name = "smuggler", count = 3 },
					},
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.AskMoustachillesAboutDomino,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.AskMoustachillesAboutDomino,
			QuestFactory.Dialog("Moustachilles", {
				[{ "informacje", "info", "information", "informations", "thief", "zlodziej" }] = {
					text = "Fine! - calm down, we will get along somehow. What has been stolen from you?",
				},
				[{ "meble", "drewno", "furniture", "wood" }] = {
					text = "Ohh, that dude ... he left on a boat recently. He was asking me for some good place to hide. ...\nI told him to look around at the south of the steppes. That's all I know.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore,
			QuestFactory.Script(function(missionState)
				local tileBeforeHawser = MoveEvent()
				function tileBeforeHawser.onStepIn(player, item, toPosition, fromPosition)
					if not player:isPlayer() then
						return
					end
					if not player:HasExactMissionState(missionState) then
						return
					end

					if SpawnLocks.LocalSupport.DominoShore:IsSet() then
						return
					end

					Game.createMonster("Lumberjack Domino Shore", toPosition)
					SpawnLocks.LocalSupport.DominoShore:Set()
				end
				tileBeforeHawser:aid(Storage.LocalSupport.TileBeforeHawser)
				tileBeforeHawser:type("stepin")
				tileBeforeHawser:register()
			end),
			QuestFactory.StartupItems({
				{ id = 4407, pos = { 6198, 1206, 7 }, aid = Storage.LocalSupport.TileBeforeHawser },
			})
	end)
	:MonsterEvent(function()
		local dominoShore = CreatureEvent("LumberjackDominoShoreDeath")
		function dominoShore.onDeath(creature)
			SpawnLocks.LocalSupport.DominoShore:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValue(Storage.LocalSupport.IKEAForTheBold) == QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore then
					player:setStorageValue(Storage.LocalSupport.IKEAForTheBold, QuestState.LocalSupport.IKEAForTheBold.SearchDominoShoreHideout)
				end
			end)
			return true
		end
		dominoShore:register()
	end)
	:Monster(function()
		local mType = Game.createMonsterType("Lumberjack Domino Shore")
		local monster = {}

		monster.name = "Lumberjack Domino"
		monster.description = "a lumberjack domino"
		monster.experience = 21000
		monster.outfit = {
			lookType = 143,
			lookHead = 114,
			lookBody = 116,
			lookLegs = 116,
			lookFeet = 114,
			lookAddons = 0,
			lookMount = 0,
		}

		monster.health = 8000
		monster.maxHealth = 8000
		monster.race = "blood"
		monster.corpse = 111
		monster.speed = 90
		monster.manaCost = 0

		monster.changeTarget = {
			interval = 5000,
			chance = 0,
		}

		monster.strategiesTarget = {
			nearest = 70,
			health = 10,
			damage = 10,
			random = 10,
		}

		monster.flags = {
			summonable = false,
			attackable = true,
			hostile = true,
			convinceable = false,
			pushable = false,
			rewardBoss = false,
			illusionable = false,
			canPushItems = true,
			canPushCreatures = true,
			staticAttackChance = 90,
			targetDistance = 1,
			runHealth = 0,
			healthHidden = false,
			isBlockable = false,
			canWalkOnEnergy = true,
			canWalkOnFire = true,
			canWalkOnPoison = true,
			pet = false,
		}

		monster.voices = {
			interval = 5000,
			chance = 10,
		}

		monster.loot = {
			{ name = "platinum coin", chance = 100000, minCount = 10, maxCount = 15 },
			{ name = "knight axe", chance = 10000 },
			{ name = "knight armor", chance = 5000 },
			{ name = "knight legs", chance = 5000 },
			{ name = "steel helmet", chance = 60000 },
			{ name = "tower shield", chance = 5000 },
		}

		monster.attacks = {
			{ name = "melee", interval = 2000, chance = 100, minDamage = 0, maxDamage = -150 },
			{ name = "combat", interval = 2000, chance = 20, type = COMBAT_PHYSICALDAMAGE, minDamage = 0, maxDamage = -100, range = 7, radius = 1, shootEffect = CONST_ANI_WHIRLWINDAXE, target = true },
			{ name = "berserk", interval = 2000, chance = 13, minDamage = 0, maxDamage = -150, target = false },
		}

		monster.defenses = {
			defense = 9,
			armor = 9,
			{ name = "speed", interval = 2000, chance = 15, speedChange = 240, effect = CONST_ME_MAGIC_RED, target = false, duration = 5000 },
		}

		monster.elements = {
			{ type = COMBAT_PHYSICALDAMAGE, percent = 0 },
			{ type = COMBAT_ENERGYDAMAGE, percent = 0 },
			{ type = COMBAT_EARTHDAMAGE, percent = 0 },
			{ type = COMBAT_FIREDAMAGE, percent = 0 },
			{ type = COMBAT_LIFEDRAIN, percent = 0 },
			{ type = COMBAT_MANADRAIN, percent = 0 },
			{ type = COMBAT_DROWNDAMAGE, percent = 0 },
			{ type = COMBAT_ICEDAMAGE, percent = 0 },
			{ type = COMBAT_HOLYDAMAGE, percent = 0 },
			{ type = COMBAT_DEATHDAMAGE, percent = 0 },
		}

		monster.immunities = {
			{ type = "paralyze", condition = true },
			{ type = "outfit", condition = false },
			{ type = "invisible", condition = true },
			{ type = "bleed", condition = false },
		}

		monster.events = {
			"LumberjackDominoShoreDeath",
		}

		mType:register(monster)
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.SearchDominoShoreHideout,
			QuestFactory.StartupItems({
				{
					id = 2472,
					pos = { 6206, 1208, 7 },
					rewards = {
						{ id = 7934 },
						{ id = 3055 },
						{ id = 3357 },
						{ id = 3557 },
					},
					expReward = 2000,
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.ReportToCommissioner,
						[Storage.LocalSupport.LumberjackBoatAccess] = ACCESS_GRANTED,
					},
				},
			}),
			QuestFactory.Script(function()
				InstantTravel({
					positions = { Position(6197, 1206, 7), Position(6058, 1651, 7) },
					requiredState = {
						[Storage.LocalSupport.LumberjackBoatAccess] = ACCESS_GRANTED,
					},
				}):Register()
			end)
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.ReportToCommissioner,
			QuestFactory.Dialog("Commissioner Fisher", {
				[{ "mission", "misja" }] = {
					text = "Well done soldier, here's your reward. I found these items among stolen goods which we found in this thug's den.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = MISSION_FINISHED,
						[Storage.Finished.IkeaForTheBold] = MISSION_FINISHED,
					},
					rewards = {
						{ id = 22195 },
						{ id = 7457 },
					},
					expReward = 60000,
				},
			})
	end)
	:Mission(Storage.LocalSupport.SettledDownFishmonger)
	:State(function()
		return QuestState.LocalSupport.SettledDownFishmonger.DeliverAnonFatherPackage,
			QuestFactory.Dialog("Anon's Father", {
				[{ "paczka", "paczke", "mission", "misja", "puszka" }] = {
					text = "Did you bring my package with you?",
					nextTopic = QuestTopics.LocalSupport.ConfirmHavingpackage,
				},
				[{ "yes", "tak" }] = {
					text = "Thank you for dealing with this matter. Here's your reward. If you're willing, I have another {problem} that you could help me with.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmHavingpackage,
					textNoRequiredItems = "Come back to me once you've resolved the matter with the Old Postman.",
					requiredItems = {
						QuestKeyItems.LocalSupport.FishBait,
					},
					expReward = 10000,
					rewards = {
						{ id = 12807 },
					},
					outfitRewards = {
						{ outfit = 157, addons = 0 },
						{ outfit = 153, addons = 0 },
					},
					nextState = {
						[Storage.LocalSupport.SettledDownFishmonger] = QuestState.LocalSupport.SettledDownFishmonger.FindAndDevilerAnonFatherMissingItems,
					},
				},
				[{ "no", "nie" }] = {
					text = "Come back to me once you've resolved the matter with the Old Postman.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmHavingpackage,
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.SettledDownFishmonger.FindAndDevilerAnonFatherMissingItems,
			QuestFactory.Dialog("Anon's Father", {
				[{ "problem" }] = {
					text = "Listen, over the past few years, I've lost a few components of my fishing gear in various ponds and lakes around Mirko. Specifically, I lost my wooden {float}, {reel}, and my old {stool}. Find all these items and {return} to me.",
				},
				[{ "return", "odnies" }] = {
					text = "Thank you! Here's your reward. Wait a moment! Someone scribbled on my chair with a marker! Oh, {darn} it... For my current condition, only a stew with Chinese ping pong onion, meat from an under-milked centennial bull raised by wolves, all topped with wine stolen from the Kutonapleton winery, will help. Alternatively, a simple rotworm {stew} might do the trick.",
					textNoRequiredItems = "Come back with all the items i need: {float}, {reel}, and my old {stool}.",
					nextState = {
						[Storage.LocalSupport.SettledDownFishmonger] = QuestState.LocalSupport.SettledDownFishmonger.BringSoupToAnonFather,
					},
					requiredItems = {
						QuestKeyItems.LocalSupport.FishmongerFloat,
						QuestKeyItems.LocalSupport.FishmongerReel,
						QuestKeyItems.LocalSupport.FishmongerStool,
					},
					rewards = {
						{ id = 12735 },
						{ id = 7457 },
					},
					expReward = 40000,
					outfitRewards = {
						{ outfit = 157, addons = 1 },
						{ outfit = 153, addons = 1 },
					},
				},
				[{ "float", "splawik" }] = {
					text = "It fell into the small pond nearby once. I hope you find it.",
				},
				[{ "reel", "spinning" }] = {
					text = "I lost it while fishing by the western gate. I hope you can find it.",
				},
				[{ "stool", "stolek" }] = {
					text = "It slipped into the water by the lake at the beach. I hope you find it.",
				},
			}),
			QuestFactory.StartupItems({
				{ id = 3687, pos = { 5931, 1640, 7 }, aid = Storage.LocalSupport.FishmongerFloat, rewards = { QuestKeyItems.LocalSupport.FishmongerFloat } },
				{ id = 3686, pos = { 5829, 1598, 7 }, aid = Storage.LocalSupport.FishmongerReel, rewards = { QuestKeyItems.LocalSupport.FishmongerReel } },
				{ id = 1768, pos = { 5792, 1594, 7 }, aid = Storage.LocalSupport.FishmongerStool, rewards = { QuestKeyItems.LocalSupport.FishmongerStool } },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.SettledDownFishmonger.BringSoupToAnonFather,
			QuestFactory.Dialog("Anon's Father", {
				[{ "bigos", "zupa", "soup", "stew", "mission", "misja" }] = {
					text = "Slurp slurp... I'm feeling better now. To be honest, I can't finish the rest. Either eat or give it to those in need. You can collect your reward from my {son}.",
					textNoRequiredItems = "Return with the stew, or the things might become unpleasant!",
					requiredItems = {
						{ id = 9079 },
					},
					removeItems = false,
					nextState = {
						[Storage.LocalSupport.SettledDownFishmonger] = QuestState.LocalSupport.SettledDownFishmonger.AskFishermanSonForReward,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.SettledDownFishmonger.AskFishermanSonForReward,
			QuestFactory.Dialog("Anon's Father", { [{ "syn", "syna", "son", "mission", "misja" }] = {
				text = "He's involved in maritime transport. You can find him in the western part of the suburbs of Mirkotown.",
			} }),
			QuestFactory.Dialog("Fisherman Son", {
				[{ "mission", "misja", "nagroda", "reward" }] = {
					text = "Here's your reward. If you'd like to buy more {shimmer swimmer}s just ask me.",
					rewards = {
						{ id = 12557 },
						{ id = 7250, count = 2 },
						{ id = 3033, count = 5 },
					},
					outfitRewards = {
						{ outfitId = 157, addon = 3 },
						{ outfitId = 153, addon = 3 },
					},
					expReward = 80000,
					nextState = {
						[Storage.LocalSupport.SettledDownFishmonger] = MISSION_FINISHED,
						[Storage.LocalSupport.FishermanSonBoat] = ACCESS_GRANTED,
						[Storage.Finished.SettledDownFishmonger] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return { neq = MISSION_FINISHED }, QuestFactory.Dialog("Fisherman Son", {
			[{ "shimmer swimmer" }] = {
				text = "Yeah, they're pretty.",
			},
		})
	end)
	:State(function()
		return MISSION_FINISHED,
			QuestFactory.Dialog("Fisherman Son", {
				[{ "shimmer swimmer" }] = {
					text = "Do you want to buy one shimmer swimmer for 1000gp?",
					nextTopic = QuestTopics.LocalSupport.ConfirmBuyingShimmerSwimmer,
				},
				[{ "yes", "tak" }] = {
					text = "Here you go.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmBuyingShimmerSwimmer,
					requiredMoney = 1000,
					rewards = {
						{ id = 12557 },
					},
				},
			}),
			QuestFactory.Script(function()
				InstantTravel({ positions = { Position(6025, 1951, 7), Position(5916, 1950, 7) }, requiredState = { [Storage.LocalSupport.FishermanSonBoat] = ACCESS_GRANTED } }):Register()
			end)
	end)
	:Register()
