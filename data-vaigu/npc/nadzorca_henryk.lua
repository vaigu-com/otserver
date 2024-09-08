local internalNpcName = "Henry the Foreman"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1444,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 76,
	lookFeet = 94,
	lookAddons = 2,
}

npcConfig.flags = { floorchange = false }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local config = {
	[Storage.SynMarnotrawny.Questline] = {
		[3] = {
			[{ "mission" }] = {
				text = "Are you new here? This will be your first job: paint the topex hammers. Head to the 'A' building first.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 4,
					[Storage.SynMarnotrawny.Mission02] = 2,
				},
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "Get to making calculators, you slacker! Go to the 'P' building now.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 5,
					[Storage.SynMarnotrawny.Mission02] = 3,
				},
				requiredItems = {
					{ id = SYN_MARNOTRAWNY_NORMAL_ITEMS.doneHammer, count = 5 },
				},
				textNoRequiredItems = "Bring me five hammers painted metallic.",
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "Non-standard work footwear! For that you will go to the 'S' building and take care of plier work order.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 6,
					[Storage.SynMarnotrawny.Mission02] = 4,
				},
				requiredItems = {
					{
						id = SYN_MARNOTRAWNY_NORMAL_ITEMS.doneCalculator,
						count = 5,
					},
				},
				textNoRequiredItems = "Should be five calculators! Im still waiting.",
			},
		},
		[6] = {
			[{ "mission" }] = {
				text = "Good job. You just earned your way into the assistant position. You are now granted a permission to use main entrance and exit to the surface.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 7,
					[Storage.SynMarnotrawny.Mission02] = 5,
					[Storage.SynMarnotrawny.Mission03] = 1,
					[Storage.SynMarnotrawny.MainGateAccess] = 1,
				},
				requiredItems = {
					{ id = SYN_MARNOTRAWNY_NORMAL_ITEMS.donePliers, count = 5 },
				},
				textNoRequiredItems = "Im still waiting for those pliers.",
			},
		},
		[7] = {
			[{ GREET }] = {
				text = "Are you ready to hear about your new {duties}?",
			},
			[{ "duties", "obowiazki", "yes", "tak" }] = {
				text = "I have a hunch that the quantity of our soaps and towels is shrinking at above-average rate. Find out more about this, and remember: not every Areczek is a thief, but every thief is Areczek. Bring be about four of each towel and soap.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 8,
					[Storage.SynMarnotrawny.Mission03] = 2,
				},
			},
		},
		[8] = {
			[{ "mission" }] = {
				text = "Those goddamn parasites! This company net profit is barely positive, and they are trying to ruin us!",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 9,
					[Storage.SynMarnotrawny.Mission03] = 3,
				},
				requiredItems = {
					{ id = SYN_MARNOTRAWNY_NORMAL_ITEMS.toiletSoap, count = 4 },
				},
				textNoRequiredItems = "Actually, bring me just four soaps. I just recalled that there was towel shortage at local walmart when we tried to order them.",
			},
		},
		[9] = {
			[{ "mission" }] = {
				text = "A bunch of Areczeks trying to create a worker union. Get rid of their leader, and they will surely yield.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 10,
					[Storage.SynMarnotrawny.Mission03] = 4,
				},
			},
		},
		[10] = {
			[{ "mission" }] = {
				text = "If i recall correctly, their leader won a cozy bed at a poker table. Its located between A and S buildings.",
			},
		},
		[11] = {
			[{ "mission" }] = {
				text = "Thanks for help. Now i wont have to worry about labour law or some human rights.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 12,
					[Storage.SynMarnotrawny.Mission03] = 6,
					[Storage.SynMarnotrawny.Mission04] = 1,
				},
			},
		},
		[12] = {
			[{ "mission" }] = {
				text = "Good job. Now i have a new mission for you. Take a look at the bookshelf behind me. You can find The Art of Eristics there. You are gonna need it for later mission. Also, i need you to find the two other tomes from this series. I lost one in the caves, near the south gate. Other one i accidentally flushed down the toilet, which caused the northern caves to be flooded. There is underwater lift near the temple; go down to the bottom of the sewer and search there.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 13,
					[Storage.SynMarnotrawny.Mission04] = 2,
				},
			},
		},
		[13] = {
			[{ "mission" }] = {
				text = "Alright, there are all the book you need. Now for the real task: we are hosting a party in the conference room. You can find some of our clients here. Try to convince them to take out a loan for one of our 'pristine' products. The books i had you bring to me were in Swahili, so you wouldnt understand a word. And now: I doth grant unto thee ye might of larcraeft.",
				requiredItems = {
					SYN_MARNOTRAWNY_KEY_ITEMS["BOOK_ONE"],
					SYN_MARNOTRAWNY_KEY_ITEMS["BOOK_TWO"],
					SYN_MARNOTRAWNY_KEY_ITEMS["BOOK_THREE"],
				},
				textNoRequiredItems = "Come back when you are done collecting the books.",
				rewards = {
					SYN_MARNOTRAWNY_KEY_ITEMS["POT"],
					SYN_MARNOTRAWNY_KEY_ITEMS["LOVE_POTION"],
					SYN_MARNOTRAWNY_KEY_ITEMS["HERBS"],
				},
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 14,
					[Storage.SynMarnotrawny.Mission04] = 3,
				},
			},
		},
		[14] = {
			[{ "mission" }] = {
				text = "Badass, dude - you got all of them to take out a loan for those >products. You are thereby promoted to senior assistant. Now you can access the main cave system on the north.",
				textNoRequiredItems = "Come back when you are done collecting the loan declarations.",
				requiredItems = {
					{
						id = SYN_MARNOTRAWNY_KEY_ITEMS["LOAN_DOCUMENT"].id,
						aid = SYN_MARNOTRAWNY_KEY_ITEMS["LOAN_DOCUMENT"].aid,
						count = 3,
					},
				},
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 15,
					[Storage.SynMarnotrawny.Mission04] = 4,
					[Storage.SynMarnotrawny.Mission05] = 1,
					[Storage.SynMarnotrawny.NorthMinesAccess] = 1,
				},
			},
		},
		[15] = {
			[{ "mission" }] = {
				text = "I have a new mission for you. Do you remember when i mentioned that northern caves are now flooded? Officially, everyone was out when the flooding occured, but acutally it was swarming with miners there. It were rush hours when it happened. Areczek lives dont matter, so noone ever investigated it. Later, cave has been ravaged by hostile water-shaped creatures. One of the dwarfs here had something i need now. Try to find his corpse. You can identify him by his gray Beard.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 16,
					[Storage.SynMarnotrawny.Mission05] = 2,
				},
			},
		},
		[16] = {
			[{ "mission" }] = {
				text = "Yeah, this is the one i was looking for.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 17,
					[Storage.SynMarnotrawny.Mission05] = 3,
				},
				requiredItems = { SYN_MARNOTRAWNY_KEY_ITEMS["DIAMOND_NECKLACE"] },
				textNoRequiredItems = "Grab necklace from that corpse first. Be careful, those monsters are aggressive!",
			},
		},
		[17] = {
			[{ "mission" }] = {
				text = "What else could you help me with... hmmm. Well, you check can the lava mines for new finds. Reach the top of one of the silos, and check its state by using the special machine. Also some Areczek reported that he found an abandoned cultivator there. Romek, the King of Rats might be interested in it, so give it a try and find it.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 18,
					[Storage.SynMarnotrawny.Mission05] = 4,
				},
			},
		},
		[19] = {
			[{ "mission" }] = {
				text = "Nothing special, as i thought. Now, you have to help me with something. My friend, Fredi, is currently in the north-eastern mines. I need him here, so try to convince him to come. If he wont move, try to find a distilling machine. Its content will make him move. Fredi is very aggressive when drunk, so be careful.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 20,
					[Storage.SynMarnotrawny.Mission05] = 6,
				},
			},
		},
		[20] = {
			[{ "mission", "fredi" }] = {
				text = "Good job. Give us a moment now.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 21,
					[Storage.SynMarnotrawny.Mission05] = 7,
				},
				specialConditions = {
					{
						condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.frediIsNearby,
						requiredOutcome = true,
						textNoRequiredCondition = "Come back with Fredi.",
					},
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.despawnEscortee,
						escorteeName = "fredi kamionka monster",
						despawnAfterSeconds = 10,
					},
				},
			},
		},
		[21] = {
			[{ "mission" }] = {
				text = "I had a word with my friend Fredi. HE TOLD ME ABOUT HE NEW BMW OUR IMPERATOR IS DRIVING. This goddamn ostentatious thief. You proven yourself reliable. Its time to end him now. To be granted an audience with him, you need to know the password. The password is written on the blackboard, along the cobblestone trail. Not one Areczek is smart enough to figure the workings of the mechanism that reveals it. I cannot leave my position, but you can go and read it. Came back to me when you find it.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 22,
					[Storage.SynMarnotrawny.Mission05] = 8,
					[Storage.SynMarnotrawny.Mission06] = 1,
					[Storage.SynMarnotrawny.PolAccess] = 1,
				},
				specialConditions = {
					{
						condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.frediIsNearby,
						requiredOutcome = false,
						textNoRequiredCondition = "Give us a moment.",
					},
				},
			},
		},
		[22] = {
			[{ "mission" }] = {
				text = "Did you find out what is the password? What is it?",
			},
			[{ "yes", "tak" }] = {
				text = "Go and talk with Access-o-bot in eastern part of the castle. Tell him the password, and he will let you in.",
			},
			[{ ANY_MESSAGE }] = {
				text = "Yeah, thats it! Go and get rid of our imperator!",
				specialConditions = {
					{
						condition = SYN_MARNOTRAWNY_SPECIAL_CONDITIONS.saidCorrectPassword,
						requiredOutcome = true,
						textNoRequiredCondition = "No. Im sure its not the password. Try looking behind the waterfall.",
					},
				},
			},
		},
		[23] = {
			[{ "mission" }] = {
				text = "Alright. For all your effort i present to you this legendary payslip. Dont worry, it works outside our company shop.",
				rewards = { SYN_MARNOTRAWNY_KEY_ITEMS["PAYSLIP"] },
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 24,
					[Storage.SynMarnotrawny.Mission06] = 3,
				},
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveConversation(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
