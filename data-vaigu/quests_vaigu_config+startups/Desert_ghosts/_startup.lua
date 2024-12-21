BANJO_KROLA_SZCZUROW:Script(function(missionState)
local npc = { { name = "Ghost of Anthony the Engineer", pos = { 3, -3, 1 } } }

local desertQuestInit = GlobalEvent("CaveExplorerOnShieldInit")
function desertQuestInit.onStartup()
	LoadStartupItems(items, DESERT_QUEST_ONE_ANCHOR)
end
desertQuestInit:register()
end)
