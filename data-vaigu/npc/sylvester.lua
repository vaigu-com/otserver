local name = "Sylvester"
local outfit = {
	lookType = 1251,
	lookHead = 92,
	lookBody = 50,
	lookLegs = 83,
	lookFeet = 73,
	lookAddons = 3,
}
local shop = { { itemName = "fireworks rocket", 6576, buy = 3 } }

local context = {
	name = name,
	shop = shop,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
	spawnedByScript = true,
}
NpcRegistry:AppendNpcData(context)
