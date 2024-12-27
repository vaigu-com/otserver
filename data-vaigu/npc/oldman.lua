local name = "Oldman"
local outfit = {
	lookType = 153,
	lookHead = 0,
	lookBody = 41,
	lookLegs = 40,
	lookFeet = 116,
	lookAddons = 1,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Ten Lidl ciagle probuje kopiowac moje promocje..." },
	{ text = "Promocja na piersi z kurczaka i stejki ! Robcie zapasy !" },
	{ text = "Swieze warzywa i owoce w korzystnych cenach !" },
	{
		text = "Dostawcy bananow dalej nie spelniaja wymogow unijnych wzgledem ich krzywizny...A kare zaplace ja !",
	},
	{ text = "Kukurydza, ziemniaki, marchew, rzodkiew, wszystko bez GMO ! " },
}
local context = {
	name = name,
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD, },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
