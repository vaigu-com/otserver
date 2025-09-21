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

local outfit = {
	lookType = 136,
	lookHead = 20,
	lookBody = 100,
	lookLegs = 50,
	lookFeet = 99,
	lookAddons = 3,
}
local context = {
	name = "Walmart007",
	greetJob = JOB_FOOD,
	jobs = { JOB_FOOD },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}

NpcRegistry:AppendNpcData(context)
