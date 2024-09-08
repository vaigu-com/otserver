local internalNpcName = "Fisherman Son"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 132,
	lookHead = 19,
	lookBody = 10,
	lookLegs = 38,
	lookFeet = 95,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local locationToPos = {
	fortress = Position(6029, 1945, 7),
	city = Position(5800, 1649, 7),
}

local locationGreet = {
	fortress = "My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to The Mirko City or sell some of those {rods}.. If you are interested in some {stories}, ask me for one.",
	city = "My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to elf court or sell some of those {rods}.. If you are interested in some {stories}, ask me for one.",
}

local function getFurthestDestination(player)
	local distanceFortress = locationToPos.fortress:DistanceTo(player:getPosition())
	local distanceCity = locationToPos.city:DistanceTo(player:getPosition())

	local furthestDestination = "city"
	if distanceFortress > distanceCity then
		furthestDestination = "fortress"
	end
	return furthestDestination
end

local function getClosestDestination(player)
	local distanceFortress = locationToPos.fortress:DistanceTo(player:getPosition())
	local distanceCity = locationToPos.city:DistanceTo(player:getPosition())

	local furthestDestination = "city"
	if distanceFortress < distanceCity then
		furthestDestination = "fortress"
	end
	return furthestDestination
end

local function getDestinationText(context)
	local player = context.player
	local closest = getClosestDestination(player)
	return locationGreet[closest]
end

local function tryTeleportToOtherSide(player)
	player:removeMoney(100)
	local furthest = getFurthestDestination(player)
	local toPos = locationToPos[furthest]
	player:teleportTo(toPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

local config = {
	[LOCALIZER_UNIVERSAL] = {
		[{ "sail", "plynac" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = tryTeleportToOtherSide,
				},
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.playerIsPzLocked,
					requiredOutcome = false,
					textNoRequiredCondition = "Looks like you have fought someone.. Better step away, I can't trust you.",
				},
				{
					conditions = SPECIAL_CONDITIONS_UNIVERSAL.hasMoney,
					requiredOutcome = true,
					textNoRequiredCondition = "You dont have enough money.",
					price = 100,
				},
			},
		},
		[GREET] = { text = getDestinationText },
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
	},
	[Storage.UstatkowanyFanatyk.Bigos] = {
		[{ max = 3 }] = { [{ "shimmer swimmer" }] = { text = "Yeah, they're pretty." } },
		[3] = {
			[{ "mission", "misja", "nagroda", "reward" }] = {
				text = "Here's your reward. If you'd like to buy more {shimmer swimmer}s just ask me.",
				rewards = {
					{ id = 12557 },
					{ id = 7250, count = 2 },
					{ id = 3033, count = 5 },
				},
				outfitRewards = {
					{ outfitId = 157, addon = 3 },
					{ outfitId = 153, addon = 3 },
				},
				expReward = 80000,
				nextState = {
					[Storage.UstatkowanyFanatyk.Bigos] = 4,
					[Storage.Finished.Fanatyk] = 1,
				},
			},
		},
		[{ min = 4 }] = {
			[{ "shimmer swimmer" }] = {
				text = "Do you want to buy one shimmer swimmer for 1000gp?",
				nextTopic = 10,
			},
			[{ "yes", "tak" }] = {
				text = "Here you go.",
				requiredTopic = { min = 10, max = 10 },
				specialConditions = {
					{
						condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMoney,
						requiredOutcome = true,
						textNoRequiredCondition = "You dont have enough money.",
						price = 1000,
					},
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.removeMoneyBank,
						price = 1000,
					},
				},
			},
		},
	},
	-- ToDo: change to reference
	[2050] = {
		[-1] = {
			[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
				text = "Wow! You have merlin! Will I get this fish from you if we agree that I will make a nice trophy for you from second one you bring me?",
				requiredItems = { { id = 901, remove = false } },
				removeRequiredItems = false,
				nextTopic = 1,
			},
			[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
				text = "Yeah! Lets see.. <bonk blonk> Here you go. Hope you are satisfied",
				nextState = { [2050] = 1 },
				rewards = { { id = 902 } },
				expReward = 5000,
				requiredItems = { { id = 901, count = 2 } },
				requiredState = { min = 1, max = 1 },
				textNoRequiredCondition = "Bring me exactly two marlins",
			},
		},
		[1] = {
			[{ "marlin", "ryba", "rybka", "fish", "merlin" }] = {
				text = "Thank you for that marlin. It looks great by the fireplace.",
			},
		},
	},
}

local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	return TryResolveConversation(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)

--[[
keywordHandler:addKeyword({ "rodzaje" }, StdModule.say, { npcHandler = npcHandler, text = "No wiec jest 5 rodzajow. Quara {Constrictor}, {Mantassin}, {Hydromancer}, {Pincher}, {Predator}! Ha, wszystkie znam." })
keywordHandler:addKeyword(
	{ "constrictor" },
	StdModule.say,
	{
		npcHandler = npcHandler,
		text = "Dziwaczne stwory, mieszanki Krakena i kalamarnic. Jak slyszalem sa nawet inteligentne i chyba sa przywodcami, chociaz sa najslabsze.",
		"Chodza sluchy, ze podobno jeszcze zyje jeden z zalozycieli podwodnego miasta i jest wlasnie tego rodzaju. Mowia na niego gul, to znaczy {Thul}. W ich krwi plynie krew wegorza, wiec sa w stanie oszolomic swoich wrogow na chwile.",
	}
)
keywordHandler:addKeyword({ "mantassin" }, StdModule.say, { npcHandler = npcHandler, text = "Sa czesto nie dostrzegane, az do chwili gdy jest juz za pozno <lenny>. Ta tez wyewoulowala, ale z osmiornicy i plaszczki, czyniac swoja rase mistrzami kamuflazu. Ja tam sie nie znam na nauce. Moze magowie wytlumacza ci o co chodzi z wzajemna mimikra." })
keywordHandler:addKeyword({ "hydromancer" }, StdModule.say, { npcHandler = npcHandler, text = "Czesto niedoceniani przez obwisle brzuchy. Tymczasem najbardziej wkurwiaja. Ich dziedzictwem jest czarna magia, dawnych wymarlych mistrzow." })
keywordHandler:addKeyword({ "pincher" }, StdModule.say, { npcHandler = npcHandler, text = "Zywe i chodzace fortece, wygladajace na niemozliwe do zatrzyania, atakuja ze stoickim spokojem, bez wahania i litosci. Nie jednemu swoim usciskiem szczypiec polamaly dobry miecz na kawalki. Przewage uzyskasz w walce z nimi jesli ci powiem, ze sa cokolwiek niezdarne i naiwne." })
keywordHandler:addKeyword({ "predator" }, StdModule.say, { npcHandler = npcHandler, text = "Najbrdziej krwiozerce ze wszystkiech Quar. Ich morderczego szalu obawia sie wlasna rasa. Zmutowany rekin wypelniony magia wzmacniajaca jego kosci i sk�re. Bezwgledny i okrutny. Lepiej unikac." })
]]
--
