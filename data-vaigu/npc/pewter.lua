local name = "Pewter"
local outfit = {
	lookType = 146,
	lookHead = 95,
	lookBody = 97,
	lookLegs = 95,
	lookFeet = 116,
	lookAddons = 1,
}
local customDialogs = {
	[{ "bug milk" }] = {
		text = "My friend from this village can provide you wih it.",
	},
	[{ "coconut milk" }] = {
		text = "You have to squeeze a coconut to extract its milk.",
	},
	[{ "mead" }] = {
		text = "Namir will sell you an empty mead horn. For the actual mead, i heard that ogres like the taste of it and they store it in barrels.",
	},
	[{ "hydra tongue" }] = {
		text = "You can sometimes find it in hydra nests. One location i know are the waterfalls in the jungle where lot of crocodiles reside.",
	},
	[{ "kulka ryzowa", "rice ball" }] = {
		text = "My friend Namir can prepare those for you.",
	},
	[{ "ksiazka kucharska", "cookbook" }] = {
		text = "Every professional chef writes their own book with their best recipes.",
	},
	[WALKAWAY] = { text = "Hope you will come again, |PLAYERNAME|" },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
