local talkaction = TalkAction("!bosses", "!bosy")

function talkaction.onSay(player, words, param)
	local bossNames = {
		[1] = "Maxxenius",
		[2] = "Alptramun",
		[3] = "Izcandar the Banished",
		[4] = "Plagueroot",
		[5] = "Malofur Mangrinder",
	}

	local dreamboss = bossNames[Game.getStorageValue(GlobalStorage.DreamBoss)] or "Unknown"

	local deeplingNames = {
		[1] = "Tanjis",
		[2] = "Jaul",
		[3] = "Obujos",
	}

	local deeplingboss = deeplingNames[Game.getStorageValue(GlobalStorage.DeeplingBoss)] or "Unknown"

	local werebossNames = {
		[1] = "Black Vixen",
		[2] = "Sharpclaw",
		[3] = "Darkfang",
		[4] = "Bloodback",
		[5] = "Shadowpelt",
	}

	local wereboss = werebossNames[Game.getStorageValue(GlobalStorage.WereBoss)] or "Unknown"

	player:popupFYI("Daily bosses available:\n" .. "\nDeepling: " .. deeplingboss .. "\nWerecreature: " .. wereboss .. "\nDream Court: " .. dreamboss)
	return false
end

talkaction:separator(" ")
talkaction:groupType("normal")
talkaction:register()
