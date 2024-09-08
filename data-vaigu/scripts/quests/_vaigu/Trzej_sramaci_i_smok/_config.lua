TRZEJ_SRAMACI_I_SMOK_SPECIAL_CONDITIONS = {
	playerIsDrunk = function(context)
		local player = context.player
		if not player then
			return false
		end
		return player:hasCondition(CONDITION_DRUNK)
	end,
}

TRZEJ_SRAMACI_I_SMOK_KEY_ITEMS = {
	["RUM"] = {
		aid = Storage.TrzejSramaciISmok.Rewards.Rum,
		id = 2875,
		desc = "Pirate rum. Bilbeus might be interested in this one",
	},
	["RUNE1"] = { aid = Storage.TrzejSramaciISmok.Rewards.Rune1, id = 3181, desc = "Unsealing rune" },
	["RUNE2"] = { aid = Storage.TrzejSramaciISmok.Rewards.Rune2, id = 3183, desc = "Unsealing rune" },
	["RUNE3"] = { aid = Storage.TrzejSramaciISmok.Rewards.Rune3, id = 3184, desc = "Unsealing rune" },
	["DEEP_CRYSTAL"] = { aid = Storage.TrzejSramaciISmok.Rewards.DeepCrystal, id = 7281, desc = "Deep sea crystal" },
}
