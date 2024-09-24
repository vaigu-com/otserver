local internalNpcName = "Ghost of Germi the Journeyman"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 114,
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

local dialog = {
	[Storage.CaveExplorerOnShield.Questline] = {
		[-1] = {
			[{ GREET }] = { text = "Ouhhh..." },
			[{ ANY_MESSAGE }] = {
				text = "Who are You?",
				requiredTopic = { min = 0, max = 0 },
				nextTopic = 1,
			},
			[{ ANY_MESSAGE }] = {
				text = "Aaaaahhhhh... Beat it!",
				requiredTopic = { min = 1, max = 1 },
				nextTopic = 2,
			},
			[{ ANY_MESSAGE }] = {
				text = "Who am I? What is going on? I can't recall anything!",
				requiredTopic = { min = 2, max = 2 },
				nextTopic = 3,
			},
			[{ ANY_MESSAGE }] = {
				text = "I am... Who...? What...? I.. am dead?",
				requiredTopic = { min = 3, max = 3 },
				nextTopic = 4,
			},
			[{ ANY_MESSAGE }] = {
				text = "I was there - searching for something? Some item? I don't remember...",
				requiredTopic = { min = 4, max = 4 },
				nextTopic = 5,
			},
			[{ ANY_MESSAGE }] = {
				text = "We are in some form of camp. It was a camp... of mine! There has to be something that will help me recall. Find something... anything... Tell me who I was... Look around... Find something that belonged to me. Will you help me? Please!",
				requiredTopic = { min = 5, max = 5 },
				nextTopic = 5,
			},
			[{ "yes", "tak" }] = {
				text = "Thank you.. thanks...",
				requiredTopic = { min = 5, max = 5 },
				nextState = {
					[Storage.CaveExplorerOnShield.Questline] = 1,
					[Storage.CaveExplorerOnShield.Mission01] = 1,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffect,
					},
				},
			},
		},
		[1] = { [{ GREET }] = { text = "Please come back with something of mine." } },
		[2] = {
			[{ GREET }] = { text = "Have you found anything yet?" },
			[{ "mission" }] = {
				text = "Have you found anything yet?",
				nextTopic = 0,
			},
			[{ "yes", "tak" }] = {
				text = "What is that... That looks like my writing... I am remembering now... Yes, I remember! I was an adventurer, and our camp was built there. My memories... They are coming back! Do you... also are up to something in this place? You are the first living human being that I encountered after my... death. I have so much to say. Do you want to listen to my {story}?",
				nextTopic = 1,
				requiredTopic = { min = 0, max = 0 },
				requiredItems = { CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.germiDocument },
				removeRequiredItems = false,
				textNoRequiredItems = "Please come back with something of mine.",
			},
			[{ "story", "historie" }] = {
				text = "In the past I was an adventurer, down for treasure and fame. Over the years of exploring caves I gained ground in my profession, until.... I and my {team} encountered this dungeon. I would try to talk you out of delving here, but alas I already know you won't listen. At least to listen to what I have for you. I might give you few {directions}.",
				requiredTopic = { min = 1, max = 1 },
				nextTopic = 2,
				nextState = {
					[Storage.CaveExplorerOnShield.Questline] = 3,
					[Storage.CaveExplorerOnShield.Mission01] = 3,
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffect,
					},
				},
			},
			[{ ANY_MESSAGE }] = {
				text = "Please come back with something of mine.",
			},
		},
		[3] = {
			[{ GREET }] = {
				text = "In the past I was an adventurer, down for treasure and fame. Over the years of exploring caves I gained ground in my profession, until.... I and my {team} encountered this dungeon. I would try to talk you out of delving here, but alas I already know you won't listen. At least to listen to what I have for you. I might give you few {directions}.",
			},
			[{ "towarzyszami", "team" }] = {
				text = "I remember that i didn't come here alone. I was there with  my fellow {team}. If you ever encounter any of them, will you send my regards?.",
			},
			[{ "yes", "tak" }] = { text = "Thanks in advance. I owe you." },
			[{ "wskazowek", "directions" }] = {
				text = "When I wandered those tunnels, I encountered many hints, probably left by other daredevils when they were still alive or... undead. Some of them were scribblings written on letters, book pages or anything that was probably at hand. Some of them were also written on wooden, metal signs and on gravestones. Some of them were really helpful but others... not so much. Their only purpose was to divert us from the correct path. I fear that these signs were left there by something of malicious nature - the {phantasms}. I took my time to study and analyze this place and the hints left there. The results are in my {journal}.",
			},
			[{ "phantasms", "phantasmy" }] = {
				text = "Long time ago, they made their home in one of the surface pyramids. Recently something is attracting them there. Phantasms can understand human language therefore they can forge their own hints and use them to allure adventurers into traps inside this dungeon. Once their victim is dead, they can feast on their souls. Furthermore, thanks to their psychic powers they can control other beings. Have that in mind before you {trust} anyone here.",
			},
			[{ "dzienniku", "journal" }] = {
				text = "Alas, not being able to find the treasures i desire, i started to lose my way inside those tunnels. My journal has been torn away from me, and ripped apart into pieces. Then these pieces were spread, all around the place. I'm sure that there are {pages} from the journal that still remain intact. Please keep an eye out for those - without them you are doomed!",
			},
			[{ "strony", "pages" }] = {
				text = "On these pages I left information about traps, hints and their authors. There are so many hints already and I suspect that phantasms were making even more of them when I was there. Therefore you won't find information on every trap inside, but rather a general view on the other people and hints. Remember not to trust all of those. Only by wielding the information in my journal can you determine whether the information is {truthful} or not. If you are wondering if my journal pages can be manipulated, there is no way they would be able to {forge} my handwriting.",
			},
			[{ "zaufasz", "trust" }] = {
				text = "Certainly you are wondering whether you can trust me. Whether I was already possessed by phantasms. I would like to prove that I'm myself, but I don't know how to achieve it. You have to decide for yourself, whether you trust me or not - the decision is yours. I can only assure you, that soon you will see about me... hope its not gonna be too late for you.",
			},
			[{ "prawdziwa", "truthful" }] = {
				text = "Unfortunately, I've been in an undead ghost state since some time ago and I don't remember most of my research. One person I'm currently sure about being trustworthy is Miroslaw - adventurer of Ankhar. Alas, I can't recall anything else. If you're gonna delve into this dungeon, you will certainly find notes from my journal that will guide you. Now I advised you with all essential information I had and my conscience is clear. Now i can help you with moving through that {passage}.",
			},
			[{ "podrobione", "forged" }] = {
				text = "There is no way that phantasms can forge my journal, because they cannot recreate others' handwriting. This task would prove difficult for a human let alone a phantasm, who are relatively new to the concept of writing. I saw one of my journal pages not that far behind the door. You can read it and confirm how my handwriting looks, so you can know which pages are genuine.",
			},
			[{ "przejsciem", "passage" }] = {
				text = "Me and my friends sealed the one and only entrance to this dungeon, so no more inexperienced adventurers would die here. If you understood all I had to say I can lead you further. Until that, remember to {prepare} first.",
			},
			[{ "przygotowac", "prepare" }] = {
				text = "From the memory fragments that remain in my brain I conclude that you can't go inside alone. You will be needing a sorcerer, knight, druid and paladin. Also, you all should be equipped with those essential items: rope, shovel, red apple, crossbow, sword and spellbook. Without those you will surely be stuck in there for good. If you got those and you came with trustworthy team, ask me for {opening}",
			},
			[{ "otwarcie", "open", "opening" }] = {
				text = "Here you go - this is a punchcard that will start the door mechanism and open them. Be wary! Doors will automatically close if you pass through them. Take your steps cautiously - every step can be your last!",
				nextState = {
					[Storage.CaveExplorerOnShield.Questline] = 4,
					[Storage.CaveExplorerOnShield.Mission02] = 1,
				},
				rewards = { CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.punchcard },
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.sendMagicEffect,
					},
				},
			},
		},
		[6] = {
			[{ GREET }] = {
				text = "Hello again |PLAYERNAME|. Have you visited my friend?",
			},
			[{ "pozdrowienia", "regards", "salutations", "mission", "yes", "tak" }] = {
				text = "So you visited Engineer Anthony? Anthony, yes... that was his name... That means he is as {dead} as me? What a pity. Despite this... you did good. As I promised, here is your reward. This is all my gold that I hoarded during my lifetime. I can't make any other use of it anymore. I fear that a great evil lies beyond the gate Anthony tried to open. Good luck...",
				rewards = { { id = 3035, count = 100 } },
				expReward = 50000,
				requiredItems = {
					CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.firebug,
					CAVE_EXPLORER_ON_SHIELD_KEY_ITEMS.germiDocument,
				},
			},
		},
		[7] = {
			[{ GREET }] = {
				text = "Hello again |PLAYERNAME|. Do you want to continue our conversation?",
			},
			[{ "mission", "martwy", "dead", "yes", "tak" }] = {
				text = "I'm positive that you are wondering: what was Anthony up to that far from our camp? Well... only now I'm starting to get back my memory. Anthony liked to take matters into own hands, but never did he act so irresponsibly. That night he must have gone to the room with a large key. He must have sneaked out when I was fast asleep. As you know, our camp is separated from the rest of the dungeon with those mechanical doors. Those doors were an Anthony idea - so no unauthorized person can get in. He was probably attacked when he arrived at that room. It could have been the ghouls - cursed remains of past adventurers. He had no chance of resisting their attack given he was there alone... he was eaten alive... poor Anthony. I could not rush to help him, because in the morning... you wouldn't {believe}.",
			},
			[{ "cos", "believe" }] = {
				text = "That morning our camp was instantly overrun by a horde of deadly arachnids. Yes, I remember now... This is how I died... I was bitten to death by dumb maggots! I'm a joke of an adventurer, to die from insects?! They had to be influenced by phantasms. They were the ones to play with Anthony's mind, for sure! They needed us to part ways, so they could deal with us separately. They startled many creatures from nearby caves and hiding places and guided them to our camp. This cave is cursed! Please, don't go further! I already gave you all my gold - you can take all you can find here, but please don't tread further into this dungeon! This place... it does not belong to this world. Phantasms... they are guarding something, I fear that a greater evil lies beyond where you delve so far. Stay here, only death awaits you beyond.",
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, dialog, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, dialog, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
