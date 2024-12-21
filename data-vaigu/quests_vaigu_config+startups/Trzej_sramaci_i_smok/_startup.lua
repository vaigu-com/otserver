BANJO_KROLA_SZCZUROW:Script(function(missionState)
	local startupItemsStatic = {

	}

	local npcs = {
		{ name = "goldblum", pos = { 5954, 1417, 11 } },
		{ name = "boboeater", pos = { 6211, 918, 9 } },
		{ name = "polychek", pos = { 6620, 1085, 5 } },
	}

	local bhpInit = GlobalEvent("trzejSramaciISmokInit")
	function bhpInit.onStartup()
		LoadStartupItems(startupItemsStatic)
	end
	bhpInit:register()
end)
