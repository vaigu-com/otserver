local internalNpcName = "Mareesha"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 150,
	lookHead = 0,
	lookBody = 48,
	lookLegs = 49,
	lookFeet = 3,
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

local dialog = {
	[Storage.PerIustitiaAdAstra.Localizer] = {
		[Storage.PerIustitiaAdAstra.HelpedRubelstein] = {
			[2] = {
				[{ "czek", "token", "bon", "nagroda", "reward" }] = {
					text = "I can pay you any amount admitted in a token, effectively charging the party that signed it.",
				},
				[{ ANY_MESSAGE }] = {
					text = "Here, take your money.",
					nextState = { [Storage.PerIustitiaAdAstra.HelpedRubelstein] = 3 },
					rewards = { { id = 3043, count = 10 } },
					specialConditions = {
						{
							condition = PER_IUSTITIA_AD_ASTRA_SPECIAL_CONDITIONS.saidRubelsteinsChecksum,
							requiredOutcome = true,
						},
					},
				},
			},
		},
	},
	[Storage.AssassinsCreedSquurvaali.Localizer] = {
		[Storage.AssassinsCreedSquurvaali.Mission02] = {
			[1] = {
				[{ "mission" }] = {
					text = "Magic carpets? What nonsense. If you want, I can {sew} the green carpet you're talking about, but don't expect any magical abilities.",
				},
				[{ "tailor", "uszyc", "sew" }] = {
					text = "I will need the following: 5 spider silk, 1 red pillow, 1 {artist palette}.",
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = 2,
					},
				},
			},
			[2] = {
				[{ "artist palette", "mission" }] = {
					text = "GM Tomek stole the last palette from me. Now he's in Knurow.",
				},
			},
			[3] = {
				[{ "artist palette", "mission" }] = {
					text = "GM Tomek stole the last palette from me. Now he's in Knurow.",
				},
			},
			[4] = {
				[{ "mission", "tailor", "uszyc", "sew" }] = {
					text = "Here is your carpet.",
					textNoRequiredItems = "Return when you have all the items.",
					requiredItems = {
						{ id = 2395, count = 1 },
						{ id = 5879, count = 5 },
						ASSASSINS_CREED_SKURWOALA_KEY_ITEMS.palette,
					},
					nextState = {
						[Storage.AssassinsCreedSquurvaali.Mission02] = 5,
						[Storage.AssassinsCreedSquurvaali.Mission03] = 1,
					},
					specialActionsOnSuccess = {
						{
							action = ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS.addCarpetMount,
						},
					},
				},
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
