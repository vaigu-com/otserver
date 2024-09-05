local internalNpcName = "Chester the Dwarf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 160,
	lookHead = 76,
	lookBody = 132,
	lookLegs = 94,
	lookFeet = 0,
	lookAddons = 3,
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

local conversationData = {
	[Storage.SpoczywajacyTutaj.Questline] = {
		[6] = {
			[{ "mission" }] = {
				text = "Listen, I've finished exploring holes, and now I have a different passion. If you want to help me, listen up. Some time ago, I got a job as a TV presenter, and I still have that job. Unfortunately, the salary is not entirely satisfactory. I found out that one of the fortune tellers hosting some show on the network where I work has been quarantined. The station is now looking for a replacement for his position, and I think I'm suited for it - I have a degree in quackery, but I'll need a few props. Are you ready to help me?",
			},
			[{ "yes", "tak" }] = {
				text = "Great. I need a Magic Light Wand to blind viewers with false promises. A Magician's Robe to look like a magician. A crystal ball with a small hole... just find a round aquarium. Lastly, I need a life crystal. If you gather these items, come back to me.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 1,
					[Storage.CzeslawKrasnolud.Mission01] = 1,
					[Storage.SpoczywajacyTutaj.Questline] = 7,
				},
				requiredItems = { SPOCZYWAJACY_TUTAJ_KEY_ITEMS["last_will"] },
			},
		},
	},
	[Storage.CzeslawKrasnolud.Questline] = {
		[1] = {
			[{ GREET }] = {
				text = "Hello, hello. Have you already acquired all the items I requested?",
			},
			[{ "mission", "yes", "tak" }] = {
				text = "Thanks. I'm heading for the casting soon. Here's your reward, my pickaxe.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 2,
					[Storage.CzeslawKrasnolud.Mission01] = 2,
					[Storage.CzeslawKrasnolud.Mission02] = 1,
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
		},
		[2] = {
			[{ "mission" }] = {
				text = "My career as a TV fortune teller was going well. Some time ago, I took out a loan to start my own business, which turned out to be a scam, of course. I went to the turf accountant and bet on RKS Huwdu winning. Those failures of a human decided to lose, and I ended up with a payday loan with 69% interest! The deadline for the first loan installment is approaching. I don't want the bailiff to seize my house. Try asking Andrew the Moustachizzle about my problem. They always manage to avoid the law and responsibility.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 3,
					[Storage.CzeslawKrasnolud.Mission02] = 2,
				},
			},
		},
		[3] = {
			[{ "mission" }] = {
				text = "Andrew the Moustachizzle has its bandit shithole located on east of mirkotown.",
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "Thanks for your help. Now I'll be able to set up my office properly. Please take my mining helmet as a reward. As for the costs, I didn't expect such a high amount. I only have 70 platinum with me. I'll try to cover the rest in the future.",
				requiredItems = {
					CZESLAW_KRANSOLUD_KEY_ITEMS["identity_document"],
				},
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 5,
					[Storage.CzeslawKrasnolud.Mission02] = 4,
					[Storage.CzeslawKrasnolud.Mission03] = 1,
				},
				outfitRewards = {
					{ outfitId = 574, addon = 3 },
					{ outfitId = 575, addon = 3 },
				},
				rewards = { { id = 3035, count = 70 } },
				expReward = 250000,
				textNoRequiredItems = "Don't you have a new document for me yet? I'll wait then.",
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "You still need to help me with one more thing. I accidentally burned my cover, and the officials will seize my house soon. For financial scams, evading the authorities and other frauds, I'll get at least 15 years. I'm too old for that. I won't even survive that long. I thought about escaping from this continent. Somewhere in the desert, deep underground, I parked my steamboat. It was a long time ago, so I don't remember where the entrance to the cave is where I keep the steam engine. All I remember is that the entrance is boarded up. Just find that place and come back to me to mark it on the map.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 6,
					[Storage.CzeslawKrasnolud.Mission03] = 2,
				},
			},
		},
		[6] = {
			[{ "mission", "entrance", "wejscie" }] = {
				text = '"Come to think of it, I might have encountered some gargoyles while exploring around the cave.',
			},
		},
		[7] = {
			[{ "mission" }] = {
				text = "Are you sure that's the place? All right, here are the keys to my mole. I don't remember where I parked it, but actually, any mole will do. One more thing: I heard that my travel companion, Gandalf, is still alive. We used to steal from a certain library where we found a prophecy about the resurrection of the Crypt King. If that moment ever comes, I think Gandalf will count on the help of the bravest warriors like you. If you want to befriend him, it's worth remembering this secret passphrase: {aside from that people}. Meanwhile, I'm heading out of here. Goodbye.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 8,
					[Storage.CzeslawKrasnolud.Mission03] = 4,
					[Storage.CzeslawKrasnolud.DoorToCzeslawCompartment] = 1,
				},
				expReward = 30000,
				rewards = { { id = 27605 } },
			},
		},
		[8] = {
			[{ "oprocz tego ludzie", "aside from that people" }] = {
				text = "Yeah, its our key.",
			},
		},
		[9] = {
			[{ "mission" }] = {
				text = "Found, not stolen. But due to our acquaintance, I can return what I took from Gandalf. Here's his camo backpack that I couldn't open. I won't lie, I'd like to know what's inside. Besides that, I have some stuff from WotE and this strange bag.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 10,
					[Storage.CzeslawKrasnolud.Mission04] = 2,
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
					CZESLAW_KRANSOLUD_KEY_ITEMS["gandalf_bag"],
					{ id = 11698 },
					{ id = 27565 },
				},
			},
		},
	},
	[Storage.SynMarnotrawny.Questline] = {
		[1] = {
			[{ "mission" }] = {
				text = "I now have my eye on a certain Januszex TM. They have their headquarters far to the east. I would start working on my CV, but first, i need to learn more about the working conditions there. I would like to ask you to go there by {train}. They have a special metro line that stops at their company. When you are there, search for building with 'C' marking outside.",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 2,
					[Storage.SynMarnotrawny.Mission01] = 2,
					[Storage.SynMarnotrawny.MetroAccess] = 1,
					[Storage.SynMarnotrawny.TrainDestinations.ToJanuszex] = 1,
					[Storage.SynMarnotrawny.TrainDestinations.ToHurghada] = 1,
				},
				specialActionsOnSuccess = {
					[SYN_MARNOTRAWNY_SPECIAL_ACTIONS.setPersonalBlackboardPassword] = {},
				},
			},
		},
		[2] = {
			[{ "train", "pociagiem" }] = {
				text = "Just use the blackboard here to see the schedules of the train.",
			},
		},
		[24] = {
			[{ GREET }] = { text = "Did you manage to get the payslip?" },
			[{ "yes", "tak" }] = {
				text = "Thanks for the info. This is your reward for your good job!",
				nextState = {
					[Storage.SynMarnotrawny.Questline] = 25,
					[Storage.SynMarnotrawny.Mission06] = 4,
					[Storage.Finished.SynMarnotrawny] = 1,
					[Storage.BigKlamoty.Questline] = 1,
					[Storage.BigKlamoty.Mission01] = 1,
				},
				expReward = 2000000,
				rewards = { ExerciseWeaponBox(6000) },
				requiredItems = { SYN_MARNOTRAWNY_KEY_ITEMS["PAYSLIP"] },
				textNoRequiredItems = "Come back when you have it.",
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, conversationData, npcHandler, npc)
	return true
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveConversation(creature, msg, conversationData, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
