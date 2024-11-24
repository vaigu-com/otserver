BANJO_KROLA_SZCZUROW:Script(function(missionState)
	local npcs = {
		{ name = "mareesha", pos = { 6498, 1257, 7 } },
		{ name = "ryan", pos = { 5566, 1575, 8 } },
		{ name = "Lambor", pos = { 6499, 1148, 6 } },
		{ name = "aunor", pos = { 5726, 794, 4 } },
	}

	local desertQuestInit = GlobalEvent("assassinsCreedInit")
	function desertQuestInit.onStartup()
		LoadStartupItems(rewardChests)

		LoadStartupNpcs(npcs)
	end
	desertQuestInit:register()
end)
