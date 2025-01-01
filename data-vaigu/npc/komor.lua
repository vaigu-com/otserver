local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Antyki, meble z Ikei, wszystko czego zapragniesz ! Nasz klient nasz pan !",
	},
	{ text = "Pssst, nie chcesz moze zyrandolu z Palacu Prezydenckiego?" },
	{
		text = "Kiedy pytaja mnie co robie aktualnie odpowiadam: handluje meblami !",
	},
	{ text = "Nareszcie wzialem kredyt i zmienilem prace !" },
	{
		text = "Witam, witam, prosze zerknac na asortyment krzesel jaki posiadam, zaiste wyborny!",
	},
	{ text = "Paaaanie kochany, te meble to prosto z Belwederu !" },
}
local outfit = {
	lookType = 273,
	lookHead = 0,
	lookBody = 81,
	lookLegs = 93,
	lookFeet = 0,
	lookAddons = 3,
}
local context = {
	name = "Komor",
	greetJob = JOB_FURNITURE,
	jobs = { JOB_FURNITURE },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
