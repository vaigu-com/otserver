local internalNpcName = "xXxTurdstinxXx"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 3000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 619,
	lookHead = 78,
	lookBody = 0,
	lookLegs = 94,
	lookFeet = 94,
	addons = 0,
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
	[LOCALIZER_UNIVERSAL] = {
		[{ WALKAWAY }] = { text = "Peace God." },
		[{ FAREWELL }] = { text = "Seeee yaaa." },
		[{ GREET }] = { text = "Waddup, G?" },
	},
	[Storage.BezpieczenstwoIHigienaPracy.Questline] = {
		[1] = {
			[{ "mission" }] = {
				text = "Maybe I have some information about this Rat, but it certainly won't be free. I am the most important person in the world because I belong to the MGTOW order, and of all people, I loathe women the most, as they ruin this world. Go to their village and convince them to acknowledge our superiority and remove their cuckurse.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 2,
					[Storage.BezpieczenstwoIHigienaPracy.Mission01] = 2,
				},
			},
		},
		[2] = {
			[{ "mission" }] = {
				text = "Amazonki maja swoja siedzibe gdzies na skalkach na polnoc od mirko.",
			},
		},
		[3] = {
			[{ "mission", "cuckurse", "cucklatwa" }] = {
				text = "Oh god, what a foolish woman. Objectively and impartially, I conclude that I belong to the most repressed social group. Be that as it may, let's leave it for now. You mentioned the Rat of Kings earlier. The only way to find him is to listen carefully to the chorus of januses. They rarely say anything sensible, so you'll have to decide for yourself what is nonsense and what will lead you to the Rat.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 4,
					[Storage.BezpieczenstwoIHigienaPracy.Mission01] = 4,
					[Storage.BezpieczenstwoIHigienaPracy.Mission02] = 1,
				},
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "I am currently collecting cans that may still contain a certain amount of volts. Bring me about 100 small used vials, and I will reward you.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 5,
					[Storage.BezpieczenstwoIHigienaPracy.Mission02] = 2,
				},
			},
		},
		[5] = {
			[{ "mission" }] = {
				text = "Here is your reward. Come back in some time, preferably in the evening.",
				requiredItems = { { id = 285, count = 100 } },
				textNoRequiredItems = "Come back when you have collected 100 small vials.",
				expReward = 30000,
				rewards = { ExerciseWeaponBox(500) },
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 6,
					[Storage.BezpieczenstwoIHigienaPracy.Mission02] = 3,
					[Storage.BezpieczenstwoIHigienaPracy.Mission03] = 1,
				},
			},
		},
		[6] = {
			[{ "mission" }] = {
				text = "That damn emperor took away my rights to the land where I collected cans. I won't let him get away with it, and I certainly won't let the new masters feel safe here. Come here at night because that's when the bums sleep. We'll ambush the invaders then, and maybe we won't wake up all the bums. Ask me about {attack} if you're ready.",
			},
			[{ "attack", "atak" }] = {
				text = "Oh wow, they are swarming!",
				specialActionsOnSuccess = {
					{
						action = BEZPIECZENSTWO_I_HIEGIENA_PRACY_SPECIAL_ACTIONS.turdstinAttack,
					},
				},
			},
		},
		[7] = {
			[{ "mission" }] = {
				text = "I didn't expect this. The group of local bums from this beach, under the leadership of their chief, got upset, so someone else will now take their cans on a massive scale. Anyway, thanks for your help. Choose your reward: {axe}, {sword}, {mace}, {bow}, {rod}, {wand} (exercise weapon).",
			},
			[{ "axe", "sword", "mace", "bow", "rod", "wand" }] = {
				text = "Here is your reward. Come back in some time, and maybe I'll find a task for you.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 8,
					[Storage.BezpieczenstwoIHigienaPracy.Mission03] = 3,
					[Storage.BezpieczenstwoIHigienaPracy.Mission04] = 1,
				},
				rewards = { ExerciseWeaponBox(400) },
			},
		},
		[8] = {
			[{ "mission" }] = {
				text = "A while ago, I found a premium account on 4chan - all thanks to my metal detector. Someone must have thrown it away. And rightly so, because it doesn't work. But the Amazons probably don't know that. Try to bribe them with this account to get rid of my cuckurse.",
				nextState = {
					[Storage.BezpieczenstwoIHigienaPracy.Questline] = 9,
					[Storage.BezpieczenstwoIHigienaPracy.Mission04] = 2,
				},
			},
		},
	},
	[Storage.TragedyaWCzterechAktach.Questline] = {
		[2] = {
			[{ "mission" }] = {
				text = "Good day person |PLAYERNAME|. We are here to {discuss} compensation claims related to the 'accident' in which Mr. HF-P/X was injured.",
			},
			[{ "omowic", "discuss" }] = {
				text = "According to our information, you {was} the main cause of the accident that resulted in Mr. HF-P/X's injuries.",
			},
			[{ "byl", "was" }] = {
				text = "In that case, please send the documents, and our team of specialists shh butt butt butt kshhhh. Oh, damn, my throat recorder broke. Umm... okay, I was lying about the insurance. But understand me - ever since the emperor took my lands, I have to fight for them, which has made me even more homeless.",
				nextState = {
					[Storage.TragedyaWCzterechAktach.Questline] = 3,
					[Storage.TragedyaWCzterechAktach.Mission01] = 3,
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
