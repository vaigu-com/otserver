local internalNpcName = "Gandalf"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 325,
	lookHead = 0,
	lookBody = 19,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
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
	[Storage.SciezkaNieumarlych.Questline] = {
		[-1] = {
			[{ GREET }] = { text = "Hello. What brings you here?" },
			[{ "oprocz tego ludzie", "aside from that people" }] = {
				text = "It was many years ago. One day, in Mirkotown, the Undead King of the Crypt appeared, causing havoc among our residents. The city slowly turned into a ruin until 9:37 PM when one of the houses was blown up using dark magic. In that same house, there was a laundry basket, and inside it, a holy relic - socks with John Paul, which flew and landed in the hands of the Crypt King. At that moment, he howled with a demonic voice, 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜ' and immediately became paralyzed. Without waiting, all defenders seized the opportunity and gathered to seal his soul. On the same day, we locked his soul in the banshee cave. The remains of his body were scattered across the desert to prevent any attempts at reanimation. I thought his spirit would be neutralized in the cave, but as I recently found out, he managed to escape from there. I don'\t know how strong he is right now, but he will surely try to regenerate. We must ultimately destroy him! It won't be an easy task, and before I entrust it to you, you will need to prove to me that you are worthy of leading this crusade. Return to me when you fulfill all my {conditions}.",
				nextState = {
					[Storage.SciezkaNieumarlych.Questline] = 1,
					[Storage.SciezkaNieumarlych.Mission01] = 1,
				},
				requiredState = {
					[Storage.CzeslawKrasnolud.Questline] = 8,
					[Storage.SpoczywajacyTutaj.Mission01] = 2,
					[Storage.AssassinsCreedSkurwoala.Questline] = 16,
					[Storage.SultanPrime.Questline] = 13,
				},
				textNoRequiredState = "It's interesting that you know our password. Nevertheless, I have no task for you or anything to interest you with.",
			},
			[{ "king", "crypt king", "king of the crypt", "krol krypty", "krol" }] = {
				text = "If you really know what danger he is, deal with his ally first - the Sultan of Phantasms. Also deal with that swindler, Chester, who tried to fuck me over in Down's Labyrinth.",
			},
		},
		[1] = {
			[{ GREET }] = {
				text = "Welcome again. Are you ready to accept my {conditions}?",
			},
			[{ "conditions", "warunki" }] = {
				text = "Allakhazam!!!1. Oh, wait, that's not all. I forgot that you also need to visit the magic circles. Each circle consists of 6 stones in 3 different colors, with a special grid in the middle. Stand on all five grids, and I will be able to bless you. I won't tell you where the circles are because you can ask the owners of magic shops in towns about it. Talk to them, and they will guide you to the circles. Just write 'circle' to them, and they will explain everything to you.",
				nextState = {
					[Storage.SciezkaNieumarlych.Questline] = 2,
					[Storage.SciezkaNieumarlych.Mission01] = 2,
					[Storage.SciezkaNieumarlych.Mission02] = 1,
					[Storage.SciezkaNieumarlych.Circles] = 0,
				},
				requiredState = {
					[Storage.PitsOfInferno.OneThrone] = 1,
					[Storage.Finished.YalahariQuest] = 1,
					[Storage.SciezkaDruida.KragDruidow] = 7,
				},
				textNoRequiredState = "My conditions are to complete the following tasks: Druid Path, Yalahar Quest. While you know the secret password, I also want other druids and elves to vouch for you. Additionally, you must visit at least one poi throne. If you are ready, ask me again about {conditions}.",
			},
		},
		[2] = {
			[{ "mission" }] = {
				text = "Hokus Pokus! Teraz juz wszystko powinno grac. W podziemiach piramidy czai sie cos bardzo mrocznego. Zapytaj Konmulda o porade, a byc moze ujdziesz stamtad z zyciem. Bym zapomnial: od teraz mozesz uzywac zapieczetowanych drzwi w piramidzie.",
				nextState = {
					[Storage.SciezkaNieumarlych.Questline] = 3,
					[Storage.SciezkaNieumarlych.Mission02] = 2,
					[Storage.SciezkaNieumarlych.Mission03] = 1,
				},
				requiredState = { [Storage.SciezkaNieumarlych.Circles] = 31 },
				textNoRequiredState = "Ask the individual owners of magic shops about the locations of the circles.",
			},
		},
		[4] = {
			[{ "mission" }] = {
				text = "Here is your reward for your effort. Wait, wait... where is my backpack!? It was probably Chester doing. Well, I guess your bonus reward is gone.",
				nextState = {
					[Storage.SciezkaNieumarlych.Questline] = 5,
					[Storage.SciezkaNieumarlych.Mission03] = 3,
					[Storage.Finished.SciezkaNieumarlych] = 1,
					[Storage.CzeslawKrasnolud.Mission04] = 1,
					[Storage.CzeslawKrasnolud.Questline] = 9,
				},
				expReward = 25000000,
			},
		},
	},
	[Storage.CzeslawKrasnolud.Questline] = {
		[10] = {
			[{ "mission" }] = {
				text = "In this bag i kept an item from the WotE quest. I completed it on the *REDACTED* server. Do you remember was item it was?",
			},
			[{ "Elite Draken Helmet" }] = {
				requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
				text = "Right, it was the Elite Draken Helmet. Here's your reward.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 11,
					[Storage.CzeslawKrasnolud.Mission04] = 3,
					[Storage.Finished.Czeslaw] = 1,
				},
				rewards = { { id = 11689 } },
				textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
			},
			[{ "Royal Draken Mail" }] = {
				requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
				text = "Right, it was the Royal Draken Mail. Here's your reward.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 11,
					[Storage.Finished.Czeslaw] = 1,
				},
				rewards = { { id = 11686 } },
				textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
			},
			[{ "Royal Scale Robe" }] = {
				requiredItems = { CZESLAW_KRANSOLUD_KEY_ITEMS.gandalfBag },
				text = "Right, it was the Royal Scale Robe. Here's your reward.",
				nextState = {
					[Storage.CzeslawKrasnolud.Questline] = 11,
					[Storage.Finished.Czeslaw] = 1,
				},
				rewards = { { id = 11687 } },
				textNoRequiredItems = "Lost the bag? Come back when you retrieve it.",
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
