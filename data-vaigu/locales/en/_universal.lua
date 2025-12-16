local directionToString = {
	[DIRECTION_NORTH] = "North",
	[DIRECTION_NORTHEAST] = "North-East",
	[DIRECTION_EAST] = "East",
	[DIRECTION_SOUTHEAST] = "South-East",
	[DIRECTION_SOUTH] = "South",
	[DIRECTION_SOUTHWEST] = "South-West",
	[DIRECTION_WEST] = "West",
	[DIRECTION_NORTHWEST] = "North-West",
}
local incomprehensibleStringPool = {
	"You have to speak more clearly.",
	"I dont get it.",
	"Can you repeat, please.",
	"I dont get what you're talking about.",
	"I didn't catch that.",
	"What?!",
}

local toOrdinalGrandPlace = {
	[1] = "first",
	[2] = "second",
	[3] = "third",
}

return {
	[NO_TEXT] = NO_TEXT,
	["Hey, Im Zong! Would you like to {ride} somewhere?"] = "Hey, Im Zong! Would you like to {ride} somewhere?",
	["Hello! You look really hungry.. Ask about {trade} to see my offer."] = "Hello! You look really hungry.. Ask about {trade} to see my offer.",
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard} which will increase your prey powers!"] = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard} which will increase your prey powers!",
	["Welcome to my workshop. If you would like to see my furniture and other wares, just ask me for {trade}."] = "Welcome to my workshop. If you would like to see my furniture and other wares, just ask me for {trade}.",
	["Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors."] = "Hello |PLAYERNAME|. You already finished a daily {task} from the notice board? You can {cancel} it whenever you want. I also have some {outfit} for the most generous donors.",
	["Hello! You want to trade or repair your worn {soft boots}? I can also exchange your {medicine pouch}."] = "Hello! You want to trade or repair your worn {soft boots}? I can also exchange your {medicine pouch}.",
	["Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!"] = "Hello, I can see you have completed one of the tasks. Talk to me to get your {reward}!",
	["Hello, I have some {tasks} for you. You can also ask for {trade} if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}."] = "Hello, I have some {tasks} for you. You can also ask for {trade} if you want to take a look at my offer. And I'm also selling {creature product} bundles and exchanging task {points}.",
	["Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?"] = "Yes? What may I do for you, |PLAYERNAME|? Bank business, perhaps?",
	["Of course, just browse through my wares."] = "Of course, just browse through my wares.",
	["Sorry, I'm not offering anything."] = "Sorry, I'm not offering anything.",
	["Distance shop"] = "Distance shop",
	["Smith shop"] = "Smith shop",
	["Magic shop"] = "Magic shop",
	["Creature product vendor"] = "Creature product vendor",
	["Furniture"] = "Furniture",
	["Tasks"] = "Tasks",
	["Jeweller"] = "Jeweller",
	["Utility shop"] = "Utility shop",
	["Post Office"] = "Post Office",
	["Food shop"] = "Food shop",
	["Soft Boots Recharge"] = "Soft Boots Recharge",
	["Ruler"] = "Ruler",
	["Fisher"] = "Fisher",
	["Aol"] = "Aol",
	["Bank"] = "Bank",
	["Temple"] = "Temple",
	["NECK NECK NEEEECKLACES ONLY FOR TWO BUCKS, CHEAP RINGS FOR PRETTY LADIEEES, {LIFE CRYSTAL} EXCHANGE! Take a look at my offer!"] = "NECK NECK NEEEECKLACES ONLY FOR TWO BUCKS, CHEAP RINGS FOR PRETTY LADIEEES, {LIFE CRYSTAL} EXCHANGE! Take a look at my offer!",
	["Bye, be aware of pickpockets!"] = "Bye, be aware of pickpockets!",
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to some nearby places or sell some of those {rods}. If you are interested in some {stories}, ask me for one. I can also provide you with information on fishing {hotspots}."] = "My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to some nearby places or sell some of those {rods}. If you are interested in some {stories}, ask me for one. I can also provide you with information on fishing {hotspots}.",
	["Fishing hotspot move every now and then from city to city. You can find nearest hotspot bu using a dowser. You can probably find it in the wilderness."] = "Fishing hotspot move every now and then from city to city. You can find nearest hotspot bu using a dowser. You can probably find it in the wilderness.",
	[MINIGAMES_BROADCAST_TOP_PARTICIPANTS] = function(context)
		local min, sec = SecondsToMinSec(context.timeTakenSeconds)
		context.min = min
		context.sec = sec
		context.ordinal = toOrdinalGrandPlace[context.grandPlace]
		if context.competitionType == MINIGAME_COMPETITION_TYPE.SPEEDRUN then
			return T("Player :playerName: finished :minigameName: with :ordinal: place and the time of :min: minutes and :sec: seconds. Congratulations!", context)
		else
			return T("Player :playerName: finished :minigameName: with :ordinal: place lasting :min: minutes and :sec: seconds. Congratulations!", context)
		end
	end,
	[ENCOUNTER_ERROR_CODES.NO_DIFFICULTY_CHOSEN] = "You didn't choose difficulty for this encounter! Look at encounter lever to choose one.",
	[ENCOUNTER_LEVER_HELP_WINDOW_TEXT] = "This is an encounter lever. You can unlock higher encounter difficulties by completing lower ones. Looking at lever lets you choose difficulty.\n\nHigher difficulty gives you more loot, but also scales monster damage and healing, and might also add additional mechanics to the fight.\n\n20% additive loot per level\n\n20% multiplicative damage and health per level",
	["Select difficulty:"] = "Select difficulty:",
	["Go away, or even better: flip off."] = "Go away, or even better: flip off.",
	["YOU_ARE_NOW_CITIZEN_OF"] = function(context)
		local townName = context.townName
		--local genderText = "Zostales"
		--if context.player:getSex() == PLAYERSEX_FEMALE then
		--	genderText = "Zostalas"
		--end
		return T("You are now a citizen of :townName:.", { townName = townName })
	end,
	["Hello, |PLAYERNAME|! Lately hardly any people come to visit me"] = "Hello, |PLAYERNAME|! Lately hardly any people come to visit me",
	["QUEST_MISSION_COMPLETE_SUFFIX"] = " (complete)",
	["GO_IN_DIRECTION"] = function(context)
		local direction = context.direction
		if direction == DIRECTION_NONE then
			return "You are there!"
		end
		return T("Go :direction:.", { direction = directionToString[direction] })
	end,
	["Starter weapons"] = "Starter weapons",
	["Choose your starter weapon:"] = "Choose your starter weapon:",
	["Fine, i will choose your starter weapon then..."] = "Fine, i will choose your starter weapon then...",
	["WELCOME_TO_SERVER"] = function()
		return T("Welcome to :serverName:!", { serverName = configManager.getString(configKeys.SERVER_NAME) })
	end,
	["YOUR_LAST_VISIT"] = function(context)
		return T("Your last login was on :lastLogin:.", { lastLogin = os.date("%d-%m-%Y %X", context.player:getLastLoginSaved()) })
	end,
	["Please choose your outfit."] = "Please choose your outfit.",
	["Premade action bars for every vocation are available in options."] = "Premade action bars for every vocation are available in options.",
	["LIST_AVAILABLE_COMMANDS"] = "Change your language with: !language, frequenty asked questions: !faq. Rest of commands is available under !commands",
	["You can report ingame bugs using ctrl+z."] = "You can report ingame bugs using ctrl+z.",
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT] = function(context)
		return T("You or a member in your team still has a cooldown for the :displayName: encounter.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS] = function(context)
		return T("You or a member in your team does not have the required access to enter :displayName: encounter.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS] = function(context)
		return T("You dont have access to :displayName: encounter.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.ONLY_PLAYERS] = function()
		return "Only players can participate in the fight!"
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY] = function(context)
		return T("There's someone fighting :displayName: already.", { displayName = context.displayName })
	end,
	[ENCOUNTER_ERROR_CODES.STAND_ON_ENTRANCE] = function()
		return "You have to be standing on the entrance array to start the encounter."
	end,
	[ENCOUNTER_ERROR_CODES.NO_LEVEL] = function(context)
		return T("You or a member in your team doesnt have a minimal level of :minLevel:.", { minLevel = context.requiredLevel })
	end,
	[ENCOUNTER_ERROR_CODES.ENCOUNTER_DISABLED] = function()
		return "This encounter is temporarily disabled."
	end,
	[ENCOUNTER_ERROR_CODES.ENCOUNTER_ACTIVE] = function()
		return "This encounter is ongoing and cannot be entered."
	end,
	["YOU_CHANGED_YOUR_LOOTRATE"] = function(context)
		return T("You changed your loot rate to x:rate:", { rate = context.rate })
	end,
	["ModalWindowOk"] = "Ok",
	["ExerciseWeaponBoxTitle"] = "Reward",
	["ExerciseWeaponBoxMessage"] = function(context)
		local charges = context.charges
		return T("Choose your exercise weapon (:charges: uses):", { charges = charges })
	end,
	["Well, go away."] = "Well, go away.",
	["You won't even farewell me.."] = "You won't even farewell me..",
	["Hi |PLAYERNAME|. Perhaps you want to deposit some {vials}?"] = "Hi |PLAYERNAME|. Perhaps you want to deposit some {vials}?",
	["I can give you {lottery ticket} for 100 empty flasks. Are you down?"] = "I can give you {lottery ticket} for 100 empty flasks. Are you down?",
	["You don't have 100 empty flasks."] = "You don't have 100 empty flasks.",
	["Great! Here's your lottery ticket."] = "Great! Here's your lottery ticket.",
	["You can exchange winning lottery ticket for one of addons. Michael Dumpling will tell you more about that."] = "You can exchange winning lottery ticket for one of addons. Michael Dumpling will tell you more about that.",
	["a honeyflower patch."] = "a honeyflower patch.",
	["a banana palm."] = "a banana palm.",
	["a gargoyle statue.\n You read: \n\n Either loved or hated \n\nCitizen Honoris Causa\n\nPtaaq"] = "a gargoyle statue.\n You read: \n\n Either loved or hated \n\nCitizen Honoris Causa\n\nPtaaq",
	["Map of burried spell."] = "Map of burried spell.",
	["Map of brasilian Ratland."] = "Map of brasilian Ratland.",
	["Overdue package.\nThis is a big parcel with lot of orders. The recipient is the Mirkotown depot, 2nd floor"] = "Overdue package.\nThis is a big parcel with lot of orders. The recipient is the Mirkotown depot, 2nd floor",
	["Bait in a can."] = "Bait in a can.",
	["Anon's father's float."] = "Anon's father's float.",
	["Anon's father's fishing reel."] = "Anon's father's fishing reel.",
	["Anon's father's stool."] = "Anon's father's stool.",
	["You failed to complete the rescue in time."] = function(context)
		T("You failed to complete the rescue :escorteeName: in time.", { escorteeName = context.escorteeName })
	end,
	["You failed to complete the escort because rescuee died."] = function(context)
		T("You failed to complete the escort because :escorteeName: died.", { escorteeName = context.escorteeName })
	end,
	[""] = "",
	["Cancel"] = "Cancel",
	["Select"] = "Select",
	["Exit"] = "Exit",
	["Help"] = "Help",
	[GREET] = "Hello.",
	[WALKAWAY] = "Bye.",
	["SoldierWalkaway"] = "Bye.",
	["Bye..."] = "Bye...",
	[FAREWELL] = "Farewell.",
	["Thanks."] = "Thanks.",
	[INCOMPREHENSIBLE] = function()
		return table.random(incomprehensibleStringPool)
	end,
	[NOT_ENOUGH_CAP_OR_SLOTS] = "You dont have enough capacity or equipment slots.",
	["You dont have enough money."] = function(context)
		local price = context.price
		if price then
			return T("You dont have enough money. You need at least :price: gold for that.", { price = price })
		end
		return "You dont have enough money."
	end,
	["This amount is not a number."] = "This amount is not a number.",
	["To be continued..."] = "To be continued...",
	["Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world."] = "Hello |PLAYERNAME|. I can tell you {informations} about whats behind the gates. You can also take some {mission} from me. By the way: im an expert at WoW raids, and I might be able to help you with dangerous {encounters} of this world.",
	["They call me reborn eater, because i have a meat mortar in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go."] = "They call me reborn eater, because i have a meat mortar in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go.",
	["Lebewohl."] = "Lebewohl.",
	["Auf wiedersehen."] = "Auf wiedersehen.",
	["Ich verstehe kein einziges wort."] = "Ich verstehe kein einziges wort.",
	["Strammstehen!"] = "Strammstehen!",
	["Ich weiss nichts daruber."] = "Ich weiss nichts daruber.",
	["Peace God."] = "Peace God.",
	["Seeee yaaa."] = "Seeee yaaa.",
	["Waddup, G?"] = "Waddup, G?",
	["What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived."] = "What in the? I say what in the fuck are those discussions!? Shut the hell up until we have arrived.",
	["Yeah, you got it!"] = "Yeah, you got it!",
	["Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}"] = "Goldblum is a very cunning one. He likes to play the riddles game. If he asks you about the valuation of structured bonds, say exactly these words: {It depends on the current level of the stock market index, stock price, commodity price, currency exchange rate, or other market indicator that serves as their underlying instrument}",
	["TRAVEL_YOU_NEED_LEVEL"] = function(context)
		return T("You need :minLevel: level to travel there", { minLevel = context.minLevel })
	end,
	["TRAVEL_YOU_NEED_ACCESS"] = "You did not unlock access to this location yet",
	["TravelHelpDialog"] = function(context)
		return T("You can travel between cities if you have enough money. Also, you cannot be a suspect in any illegal activity. Current cost is :transportPrice:. You currently have :money: gold.", {
			transportPrice = context.price,
			money = context.player:getMoney(),
		})
	end,
	["ShipWindowTitle"] = "Ship",
	["CarpetWindowTitle"] = "Carpet",
	["TrainWindowTitle"] = "Train",
	["CamelWindowTitle"] = "Camel",
	["ShipWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("As a novice, you are entitled to free Ship sailing. Remaining admits :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Where would you like to sail?"
		return finalString
	end,
	["CarpetWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("As a novice, you are entitled to free Carpet flights. Remaining admits :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Where would you like to fly?"
		return finalString
	end,
	["TrainWindowMessage"] = "Where would you like to ride?",
	["CamelWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValueByKey(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("As a novice, you are entitled to free Camel rides. Remaining admits :freeTravels:.\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Where would you like to ride?"
		return finalString
	end,
	["Looks like you have fought someone.. Better step away, I can't trust you."] = "Looks like you have fought someone.. Better step away, I can't trust you.",
	["Welcome to my ship. Where would you like to {sail}?"] = "Welcome to my ship. Where would you like to {sail}?",
	["Hello, traveler. Would you like me to {fly} you somewhere?"] = "Hello, traveler. Would you like me to {fly} you somewhere?",
	-- gruby mirek
	["I didnt throw my life away for video games just to give away those informations for free. Bring me a {cake} and i will tell you all you need to know about any encounter."] = "I didnt throw my life away for video games just to give away those informations for free. Bring me a {cake} and i will tell you all you need to know about any encounter.",
	["Come back with a cake. Also, i dont want any toppings on it."] = "Come back with a cake. Also, i dont want any toppings on it.",
	["Alright, i can help you with your {encounter} now."] = "Alright, i can help you with your {encounter} now.",
	-- gertruda
	["Just a common drunkard... if you don't give him a drink, he won't talk to you."] = "Just a common drunkard... if you don't give him a drink, he won't talk to you.",
	["I see you have met one of our brothers. Welcome to our family then, there are not many of us left in this world.\nIf you want, I can tell you a part of our {story}."] = "I see you have met one of our brothers. Welcome to our family then, there are not many of us left in this world.\nIf you want, I can tell you a part of our {story}.",
	["I don't know who told you this password. Go away please."] = "I don't know who told you this password. Go away please.",
	["Can you see the lizard village south to my hut? They have a strange plant that they use to produce vodka most potent. Once, i took two sips of this beverage... i dont remember much after, as i slept for next two days. \nIm now getting ready to visit my friend Konmuld. Hes not very talkative outside of the time he is drunk.\n\nPlease steal some of this liquor from lizards if you want to visit him too."] = "Can you see the lizard village south to my hut? They have a strange plant that they use to produce vodka most potent. Once, i took two sips of this beverage... i dont remember much after, as i slept for next two days. \nIm now getting ready to visit my friend Konmuld. Hes not very talkative outside of the time he is drunk.\n\nPlease steal some of this liquor from lizards if you want to visit him too.",
	["I will tell you everything I remember, but I need some help, are you up for it?"] = "I will tell you everything I remember, but I need some help, are you up for it?",
	["Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Hirschberg. You might wanna visit him in the southern steppes.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you."] = "Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Hirschberg. You might wanna visit him in the southern steppes.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you.",
	["Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night."] = "Do you need a rat killer? We don't have any left. I will make you a special remedy, but you must bring me one ingredient: moldy cheese\nPerfectly lures rats, I will season it with a special substance that will make them all die in one night.",
	["What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard."] = "What a smell, perfect. In the meantime, I have prepared a decoction. Now we'll inject and it's ready.\nPut it somewhere in the cellar overnight, and in the morning you will see a graveyard.",
	["Bring me some mouldy cheese."] = "Bring me some mouldy cheese.",
	["I have already poisoned it for you."] = "I have already poisoned it for you.",
	["I dont get it."] = "I dont get it.",
	["Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work."] = "Hi |PLAYERNAME|. You can check my offer, say {trade} if you're down for garden work.",
	["He is my brother, nothing more to it."] = "He is my brother, nothing more to it.",
	["Ask Woody about the wood supply."] = "Ask Woody about the wood supply.",
	["Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?"] = "Hello, Im Jack Sparrow - Caribbean King! Would you like to {sail} somewhere?",
	["Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?"] = "Hello. I can sail you to steppes, Bornholm and island inhabited by quaras. So where you'd like to {sail} to?",
	["When i was still a kid, my father would tell me stories about {mythical} creatures inhabiting the {ocean}. The more stories i heard, the more i wanted to have some of this world in my {house}.\nI would really like to find a giant fish like in the stories. But im a simple man - adventures are not for me. Ehhh, i really wish i could face the legendary {Thul}, perhaps some day.."] = "When i was still a kid, my father would tell me stories about {mythical} creatures inhabiting the {ocean}. The more stories i heard, the more i wanted to have some of this world in my {house}.\nI would really like to find a giant fish like in the stories. But im a simple man - adventures are not for me. Ehhh, i really wish i could face the legendary {Thul}, perhaps some day..",
	["There is lot of creatures that came from the great unknown. My father friend, Christopher, talked about fish with human-like features or even whole bodies. {Quara}s inhabit the very deeps of the {ocean} near the island where he likes to party while his {red wife} is oblivious.\n Hehe, his ship is visibly damaged by sea serpents. This is his second ship already. {Santa Maria} Mark I was utterly demolished by a giant {Sea Serpent}\nUncle says, that is was Leviathan itself that made attempt on his life, but it was probably just the rum-incuced delirium. Haha, Leviathan, good one. When the end of times come, perhaps he will come."] = "There is lot of creatures that came from the great unknown. My father friend, Christopher, talked about fish with human-like features or even whole bodies. {Quara}s inhabit the very deeps of the {ocean} near the island where he likes to party while his {red wife} is oblivious.\n Hehe, his ship is visibly damaged by sea serpents. This is his second ship already. {Santa Maria} Mark I was utterly demolished by a giant {Sea Serpent}\nUncle says, that is was Leviathan itself that made attempt on his life, but it was probably just the rum-incuced delirium. Haha, Leviathan, good one. When the end of times come, perhaps he will come.",
	["Giant creatures that look similar to snakes. Their breath can put a sizeable fire away. Lot of wenches in our city love hearing stories about those. Perhaps if i could put my hands on a proof of their demise, i would get laid? Who knows.."] = "Giant creatures that look similar to snakes. Their breath can put a sizeable fire away. Lot of wenches in our city love hearing stories about those. Perhaps if i could put my hands on a proof of their demise, i would get laid? Who knows..",
	["The biggest one of them all serpents. If i could escape this life, i will face him."] = "The biggest one of them all serpents. If i could escape this life, i will face him.",
	["Big family of sea creatures. I saw their sketches made by adventurers visiting city marketplace. I saw so many of them, i can now differentiate every {species}. Maybe not with closed eyes, but i roughly know this subject."] = "Big family of sea creatures. I saw their sketches made by adventurers visiting city marketplace. I saw so many of them, i can now differentiate every {species}. Maybe not with closed eyes, but i roughly know this subject.",
	["To my knowledge, there is five species. Quara Constrictor, Mantassin, Hydromancer, Pincher, Predator! Ha, i know them all."] = "To my knowledge, there is five species. Quara Constrictor, Mantassin, Hydromancer, Pincher, Predator! Ha, i know them all.",
	["Rumored to be the last one living of the lost underound city that was established ages ago. He is saving his energy, and only comes out when his {Quara} sons are failing. In that case, he comes out from his slumber, and shows no fear."] = "Rumored to be the last one living of the lost underound city that was established ages ago. He is saving his energy, and only comes out when his {Quara} sons are failing. In that case, he comes out from his slumber, and shows no fear.",
	["A puddle of water that someone sprinkled salt over."] = "A puddle of water that someone sprinkled salt over.",
	["The Water Buffalos love them."] = "The Water Buffalos love them.",
	["You sometimes find them inside a gooey mass."] = "You sometimes find them inside a gooey mass.",
	["Ask about {trade} if you want to see some. I also have special {mechanical} rod in my offer."] = "Ask about {trade} if you want to see some. I also have special {mechanical} rod in my offer.",
	["Really strong designed to swamp use. Its recommeded to use {larvaes} instead of worms. Be aware of {leeches}!"] = "Really strong designed to swamp use. Its recommeded to use {larvaes} instead of worms. Be aware of {leeches}!",
	["Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day. At least he has his {marlin} still."] = "Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day. At least he has his {marlin} still.",
	["It was my uncle original ship. He used it since his very first adventure. I dont know how i would stand losing such a chunk of my life and its history. Perhaps he will tell you more about it, if you can serve him a full glass of acohol - when sober, hes not talkative."] = "It was my uncle original ship. He used it since his very first adventure. I dont know how i would stand losing such a chunk of my life and its history. Perhaps he will tell you more about it, if you can serve him a full glass of acohol - when sober, hes not talkative.",
	["I live just in next house."] = "I live just in next house.",
	-- shop npcs
	["Hello, |PLAYERNAME|. My offers are bows, crossbows and ammunition. If you'd like to see, ask me for a {trade}. I can also exchange your {soul orbs}."] = "Hello, |PLAYERNAME|. My offers are bows, crossbows and ammunition. If you'd like to see, ask me for a {trade}. I can also exchange your {soul orbs}.",
	["I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?"] = "I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?",
	["You're welcome! Use them wisely."] = "You're welcome! Use them wisely.",
	["I can see you don't have them! I can only craft infernal bolts from {soul orb}."] = "I can see you don't have them! I can only craft infernal bolts from {soul orb}.",
	["Please, don't bother me!"] = "Please, don't bother me!",
	["You got your reward already, visit Fstab for a potion supply."] = "You got your reward already, visit Fstab for a potion supply.",
	["Trollsky sent you there? What you prefer to get, {bolts} or {arrows}?"] = "Trollsky sent you there? What you prefer to get, {bolts} or {arrows}?",
	["Here are bolts for you. You should visit Fstab for a potion supply."] = "Here are bolts for you. You should visit Fstab for a potion supply.",
	["Here are arrows for you. You should visit Fstab for a potion supply."] = "Here are arrows for you. You should visit Fstab for a potion supply.",
	["Everything is in perfect order, only if you could check what is going on with this wood delivery.. I'm almost out of my stock, I don't want to disappoint my customers."] = "Everything is in perfect order, only if you could check what is going on with this wood delivery.. I'm almost out of my stock, I don't want to disappoint my customers.",
	["What do you want? Better visit Commissioner Fisher first."] = "What do you want? Better visit Commissioner Fisher first.",
	["Hello, I buy various equipment like armors, weapons, and.. well ask about {trade} to see my whole offer."] = "Hello, I buy various equipment like armors, weapons, and.. well ask about {trade} to see my whole offer.",
	["Well I do need some help. Wood delivery from Knurow is already delayed for two days, and currently I can't check why.."] = "Well I do need some help. Wood delivery from Knurow is already delayed for two days, and currently I can't check why..",
	["Better visit Commissioner Fisher first."] = "Better visit Commissioner Fisher first.",
	["Here is your axe. You should also visit Fstab, he should provide you some supplies."] = "Here is your axe. You should also visit Fstab, he should provide you some supplies.",
	["Here is your sword. You should also visit Fstab, he should provide you some supplies."] = "Here is your sword. You should also visit Fstab, he should provide you some supplies.",
	["Here is your club. You should also visit Fstab, he should provide you some supplies."] = "Here is your club. You should also visit Fstab, he should provide you some supplies.",
	["Here is your spellbook. You should also visit Fstab, he should provide you some supplies."] = "Here is your spellbook. You should also visit Fstab, he should provide you some supplies.",
	["Visit Filozofujaca Calka for this reward, and then meet Fstab. He should provide you some supplies."] = "Visit Filozofujaca Calka for this reward, and then meet Fstab. He should provide you some supplies.",
	["You got your reward already."] = "You got your reward already.",
	["Yeah! You deserve some reward for helping us. You can choose one from the following:"] = "Yeah! You deserve some reward for helping us. You can choose one from the following:",
	["{Axe}, {sword}, {club}, {spellbook}, {bolts} and {arrows}."] = "{Axe}, {sword}, {club}, {spellbook}, {bolts} and {arrows}.",
	["Some time ago orcs stole my old red backpack. Maybe you have found it?"] = "Some time ago orcs stole my old red backpack. Maybe you have found it?",
	["Thank you very much! This brings back good old memories! Here is reward for you!"] = "Thank you very much! This brings back good old memories! Here is reward for you!",
	["Thats unfortunate."] = "Thats unfortunate.",
	["Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is somewhere south of Knurow."] = "Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is somewhere south of Knurow.",
	["WILDCARD_COST_QUESTION"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		return T("Wildcard will cost you :preyWildcardPrice: gold. You can get better bonuses in your prey creatures with it. How many wildcards would you like to buy?", { preyWildcardPrice = preyWildcardPrice })
	end,
	["WILDCARD_COUNT_CHOSEN"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		local orderedWildcardsCount = context.npcHandler.topic[context.player:getId()] - 100
		local orderedCardsPrice = preyWildcardPrice * orderedWildcardsCount
		return T("Are you sure, that you want to buy :orderedWildcardsCount: wildcard? It will cost you :orderedCardsPrice: gold.", {
			orderedWildcardsCount = orderedWildcardsCount,
			orderedCardsPrice = orderedCardsPrice,
		})
	end,
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages."] = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages.",
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!"] = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!",
	["Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer."] = "Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer.",
	["You need to tell me the number of wildcards you'd like to buy."] = "You need to tell me the number of wildcards you'd like to buy.",
	["Here are your wildcards!"] = "Here are your wildcards!",
	["Hello hello, |PLAYERNAME| I am Jurek and I sell some.. protection thing.. Ask about {trade} if you want to see!"] = "Hello hello, |PLAYERNAME| I am Jurek and I sell some.. protection thing.. Ask about {trade} if you want to see!",
	["Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}."] = "Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}.",
	["Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}"] = "Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}",
	["Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested."] = "Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested.",
	["Hello, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you."] = "Hello, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you.",
	["I am local postman, ask about {trade} if you want to buy some parcel or letter."] = "I am local postman, ask about {trade} if you want to buy some parcel or letter.",
	["Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}."] = "Hello! You want to {trade}, or repair your worn {soft boots}? I can also exchange your {medicine pouch}.",
	["Oh hello! Check out my new recipes, we can {trade} a little."] = "Oh hello! Check out my new recipes, we can {trade} a little.",
	["I can exchange your life crystals for a life rings. Is that what youre interested in?"] = "I can exchange your life crystals for a life rings. Is that what youre interested in?",
	["Here you go."] = "Here you go.",
	["Im sorry, but you dont have such crystal. Only life crystal counts."] = "Im sorry, but you dont have such crystal. Only life crystal counts.",
	["Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold."] = "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.",
	["Here you are."] = "Here you are.",
	["What?! I wont do it for free."] = "What?! I wont do it for free.",
	["Here are your soft boots."] = "Here are your soft boots.",
	["I wont do it for free."] = "I wont do it for free.",
	["Sorry, but you dont have such item. I can only fix {soft boots}."] = "Sorry, but you dont have such item. I can only fix {soft boots}.",
	["You have medicine pouch for me?"] = "You have medicine pouch for me?",
	["I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one."] = "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.",
	["You dont have that."] = "You dont have that.",
	["What do you want? Better meet Commissioner Fisher first.."] = "What do you want? Better meet Commissioner Fisher first..",
	["No need, but if you know some way to get rid of {rats} once and for all, tell me."] = "No need, but if you know some way to get rid of {rats} once and for all, tell me.",
	["I still have rats in the warehouse. I need some poison to get rid of them."] = "I still have rats in the warehouse. I need some poison to get rid of them.",
	["Well, I'm waiting for this poison that will help me exterminate the rats."] = "Well, I'm waiting for this poison that will help me exterminate the rats.",
	["Are you sure it will work? Thanks for your help. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it."] = "Are you sure it will work? Thanks for your help. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it.",
	["It's alright, I don't need any help."] = "It's alright, I don't need any help.",
	["Rats are gone, thanks again."] = "Rats are gone, thanks again.",
	["I heard that it brings you luck, if you catch one of fireflies from magical tree into that."] = "I heard that it brings you luck, if you catch one of fireflies from magical tree into that.",
	["Hello, I {trade} with fishing equipment, take a look at my offer if you want."] = "Hello, I {trade} with fishing equipment, take a look at my offer if you want.",
	["I can exchange your red gems for a three rings of healing. Is that what youre interested in?"] = "I can exchange your red gems for a three rings of healing. Is that what youre interested in?",
	["Nothing there."] = "Nothing there.",
	["Hum Humm! Welcume {here} li'l Player."] = "Hum Humm! Welcume {here} li'l Player.",
	["I am {smith}."] = "I am {smith}.",
	["Working {steel} is my profession. Me too {melts} gold, {iron ore} and {soul orbs}."] = "Working {steel} is my profession. Me too {melts} gold, {iron ore} and {soul orbs}.",
	["Many kinds of. Some I {forge}. But not ancient steel."] = "Many kinds of. Some I {forge}. But not ancient steel.",
	["Me can forge equipment back to steel. Like {Za'Ralator}, {Uth'Kean}, {Uth'Lokr}, {Uth'Prta}."] = "Me can forge equipment back to steel. Like {Za'Ralator}, {Uth'Kean}, {Uth'Lokr}, {Uth'Prta}.",
	["Can melt gold ingot for lil' one. You want?"] = "Can melt gold ingot for lil' one. You want?",
	["Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?"] = "Very noble. Shiny. Me like. But breaks so fast. Me can make from shiny armour. Lil' one want to trade?",
	["Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?"] = "Firy steel it is. Need green ones' breath to melt. Or red even better. Me can make from shield. Lil' one want to trade?",
	["Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?"] = "Good iron is. Me friends use it much for fight. Me can make from weapon. Lil' one want to trade?",
	["Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?"] = "Hellsteel is. Cursed and evil. Dangerous to work with. Me can make from evil helmet. Lil' one want to trade?",
	["Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?"] = "Uh. Me can make some nasty lil' bolt from soul orbs. Lil' one want to trade all?",
	["Uh. Me can make some gear wheel from iron ores. Lil' one want to trade?"] = "Uh. Me can make some gear wheel from iron ores. Lil' one want to trade?",
	["whoooosh There!"] = "whoooosh There!",
	["There is no gold ingot with you."] = "There is no gold ingot with you.",
	["You dont have a crown armor!"] = "You dont have a crown armor!",
	["You dont have a devil helmet!"] = "You dont have a devil helmet!",
	["You dont have a giant sword!"] = "You dont have a giant sword!",
	["Lil' one does not have any iron ores."] = "Lil' one does not have any iron ores.",
	["You dont have soul orbs!"] = "You dont have soul orbs!",
	["Cling clang!"] = "Cling clang!",
	["SERVER_RESTART_NOTIFY"] = function(context)
		return T("[SERVER] Restart in :formattedTime:", { formattedTime = context.formattedTime })
	end,
	["Say {trade} if you want to see my offer."] = "Say {trade} if you want to see my offer.",
	["Hello |PLAYERNAME|. Its so hot today, youre probably really thirsty. You can buy chilled drinks there or eat some rice."] = "Hello |PLAYERNAME|. Its so hot today, youre probably really thirsty. You can buy chilled drinks there or eat some rice.",
	["Ooga Booga, |PLAYERNAME|. I heard you looking for some loud. {Trade} if you need some, playa. If you good then bounce lil nigga, we be tryin' to hustle."] = "Ooga Booga, |PLAYERNAME|. I heard you looking for some loud. {Trade} if you need some, playa. If you good then bounce lil nigga, we be tryin' to hustle.",
	["Hello |PLAYERNAME|. As a jewellery store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}."] = "Hello |PLAYERNAME|. As a jewellery store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}.",
	["Hello, im the conductor of this train. Do you need a {ride}?"] = "Hello, im the conductor of this train. Do you need a {ride}?",
	["Here you are. There are your soft boots."] = "Here you are. There are your soft boots.",
	["They call me reborn eater, because i have a mortar for reborns in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go."] = "They call me reborn eater, because i have a mortar for reborns in my pants, if you know what i mean. Bring me a fresh Reborn boy, and i will let you go.",
	["As-salamu alaykum, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you."] = "As-salamu alaykum, |PLAYERNAME|. You want to buy parcel, letter, or make a bank transfer? Im here to help you.",
	["You you like me to {sail} you anywhere?"] = "You you like me to {sail} you anywhere?",
	["Hello. I can help you with acquiring {addons} for your outfits. Are you interested?"] = "Hello. I can help you with acquiring {addons} for your outfits. Are you interested?",
	[YOU_NEED_TO_BRING_THE_FOLLOWING_ITEMS] = function(context)
		local requiredItems = context.requirements.requiredItems
		local str = "You need to bring the following items:\n" .. RequiredItemNamesCountToString(requiredItems)
		return str
	end,
	["Hello, are you interested in trading some gems? Or perhaps you want to help me with my {outfit} collection?"] = "Hello, are you interested in trading some gems? Or perhaps you want to help me with my {outfit} collection?",
	["Hello |PLAYERNAME|. You want {help} with some grinding?"] = "Hello |PLAYERNAME|. You want {help} with some grinding?",
	["Y'Hua'Ri"] = "Y'Hua'Ri",
	["If you have some small enchanted sapphires, I can turn them into sapphire {dust} for you."] = "If you have some small enchanted sapphires, I can turn them into sapphire {dust} for you.",
	["Yeah, yeah. Come back when you have it."] = "Yeah, yeah. Come back when you have it.",
	["Yeah, maybe if you had some."] = "Yeah, maybe if you had some.",
	["You dont have a dragon shield!"] = "You dont have a dragon shield!",
	["Greetings, Player! It's good to see you {alive}."] = "Greetings, Player! It's good to see you {alive}.",
	["With the world in {peril}, everyone's life is at stake."] = "With the world in {peril}, everyone's life is at stake.",
	["The actions of Ferumbras and the sinister minions of the {thing} from beyond have shattered the world. The thing is worming its way into our reality and its workings will cause further {damage}."] = "The actions of Ferumbras and the sinister minions of the {thing} from beyond have shattered the world. The thing is worming its way into our reality and its workings will cause further {damage}.",
	["To name it is to give it power. Even to think about it gives it a hold. But it can't be helped and now that it is entering our world it doesn't worsen the matter significantly. ...\nYet, thinking about it might call for its attention and might give it a hold upon you. At least that was the case in the {past}."] = "To name it is to give it power. Even to think about it gives it a hold. But it can't be helped and now that it is entering our world it doesn't worsen the matter significantly. ...\nYet, thinking about it might call for its attention and might give it a hold upon you. At least that was the case in the {past}.",
	["Through history several of those who were too curious became aware of its existence - or better its lack. They were touched and tainted by the knowledge. ...\nIt is assumed that the ancient Yalahari were the first to really grasp at least part of the concept of what it is. This knowledge gave it a tremendous hold over the Yalahari's minds and it even gave it a {name}."] = "Through history several of those who were too curious became aware of its existence - or better its lack. They were touched and tainted by the knowledge. ...\nIt is assumed that the ancient Yalahari were the first to really grasp at least part of the concept of what it is. This knowledge gave it a tremendous hold over the Yalahari's minds and it even gave it a {name}.",
	["Names hold power. The gods called things into existence by naming them. By giving something a name, it becomes more real. Ideas become concepts, feelings become expressible and so on. ...\nIn the case of the thing that wasn't, the name gave it a hold on reality, gave it a glimpse at our world. By naming it, the Yalahari began to understand it, in a twisted way at least. ...\nA knowledge that was twisted in itself and twisted the minds of those who knew. At last, the Yalahari vanished from the world and even the gods don't know their fate for sure. ...\nNow that this thing - which was not meant to be - entered our world, its name might be old news, so to say. However, it's still dangerous and malignant, nothing to be spoken or thought of lightly, especially not by you mortals."] = "Names hold power. The gods called things into existence by naming them. By giving something a name, it becomes more real. Ideas become concepts, feelings become expressible and so on. ...\nIn the case of the thing that wasn't, the name gave it a hold on reality, gave it a glimpse at our world. By naming it, the Yalahari began to understand it, in a twisted way at least. ...\nA knowledge that was twisted in itself and twisted the minds of those who knew. At last, the Yalahari vanished from the world and even the gods don't know their fate for sure. ...\nNow that this thing - which was not meant to be - entered our world, its name might be old news, so to say. However, it's still dangerous and malignant, nothing to be spoken or thought of lightly, especially not by you mortals.",
	["Probably his vain plea for ascension has brought upon him a fate worse than hell."] = "Probably his vain plea for ascension has brought upon him a fate worse than hell.",
	["While the thing becomes more real, it sheds layers of destruction and negligence of reality. Those layers are becoming threats on their own. ...\nThey eat away matter as well as laws of nature. They are threatening the creation as a whole. Even without doing anything more than becoming more and more real, the thing might win by simply undoing creation. This has to be stopped!"] = "While the thing becomes more real, it sheds layers of destruction and negligence of reality. Those layers are becoming threats on their own. ...\nThey eat away matter as well as laws of nature. They are threatening the creation as a whole. Even without doing anything more than becoming more and more real, the thing might win by simply undoing creation. This has to be stopped!",
	["The destruction that comes with that thing shares the intention of its progenitor to become more real. Therefore, the destruction has gathered into something that - under other circumstances - would be called avatars. ...\nSome destructive and unnatural forces have condensed themselves to highly dangerous constructs that are gnawing at existence itself. Even now their workings can be felt. ...\nAll over the world incursions like this one here can be encountered. They eat away matter, sanity and order - sucking them into nothingness. Behind these incursions, on the brink to nothingness and annihilation, the non-avatars are lurking. ...\nTheir most potent incarnation has been named Heart of Destruction. But there are others - less potent but disruptive on their own. The heart gives those mindless forces unity and purpose. ...\nIt unites them to the threat that they are. Every incursion itself it only restricted to time and space. Reality will eventually heal and recover, although not for an unlimited amount of time. ...\nIt is the heart what makes them so dangerous and gives them drive. Under the hunger and anger of the Heart of Destruction, the incursions are more potent and reality is breaking. ...\nTo stop them from devouring reality, the destruction has to be stopped by {destroying} its heart."] = "The destruction that comes with that thing shares the intention of its progenitor to become more real. Therefore, the destruction has gathered into something that - under other circumstances - would be called avatars. ...\nSome destructive and unnatural forces have condensed themselves to highly dangerous constructs that are gnawing at existence itself. Even now their workings can be felt. ...\nAll over the world incursions like this one here can be encountered. They eat away matter, sanity and order - sucking them into nothingness. Behind these incursions, on the brink to nothingness and annihilation, the non-avatars are lurking. ...\nTheir most potent incarnation has been named Heart of Destruction. But there are others - less potent but disruptive on their own. The heart gives those mindless forces unity and purpose. ...\nIt unites them to the threat that they are. Every incursion itself it only restricted to time and space. Reality will eventually heal and recover, although not for an unlimited amount of time. ...\nIt is the heart what makes them so dangerous and gives them drive. Under the hunger and anger of the Heart of Destruction, the incursions are more potent and reality is breaking. ...\nTo stop them from devouring reality, the destruction has to be stopped by {destroying} its heart.",
	["You will notice many incursions throughout the world. They are accompanied by waves of uncreated beings. By killing them, you weaken the incursion which they are part of. Yet, you will get tainted with their disruptive nature. ...\nA person of strong will might resist the taint and even use it to enter the incursions. Beyond them awaits only a thin layer of ... let's call it yet undigested reality in which the non-avatars nest. ...\nEach incursion, aside from similarities, hosts another of those things. All of them are kin to their source, the {Heart of Destruction}. ...\nIf you manage to destroy one of them, a part of its ungodly charge will be passed upon you. Again you might be able to use that to your advantage, though. ...\nIf you manage to slay the different masters of the greater incursions, you'll eventually blend in with their disruptive nature and might venture further into the incursions and challenge the heart itself. ...\nBut even getting to the masters of the incursions will not be an easy task. Each of them will be guarded by some kind of instinctive reaction that will have to be dealt with before you might advance to the incursion's master."] = "You will notice many incursions throughout the world. They are accompanied by waves of uncreated beings. By killing them, you weaken the incursion which they are part of. Yet, you will get tainted with their disruptive nature. ...\nA person of strong will might resist the taint and even use it to enter the incursions. Beyond them awaits only a thin layer of ... let's call it yet undigested reality in which the non-avatars nest. ...\nEach incursion, aside from similarities, hosts another of those things. All of them are kin to their source, the {Heart of Destruction}. ...\nIf you manage to destroy one of them, a part of its ungodly charge will be passed upon you. Again you might be able to use that to your advantage, though. ...\nIf you manage to slay the different masters of the greater incursions, you'll eventually blend in with their disruptive nature and might venture further into the incursions and challenge the heart itself. ...\nBut even getting to the masters of the incursions will not be an easy task. Each of them will be guarded by some kind of instinctive reaction that will have to be dealt with before you might advance to the incursion's master.",
	["One can only call this thing the world devourer. It eats away reality and feeds on the world itself. ...\nThe thing is as unfathomable as the thing that spawned it. It is doubtful that its creation was an act of will. Regardless it is the utmost threat that we face right now. ...\nAs long as the world devourer exists, the healing powers of reality will not suffice to contain the damage caused by the incursions. Likely sooner than later reality and its laws will begin to break. ...\nThe thing itself is nothing anyone has ever encountered yet. Its existence alone is an anathema to creation and is hurting the world. ...\nIt's something between existence and destruction, between force and creature. Its whole existence is a paradox itself and harmful to the world. We have no idea how it works or what are its weaknesses. ...\nIt will take a keen mind to figure this out and a {strong} heart and soul to endure the perils on the way."] = "One can only call this thing the world devourer. It eats away reality and feeds on the world itself. ...\nThe thing is as unfathomable as the thing that spawned it. It is doubtful that its creation was an act of will. Regardless it is the utmost threat that we face right now. ...\nAs long as the world devourer exists, the healing powers of reality will not suffice to contain the damage caused by the incursions. Likely sooner than later reality and its laws will begin to break. ...\nThe thing itself is nothing anyone has ever encountered yet. Its existence alone is an anathema to creation and is hurting the world. ...\nIt's something between existence and destruction, between force and creature. Its whole existence is a paradox itself and harmful to the world. We have no idea how it works or what are its weaknesses. ...\nIt will take a keen mind to figure this out and a {strong} heart and soul to endure the perils on the way.",
	["Your future is still not written because the forces of uncreation are still tearing on reality. For the sake of your world, please hurry! \n"] = "Your future is still not written because the forces of uncreation are still tearing on reality. For the sake of your world, please hurry! \n",
}
