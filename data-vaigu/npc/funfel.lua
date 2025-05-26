local name = "Funfel"
local outfit = {
	lookType = 154,
	lookHead = 114,
	lookBody = 49,
	lookLegs = 125,
	lookFeet = 0,
	lookAddons = 2,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Mikstury, runy, magia !" },
	{
		text = "Ale w tej dzungli goraco i wilgotno, a klimatyzacji nie ma do dzis....",
	},
	{ text = "Sklep magiczny, Funfel zaprasza, pelen asortyment !" },
	{ text = "Magiczne napoje i runy na wyprawe zawsze sie przydadza..." },
	{ text = "Abrakadabra, to czary i magia...." },
	{
		text = "Ehhh, gdyby tylko te cholerne malpy zostawily nasze magazyny w spokoju! Niech ktos pogada z przywodca malp.",
	},
}
local dialogs = {
	[{ "syrop", "plyn", "fluid", "kaszel", "syrup" }] = {
		text = "At the moment we're almost out of syrup. Those monkeys keep pestering us about it. That's why we charge 1000 gold for each bottle, do you have such money?",
		nextTopic = QuestTopics.TheApeCity.ConfirmBuyCoughSyrup,
		requiredState = {
			[Storage.TheApeCity.QuestProgress] = { max = 3 },
		},
	},
	[{ "syrop", "plyn", "fluid", "kaszel", "syrup" }] = {
		text = "Urbanisation and the progress of civilization, which in turn meant ignorance towards the forces of nature, caused many people to fall ill. We export and sell medicine all over the world. If only those pesky monkeys could leave our warehouse alone.",
		requiredState = {
			[Storage.TheApeCity.QuestProgress] = { min = 4 },
		},
	},
	[{ "yes", "tak" }] = {
		text = "Wish you health.",
		rewards = {
			{ id = 4828 },
		},
		requiredMoney = 1000,
		textNoRequiredMoney = "You dont have enough money.",
		requiredTopic = QuestTopics.TheApeCity.ConfirmBuyCoughSyrup,
	},
	[{ "no", "nie" }] = {
		text = "I am aware what im asking for is a lot, but this is the cost of the top notch service.",
		requiredTopic = QuestTopics.TheApeCity.ConfirmBuyCoughSyrup,
		nextTopic = TOPIC_DEFAULT,
	},
}
local context = {
	name = name,
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_MAGIC, JOB_MAGIC_WILDCARD },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
