local name = "Richard Petrol"
local outfit = {
	lookType = 472,
	lookHead = 0,
	lookBody = 29,
	lookLegs = 95,
	lookFeet = 79,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "U mnie twoje pieniadze sa bezpieczne." },
	{
		text = "Darmowe wplaty i wyplaty, a za prowadzenie konta nic nie pobieramy.",
	},
	{
		text = "Bo na swiecie jest o ile nie pamietam 130 pare krajow... a do kazdego przelewy za darmo !",
	},
	{ text = "Przypominam ze po swietach jest szesciu kroli... Tak? " },
	{
		text = "Sa takie momenty kiedy imperia padaja. Imperia  padaja zwykle w szczycie swojej chwaly, na przyklad Reborn. ",
	},
	{ text = "Balans Twojego konta? Mam to w komorce..." },
	{ text = "Darmowe przelewy blyskawiczne." },
}
local context = {
	name = name,
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
