local name = "Nadia France"
local outfit = {
	lookType = 279,
	lookHead = 108,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 2,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Dawniej blogi i strony o rozwoju personalnym byly wartosciowe." },
	{ text = "Sytuacja we Francji jest stabilna" },
	{ text = "Parcele i listy wymyslili Francuzi" },
	{ text = "Francja to silny i stabilny kraj," },
	{ text = "Informacja nieprawdziwa, nie badz zlosliwy..." },
	{ text = "Szanuje twoje prawo do posiadania opini" },
}
local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_WILDCARD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
