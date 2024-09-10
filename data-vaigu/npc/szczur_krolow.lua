local internalNpcName = "Rat of Kings"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1346,
	lookHead = 0,
	lookBody = 59,
	lookLegs = 0,
	lookFeet = 94,
	lookAddons = 1,
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
	[Storage.BezpieczenstwoIHigienaPracy.Questline] = {
		[10] = {
			[{ GREET }] = {
				text = "Eeeuuu... eating... even... hydrofoils with sauce...",
			},
			[{ ANY_MESSAGE }] = {
				text = "Thanks, I feel better now. So, did Tomek send you? Ask me about {mission}, and I'll guide you as soon as I regain my strength.",
				requiredItems = { { id = 3579, count = 1 } },
				textNoRequiredItems = "Uhh....",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 11,
					[Storage.BezpieczenstwoIHigienaPracy.Mission05] = 2,
				},
			},
		},
		[11] = {
			[{ "mission", "misje" }] = {
				text = "I think I know why Tomek sent you here. He wants you to defeat the menacing wizard who threatens the lives of Mirkotown's residents. It's a noble and just cause. I'm talking, of course, about Petrus The Tyrant, who wields the Ytong of Power forged in the shadows of the darkest asshole. You'll find his hideout at the top of the magician's tower northeast of Mirkotown.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 12,
					[Storage.BezpieczenstwoIHigienaPracy.Mission05] = 3,
					[Storage.BezpieczenstwoIHigienaPracy.Mission06] = 1,
				},
			},
		},
		[12] = {
			[{ "mission", "petrus" }] = {
				text = "Petrus has his hideout at the top of the eastern tower on the magician's rock.",
			},
		},
		[14] = {
			[{ "mission" }] = {
				text = "So, this is the end of Petrus' reign. Let me now tell you about another threat that slumbers deep in the underground of Kongo. It's an ancient creature sent by aliens to enslave humanity by undermining the authority of the King of Rats. Its name is HF-P/X. You shouldn't go on this journey alone. Ask Tom if he knows anyone who would like to accompany you.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 15,
					[Storage.BezpieczenstwoIHigienaPracy.Mission06] = 4,
					[Storage.Finished.BHP] = 1,
				},
			},
		},
	},
	[Storage.TrzejSramaciISmok.Questline] = {
		[21] = {
			[{ "mission" }] = {
				text = "Don't wait for the sramatians. They're slacking on purpose to avoid having to fight {HF-P/X}. Besides, do you have all the {runes}?",
			},
			[{ "hfpx", "hf-p/x" }] = {
				text = "While you were traveling the world, I went to the library in Zbaszyn. I found information that HF-P/X terrorized an ancient temple where the treasury of Passats was located. For uncounted years, it's been hiding somewhere in the underground of that temple. I think he might want to use Passats in a fight. Perhaps he possesses necromantic abilities and can animate inanimate objects. Or maybe he'll use Passats as kamikaze projectiles? Don't wait for the sramats; they won't come.",
			},
			[{ "runy", "runes" }] = {
				text = "Yes, those are all the needed runes. You can now try to use the enchanted lever. Maybe we'll find HF-P/X here.",
				requiredItems = {
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS["RUNE1"],
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS["RUNE2"],
					TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS["RUNE3"],
				},
				textNoRequiredItems = "I see you don't have all the runes yet.",
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.endDialog,
					},
				},
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 22,
					[Storage.TrzejSramaciISmok.Mission08] = 3,
					[Storage.TrzejSramaciISmok.Mission09] = 1,
					[Storage.TrzejSramaciISmok.HfpxAccess] = 1,
				},
			},
		},
		[22] = {
			[{ "mission" }] = { text = "I'm gonna stay here and have your back." },
		},
		[23] = {
			[{ "mission" }] = {
				text = "WHAAAAAT??? How many Passats were lost there? I'm about to faint...",
				nextState = {
					[Storage.TrzejSramaciISmok.Questline] = 24,
					[Storage.TrzejSramaciISmok.Mission09] = 3,
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
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
