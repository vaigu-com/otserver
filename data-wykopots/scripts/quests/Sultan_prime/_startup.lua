DESERT_QUEST_ONE_QUESTDOOR_ID_CLOSED = 8261

local startupItemsMagicians = {
	{ pos = { -7, -3, 0 }, id = 1936, aid = Storage.SultanPrime.MagicianFountain },
	{ pos = { -6, -3, 0 }, id = 1937, aid = Storage.SultanPrime.MagicianFountain },
	{ pos = { -7, -2, 0 }, id = 1938, aid = Storage.SultanPrime.MagicianFountain },
	{ pos = { -6, -2, 0 }, id = 1939, aid = Storage.SultanPrime.MagicianFountain },
}
local startupItemsCamels = {
	{ pos = { 10, -3, 0 }, id = 8520, aid = Storage.SultanPrime.FarmerChair, uid = 1000 },
}
local startupItemsRetro = {
	{ pos = { 34, 1, 2 }, id = 2772, aid = Storage.SultanPrime.RetroLever },

	{ pos = { -31, -72, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
	{ pos = { -4, -73, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
	{ pos = { -71, -63, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
	{ pos = { -64, -72, 0 }, id = 2477, aid = Storage.SultanPrime.Coffin },
	{ pos = { -14, -80, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -23, -74, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -27, -85, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -28, -74, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -47, -85, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -52, -78, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },
	{ pos = { -68, -76, 0 }, id = 1984, aid = Storage.SultanPrime.Coffin },

	{ pos = { -7, -10, 1 }, id = 10548, aid = Storage.SultanPrime.Jaw },

	{ pos = { -31, 43, 0 }, id = 6260, aid = Storage.SultanPrime.DoorAfterRyba },

	{ pos = { -35, 31, 0 }, id = 23483, aid = Storage.DesertQuestHub.ToSultanPrime },
	{ pos = { -48, -68, -2 }, id = 1949, aid = Storage.DesertQuestHub.ToSultanPrime },
}

local npcsRetroMirko = { { name = "The sultan of Phantasms", pos = { 20, -8, 2 } } }
local npcsCamels = { { name = "Dampreefer", pos = { 0, 0, 0 } } }
local monstersDesert = { { name = "Cezary Baryka", pos = { -106, 122, 2 } } }
local monstersRetro = { { name = "Aspirant Ryba", pos = { -32, 48, 0 } } }

local desertQuestInit = GlobalEvent("sultanPrimeInit")
function desertQuestInit.onStartup()
	LoadStartupItems(startupItemsMagicians, MIRKO_MAGICIANS_ANCHOR)
	LoadStartupItems(startupItemsCamels, CAMEL_FARM_ANCHOR)
	LoadStartupItems(startupItemsRetro, RETRO_MIRKO_ANCHOR)

	LoadStartupNpc(npcsRetroMirko, RETRO_MIRKO_ANCHOR)
	LoadStartupNpc(npcsCamels, CAMEL_FARM_ANCHOR)

	LoadStartupMonsters(monstersDesert, DESERT_QUEST_ONE_ANCHOR)
	LoadStartupMonsters(monstersRetro, RETRO_MIRKO_ANCHOR)
end
desertQuestInit:register()
