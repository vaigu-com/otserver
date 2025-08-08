local name = "Ignatz"
local outfit = {
	lookType = 514,
	lookHead = 59,
	lookBody = 40,
	lookLegs = 78,
	lookFeet = 99,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mam szpadle, liny, maczety, kosy i inne przydatne gadzety..." },
	{ text = "Wedki plecaki, robaki w korzystnej cenie ! " },
	{
		text = "Jesli potrzebujesz sprzet niezbedny do eksplorowania terenu to dobrze trafiles.",
	},
	{ text = "Bez sprzetu na wyprawe? " },
	{
		text = "Ludzie to nie maja wyobrazni mam nadzieje ze w koncu wejdzie ta ustawa i na zwiedzanie bedzie mozna chodzic tylko z licencja...",
	},
}
local context = {
	name = name,
	greetJob = JOB_UTILITY,
	jobs = { JOB_UTILITY, JOB_DISTANCE },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
