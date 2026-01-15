local quest = Quest(LOCALIZERS.LocalSupport)

local mysticTurbanExchangeRate = 1
local redRobeExchangeRate = 1
local greenTunicExchangeRate = 2

quest
	:Storage(function()
		Storage.LocalSupport = {
			Discernment = {},
			VendorsAsked = {
				TrollskyAsked = {},
				FstabAsked = {},
				LebesgueAsked = {},
				PostmanAsked = {},
				MadameAsked = {},
				WalmartAsked = {},
				KomorAsked = {},
				DiggerAsked = {},
				JackAsked = {},
				GypsyAsked = {},
			},

			PotionConveyorJourneyman = {},

			WoodDelivery = {},
			CaravanZone = {},
			NarroStages = {},

			FreakingRats = {},
			PoisonedCheese = {},

			BudgetRecycling = {},
			BudgetRecyclingClothExchange = {},

			LostCrystalBall = {},
			RedGemExchange = {},

			Biodegradable = {},
			FishBait = {},
			Parcel = {},

			UnwantedGuests = {},
			OldManFrostPickaxe = {},

			TwoMarlinQuest = {},

			OcellatusXD = {},
			Ticket = {},
			OcellatusBoat = {},

			IKEAForTheBold = {},
			SpawnDominoUndergroundChest = {},
			BookChest = {},
			BookOfContraband = {},
			UpstairsRoom = {},
			MilesAsked = {},
			TileBeforeHawser = {},
			ShoreCaveChest = {},
			LumberjackBoatAccess = {},

			SettledDownFishmonger = {},
			FishmongerFloat = {},
			FishmongerReel = {},
			FishmongerStool = {},
			FishermanSonBoat = {},
		}
		QuestState.LocalSupport = {
			Discernment = {
				AfterFirstLogin = 0,
				VisitDealers = 1,
			},
			PotionConveyorJourneyman = {
				BringMouldyIngredients = 1,
				AskForPinataQuest = 2,
				BringPinataIngredients = 3,
				AskForUnknownCauseQuest = 4,
				BringUnknownCauseIngredients = 5,
				AskForCombatQuest = 6,
				BringCombatIngredients = 7,
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
				DefeatedSecondWave = 2,
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
				BringMarlinsToFishermanSon = 1,
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
			ConfirmPinataQuestSecret = NextTopic(),
			ConfirmExchangeTurban = NextTopic(),
			ConfirmExchangeRobe = NextTopic(),
			ConfirmExchangeTunic = NextTopic(),
		}
	end)
	:Constant(function()
		QuestKeyItems.LocalSupport = {
			PoisonedCheese = { id = 3120, key = Storage.LocalSupport.PoisonedCheese, desc = "A deadly gas can be sensed coming from inside the cheese." },
			Parcel = { id = 3504, key = Storage.LocalSupport.Parcel },
			OldManFrostPickaxe = { id = 4872, key = Storage.LocalSupport.OldManFrostPickaxe },
			Ticket = { id = 28818, key = Storage.LocalSupport.Ticket },
			BookOfContraband = { id = 2816, key = Storage.LocalSupport.BookOfContraband, text = "DOMINO_BOOK_OF_CONTRABAND_TEXT" },
			FishBait = { id = 15817, key = Storage.LocalSupport.FishBait },
			FishmongerFloat = { id = 6126, key = Storage.LocalSupport.FishmongerFloat },
			FishmongerReel = { id = 3224, key = Storage.LocalSupport.FishmongerReel },
			FishmongerStool = { id = 3107, key = Storage.LocalSupport.FishmongerStool },
		}
		QuestConstants.LocalSupport = {
			LocalSupportMissionStorages = {
				Storage.LocalSupport.Discernment,
				Storage.LocalSupport.WoodDelivery,
				Storage.LocalSupport.FreakingRats,
				Storage.LocalSupport.BudgetRecycling,
				Storage.LocalSupport.LostCrystalBall,
				Storage.LocalSupport.Biodegradable,
				Storage.LocalSupport.UnwantedGuests,
				Storage.LocalSupport.TwoMarlinQuest,
				Storage.LocalSupport.OcellatusXD,
				Storage.LocalSupport.IKEAForTheBold,
				Storage.LocalSupport.SettledDownFishmonger,
				Storage.LocalSupport.PotionConveyorJourneyman,
			},
			PotionConveyorJourneyman = {
				MouldyIngredients = {
					{ id = ItemId.MOULDY_CHEESE, count = 1 },
					{ id = ItemId.DAMSELFLY_EYE, count = 1 },
					{ id = ItemId.HAUNCH_OF_BOAR, count = 1 },
				},
				PinataIngredients = {
					{ id = ItemId.WOOD, count = 1 },
					{ id = ItemId.SWAMPLING_MOSS, count = 1 },
					{ id = ItemId.ACORN, count = 1 },
				},
				UnknownCauseIngredients = {
					{ id = ItemId.SHARD, count = 1 },
					{ id = ItemId.POISONOUS_SLIME, count = 1 },
					{ id = ItemId.HAUNTED_PIECE_OF_WOOD, count = 1 },
				},
				CombatIngredients = {
					{ id = ItemId.MAGIC_SULPHUR, count = 1 },
					{ id = ItemId.WAR_CRYSTAL, count = 1 },
					{ id = ItemId.UNHOLY_BONE, count = 1 },
				},
			},
			StorageToVisitNpcName = {
				[Storage.LocalSupport.VendorsAsked.TrollskyAsked] = "Trollsky",
				[Storage.LocalSupport.VendorsAsked.FstabAsked] = "Fstab",
				[Storage.LocalSupport.VendorsAsked.LebesgueAsked] = "Lebesgue the Philosopher",
				[Storage.LocalSupport.VendorsAsked.PostmanAsked] = "Old Postman",
				[Storage.LocalSupport.VendorsAsked.MadameAsked] = "Madame Malkin",
				[Storage.LocalSupport.VendorsAsked.WalmartAsked] = "Walmart007",
				[Storage.LocalSupport.VendorsAsked.KomorAsked] = "Komor",
				[Storage.LocalSupport.VendorsAsked.DiggerAsked] = "Grave Digger",
				[Storage.LocalSupport.VendorsAsked.JackAsked] = "Jack of all Swindles",
				[Storage.LocalSupport.VendorsAsked.GypsyAsked] = "Gypsy",
			},
		}
		QuestRewards.OutfitsAddons.LocalSupport = {
			FrostTracer0 = {
				{ outfitId = 1613, addons = 0 },
				{ outfitId = 1612, addons = 0 },
			},
			Jersey0 = {
				{ outfitId = 619, addons = 0 },
				{ outfitId = 620, addons = 0 },
			},
			Beggar0 = {
				{ outfitId = 157, addons = 0 },
				{ outfitId = 153, addons = 0 },
			},
			Beggar1 = {
				{ outfitId = 157, addons = 1 },
				{ outfitId = 153, addons = 1 },
			},
			Beggar2 = {
				{ outfitId = 157, addons = 2 },
				{ outfitId = 153, addons = 2 },
			},
		}
	end)
	:Questlog(function(localizer)
		table.insert(Questlog, {
			name = "Local Support",
			localizer = localizer,
			missions = {
				{
					name = "Discernment",
					storage = Storage.LocalSupport.Discernment,
					states = {
						[QuestState.LocalSupport.Discernment.AfterFirstLogin] = "Commissioner fisher wants to see you, the new recruit, so he can show you your way around the city. Find his quarters in the southern west part of this city, the Mirkotown.",
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
					linkedStorages = Storage.LocalSupport.VendorsAsked,
				},
				{
					name = "Wood Delivery",
					storage = Storage.LocalSupport.WoodDelivery,
					states = {
						[QuestState.LocalSupport.WoodDelivery.TalkWithWoody] = "Go to Knurowo's port and find out what happened to the wood delivery. You can sail there from Mirkotown port in northeast part of the town.",
						[QuestState.LocalSupport.WoodDelivery.InvestigateCamp] = "Woody is sure that the wood was shipped on a caravan leaving Knurowo. He asked you to investigate this.",
						[QuestState.LocalSupport.WoodDelivery.TellCommissionerAboutMafia] = "Tell Commissioner that Narro and his mafia stole all of the wood delivery.",
						[QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia] = "Commissioner Fisher ordered you to recover the stolen wood, but he also warned you about the Narro's mafia.",
						[QuestState.LocalSupport.WoodDelivery.ReportToCommissioner] = "Narro gave up, and he is going to let Commissioner take the wood back. Report back to Commissioner.",
						[QuestState.LocalSupport.WoodDelivery.TakeTrollskyReward] = "Your merits earned you a special reward. Commissioner sent you to Trollsky, where you can receive your reward.",
						[QuestState.LocalSupport.WoodDelivery.TakeFstabReward] = "Ask fstab for the promised potion supply.",
						[MISSION_FINISHED] = "You completed the mission and picked up all rewards.",
					},
				},
				{
					name = "Freaking Rats",
					storage = Storage.LocalSupport.FreakingRats,
					states = {
						[QuestState.LocalSupport.FreakingRats.AskGertrudeForRepellant] = "Walmart wishes she knew how to repel rats. Find out where Gertrude lives. She should know how to craft a rat poison.",
						[QuestState.LocalSupport.FreakingRats.BringMouldyCheeseToGertrude] = "Gertrude asked you to bring her one mouldy cheese.",
						[QuestState.LocalSupport.FreakingRats.BringPoisonedChesseToWalmart] = "The cheese has been poisoned. Bring it to Walmart, so she can repel the rats.",
						[MISSION_FINISHED] = "Walmart didn't have time to make use of the poisonous cheese, but she already gave you your reward: Carrot cake and a minor gift.",
					},
				},
				{
					name = "Potion Conveyor Journeyman",
					storage = Storage.LocalSupport.PotionConveyorJourneyman,
					states = {
						[QuestState.LocalSupport.PotionConveyorJourneyman.BringMouldyIngredients] = "BRING_MOULDY_INGREDIENTS_DESCRIPTION",
						[QuestState.LocalSupport.PotionConveyorJourneyman.AskForPinataQuest] = "Ask fstab about a new mission.",
						[QuestState.LocalSupport.PotionConveyorJourneyman.BringPinataIngredients] = "BRING_MOULDY_PINATA_DESCRIPTION",
						[QuestState.LocalSupport.PotionConveyorJourneyman.AskForUnknownCauseQuest] = "Ask fstab about a new mission.",
						[QuestState.LocalSupport.PotionConveyorJourneyman.BringUnknownCauseIngredients] = "BRING_UNKNOWNCAUSE_INGREDIENTS_DESCRIPTION",
						[QuestState.LocalSupport.PotionConveyorJourneyman.AskForCombatQuest] = "Ask fstab about a new mission.",
						[QuestState.LocalSupport.PotionConveyorJourneyman.BringCombatIngredients] = "BRING_COMBAT_INGREDIENTS_DESCRIPTION",
						[MISSION_FINISHED] = "You collected all the items fstab asked and got rewarded for it.",
					},
				},
				{
					name = "Cheap Recycling",
					storage = Storage.LocalSupport.BudgetRecycling,
					states = {
						[QuestState.LocalSupport.BudgetRecycling.BringPieceOfEachClothToMadame] = "Malkin asked you to bring her 1 piece of cloth of every color.",
						[MISSION_FINISHED] = "Madame Malkin is grateful for your effort, and from now on you can exchange mystic turbans, red robe, and green tunic for corresponding pieces of cloth.",
					},
				},
				{
					name = "Broken Orb",
					storage = Storage.LocalSupport.LostCrystalBall,
					states = {
						[QuestState.LocalSupport.LostCrystalBall.FindBallForGypsy] = "Gypsy needs a new Crystal ball. Bring it to him, and he will reward you abundantly.",
						[MISSION_FINISHED] = "The crystal ball wasn't perfect, but Gypsy is fine with it. Since now he will also let you exchange red gem to ring of healing.",
					},
				},
				{
					name = "Biodegradable",
					storage = Storage.LocalSupport.Biodegradable,
					states = {
						[QuestState.LocalSupport.Biodegradable.FindPostmanPackage] = "Old postman asked you to find a package. You know that this cargo was supposed to arrive by water from the west.",
						[QuestState.LocalSupport.Biodegradable.ReturnPackageToPostman] = "You found the package for Old Postman. Return to him now.",
						[QuestState.LocalSupport.Biodegradable.AskForNewMission] = "You received a reward from Old Postman in exchange for helping locate the overdue shipment. He mentioned that you can also take a box of fish bait to Anon's father.",
						[MISSION_FINISHED] = "You took the box from Old Postman, which you should deliver to Anon's father.",
					},
				},
				{
					name = "Unwanted Guests",
					storage = Storage.LocalSupport.UnwantedGuests,
					states = {
						[QuestState.LocalSupport.UnwantedGuests.BringOldManFrostItems] = "Bring Brutetamers Staff and Fur Boots to Old Man Frost.",
						[MISSION_FINISHED] = "You completed Old Man Frost's request.",
					},
				},
				{
					name = "Two Marlins",
					storage = Storage.LocalSupport.TwoMarlinQuest,
					states = {
						[QuestState.LocalSupport.TwoMarlinQuest.BringMarlinsToFishermanSon] = "Bring two marlins to Fisherman Son.",
						[MISSION_FINISHED] = "You delivered two marlins to Fisherman son and were rewarded for it.",
					},
				},
				{
					name = "Ocellatus Xddd",
					storage = Storage.LocalSupport.OcellatusXD,
					states = {
						[QuestState.LocalSupport.OcellatusXD.FindTicket] = "Recover the match tickets that have been stolen from Ocellatus.",
						[QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus] = "You found the Tickets in a bandits tent. Bring to to Ocellatus.",
						[QuestState.LocalSupport.OcellatusXD.AskOcellatusForNewMission] = "You gave tickets back to Ocellatus. Ask him for new mission.",
						[QuestState.LocalSupport.OcellatusXD.BringFoodToOcellatus] = "Ocellatus asks you to bring him soup and wings. Ask Pewter for help.",
						[MISSION_FINISHED] = "You brang food to Ocellatus. In his gratitude, he gave you outfit and let you sail his boat.",
					},
				},
				{
					name = "IKEA for the BOLD",
					storage = Storage.LocalSupport.IKEAForTheBold,
					states = {
						[QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor] = "Commissioner Fisher has mentioned that Komor needs help.",
						[QuestState.LocalSupport.IKEAForTheBold.AskGypsy] = "Komor asked you inquire Gypsy if he knows anything about the recent theft of the furniture.",
						[QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers] = "Try to find the thief; he's possibly hiding in the sewers.",
						[QuestState.LocalSupport.IKEAForTheBold.SearchDominoUndergroundHideout] = "You found the thief, but he managed to get away. Try to look around his hideout.",
						[QuestState.LocalSupport.IKEAForTheBold.BringStolenItemListToKomor] = "You found a list of stolen items; the thief has apparently stolen more than just furniture. Go to Komor and give him the list.",
						[QuestState.LocalSupport.IKEAForTheBold.ConsultCommissioner] = "Komor asked you to consult Commissioner Fisher about the thief.",
						[QuestState.LocalSupport.IKEAForTheBold.AskNearbyPeople_FindMoustachilles] = "Fisher asked you to track down the thief. Perhaps someone from nearby saw where he ran away?",
						[QuestState.LocalSupport.IKEAForTheBold.AskMoustachillesAboutDomino] = "Ask the bandit leader about the furniture thief.",
						[QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore] = "Everything indicates that the thief is trying to smuggle items and hide in the steppes. The bandit leader suggested where you should go now.",
						[QuestState.LocalSupport.IKEAForTheBold.SearchDominoShoreHideout] = "You have defeated the Lumberjack Domino, look around his hiding place.",
						[QuestState.LocalSupport.IKEAForTheBold.ReportToCommissioner] = "From now on, you can use Domino's boat. Report to Commissioner Fisher.",
						[MISSION_FINISHED] = "You prematurely ended the efforts of Lumberjack Domino. From now on you can sail his boat from the bandit camp to the south of the steppes.",
					},
				},
				{
					name = "Settled down Fishmonger",
					storage = Storage.LocalSupport.SettledDownFishmonger,
					states = {
						[QuestState.LocalSupport.SettledDownFishmonger.DeliverAnonFatherPackage] = "Anon's father is waiting for his order.",
						[QuestState.LocalSupport.SettledDownFishmonger.FindAndDevilerAnonFatherMissingItems] = "Anon's father needs help finding some old junk he carried with him for fishing. Search all boats, piers, and swamps around Mirko Town for any found items.",
						[QuestState.LocalSupport.SettledDownFishmonger.BringSoupToAnonFather] = "Anon's father received his table in a deplorable state, ask how you can improve his mood.",
						[QuestState.LocalSupport.SettledDownFishmonger.AskFishermanSonForReward] = "You helped Anon's father with all the troubles. Now, go to his son for your reward.",
						[MISSION_FINISHED] = "You have received a reward from the Fisherman Son. You gained the ability to purchase Shimmer Swimmer.",
					},
				},
			},
		})
	end)
	:Mission(Storage.LocalSupport.Discernment)
	:State(function()
		return { max = QuestState.LocalSupport.Discernment.AfterFirstLogin },
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
					text = "Everything is fine, but some {journeyman} could come in handy. Id say that you look promising.",
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
					text = "Gypsy fortune telling ball? He was a clumsy one ever since.\nThree people are complaining about wood deficiency? It has to be checked as soon as possible. Make your way to Knurowo and ask in about the delivery at the city pier.\nFollow the road at the west of the city and you will find it. Alternatively, you can ask Jack Sparrow to sail you to knurow. Find him in our city port, on the north east. I'll give you some potions supply, you may need them.",
					nextState = {
						[Storage.LocalSupport.Discernment] = MISSION_FINISHED,
						[Storage.Finished.Discernment] = MISSION_FINISHED,
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
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isMage,
							requiredOutcome = true,
						},
					},
					expReward = 200,
					rewards = {
						{ id = 268, count = 15, addToStore = true },
						{ id = 266, count = 5, addToStore = true },
						{ id = 21400 },
						{ ExerciseWeaponBox(20) },
					},
				},
				[{ ANY_MESSAGE }] = {
					text = "Gypsy fortune telling ball? He was a clumsy one ever since.\nThree people are complaining about wood deficiency? It has to be checked as soon as possible. Make your way to Knurowo and ask in about the delivery at the city pier.\nFollow the road at the west of the city and you will find it. Alternatively, you can ask Jack Sparrow to sail you to knurow. Find him in our city port, on the north east. I'll give you some potions supply, you may need them.",
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
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isMage,
							requiredOutcome = false,
						},
					},
					expReward = 200,
					rewards = {
						{ id = 268, count = 10, addToStore = true },
						{ id = 266, count = 10, addToStore = true },
						{ id = 3412 },
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
			QuestFactory.Script(function(missionState)
				local caravanZoneSetup = GlobalEvent("CaravanZoneSetup")
				function caravanZoneSetup.onStartup()
					local zone = Zone(Storage.LocalSupport.CaravanZone)
					local zoneEvents = ZoneEvent(zone)
					function zoneEvents.afterEnter(zone, creature)
						local player = creature:getPlayer()
						if not player then
							return true
						end
						if not player:HasExactMissionState(missionState) then
							return true
						end

						local translatedMessage = player:Localizer(LOCALIZERS.LocalSupport):Get("This caravan of wood was just attacked. I better follow the path of loose wooden planks.")
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
					end
					zoneEvents:register()
				end
				caravanZoneSetup:register()
			end),
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
					text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you some better gear because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isPaladin,
							requiredOutcome = true,
						},
					},
					rewards = {
						{ id = 3571 },
						{ id = 3031, count = 70 },
					},
				},
				[{ "narro", "waski", "mission", "misja", "wood", "drewno" }] = {
					text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you some better gear because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isKnight,
							requiredOutcome = true,
						},
					},
					rewards = {
						{ id = 3372 },
						{ id = 3031, count = 70 },
					},
				},
				[{ "narro", "waski", "mission", "misja", "wood", "drewno" }] = {
					text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you some better gear because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isSorcerer,
							requiredOutcome = true,
						},
					},
					rewards = {
						{ id = 3074 },
					},
				},
				[{ "narro", "waski", "mission", "misja", "wood", "drewno" }] = {
					text = "What?! Narro, that moron? He is a wanna gangster now? I'll show him who is the real deal here.\nIt might be a difficult mission for you but I believe that you can make it. I'll give you some better gear because yours looks like crap. If you were to reclaim the wood I'll reward you.\nAnd also you can visit Komor, hes in some trouble recently.",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.OfferHelpToKomor,
						[Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.DealWithNarroMafia,
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isDruid,
							requiredOutcome = true,
						},
					},
					rewards = {
						{ id = 3066 },
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
					expReward = 35000,
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
					rewards = { { id = 3326 } },
				},
				[{ "obuch", "club" }] = {
					text = "Here is your club. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 7387 } },
				},
				[{ "spellbook", "ksiazka" }] = {
					text = "Here is your spellbook. You should also visit Fstab, he should provide you some supplies.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 8072 } },
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
					rewards = { { id = 7363, count = 300 } },
				},
				[{ "strzaly", "arrows" }] = {
					text = "Here are arrows for you. You should visit Fstab for a potion supply.",
					nextState = { [Storage.LocalSupport.WoodDelivery] = QuestState.LocalSupport.WoodDelivery.TakeFstabReward },
					rewards = { { id = 7364, count = 300 } },
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.WoodDelivery.TakeFstabReward,
			QuestFactory.Dialog("Fstab", {
				[{ "nagroda", "reward", "przydzial", "potions", "potion", "potionow", "potiony" }] = {
					text = "Well, thank you on behalf of our City for your help, get some of these potions.",
					nextState = {
						[Storage.LocalSupport.WoodDelivery] = MISSION_FINISHED,
						[Storage.Finished.WoodDelivery] = MISSION_FINISHED,
					},
					rewards = { { id = 268, count = 40, addToStore = true } },
				},
			})
	end)
	:Mission(Storage.LocalSupport.PotionConveyorJourneyman)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik", "mission", "misja" }] = {
					text = "Well i have a mission that could interest you. My competitor, walmart is selling mana and health regenerating food dirt cheap. I need few ingredients to undermine her reputation. When you have them, come back to me. You can check exactly what i need in your questlog. Also, when you want to report to me, use our codeword {journeyman} when you have all ingredients.",
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.BringMouldyIngredients,
					},
					requiredState = {
						[Storage.LocalSupport.VendorsAsked.FstabAsked] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.BringMouldyIngredients,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "Thanks, these are things i needed. Here's your reward.",
					requiredItems = QuestConstants.LocalSupport.PotionConveyorJourneyman.MouldyIngredients,
					rewards = {
						ExerciseWeaponBox(80),
					},
					wildcardReward = 1,
					expReward = 5000,
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.AskForPinataQuest,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.AskForPinataQuest,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "My plan is very sticky. Make sure to not tell anyone, alright?",
					nextTopic = QuestTopics.LocalSupport.ConfirmPinataQuestSecret,
				},
				[{ "yes", "tak", "ok", "sure", "yeah" }] = {
					text = "I heard about some elf trying to make a move on madame malkin. I have a plan involving pinata vooodoo.. Bring me the pinata ingredients and i will reward you.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmPinataQuestSecret,
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.BringPinataIngredients,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.BringPinataIngredients,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "Now this is a cooperation! Here is your reward.",
					requiredItems = QuestConstants.LocalSupport.PotionConveyorJourneyman.PinataIngredients,
					rewards = {
						ExerciseWeaponBox(160),
						{ id = ItemId.MANA_POTION, count = 30 },
						{ id = ItemId.MAGICAL_TORCH },
					},
					wildcardReward = 3,
					expReward = 12000,
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.AskForUnknownCauseQuest,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.AskForUnknownCauseQuest,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "So you are back. I got a new hustle for you. Bring me items from questlog. Their purpose is to no interest to you, so i wont be bothering you with that.",
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.BringUnknownCauseIngredients,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.BringUnknownCauseIngredients,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "Yo, whats good? I see you got all things i needed. Take this reward.",
					requiredItems = QuestConstants.LocalSupport.PotionConveyorJourneyman.UnknownCauseIngredients,
					rewards = {
						ExerciseWeaponBox(300),
						{ id = ItemId.BEETLE_NECKLACE },
					},
					wildcardReward = 3,
					expReward = 50000,
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.AskForCombatQuest,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.AskForCombatQuest,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "I have some grim news - for myself at least. Plot owner raised rent prices and i might be out of business soon with that walmart prospering.. I heard he likes exotic items used for black magic. Bring me those and i will reward you.",
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = QuestState.LocalSupport.PotionConveyorJourneyman.BringCombatIngredients,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.PotionConveyorJourneyman.BringCombatIngredients,
			QuestFactory.Dialog("Fstab", {
				[{ "journeyman", "czeladnik" }] = {
					text = "I knew i could count on you. Take this as your reward. Thats all for now, i dont want to attract any more attention to my totally legal fluids. See you around!",
					requiredItems = QuestConstants.LocalSupport.PotionConveyorJourneyman.CombatIngredients,
					rewards = {
						ExerciseWeaponBox(1000),
						{ id = ItemId.SWAN_FEATHER_CLOAK },
					},
					wildcardReward = 10,
					expReward = 700000,
					nextState = {
						[Storage.LocalSupport.PotionConveyorJourneyman] = MISSION_FINISHED,
						[Storage.Finished.PotionConveyorJourneyman] = MISSION_FINISHED,
					},
				},
			})
	end)
	:State(function()
		return MISSION_FINISHED, QuestFactory.Dialog("Fstab", {
			[{ "journeyman", "czeladnik" }] = {
				text = "Thanks for your help. Although i wont be needing your assistance for now.",
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
					expReward = 65000,
					requiredItems = {
						QuestKeyItems.LocalSupport.PoisonedCheese,
					},
					nextState = {
						[Storage.LocalSupport.FreakingRats] = MISSION_FINISHED,
						[Storage.Finished.FreakingRats] = MISSION_FINISHED,
					},
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
					text = "Thank you, the quality is not cutting edge but in the end I am Madame Malkin. I can replace your mystic turbans, red robes and green tunics for pieces of {cloth} from now on.",
					textNoRequiredItems = "I think you missed some colour, bring me all six clothes.",
					nextState = {
						[Storage.LocalSupport.BudgetRecycling] = MISSION_FINISHED,
						[Storage.LocalSupport.BudgetRecyclingClothExchange] = ACCESS_GRANTED,
						[Storage.Finished.BudgetRecycling] = MISSION_FINISHED,
					},
					rewards = {
						{ id = 8040 },
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
	:Mission(Storage.LocalSupport.BudgetRecyclingClothExchange)
	:State(function()
		return ACCESS_GRANTED,
			QuestFactory.Dialog("Madame Malkin", {
				[{ GREET }] = {
					text = "Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch} or {cloth}.",
				},
				[{ "cloth", "szmatki" }] = {
					text = "I will change your {mystic turban}, {red robe}, {green tunic} for corresponding cloth of similar colour.",
				},

				[{ "mystic turban", "mistyczny turban" }] = {
					text = "I will need EXCHANGE_RATE turbans to sew one blue cloth. Would you like to exchange?",
					nextTopic = QuestTopics.LocalSupport.ConfirmExchangeTurban,
					exchangeRate = mysticTurbanExchangeRate,
				},
				[{ "red robe", "czerwona szate" }] = {
					text = "I will need EXCHANGE_RATE robes to sew one red cloth. Would you like to exchange?",
					nextTopic = QuestTopics.LocalSupport.ConfirmExchangeRobe,
					exchangeRate = redRobeExchangeRate,
				},
				[{ "green tunic", "zielona tunike" }] = {
					text = "I will need EXCHANGE_RATE tunics to sew one green cloth. Would you like to exchange?",
					nextTopic = QuestTopics.LocalSupport.ConfirmExchangeTunic,
					exchangeRate = greenTunicExchangeRate,
				},
				[{ "yes", "tak" }] = {
					text = "Here you go.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmExchangeTurban,
					requiredItems = {
						{ id = ItemId.MYSTIC_TURBAN, count = mysticTurbanExchangeRate },
					},
					rewards = {
						{ id = ItemId.BLUE_PIECE_OF_CLOTH, count = 1 },
					},
				},
				[{ "yes", "tak" }] = {
					text = "Here you go.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmExchangeRobe,
					requiredItems = {
						{ id = ItemId.RED_ROBE, count = redRobeExchangeRate },
					},
					rewards = {
						{ id = ItemId.RED_PIECE_OF_CLOTH, count = 1 },
					},
				},
				[{ "yes", "tak" }] = {
					text = "Here you go.",
					requiredTopic = QuestTopics.LocalSupport.ConfirmExchangeTunic,
					requiredItems = {
						{ id = ItemId.GREEN_TUNIC, count = greenTunicExchangeRate },
					},
					rewards = {
						{ id = ItemId.GREEN_PIECE_OF_CLOTH, count = 1 },
					},
				},
			})
	end)
	--TODO
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
		return QuestState.LocalSupport.LostCrystalBall.FindBallForGypsy,
			QuestFactory.Dialog("Gypsy", {
				[{ "kula", "ball", "kule" }] = {
					text = "Well, the previous one was better, but this one is fine too. Thank you!\nYou can exchange your {red gem}s for a ring of healing from now on.",
					requiredItems = {
						{ id = 3076 },
					},
					expReward = 4000,
					nextState = {
						[Storage.LocalSupport.RedGemExchange] = ACCESS_GRANTED,
						[Storage.LocalSupport.LostCrystalBall] = MISSION_FINISHED,
						[Storage.Finished.LostCrystalBall] = MISSION_FINISHED,
					},
				},
			})
	end)
	:Mission(Storage.LocalSupport.Biodegradable)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Old Postman", {
				[{ "szlakiem", "pass", "route", "mission", "misja" }] = {
					text = "The waterway begins at their rock to the west. Then it flows under the bridge, passes by the orc fortress, and enters a larger lake. From that lake, it flows to the Fisherman Son. Somewhere along this waterway, my shipment got stuck.",
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
			QuestFactory.OnUseDeclarations({
				{ key = Storage.LocalSupport.Parcel, rewards = { QuestKeyItems.LocalSupport.Parcel }, nextState = { [Storage.LocalSupport.Biodegradable] = QuestState.LocalSupport.Biodegradable.ReturnPackageToPostman } },
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
					expReward = 3500,
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
						[Storage.Finished.Biodegradable] = MISSION_FINISHED,
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
			}),
			QuestFactory.Script(function()
				local mammothLook = Look()
				function mammothLook.onLook(player, item)
					player:removeMoneyBank(50)
					return DO_SHOW_ONLOOK
				end
				mammothLook:key(Storage.OldManFrostMammoth)
				mammothLook:register()
			end)
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
					expReward = 120000,
					rewards = {
						QuestKeyItems.LocalSupport.OldManFrostPickaxe,
					},
					nextState = {
						[Storage.LocalSupport.UnwantedGuests] = MISSION_FINISHED,
						[Storage.Finished.UnwantedGuests] = MISSION_FINISHED,
					},
					outfitRewards = QuestRewards.OutfitsAddons.LocalSupport.FrostTracer0,
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

					if not player:isLockoutExpired(Storage.LocalSupport.OldManFrostPickaxe) then
						player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Magic effects of this pickaxe have dissipated. It should be ready to use in few days.")
						return false
					end

					player:setLockoutExpiry(Storage.LocalSupport.OldManFrostPickaxe, LOCKOUT_EXPIRY_TIME.WEEKLY)
					player:addCharmPoints(charmPoints)
					local bonusExp = math.floor(player:ExpForNextlevel() * 0.15 + 50000)
					AddExperienceWithAnnouncement(player, bonusExp)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You received :points: charm points.", { points = charmPoints }))
				end
				oldManFrostPickaxe:key(Storage.LocalSupport.OldManFrostPickaxe)
				oldManFrostPickaxe:register()
			end)
	end)
	:Mission(Storage.LocalSupport.TwoMarlinQuest)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Fisherman Son", {
				[{ "marlin", "ryba", "rybka", "fish", "merlin", "marlina" }] = {
					text = "I can make a nice marlin trophy. If you agree to bring me two marlins i will have them for both of us.",
					nextState = {
						[Storage.LocalSupport.TwoMarlinQuest] = QuestState.LocalSupport.TwoMarlinQuest.BringMarlinsToFishermanSon,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.TwoMarlinQuest.BringMarlinsToFishermanSon,
			QuestFactory.Dialog("Fisherman Son", {
				[{ "marlin", "ryba", "rybka", "fish", "merlin", "marlina" }] = {
					text = "Wow! You have merlin! Would you like to bring me also a second one, so i can make a nice trophy for you?",
					textNoRequiredItems = "Find two marlins for me and i will craft you a trophy that you can hang on your house walls.",
					requiredItems = {
						{ id = 901, remove = false },
					},
					requiredTopic = DEFAULT_TOPIC,
					nextTopic = QuestTopics.LocalSupport.ConfirmTradeInTwomarlins,
				},
				[{ "marlin", "ryba", "rybka", "fish", "merlin", "marlina", "yes", "tak" }] = {
					text = "Yeah! Lets see.. <bonk blonk> Here you go. Hope you are satisfied",
					nextState = {
						[Storage.LocalSupport.TwoMarlinQuest] = MISSION_FINISHED,
						[Storage.Finished.TwoMarlinQuest] = MISSION_FINISHED,
					},
					rewards = {
						{ id = 902 },
					},
					expReward = 27000,
					requiredTopic = QuestTopics.LocalSupport.ConfirmTradeInTwomarlins,
					requiredItems = {
						{ id = 901, count = 2 },
					},
					textNoRequiredItems = "Bring me exactly two marlins",
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
					text = "Well, I was supposed to go to my favourite team's match, but the nationalists came up and they ripped the from my hands. Help me get it back.",
					requiredTopic = QuestTopics.LocalSupport.AcceptBringTicketQuest,
					nextState = {
						[Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.FindTicket,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.FindTicket,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "I hope that you'll find this ticket.",
				},
			}),
			QuestFactory.OnUseDeclarations({
				{ id = 256, key = Storage.LocalSupport.Ticket, rewards = { QuestKeyItems.LocalSupport.Ticket }, nextState = { [Storage.LocalSupport.OcellatusXD] = QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus }, requiredState = {} },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.OcellatusXD.BringTicketToOcellatus,
			QuestFactory.Dialog("Ocellatus", {
				[{ "mission", "misja" }] = {
					text = "Thanks a lot! Can't wait to see the match.",
					expReward = 2500,
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
				[{ "rotworm stew", "roasted dragon wings", "zupe rotwormowa", "zupa rotwormowa", "pieczone smocze skrzydelka" }] = {
					text = "Pewter from the steppes would know a thing or two about cooking. Head there and talk to him and he might just help you.",
				},
				[{ "mission", "misja", "food", "soup", "order", "zupa" }] = {
					text = "Fantastic, thanks! Nevermind about the soup. Just the wings will suffice. You can use my boat whenever you want and take this soccer T-shirt. The size doesn't fit me anyway.",
					textNoRequiredItems = "Come back with the food. I would like to eat {rotworm stew} and {roasted dragon wings}.",
					expReward = 150000,
					requiredItems = {
						{ id = 9081 },
						{ id = 9079, remove = false },
					},
					outfitRewards = QuestRewards.OutfitsAddons.LocalSupport.Jersey0,
					nextState = {
						[Storage.LocalSupport.OcellatusXD] = MISSION_FINISHED,
						[Storage.LocalSupport.OcellatusBoat] = ACCESS_GRANTED,
						[Storage.FashionistaOnanista.Mission01] = QuestState.FashionistaOnanista.Mission01.AskOcellatusForNewMission,
						[Storage.Finished.OcellatusXD] = MISSION_FINISHED,
					},
				},
			}),
			QuestFactory.Script(function()
				InstantTravel({ positions = { Position(5746, 1377, 7), Position(5641, 1424, 6) }, requiredState = { [Storage.LocalSupport.OcellatusBoat] = ACCESS_GRANTED } }):Register()
			end)
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
		return QuestState.LocalSupport.IKEAForTheBold.AskGypsy,
			QuestFactory.Dialog("Komor", { [{ "misja", "mission", "help", "pomoc" }] = {
				text = "Maybe Gypsy knows something about furniture thief, people like him stick together...",
			} }),
			QuestFactory.Dialog("Gypsy", {
				[{ "mission", "misja", "thief", "theft", "zlodziej", "meble", "wood", "dostawa", "furniture" }] = {
					text = "First off, I didnt see anything, Second: ... wait, did you say {furniture}?",
					nextState = {
						[Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers,
					},
				},
			})
	end)
	:State(function()
		return QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers,
			QuestFactory.Dialog("Gypsy", {
				[{ "thief", "theft", "zlodziej", "meble", "wood", "dostawa", "meble", "furniture" }] = {
					text = "I don't know of anyone who would like to {steal} this junk from Komor.",
				},
				[{ "steal", "krasc" }] = {
					text = "Maybe the thief is hiding beneath the MirkoTown, I doubt its anyone from outside of town. However, no one has the courage to check it out.",
				},
			}),
			QuestFactory.Script(function(missionState)
				local undergroundChest = Action()
				function undergroundChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					if not player:HasExactMissionState(missionState) then
						return false
					end

					if SpawnLocks.LocalSupport.IKEAForTheBold.DominoUnderground:IsSet() then
						return false
					end

					SpawnLocks.LocalSupport.IKEAForTheBold.DominoUnderground:Set(Game.createMonster("Lumberjack Domino Underground", toPosition))
				end
				undergroundChest:key(Storage.LocalSupport.SpawnDominoUndergroundChest)
				undergroundChest:register()
			end)
	end)
	:MonsterEvent(function()
		local dominoUnderground = CreatureEvent("LumberjackDominoUndergroundDeath")
		function dominoUnderground.onDeath(creature)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
			SpawnLocks.LocalSupport.IKEAForTheBold.DominoUnderground:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.LocalSupport.IKEAForTheBold) == QuestState.LocalSupport.IKEAForTheBold.FindThiefInSewers then
					player:setStorageValueByKey(Storage.LocalSupport.IKEAForTheBold, QuestState.LocalSupport.IKEAForTheBold.SearchDominoUndergroundHideout)
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
			QuestFactory.OnUseDeclarations({
				{
					key = Storage.LocalSupport.BookChest,
					rewards = {
						{ id = 3076 },
						QuestKeyItems.LocalSupport.BookOfContraband,
					},
					nextState = { [Storage.LocalSupport.IKEAForTheBold] = QuestState.LocalSupport.IKEAForTheBold.BringStolenItemListToKomor },
				},
			}),
			QuestFactory.Script(function()
				local contrabantBook = Action()
				function contrabantBook.onUse(player, item, fromPosition, target, toPosition, isHotkey)
					SimpleTextDisplay(player, player:Localizer(LOCALIZERS.LocalSupport):Get("DOMINO_BOOK_OF_CONTRABAND_TEXT"))
					return true
				end
				contrabantBook:key(QuestKeyItems.LocalSupport.BookOfContraband.key)
				contrabantBook:register()
			end)
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
					expReward = 7000,
				},
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
			QuestFactory.Dialog("Anon's Father", {
				[{ "thief", "zlodziej" }] = {
					text = "Mister, I'm just fishing here quietly, and all of the sudden I see a man emerging on the surface. You're saying that he is a thief? - he ran that way, to the east.",
				},
			}),
			QuestFactory.Dialog("Miles, The Guard", {
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

					if SpawnLocks.LocalSupport.IKEAForTheBold.DominoShore:IsSet() then
						return
					end

					SpawnLocks.LocalSupport.IKEAForTheBold.DominoShore:Set(Game.createMonster("Lumberjack Domino Shore", toPosition))
				end
				tileBeforeHawser:key(Storage.LocalSupport.TileBeforeHawser)
				tileBeforeHawser:type("stepin")
				tileBeforeHawser:register()
			end)
	end)
	:MonsterEvent(function()
		local dominoShore = CreatureEvent("LumberjackDominoShoreDeath")
		function dominoShore.onDeath(creature)
			SpawnLocks.LocalSupport.IKEAForTheBold.DominoShore:Reset()

			onDeathForDamagingPlayers(creature, function(creature, player)
				if player:getStorageValueByKey(Storage.LocalSupport.IKEAForTheBold) == QuestState.LocalSupport.IKEAForTheBold.FindAndKillDominoShore then
					player:setStorageValueByKey(Storage.LocalSupport.IKEAForTheBold, QuestState.LocalSupport.IKEAForTheBold.SearchDominoShoreHideout)
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
			QuestFactory.OnUseDeclarations({
				{
					id = 2472,
					key = Storage.LocalSupport.ShoreCaveChest,

					rewards = {
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
					positions = { Position(6197, 1206, 7), Position(6051, 1648, 7) },
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
						[Storage.Finished.IKEAForTheBold] = MISSION_FINISHED,
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
					expReward = 1000,
					rewards = {
						{ id = 12807 },
					},
					outfitRewards = QuestRewards.OutfitsAddons.LocalSupport.Beggar0,
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
				[{ "return", "odnies", "mission", "misja" }] = {
					text = "Thank you! Here's your reward. Wait a moment! Someone scribbled on my chair with a marker! Oh, {darn} it... For my current condition, only a stew with Chinese ping pong onion, meat from an under-milked centennial bull raised by wolves, all topped with wine stolen from the Kutonapleton winery, will help. Alternatively, a simple rotworm {stew} might do the trick.",
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
					expReward = 12000,
					outfitRewards = QuestRewards.OutfitsAddons.LocalSupport.Beggar1,
				},
				[{ "float", "splawik" }] = {
					text = "It fell into the small pond nearby once. Try looking just outside the west gate.",
				},
				[{ "reel", "spinning" }] = {
					text = "I lost it while fishing right there. I think it might be entanged with some weeds. If thats true, you might wanna ask Grave Digger for a machete.",
				},
				[{ "stool", "stolek" }] = {
					text = "It slipped into the water by the lake at the beach with parasols.",
				},
			}),
			QuestFactory.OnUseDeclarations({
				{ id = 3687, key = Storage.LocalSupport.FishmongerFloat, rewards = { QuestKeyItems.LocalSupport.FishmongerFloat } },
				{ id = 3686, key = Storage.LocalSupport.FishmongerReel, rewards = { QuestKeyItems.LocalSupport.FishmongerReel } },
				{ id = 1768, key = Storage.LocalSupport.FishmongerStool, rewards = { QuestKeyItems.LocalSupport.FishmongerStool } },
			})
	end)
	:State(function()
		return QuestState.LocalSupport.SettledDownFishmonger.BringSoupToAnonFather,
			QuestFactory.Dialog("Anon's Father", {
				[{ "bigos", "zupa", "soup", "stew", "mission", "misja", "darn", "kuuurla" }] = {
					text = "Slurp slurp... I'm feeling better now. To be honest, I can't finish the rest. Either eat or give it to those in need. You can collect your reward from my {son}.",
					textNoRequiredItems = "Return with the stew, or the things might become unpleasant!",
					requiredItems = {
						{ id = 9079, remove = false },
					},
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
					outfitRewards = QuestRewards.OutfitsAddons.LocalSupport.Beggar2,
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
