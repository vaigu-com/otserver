local internalNpcName = "Xe'na"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 1043,
	lookHead = 115,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 115,
	lookAddons = 0,
	lookMount = 438,
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
		[2] = {
			[{ "cuckurse", "cucklatwa" }] = {
				text = "Hmm... no. I won't remove the curse from him. Tell him that he would first have to stop being such a misogynist and a white capitalist.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 3,
					[Storage.BezpieczenstwoIHigienaPracy.Mission01] = 3,
				},
			},
		},
		[9] = {
			[{ "mission", "cucklatwa", "cuckurse", "curse", "klatwa" }] = {
				text = "Your offer sounds reasonable. After all, I won't have to watch those cursed ads anymore. I hope you have an offering in the form of cake for the mighty Miroslawa. If not, better have it with you. Nevertheless, I'm ready for the {exchange}.",
			},
			[{ "exchange", "wymiane" }] = {
				text = "Actually, such a curse doesn't exist. But don't tell him that, or he'll get upset. But to avoid being a total fraud, I'll give you this scroll of feminazi knowledge instead.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 10,
					[Storage.BezpieczenstwoIHigienaPracy.Mission04] = 3,
					[Storage.BezpieczenstwoIHigienaPracy.Mission05] = 1,
				},
				rewards = {
					BEZPIECZENSTWO_I_HIEGIENA_PRACY_KEY_ITEMS.grazynaDocument,
				},
				specialActionsOnSuccess = {
					{
						action = BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS.feministCake,
					},
				},
			},
		},
	},
	[Storage.TragedyaWCzterechAktach.Questline] = {
		[15] = {
			[{ "mission", "grazhenacore", "grazynacore", "grazyna", "grazhena" }] = {
				requiredItems = {
					TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.grazynaCore,
				},
				textNoRequiredItems = "Come back when you have Grazhenacore with you.",
				text = "The existence of cancercontent is necessary if we want to maintain the balance of the universe. The cringe factory of rural housewives' kept our world at rest until recently when Grazhena Core was stolen. I will now take Grazhenacore from you. Try to find Grazhena in the prison. Self-proclaimed heroes from the eastern part of the city have locked her in the depths of their dungeons. Now she is forced to live among nightmare creatures.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 16,
					[Storage.TragedyaWCzterechAktach.Mission06] = 2,
					[Storage.TragedyaWCzterechAktach.GrazhenaDoor] = 1,
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
