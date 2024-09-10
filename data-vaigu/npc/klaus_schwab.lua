local internalNpcName = "Klaus Schwab"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 278,
	lookHead = 40,
	lookBody = 95,
	lookLegs = 94,
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

local config = {
	[WALKAWAY] = "Lebewohl.",
	[FAREWELL] = "Auf wiedersehen.",
	[GREET] = "Strammstehen!",
	["INCOMPREHENSIBLE"] = "Ich verstehe kein einziges wort.",
	[Storage.PerIustitiaAdAstra.Questline] = {
		[13] = {
			[{ GREET }] = { text = "Identifiziere dich, Soldat!" },
			[{ "Friedrich Knopf", "friedrich knopf" }] = {
				text = "Lieutenant, warum ist deine Nase so klein? Dennoch. Haben wir einen Hinrichtungsbefehl auf Rubelstein bestatigt?",
				nextTopic = 1,
			},
			[{ "yes", "no", "tak", "nie", "mission" }] = {
				text = "Eine kleine Betruger... Wachen, zu den Waffen!",
				specialActionsOnSuccess = {
					{
						action = PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS.officerCaughtYou,
					},
				},
			},
			[{ "ja", "jawohl", "doch" }] = {
				text = "Wir werden ihn hinrichten lassen. Vielen Dank fur Ihre Zusammenarbeit. Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
				requiredTopic = { min = 1, max = 1 },
				expReward = 600 * 1000,
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 14,
					[Storage.PerIustitiaAdAstra.Mission04] = 6,
				},
			},
			[{ "nein", "kein", "nicht", "nee", "nich" }] = {
				text = "Alles in Ordnung, obwohl wir vor einigen Tagen einen Sicherheitsverstoss hatten und den Fluchtigen immer noch nicht finden konnen. Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
				requiredTopic = { min = 1, max = 1 },
				nextState = {
					[Storage.PerIustitiaAdAstra.Questline] = 14,
					[Storage.PerIustitiaAdAstra.Mission04] = 5,
					[Storage.PerIustitiaAdAstra.HelpedRubelstein] = 1,
				},
			},
		},
		[14] = {
			[{ GREET }] = {
				text = "Ausserdem habe ich eine {Mission} fur Sie, Leutnant.",
			},
			[{ "mission", "Mission" }] = {
				text = "Uberbringe diese Information an Hugo Boss in seiner Zentrale: 'Wir haben einen Bauplan fur eine experimentelle {Uberfabrik} entwickelt'.",
			},
			[{ "uberfabrik", "Uberfabrik" }] = {
				text = "Ich habe den Ort des Hugo Boss-Hauptquartiers an Ihr Schiff geschickt.",
				nextState = {
					[Storage.PerIustitiaAdAstra.ShipDestinations.HugoBeachPlanet] = 1,
					[Storage.PerIustitiaAdAstra.Questline] = 16,
					[Storage.PerIustitiaAdAstra.Mission04] = 7,
					[Storage.PerIustitiaAdAstra.Mission05] = 1,
				},
			},
		},
	},
	[LOCALIZER_UNIVERSAL] = {
		[{ "hitler", "auschwitz", "holocaust" }] = {
			text = "Ich weiss nichts daruber.",
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
