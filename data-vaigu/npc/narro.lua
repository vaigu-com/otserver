local name = "Narro"
local outfit = {
	lookType = 128,
	lookHead = 114,
	lookBody = 114,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Uwazaj podrozniku, Ryba zasadzil sie na Ciebie!" },
	{ text = "Welcome to Knurrrow" },
	{
		text = "Mysleliscie ze mozna mnie bezkarnie ponizac? Ze bede waszym popychadlem?",
	},
	{ text = "Miarka sie przebrala ! Przejmuje hajs i wladze nad Mirkotown! " },
	{ text = "Do budy? Do budy? Wy do budy, i to juz!" },
	{ text = "Narro jestem, chyba widac , nie?!" },
}
local context = {
	name = name,
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
