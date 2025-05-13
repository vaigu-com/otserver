local quest = Quest(LOCALIZERS.AvastYe)

quest
	:Storage(function()
		Storage.AvastYe = {
			Mission01 = {},
			ShipDestinations = {
				PhantomPort = {},
				PirateIsland = {},
				PortLouse = {},
				WyrmCliffs = {},
				NagaIsland = {},
			},
			TrustedWith = {
				Morgram = {},
				Redbeard = {},
				LadyIronhook = {},
				ChrisTheTailor = {},
			},
		}
		QuestState.AvastYe = {
			Mission01 = {
				BringSapphiresToMorgram = 1,
				TalkToRedbeard = 2,
				BringHydraHeadToRedbeard = 3,
				TalkToIronhook = 4,
				BringPantherHeadToIronhook = 5,
				TalkToChrisTheTailor = 6,
				BringRingToChrisTheTailor = 7,
			},
		}
	end)
	:Constant(function() end)
	:Questlog(function(localizer)
		table.insert(Quests, {
			name = "Avast Ye!",
			localizer = localizer,
			missions = {
				{
					name = "Up to snuff",
					storage = Storage.AvastYe.Mission01,
					states = {
						[QuestState.AvastYe.Mission01.BringSapphiresToMorgram] = "Bring 10 sapphires to Morgram.",
						[QuestState.AvastYe.Mission01.TalkToRedbeard] = "Try to find the next pirate lord and gain his trust.",
						[QuestState.AvastYe.Mission01.BringHydraHeadToRedbeard] = "Show one freshly cut hydra head to Redbeard.",
						[QuestState.AvastYe.Mission01.TalkToIronhook] = "Try to find the next pirate lord and gain his trust.",
						[QuestState.AvastYe.Mission01.BringPantherHeadToIronhook] = "Lady Ironhook wants you to bring her one panther head.",
						[QuestState.AvastYe.Mission01.TalkToChrisTheTailor] = "Try to find the next pirate lord and gain his trust.",
						[QuestState.AvastYe.Mission01.BringRingToChrisTheTailor] = "Chris the Tailor send you out on a mission to find a broken ring of ending. Find it and bring it back to him.",
						[MISSION_FINISHED] = "You helped all pirate lords.",
					},
				},
				{
					name = "Phantom Port",
					storage = Storage.AvastYe.ShipDestinations.PhantomPort,
					states = {
						[ACCESS_GRANTED] = "You unlocked this route.",
					},
				},
				{
					name = "Pirate Island",
					storage = Storage.AvastYe.ShipDestinations.PirateIsland,
					states = {
						[ACCESS_GRANTED] = "You unlocked this route.",
					},
				},
				{
					name = "Port Louse",
					storage = Storage.AvastYe.ShipDestinations.PortLouse,
					states = {
						[ACCESS_GRANTED] = "You unlocked this route.",
					},
				},
				{
					name = "Wyrm Cliffs",
					storage = Storage.AvastYe.ShipDestinations.WyrmCliffs,
					states = {
						[ACCESS_GRANTED] = "You unlocked this route.",
					},
				},
				{
					name = "Naga Island",
					storage = Storage.AvastYe.ShipDestinations.NagaIsland,
					states = {
						[ACCESS_GRANTED] = "You unlocked this route.",
					},
				},
			},
		})
	end)
	:Mission(Storage.AvastYe.TrustedWith.Morgram)
	:State(function()
		return ACCESS_GRANTED,
			QuestFactory.Dialog("Morgram", {
				[{ GREET }] = {
					text = "Back again, eh? I knew ye had some guts in ye. If ye be needin' a {ship}, I can make it happen. Ain't no safer way than ridin' with me! Just say the word, and we be off.",
				},
				[TRAVEL_KEYWORDS[TRANSPORT_TYPE.SHIP]] = {
					text = "Where we goin'?",
					specialActionsOnSuccess = {
						{
							action = CreateTransportWindow,
							transports = TRANSPORT_ROUTES.PIRATE_SHIP,
							transportType = TRANSPORT_TYPE.SHIP,
						},
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerIsPzLocked,
							requiredOutcome = false,
							textFailedRequirement = "Har har! Ye reek of battle, matey! Ain't no captain fool enough to take a fighter fresh off the blood spillin'! Rest yer bones a while - let the sea wash away the fight. Then, and only then, I'll take ye where ye need goin'.",
						},
					},
				},
			})
	end)
	:Mission(Storage.AvastYe.TrustedWith.Redbeard)
	:State(function()
		return ACCESS_NOT_GRANTED, QuestFactory.Dialog("Redbeard", {
			[{ GREET }] = {
				text = "Oh, ye must be mistaken - I don't deal with half-done sailing.",
				interactOnGreet = false,
			},
		})
	end)
	:State(function()
		return ACCESS_GRANTED,
			QuestFactory.Dialog("Redbeard", {
				[{ GREET }] = {
					text = "Ahoy there, matey! Good to see a proper sea dog returnin' to these waters. Ye need a ship to sail? - no trouble. Just say the word, and we'll set {sail}!",
				},
				[TRAVEL_KEYWORDS[TRANSPORT_TYPE.SHIP]] = {
					text = "Where we goin'?",
					specialActionsOnSuccess = {
						{
							action = CreateTransportWindow,
							transports = TRANSPORT_ROUTES.PIRATE_SHIP,
							transportType = TRANSPORT_TYPE.SHIP,
						},
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerIsPzLocked,
							requiredOutcome = false,
							textFailedRequirement = "Har har! Ye reek of battle, matey! Ain't no captain fool enough to take a fighter fresh off the blood spillin'! Rest yer bones a while - let the sea wash away the fight. Then, and only then, I'll take ye where ye need goin'.",
						},
					},
				},
			})
	end)
	:Mission(Storage.AvastYe.TrustedWith.LadyIronhook)
	:State(function()
		return ACCESS_NOT_GRANTED, QuestFactory.Dialog("Lady Ironhook", {
			[{ GREET }] = {
				text = "Ain't no foolin' these old bones! I ain't dealin' with no privateers!",
				interactOnGreet = false,
			},
		})
	end)
	:State(function()
		return ACCESS_GRANTED,
			QuestFactory.Dialog("Lady Ironhook", {
				[{ GREET }] = {
					text = "Har har! If it ain't me favorite beast hunter! Ye lookin' fer a ride? Lucky ye - me ship {sail}s the seas. Just give the word, and I'll get us anywhere faster than a shark on fresh prey.",
				},
				[TRAVEL_KEYWORDS[TRANSPORT_TYPE.SHIP]] = {
					text = "Where we goin'?",
					specialActionsOnSuccess = {
						{
							action = CreateTransportWindow,
							transports = TRANSPORT_ROUTES.PIRATE_SHIP,
							transportType = TRANSPORT_TYPE.SHIP,
						},
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerIsPzLocked,
							requiredOutcome = false,
							textFailedRequirement = "Har har! Ye reek of battle, matey! Ain't no captain fool enough to take a fighter fresh off the blood spillin'! Rest yer bones a while - let the sea wash away the fight. Then, and only then, I'll take ye where ye need goin'.",
						},
					},
				},
			})
	end)
	:Mission(Storage.AvastYe.TrustedWith.ChrisTheTailor)
	:State(function()
		return ACCESS_NOT_GRANTED, QuestFactory.Dialog("Chris the Tailor", {
			[{ GREET }] = {
				text = "Har har! Ye think I do business with any scrappy deckhand that washes up here?",
				interactOnGreet = false,
			},
		})
	end)
	:State(function()
		return ACCESS_GRANTED,
			QuestFactory.Dialog("Chris the Tailor", {
				[{ GREET }] = {
					text = "The sea whispers yer name now, aye. If it's Naga Island ye be seekin', I can ferry ye there through waters few dare to tread. But be warned - the spirits be watchin' always. Speak, and we set sail.",
				},
				[TRAVEL_KEYWORDS[TRANSPORT_TYPE.SHIP]] = {
					text = "Where we goin'?",
					specialActionsOnSuccess = {
						{
							action = CreateTransportWindow,
							transports = TRANSPORT_ROUTES.PIRATE_SHIP,
							transportType = TRANSPORT_TYPE.SHIP,
						},
					},
					specialRequirements = {
						{
							requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerIsPzLocked,
							requiredOutcome = false,
							textFailedRequirement = "Har har! Ye reek of battle, matey! Ain't no captain fool enough to take a fighter fresh off the blood spillin'! Rest yer bones a while - let the sea wash away the fight. Then, and only then, I'll take ye where ye need goin'.",
						},
					},
				},
			})
	end)
	:Mission(Storage.AvastYe.Mission01)
	:State(function()
		return MISSION_NOT_STARTED,
			QuestFactory.Dialog("Morgram", {
				[{ GREET, "mission", "misja" }] = {
					text = "Aye, what be this? A landlubber seekin' favor from Morgram? Har har! If ye want my help, I got me own desires - 10 sapphires, rare and shimmerin' like the sea at dawn. Bring 'em to me, and I'll see to it ye get safe passage to the Hurghada Safehouse.",
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.BringSapphiresToMorgram,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.BringSapphiresToMorgram,
			QuestFactory.Dialog("Morgram", {
				[{ "mission", "misja" }] = {
					text = "Well, I'll be damned! Ye actually got 'em! Look at these beauties - shinin' like stolen moonlight! Ye done good, matey. As promised, I'll see ye safe between this Phantom Port 'ere and Pirate Island.",
					textNoRequiredItems = "Har har har! This be a jest, aye? Ye tell me ye got 10 sapphires, but I see nothin' but air in yer hands. Either cough up the goods, or get lost!",
					expReward = 25000,
					requiredItems = {
						{ id = 3029, count = 10 },
					},
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.TalkToRedbeard,
						[Storage.AvastYe.ShipDestinations.PhantomPort] = ACCESS_GRANTED,
						[Storage.AvastYe.ShipDestinations.PirateIsland] = ACCESS_GRANTED,
						[Storage.AvastYe.TrustedWith.Redbeard] = ACCESS_GRANTED,
						[Storage.AvastYe.TrustedWith.Morgram] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.TalkToRedbeard,
			QuestFactory.Dialog("Redbeard", {
				[{ "mission", "misja" }] = {
					text = "Arrr, ye look like a scallywag with a bit o' spine! Just the sort I be needin' fer a dangerous errand. I got me eyes set on a trophy fit fer a pirate king - a Hydra's head! Aye, ye heard me right. A beast with more heads than a crew o' drunkards after a raid! But I only be needing' to see one. Ye bring back that head, and i promise there be place among our crew for ye.",
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.BringHydraHeadToRedbeard,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.BringHydraHeadToRedbeard,
			QuestFactory.Dialog("Redbeard", {
				[{ "mission", "misja" }] = {
					text = "By the briny deep, ye actually did it! The ugly thing's even worse lookin' up close. Fine work, matey! I be willin' to ferry ye to Hurghada Safehouse, should ye need it. But listen now, there be other Pirate Lords with needs as dire as mine. Ye scratch their backs, and they might be helpin' ye too. If yer still thirsty fer adventure, seek out other pirate lords.",
					textNoRequiredItems = "Arrr, what kinda fool's game be this? Ye tryin' to swindle ol' Redbeard? Ye best come back when ye actually got that Hydra's head, ye sorry excuse for a deckhand!",
					requiredItems = {
						{ id = 10282, remove = false },
					},
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.TalkToIronhook,
						[Storage.AvastYe.ShipDestinations.PortLouse] = ACCESS_GRANTED,
						[Storage.AvastYe.TrustedWith.LadyIronhook] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.TalkToIronhook,
			QuestFactory.Dialog("Lady Ironhook", {
				[{ "mission", "misja" }] = {
					text = "What's this? A runt wanderin' onto me ship lookin' fer favors? I don't grant 'em lightly. I got me eyes on somethin' rare - bring me the head of a black panther, and I'll take ye to Pirate Island meself. But don't come back empty-handed, or I'll have ye swabbin' me deck for a month!",
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.BringPantherHeadToIronhook,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.BringPantherHeadToIronhook,
			QuestFactory.Dialog("Lady Ironhook", {
				[{ "mission", "misja" }] = {
					text = "Har har! Now THAT'S a fine specimen! Black as the abyss, sleek as the wind. Ye done well, whelp - ye might not be a complete disappointment after all! As promised, I'll ferry ye to Wyrm Cliffs. But if ye be lookin' for more cursed treasures, Chris the Tailor be the one to talk to next.",
					textNoRequiredItems = "Ye think ye can fool me, whelp? Where be me panther head? Unless ye got it, don't waste me time!",
					requiredItems = {
						{ id = 12039 },
					},
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.TalkToChrisTheTailor,
						[Storage.AvastYe.ShipDestinations.WyrmCliffs] = ACCESS_GRANTED,
						[Storage.AvastYe.TrustedWith.ChrisTheTailor] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.TalkToChrisTheTailor,
			QuestFactory.Dialog("Chris the Tailor", {
				[{ "mission", "misja" }] = {
					text = "Ah, another traveler seekin' passage? I don't trade in steel and blood, but I do trade in legend. The Broken Ring of Ending - an artifact lost to time. Bring it to me, and I'll sail ye to Naga Island. Im the only one on this hemisphere that can take you there And trust me, mate, I can tell a fraud when I see one.",
					nextState = {
						[Storage.AvastYe.Mission01] = QuestState.AvastYe.Mission01.BringRingToChrisTheTailor,
					},
				},
			})
	end)
	:State(function()
		return QuestState.AvastYe.Mission01.BringRingToChrisTheTailor,
			QuestFactory.Dialog("Chris the Tailor", {
				[{ "mission", "misja" }] = {
					text = "A relic woven with endings and beginnings... Aye, this be a rare treasure indeed. Ye've done well, traveler. As promised, I'll take ye to Naga Island. And a word of advice - when dealin' with the serpents there, mind yer words. They be listenin'. I almost forgot - one can sail there only on a tide!",
					textNoRequiredItems = "Now now, I ain't blind! That ring ain't in yer possession, so don't be tellin' tales, lad!",
					requiredItems = {
						{ id = 12737 },
					},
					nextState = {
						[Storage.AvastYe.Mission01] = MISSION_FINISHED,
						[Storage.AvastYe.ShipDestinations.NagaIsland] = ACCESS_GRANTED,
					},
				},
			})
	end)
	:Register()
