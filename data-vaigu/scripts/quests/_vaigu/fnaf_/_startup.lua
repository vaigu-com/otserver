BANJO_KROLA_SZCZUROW:Script(function(storageToRequiredState)
local startupJanuszex = {
	{ pos = { -1, 0, 0 }, id = 431, aid = Storage.Fnaf.LeftDoor },
	{ pos = { 1, 0, 0 }, id = 431, aid = Storage.Fnaf.RightDoor },
	{ pos = { -1, -1, 0 }, id = 2934, aid = Storage.Fnaf.LeftLight },
	{ pos = { 1, -1, 0 }, id = 2934, aid = Storage.Fnaf.RightLight },

	{ pos = { 0, -1, 0 }, id = 3464, aid = Storage.Fnaf.ControlPanel },
	{ pos = { 0, -1, 0 }, id = 3588, aid = Storage.Fnaf.ControlPanel },
}

local desertQuestInit = GlobalEvent("fnafInit")
function desertQuestInit.onStartup()
	-- LoadStartupItems(startupJanuszex, FNAF_ANCHOR)
end
desertQuestInit:register()
end)
