local internalNpcName = "Bilbeus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1069,
	lookHead = 57,
	lookBody = 10,
	lookLegs = 76,
	lookFeet = 21,
	lookAddons = 0,
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
	[Storage.TheThreeSramatiansAndTheDragon.Questline] = {
		[3] = {
			[{ "mission" }] = {
				text = "Look at him! He cant use a {toilet} properly.",
			},
			[{ "toilet", "latryny" }] = {
				text = "Anyway, soon we'll set out on a further journey. But perhaps, first, would you like to hear the prophecy about the legendary {neyghboor}?",
			},
			[{ "neyghboor", "somsiedzie" }] = {
				text = "...a specific scent not only woke up the companions of adventure but also woke up the vile neyghbor's cravings... Jan Kockodan gets annoyed when someone has it better than him. And he said this: 'This scent is everywhere. It's that dumbass Bilbo, a moron who can afford the hallway paneling. AFTER HIM!! Ugly mutts, run! Follow the scent of wealth!",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 4,
					[Storage.TheThreeSramatiansAndTheDragon.Mission03] = 2,
				},
				monstersToSpawn = { ["Thornfire Wolf"] = 5 },
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "Those wolves were just spirits I summoned to better illustrate the story. The real Jan Kockodan is much more dangerous. If you want to join us, you must complete one challenge. Let's say you steal rum from these pirates here.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 5,
					[Storage.TheThreeSramatiansAndTheDragon.Mission03] = 3,
				},
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "You can see them from our current location. Be careful; spirited water is only ordinary pastime, but rum on the other hand... It's their holy grail.",
			},
		},
		[6] = {
			[{ "mission", "rum" }] = {
				text = "Mmm, delicious. Alright, comrades, it's time to move. See you on the coast at the western steppes.",
				requiredItems = { TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rum },
				textNoRequiredItems = "Come back with rum, or there's nothing to talk about.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 7,
					[Storage.TheThreeSramatiansAndTheDragon.Mission03] = 5,
					[Storage.TheThreeSramatiansAndTheDragon.Mission04] = 1,
				},
			},
		},
		-- 7->8 klikanie ogniska
		[8] = {
			[{ GREET }] = {
				text = "Sorry we went ahead, but we were bored in that wilderness.",
			},
			[{ "mission" }] = {
				text = "Let's head to the private docks of the vampire lords. They receive a daily supply of wine for the nobility. We'll sneak in there unnoticed. No one will figure out few bottles or barrels missing.",
				specialConditions = {
					{
						condition = TRZEJ_SRAMACI_I_SMOK_SPECIAL_CONDITIONS.playerIsDrunk,
						requiredOutcome = true,
						textNoRequiredCondition = "I have a great idea, but I won't tell you while you are sober. I'm already tipsy, now it's your turn.",
					},
				},
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 9,
					[Storage.TheThreeSramatiansAndTheDragon.Mission04] = 3,
					[Storage.TheThreeSramatiansAndTheDragon.Mission05] = 1,
				},
			},
		},
		-- 9 stepin vampire->souleater
		[10] = {
			[{ "mission" }] = {
				text = "We played ourselves. We'll distract the guard, and you try to escape. If we succeed too, we'll meet up at Gertruda place. If we were tio separate, seek help from her.",
			},
		},
		-- gadamy z gertuda 10->11
		-- gadamy z jannah'ma  11->12
		-- dajemy dragon ham dla jannah'ma 12->13
		[13] = {
			[{ "mission" }] = {
				text = "Good thing you found us. I was starting to worry. No time for chit-chat. We tried to extract information about HF-P/X from the desert nomads. One of them claims to know where to find one of the ancient artifacts. We couldn't negotiate with them - maybe you can. Their settlement is in the north of the desert.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 14,
					[Storage.TheThreeSramatiansAndTheDragon.Mission05] = 6,
					[Storage.TheThreeSramatiansAndTheDragon.Mission06] = 1,
				},
			},
		},
		[14] = {
			[{ "mission" }] = {
				text = "Tourists in such a place are an easy target. I told one of the nomads that we wouldn't renovate their old town. Maybe you can offer him something in exchange for information. Currently, they're camped on one of the rocks in the north.",
			},
		},
		[15] = {
			[{ "mission" }] = {
				text = "Tourists in such a place are an easy target. I told one of the nomads that we wouldn't renovate their old town. Maybe you can offer him something in exchange for information. Currently, they're camped on one of the rocks in the north.",
			},
		},
		[16] = {
			[{ "mission" }] = {
				text = "I've heard of underground chocolate chip cookie deposits, but natural bud light formations, never. Are you sure about my truth? Well, okay. Go to the lizard village and try to find at least one bud light. In the meantime, we'll go to the Medusa Tower area. Zwalin wants to meet Marluk sister. Although now I come to think about it, we won't stay there long. Ultimately, we'll meet at Hairycles's.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 17,
					[Storage.TheThreeSramatiansAndTheDragon.Mission06] = 4,
					[Storage.TheThreeSramatiansAndTheDragon.Mission07] = 1,
				},
			},
		},
		[18] = {
			[{ "mission" }] = {
				text = "Hairycles provided us with directions to HF-P/X's hideout. But first, we need to do him a favor. If possible, bring us about 2^log(10000) bananas.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 19,
					[Storage.TheThreeSramatiansAndTheDragon.Mission07] = 3,
				},
			},
		},
		[19] = {
			[{ "mission" }] = {
				text = "Thanks for your help. Now we'll head to the eastern monkey village. Between the Kongo village and the monkey grove there lies a hidden entrance to the ruins of an ancient temple.",
				requiredItems = { { id = 3587, count = 16 } },
				textNoRequiredItems = "I need exactly 16 bananas to avoid embarassment in front of Hairycles.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 20,
					[Storage.TheThreeSramatiansAndTheDragon.Mission07] = 4,
					[Storage.TheThreeSramatiansAndTheDragon.Mission08] = 1,
				},
			},
		},
		[20] = {
			[{ "mission" }] = {
				text = "I have a feeling that Jan Kockodan got ahead of us. Maybe he's hiding somewhere in this hellish cave. Watch out for him! From the notes given to me by Hairycles, it appears that somewhere in this temple are enchanted doors. The key to opening them is to collect three different magical runes. Fortunately, all the runes are in the temple... if no one has stolen them.",
				nextState = {
					[Storage.TheThreeSramatiansAndTheDragon.Questline] = 21,
					[Storage.TheThreeSramatiansAndTheDragon.Mission08] = 2,
				},
			},
		},
		[21] = {
			[{ "mission" }] = {
				text = "Yes, those are all the needed runes. You can now try to find the enchanted doors I mentioned. Maybe we'll find HF-P/X here.",
				requiredItems = {
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune1,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune2,
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS.rune3,
				},
				removeRequiredItems = false,
				textNoRequiredItems = "Unfortunately, I don't know the exact location of the runes.",
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
			},
		},
		[22] = {
			[{ "mission" }] = {
				text = "Wait! Behind those doors might be HF-P/X! Try not to go too deep until we finish collecting, okay?",
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
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
