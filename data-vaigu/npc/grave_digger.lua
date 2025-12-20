local name = "Grave Digger"
local outfit = {
	lookType = 306,
	lookHead = 57,
	lookBody = 59,
	lookLegs = 40,
	lookFeet = 76,
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
	jobs = { JOB_UTILITY },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
