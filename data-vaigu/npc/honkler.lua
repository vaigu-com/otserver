local name = "Honkler"
local outfit = {
	lookType = 160,
	lookHead = 57,
	lookBody = 69,
	lookLegs = 95,
	lookFeet = 114,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Wszystko wina Tuska!" },
	{ text = "Cala Polska z was sie smieje, komunisci i zlodzieje!" },
	{ text = "Ale czy marihuana jest z konopi? Chyba nie..." },
	{ text = "..z ziemi polskiej do Wolski..." },
	{ text = "My jestesmy tu gdzie wtedy. Oni tam gdzie stalo ZOMO" },
	{
		text = "My nie mowimy, ze biale jest czarne, tylko ze czarne jest czarne i ze trzeba to wybielic.",
	},
}
local context = {
	name = name,
	greetJob = JOB_CREATURE_PRODUCT,
	jobs = { JOB_CREATURE_PRODUCT },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
