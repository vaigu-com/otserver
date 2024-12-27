local name = "Guseppe Four Cheeses"
local outfit = {
	lookType = 160,
	lookHead = 59,
	lookBody = 38,
	lookLegs = 59,
	lookFeet = 116,
	lookAddons = 0,
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
	npcGreetCallback = function() return false end,
}
NpcRegistry:AppendNpcData(context)
