local npc = { { name = "Ghost o Anthony the Engineer", pos = { 3, -3, 1 } } }

local items = {
	["firebugCorpse"] = {
		id = 4241,
		aid = Storage.DesertQuestGhosts.Rewards.Firebug,
		uid = 1000,
		pos = { 82, 53, -2 },
		rewards = { DESERT_QUEST_GHOSTS_KEY_ITEMS.firebug },
	},
	["germiFireplace"] = {
		id = 2001,
		aid = Storage.DesertQuestGhosts.Misc.FirebugFireplace,
		pos = { 77, 53, -2 },
	},
	["iglooFrostPlace"] = {
		id = 1997,
		aid = Storage.DesertQuestGhosts.Misc.FirebugFireplace,
		pos = { -25, 66, 3 },
	},
	["punchcardDoor"] = { id = 8342, aid = Storage.DesertQuestGhosts.Misc.Punchcard, pos = { 86, 61, -2 } },
	["punchardStepInCloseDoor"] = {
		id = 355,
		aid = Storage.DesertQuestGhosts.Misc.Punchcard,
		pos = { 87, 61, -2 },
	},
	["germiDocumentChest"] = {
		id = 2484,
		aid = Storage.DesertQuestGhosts.Rewards.GermiChest,
		uid = 1000,
		pos = { 63, 35, 0 },
		nextState = { [Storage.DesertQuestGhosts.Questline] = 2, [Storage.DesertQuestGhosts.Mission01] = 2 },
		rewards = { DESERT_QUEST_GHOSTS_KEY_ITEMS.germiDocument },
	},
	{ pos = { 5, -8, 1 }, id = 231, aid = Storage.DesertQuestGhosts.Misc.AnthonyGate },
	{ pos = { 6, -8, 1 }, id = 231, aid = Storage.DesertQuestGhosts.Misc.AnthonyGate },
	{ pos = { 7, -8, 1 }, id = 231, aid = Storage.DesertQuestGhosts.Misc.AnthonyGate },
}

local desertQuestInit = GlobalEvent("desertQuestGhostsInit")
function desertQuestInit.onStartup()
	LoadStartupNpc(npc, DESERT_QUEST_ONE_ANCHOR)
	LoadStartupItems(items, DESERT_QUEST_ONE_ANCHOR)
end
desertQuestInit:register()
