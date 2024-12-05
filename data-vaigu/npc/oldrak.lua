local outfit = {
	lookType = 57,
	lookHead = 115,
	lookBody = 113,
	lookLegs = 31,
	lookFeet = 38,
	lookAddons = 3,
}
local shop = { { itemName = "the holy tible", clientId = 2836, buy = 1000 } }

local context = {
	name = "oldrak",
	shop = shop,
}
NpcRegistry:AppendNpcData(context)
