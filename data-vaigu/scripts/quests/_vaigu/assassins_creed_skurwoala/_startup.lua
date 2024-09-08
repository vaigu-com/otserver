local rewardChests = {
	{
		pos = { 6051, 1503, 9 },
		id = 2484,
		actionid = Storage.AssassinsCreedSkurwoala.Rewards.CartSilicon,
		rewards = { ASSASSINS_CREED_SKURWOALA_KEY_ITEMS["silicon"] },
		requiredState = { [Storage.AssassinsCreedSkurwoala.Questline] = 11 },
		nextState = { [Storage.AssassinsCreedSkurwoala.Questline] = 12, [Storage.AssassinsCreedSkurwoala.Mission04] = 3 },
	},
}
local startupItems = {
	{ pos = { 5685, 1408, 7 }, aid = Storage.AssassinsCreedSkurwoala.GhostChair, id = 2355 },

	{ pos = { 5810, 804, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenPath },
	{ pos = { 5811, 804, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenPath },
	{ pos = { 5810, 805, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenPath },
	{ pos = { 5810, 806, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenPath },
	{ pos = { 5811, 806, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenPath },

	{ pos = { 5688, 1413, 7 }, id = 15047, aid = Storage.AssassinsCreedSkurwoala.KeyItems.Flare },

	{ pos = { 5749, 805, 0 }, id = 470, aid = Storage.AssassinsCreedSkurwoala.HeavenLastTile },
}
local npcs = {
	{ name = "mareesha", pos = { 6498, 1257, 7 } },
	{ name = "ryan", pos = { 5566, 1575, 8 } },
	{ name = "jannah'ma", pos = { 6499, 1148, 6 } },
	{ name = "aunor", pos = { 5726, 794, 4 } },
}

local desertQuestInit = GlobalEvent("assassinsCreedInit")
function desertQuestInit.onStartup()
	LoadStartupItems(rewardChests)
	LoadStartupItems(startupItems)

	LoadStartupNpc(npcs)
end
desertQuestInit:register()
