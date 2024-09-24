local internalNpcName = "Hugo BoSS"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 289,
	lookHead = 41,
	lookBody = 85,
	lookLegs = 1,
	lookFeet = 0,
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
	[Storage.PerIustitiaAdAstra.Questline] = {
		[16] = {
			[{ GREET }] = { text = "Guten tag. Was hast du zu sagen?" },
			[{ "uberfabrik" }] = {
				text = "I'll tell you that your German is terrible. I served with Friedrich Knopf, i knew Friedrich Knopf, Friedrich Knopf was a friend of mine. My dear, are not Friedrich Knopf. So what are you looking for here?",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 17,
					[Storage.PerIustitiaAdAstra.Mission05] = 2,
				},
			},
			[{ ANY_MESSAGE }] = { text = "Ich verstehe kein einziges wort." },
		},
		[17] = {
			[{ GREET }] = { text = "Tell me immediately what you're looking for!" },
			[{ ANY_MESSAGE }] = {
				text = "Tell me immediately what you're looking for!",
			},
			[{ "mission", "job", "praca", "pracy" }] = {
				text = "So you stole the identity of one of my employees to work for me? I hire anyone anyway. Alright, I have a first task for you: the new bartender doesn't know how to make my favorite drink. Find my recipe for 'Booty Sweat Lean' so he knows exactly what ingredients to use. You'll find a chest with recipes on the top floor of the library. Just photocopy the recipe and come back to me.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 18,
					[Storage.PerIustitiaAdAstra.Mission05] = 3,
				},
			},
		},
		[18] = {
			[{ "mission" }] = {
				text = "Unfortunately, I lost the key to the library. I'm afraid you'll have to find another way to get upstairs and find that {recipe}. Maybe try being a Spider-Man.",
			},
		},
		[19] = {
			[{ "przepis", "recipe", "mission" }] = {
				text = "Very well done! I have another task for you. You've probably noticed that the castle is overrun by partygoers. They're no nobles, so they don't know how to behave. They recently damaged part of the castle in the east wing. I hired no one other than Boguslaw Lecina to repair it. Now, not only do I have a damaged wall, but there are also grooves from the sanding. Or maybe it's just residue from his cigarettes that settled on the wall? It's not important. Find his toolbox and take one hammer from it. Then go to the waterworks and loosen the valve in the lower part. There's so much mess and I dont even know what else, that we can't flush corpses down the toilet anymore.",
				requiredItems = { PER_IUSTITIA_AD_ASTRA_KEY_ITEMS.hugoRecipe },
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 20,
					[Storage.PerIustitiaAdAstra.Mission05] = 5,
				},
				textNoRequiredItems = "Come back when you've obtained the recipe for my favorite drink.",
			},
		},
		[20] = {
			[{ "mission" }] = {
				text = "I have another task for you. You've probably noticed that the castle is overrun by partygoers. They're no nobles, so they don't know how to behave. They recently damaged part of the castle in the east wing. I hired no one other than Boguslaw Lecina to repair it. Now, not only do I have a damaged wall, but there are also grooves from the sanding. Or maybe it's just residue from his cigarettes that settled on the wall? It's not important. Find his toolbox and take one hammer from it. Then go to the waterworks and loosen the valve in the lower part. There's so much mess and I dont even know what else, that we can't flush corpses down the toilet anymore.",
			},
		},
		[21] = {
			[{ GREET }] = {
				text = "You did well. Listen, there's a very old room in the castle's basement, and inside it, there's an even older chest. One of my great-grandfathers left it there. The chest is enchanted, so it can't be opened just like that. I think it will open on its own if you solve the riddle. If you manage to open it, come back to me and report what you found inside.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 22,
					[Storage.PerIustitiaAdAstra.Mission05] = 7,
				},
			},
			[{ "mission" }] = {
				text = "You did well. Listen, there's a very old room in the castle's basement, and inside it, there's an even older chest. One of my great-grandfathers left it there. The chest is enchanted, so it can't be opened just like that. I think it will open on its own if you solve the riddle. If you manage to open it, come back to me and report what you found inside.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 22,
					[Storage.PerIustitiaAdAstra.Mission05] = 7,
				},
			},
		},
		[22] = {
			[{ "mission" }] = {
				text = "My great-grandmother, a witch, once mentioned that to open the chest, I would need some runes. I don't know anything about magic, so I can't help you with that.",
			},
		},
		[23] = {
			[{ GREET }] = { text = "So, did you manage to find anything?" },
			[{ "experience", "doswiadczenie", "level", "poziom", "mission" }] = {
				text = "Oh, that old man! What's this much of experience points worths in these times... You can keep them.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 24,
					[Storage.PerIustitiaAdAstra.Mission05] = 9,
				},
			},
		},
		[24] = {
			[{ "mission" }] = {
				text = "I have one more thing you can help me with. I heard that people who visit the southern archipelago disappear under mysterious circumstances. Investigate this matter.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 25,
					[Storage.PerIustitiaAdAstra.Mission05] = 10,
					[Storage.PerIustitiaAdAstra.Mission06] = 1,
					[Storage.PerIustitiaAdAstra.RukcaAccess] = 1,
				},
			},
		},
		[25] = {
			[{ "mission" }] = {
				text = "As I said, beachgoers have been disappearing in the southern archipelago. Try looking there.",
			},
		},
		[26] = {
			[{ "mission" }] = {
				text = "Thank you for your help. I think I have a suitable reward for you. Perhaps you'll be interested in an ancient artifact I lost somewhere in the northern dump. You can keep it if you find it.",
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 27,
					[Storage.PerIustitiaAdAstra.Mission06] = 3,
				},
			},
		},
	},
	[LOCALIZER_UNIVERSAL] = {
		[{ "hitler", "auschwitz", "holocaust" }] = {
			text = "I know nothing about it.",
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
