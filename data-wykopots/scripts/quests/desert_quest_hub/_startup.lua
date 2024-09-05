local teleportId = 775

local teleportToQuests = {
	{ pos = { -2, 0, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToDesertQuestOne },
	{ pos = { 2, 0, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToDesertQuestTwo },
	{ pos = { 0, -2, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToSultanPrime },
	-- {position = {x = 0, y= 2, z= 0}, id = teleportId, aid = Storage.DesertQuestHub}, -- unused
}
local teleportFromDesertQuestOne = { { pos = { 66, 64, -2 }, id = teleportId, aid = Storage.DesertQuestHub.ToHub } }

local teleportFromDesertQuestTwo = {
	{ pos = { 5, 20, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToHub },
}
local teleportFromSultanPrime = { { pos = { 8, 4, 2 }, id = teleportId, actionid = Storage.DesertQuestHub.ToHub } }
local desertQuestInit = GlobalEvent("desertQuestHubInit")
function desertQuestInit.onStartup()
	LoadStartupItems(teleportToQuests, DESERT_QUEST_HUB_ANCHOR)
	LoadStartupItems(teleportFromDesertQuestOne, DESERT_QUEST_ONE_ANCHOR)
	LoadStartupItems(teleportFromDesertQuestTwo, DESERT_QUEST_TWO_ANCHOR)
	LoadStartupItems(teleportFromSultanPrime, RETRO_MIRKO_ANCHOR)
end

desertQuestInit:register()
