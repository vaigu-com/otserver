return {
	["Kraken"] = "The fight starts with the leader looking through the telescope to see that kraken is attacking your ship!\nKraken tentacles want to destroy hull and board. Block their attacks with your body to delay your demise.\nWhile on ship, you can attack some of the tentacles. Damaging them will also damage the kraken itself later.\nAfter some time you wont be able to keep up with tentacles, and your ship will be turned to wreckage. The kraken will emerge from the depths to attack you. This will we your chance to strike.",
	["Zul Szczurow"] = "The Zul Szczurow itself is harmless. You should be careful when dealing with his henchman - Zul Zulow.\nZul Zulow has very low health pool, but when dying, it summons two copies of itself. Be careful, as their number can skyrocket very fast.\nThe reason why u might wanna consider killing Zul Zulow from time to time is their ramping fury. The longer the time before previous Zul Zulow death, the more damage they will deal.",
	["HF-P/X"] = "The main danger here is his army of passat wagons. He will randomly gates from which the wagons will emerge.\nBe careful not to stand in their way! They also damge HF-P/X itself, so consider baiting him into being hit by them",
	["King of the Crypt"] = "His main power is ever increasing damage when focusing on same target. You should make him change his victim constantly.\nEvery few seconds, he will summon a bomb that will deal massive damage to everyone in arena. However, if you hug te bomb, this damage will instead be split between all people who stand next to it.\nHe will also announce and fire dark energy beams. Be careful, as there will be more beams when he is below 50% health.\nHis last ability is summoning volatile undeads. They dont do anything special other than exploding in plus shape for big damage.",
	["Pol"] = "The white and black tiles are becoming increasingly deadly the longer u stand on them. Leaving colored tile will neutralize its damage after few seconds. So you should change tiles only when you cant withstand the damage.\nThis boss also has deadly plus shaped attack, so you should be always ready to move!",
	["Skurwiwij"] = "He is constantly draining elemental power from nearby pylon, or pylons in case both are in same distance.\nIf a new pylon becomes the nearest one, his power of previous pylon is reset, and that pylon explodes.\nYou have to move him between pylons when his elemental damage becomes unbearable. Be careful not to do it too often, as each pylon explosion is stronger.",
	["Ruk'ca Maw"] = "The start is very rough. Ruk'ca is very hungry and will try to consume anything. Move him to the cages, so he eats a baby seal and calms down... for a moment. Do it fast, as his fury is gonna ramp up constantly.\nWhile moving through his tunnels, you have to finally move him to the piles of salt at the end of cave. He is allergic to it.",
	["LIST_ENCOUNTERS"] = function(context)
		local finalString = ""
		finalString = finalString .. "Just ask me about specific encounter and i will give you tips to best of my ability. These are the bosses i know:"
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.GrubyMirekEncounters]) do
			if type(desc) == "string" then
				finalString = finalString .. "\n{" .. name .. "}"
			end
		end
		return finalString
	end,
	["ENCOUNTER_DESCRIPTION"] = function(context)
		local message = context.msg
		local playerLanguage = getPlayerLanguage(context.player)
		for name, desc in pairs(TRANSLATION_TABLES[playerLanguage][Storage.GrubyMirekEncounters]) do
			if type(desc) == "string" and name:lower() == message:lower() then
				return desc
			end
		end
		return "I dont have informations on this encounter."
	end,
}
