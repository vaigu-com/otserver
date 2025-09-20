local name = "Walter"
local outfit = {
	lookType = 132,
	lookHead = 57,
	lookBody = 97,
	lookLegs = 39,
	lookFeet = 57,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Antyki, meble z Ikei, wszystko czego zapragniesz ! Nasz klient nasz pan !",
	},
	{
		text = "Witam, witam, prosze zerknac na asortyment mebli jaki posiadam, zaiste wyborny!",
	},
}
local context = {
	name = name,
	greetJob = JOB_FURNITURE,
	jobs = { JOB_FURNITURE },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
