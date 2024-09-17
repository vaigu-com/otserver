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
	rum = {
		aid = Storage.TrzejSramaciISmok.Rewards.Rum,
		id = 2875,
		desc = "Pirate rum. Bilbeus might be interested in this one",
	},
	rune1 = { aid = Storage.TrzejSramaciISmok.Rewards.Rune1, id = 3181, desc = "Unsealing rune" },
	rune2 = { aid = Storage.TrzejSramaciISmok.Rewards.Rune2, id = 3183, desc = "Unsealing rune" },
	rune3 = { aid = Storage.TrzejSramaciISmok.Rewards.Rune3, id = 3184, desc = "Unsealing rune" },
	deepCrystal = { aid = Storage.TrzejSramaciISmok.Rewards.DeepCrystal, id = 7281, desc = "Deep sea crystal" },
}
