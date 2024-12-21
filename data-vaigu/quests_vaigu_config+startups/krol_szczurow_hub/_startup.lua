BANJO_KROLA_SZCZUROW:Script(function(missionState)
	local startupLeversToHub = {
	}
	local startupPortalsToOut = {
}


	local npcs = { { name = "gm romek", pos = { 0, 0, 0 } } }

	local desertQuestInit = GlobalEvent("krolSzczurowHubInit")
	function desertQuestInit.onStartup()
	end
	desertQuestInit:register()
end)
