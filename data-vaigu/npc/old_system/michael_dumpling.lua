local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "...iii nie ma Piroga w Tap Madl.. Gratuluje, zabieraja mnie na bagiety...",
	},
	{
		text = "Szybciej sie przebieraj w te outfity bo zaraz na Fashion Week spadam gosciu...",
	},
	{
		text = "Naturalna skora? Dumny ty jestes z siebie, masz ty rozum i godnosc czlowieka? Przez Ciebie gina zwierzatka... ",
	},
	{ text = "Ladnie dzis wygladasz w tych addonach, no homo heheh... oh wait" },
}

local outfit = {
	lookType = 154,
	lookHead = 114,
	lookBody = 91,
	lookLegs = 91,
	lookFeet = 114,
	lookAddons = 0,
}

local customDialogs = {
	[{ GREET }] = {
		text = "Hello. I can help you with acquiring {addons} for your outfits. Are you interested?",
	},
	[{ "yes", "tak", "addon", "addons", "dodatek", "dodatki", "dodatkow" }] = {
		text = NO_TEXT,
		specialActionsOnSuccess = {
			{
				action = function(context)
					UnlockableOutfitAddonRegistry:SendAllOutfitsWindow(context.player, context)
				end,
			},
		},
	},
}

local context = {
	name = "Michael Dumpling",
	outfit = outfit,
	customDialogs = customDialogs,
}

NpcRegistry:AppendNpcData(context)
