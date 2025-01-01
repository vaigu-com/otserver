local name = "Fisherman Son"
local outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}
local dialogs = {
	[{ "sail", "plynac" }] = {
		text = "",
		specialActionsOnSuccess = {
			{
				action = CreateTransportWindow,
				transports = TRANSPORT_ROUTES.FISHERMAN_SHIP,
				transportType = TRANSPORT_TYPE.SHIP,
			},
		},
		specialConditions = {
			{
				condition = SPECIAL_CONDITIONS_UNIVERSAL.playerIsPzLocked,
				requiredOutcome = false,
				textNoRequiredCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
			},
		},
	},
	[GREET] = { text = "FISHERMAN_GREET" },
	[{ "story", "stories", "historia", "historie" }] = {
		text = "When i was still a kid, my father would tell me stories about {mythical} creatures inhabiting the {ocean}. The more stories i heard, the more i wanted to have some of this world in my {house}.\nI would really like to find a giant fish like in the stories. But im a simple man - adventures are not for me. Ehhh, i really wish i could face the legendary {Thul}, perhaps some day..",
	},
	[{ "mythical", "mityczny", "mitycznych", "mityczne" }] = {
		text = "There is lot of creatures that came from the great unknown. My father friend, Christopher, talked about fish with human-like features or even whole bodies. {Quara}s inhabit the very deeps of the {ocean} near the island where he likes to party while his {red wife} is oblivious.\n Hehe, his ship is visibly damaged by sea serpents. This is his second ship already. {Santa Maria} Mark I was utterly demolished by a giant {Sea Serpent}\nUncle says, that is was Leviathan itself that made attempt on his life, but it was probably just the rum-incuced delirium. Haha, Leviathan, good one. When the end of times come, perhaps he will come.",
	},
	[{
		"weze morskie",
		"morskie weze",
		"waz morski",
		"morski waz",
		"sea serpent",
	}] = {
		text = "Giant creatures that look similar to snakes. Their breath can put a sizeable fire away. Lot of wenches in our city love hearing stories about those. Perhaps if i could put my hands on a proof of their demise, i would get laid? Who knows..",
	},
	[{ "leviathan" }] = {
		text = "The biggest one of them all serpents. If i could escape this life, i will face him.",
	},
	[{ "quary", "quara", "quaras" }] = {
		text = "Big family of sea creatures. I saw their sketches made by adventurers visiting city marketplace. I saw so many of them, i can now differentiate every {species}. Maybe not with closed eyes, but i roughly know this subject.",
	},
	[{ "rodzaje", "rodzaj", "species" }] = {
		text = "To my knowledge, there is five species. Quara Constrictor, Mantassin, Hydromancer, Pincher, Predator! Ha, i know them all.",
	},
	[{ "thul" }] = {
		text = "Rumored to be the last one living of the lost underound city that was established ages ago. He is saving his energy, and only comes out when his {Quara} sons are failing. In that case, he comes out from his slumber, and shows no fear.",
	},
	[{ "ocean" }] = {
		text = "A puddle of water that someone sprinkled salt over.",
	},
	[{ "leech", "pijawki" }] = { text = "The Water Buffalos love them." },
	[{ "larw", "larwa", "larva", "larvae", "larvaes" }] = {
		text = "You sometimes find them inside a gooey mass.",
	},
	[{ "wedki", "rods" }] = {
		text = "Ask about {trade} if you want to see some. I also have special {mechanical} rod in my offer.",
	},
	[{ "mechaniczna", "mechanical" }] = {
		text = "Really strong designed to swamp use. Its recommeded to use {larvaes} instead of worms. Be aware of {leeches}!",
	},
	[{ "czerwona zona", "red wife" }] = {
		text = "Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day.",
	},
	[{ "domku", "house" }] = { text = "I live just in next house." },
	[{ "santa maria" }] = {
		text = "It was my uncle original ship. He used it since his very first adventure. I dont know how i would stand losing such a chunk of my life and its history. Perhaps he will tell you more about it, if you can serve him a full glass of acohol - when sober, hes not talkative.",
	},
}
local context = {
	name = name,
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
