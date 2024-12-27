local name = "commissioner Fisher"
local outfit = {
	lookType = 268,
	lookHead = 114,
	lookBody = 0,
	lookLegs = 114,
	lookFeet = 114,
	lookAddons = 3,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Dzieki mnie przestepcy ogladaja swiat w kratke!" },
	{
		text = "Poki tutaj jestem w Mirkotown bedzie porzadek a liczba killerow w wiezieniu bedzie sie zgadzac!",
	},
	{ text = "A paragrafy mam juz dawno w dupie!" },
	{
		text = "Widzialem ooooorla cieeen, ktory wzbil sieee niczym wiatr, nananaaaa nanaaa naaaa",
	},
	{ text = "Coo powiee Ryyyybaaa.... a duzo powie jak zapytasz!" },
	{ text = "Tu Ryba, wzywam Cie, Akwarium." },
	{
		text = "Co ty myslisz, cwaniaczku?! Ze z piatego przykazania mozesz sobie zrobic spolke z ograniczona odpowiedzialnoscia?!",
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
