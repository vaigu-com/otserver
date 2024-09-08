return {
	["WELCOME_TO_SERVER"] = function()
		return T("Welcome to :serverName:!", { serverName = configManager.getString(configKeys.SERVER_NAME) })
	end,
	["YOUR_LAST_VISIT"] = function(context)
		return T("Your last login was on :lastLogin:.", { lastLogin = os.date("%d-%m-%Y %X", context.player:getLastLoginSaved()) })
	end,
	["Please choose your outfit."] = "Please choose your outfit.",
	["Premade action bars for every vocation are available in options."] = "Premade action bars for every vocation are available in options.",
	["LIST_AVAILABLE_COMMANDS"] = "List of available commands: !serverinfo - !language - !faq. Rest of commands is available under !commands",
	["You can report ingame bugs using ctrl+z."] = "You can report ingame bugs using ctrl+z.",
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_LOCKOUT] = function(context)
		return T("You or a member in your team still has a cooldown for the :encounterName: encounter.", { encounterName = context.encounterName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_LOCKOUT] = function(context)
		return T("You still have to wait :timeLeftString: to enter the :encounterName: encounter.", { encounterName = context.encounterName, timeLeftString = context.timeLeftString })
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_HAS_NO_ACCESS] = function(context)
		return T("You or a member in your team does not have the required access to enter :encounterName: encounter.", { encounterName = context.encounterName })
	end,
	[ENCOUNTER_ERROR_CODES.YOU_HAVE_NO_ACCESS] = function(context)
		return T("You dont have access to :encounterName: encounter.", { encounterName = context.encounterName })
	end,
	[ENCOUNTER_ERROR_CODES.ONLY_PLAYERS] = function()
		return "Only players can participate in the fight!"
	end,
	[ENCOUNTER_ERROR_CODES.SOMEONE_INSIDE_ALREADY] = function(context)
		return T("There's someone fighting :encounterName: already.", { encounterName = context.encounterName })
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
	["INCOMPREHENSIBLE"] = function()
		local stringPool = {
			"You have to speak more clearly.",
			"I dont get it.",
			"Can you repeat, please.",
			"I dont get what you're talking about.",
			"I didn't catch that.",
			"What?!",
		}
		local finalString = stringPool[math.random(1, #stringPool)]
		return finalString
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
	["MINIMUM_LEVEL_TO_TRAVEL"] = function(context)
		return T("You need :minLevel: level to travel there", { minLevel = context.minLevel })
	end,
	["TravelHelpDialogue"] = function(context)
		return T("You can travel between cities if you have enough money. Also, you cannot be a suspect in any illegal activity. Current cost is :transportCost:. You currently have :money: gold.", {
			transportCost = TRANSPORT_COST,
			money = context.player:getMoney(),
		})
	end,
	["ShipWindowTitle"] = "Ship",
	["ShipWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValue(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("You have :freeSails: free sail admits\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Where would you like to sail?"
		return finalString
	end,
	["CarpetWindowTitle"] = "Carpet",
	["CarpetWindowMessage"] = function(context)
		local finalString = ""
		local freeTravels = context.player:getStorageValue(Storage.FreeTravels)
		if freeTravels > 0 then
			finalString = finalString .. T("You have :freeFlight: free flght admits\n", { freeTravels = freeTravels })
		end
		finalString = finalString .. "Where would you like to fly?"
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
	["West of my hut, the lizards have a field of a strange plant. I don't know exactly what it is, but I know they make a potent vodka out of it\nOnce one of them blew a bottle, I drank 2 sips and slept for the next 2 days... I'm getting ready to go to my friend Konmuld, and if he doesn't drink, he's not very talkative.\nPlease steal from them some of this liquor. Hold this bottle, you can fill it."] = "West of my hut, the lizards have a field of a strange plant. I don't know exactly what it is, but I know they make a potent vodka out of it\nOnce one of them blew a bottle, I drank 2 sips and slept for the next 2 days... I'm getting ready to go to my friend Konmuld, and if he doesn't drink, he's not very talkative.\nPlease steal from them some of this liquor. Hold this bottle, you can fill it.",
	["I will tell you everything I remember, but I need some help, are you up for it?"] = "I will tell you everything I remember, but I need some help, are you up for it?",
	["Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Yalahar.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you."] = "Uuuu, I can smell it through the cork, you did great. I'll tell you how it went.\nI was an apprentice to the great alchemist, the one who, as you probably know, blew up the whole island, but do not trust those who say that he was mad.\nIn fact, he was constructing a mechanism that would enclose the whole island in a force field and force the rulers to surrender. He wanted everyone to live in harmony.\nUnfortunately, the government found out thanks to spies, and forced him to change his plans. Initially it was supposed to be 2 small bombs, to destroy the strongest districts.\nBut it was not enough for the rulers, and they wanted a bigger bomb, which finally destroyed the whole island. Now there are only ruins left, but I still believe that one day we will rebuild Yalahar.\nIn addition, at the alchemist I dealt with the creation of various decoctions for everyday problems, if you have a problem and need any effective remedy, I will be here for you.",
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
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to The Mirko City or sell some of those {rods}.. If you are interested in some {stories}, ask me for one."] = "My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to The Mirko City or sell some of those {rods}.. If you are interested in some {stories}, ask me for one.",
	["My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to elf court or sell some of those {rods}.. If you are interested in some {stories}, ask me for one."] = "My father is a fishing fanatic. Half of our home filled with fishing rods. Recently he let me use his boat, I can {sail} you to elf court or sell some of those {rods}.. If you are interested in some {stories}, ask me for one.",
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
	["Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day."] = "Christopher had this very brilliant idea to capture a woman from the newly discovered island and make her his wife. The consequences of this mistake can be seen in his house till this day.",
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
	["Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is in the Misguided Thief village south of Knurow."] = "Well, the stone cromlech is on top of the mountain neat Mirko Town's north gate. The second cromlech is in the Misguided Thief village south of Knurow.",
	["WILDCARD_COST_QUESTION"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		return T("Wildcard will cost you :preyWildcardPrice: gold. You can get better bonuses in your prey creatures with it. How many wildcards would you like to buy?", { preyWildcardPrice = preyWildcardPrice })
	end,
	["WILDCARD_CHOSEN_COUNT"] = function(context)
		local preyWildcardPrice = context.player:GetWildcardPrice()
		local orderedWildcardsCount = context.npcHandler.topic[context.player:getId()] - 100
		local orderedCardsPrice = preyWildcardPrice * orderedWildcardsCount
		return T("Are you sure, that you want to buy :orderedWildcardsCount: wildcard? It will cost you :orderedCardsPrice: gold.", {
			orderedWildcardsCount = orderedWildcardsCount,
			orderedCardsPrice = orderedCardsPrice,
		})
	end,
	["Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!"] = "Hello |PLAYERNAME|. My offer mainly contains supplies for mages. Im also selling {wildcard}, which will increase your prey powers!",
	["Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer."] = "Hi, Im buying all kinds of creature products. Ask me for {trade} to browse through my offer.",
	["You need to tell me the number of wildcards you'd like to buy."] = "You need to tell me the number of wildcards you'd like to buy.",
	["Here are your wildcards!"] = "Here are your wildcards!",
	["Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}."] = "Hello, hello! Hundred percent recommended seller here. Take a look at my offer, say {trade}.",
	["Wood, wood delivery. It was supposed to arrive two days ago. Probably another riots in Knurow that blocked the road."] = "Wood, wood delivery. It was supposed to arrive two days ago. Probably another riots in Knurow that blocked the road.",
	["There is one problem with which you could help me. Some furnitures started to disappear from my storages.\nI know for sure that it wasnt Narro's mafia, because they are using wood for different purposes, they are not interested in my furnitures.\nDo you want to find for me who is responsible for stealing my furnitures?"] = "There is one problem with which you could help me. Some furnitures started to disappear from my storages.\nI know for sure that it wasnt Waski's mafia, because they are using wood for different purposes, they are not interested in my furnitures.\nDo you want to find for me who is responsible for stealing my furnitures?",
	["Thanks that you agreed to {help}. I hope that its not another mafia."] = "Thanks that you agreed to {help}. I hope that its not another mafia.",
	["Maybe Gypsy knows something about furnitures thief, people like him sticks together..."] = "Maybe Gypsy knows something about furnitures thief, people like him sticks together...",
	["Thank you for finding perpetrator. Your reward is upstairs, here is the key to the door.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds"] = "Thank you for finding perpetrator. Your reward is upstairs, here is the key to the door.\nMeanwhile I will call to two almighty Mirks, so they will bring my stolen stuff from those undergrounds",
	["I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}."] = "I checked the list of stolen items, I saw that he had a ball that Gypsy was looking for. Wait, its not {all}.",
	["Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher please and tell him about it. Also ask him if he knows something about that thief."] = "Recent entries on the list suggest that our thief was stealing food and supplies from the orcs of the south.\nGo to Commissioner Fisher please and tell him about it. Also ask him if he knows something about that thief.",
	["Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}"] = "Hello |PLAYERNAME|. As a jeweler store owner i can either craft some valuable gifts or buy your unwated ornaments. Just ask me for {trade}",
	["Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested."] = "Hello. My offer constists of tools that any cave explorer has to have to get around. Ask me for {trade} if you are interested.",
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
	["Are you sure if it works? Thanks for the memory, though. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it."] = "Are you sure if it works? Thanks for the memory, though. Keep this little gift from me. This {flask} was given te me by Fstab, but in fact i don't have any use for it.",
	["It's alright, I don't need any help."] = "It's alright, I don't need any help.",
	["Rats are gone, thanks again."] = "Rats are gone, thanks again.",
	["I heard that it brings you luck, if you catch one of fireflies from magical tree into that."] = "I heard that it brings you luck, if you catch one of fireflies from magical tree into that.",
	["Hello, I {trade} with fishing equipment, take a look at my offer if you want."] = "Hello, I {trade} with fishing equipment, take a look at my offer if you want.",
	["Hello hello, |PLAYERNAME| I am Lebowski and I sell some.. protection thing.. Ask about {trade} if you want to see!"] = "Hello hello, |PLAYERNAME| I am Lebowski and I sell some.. protection thing.. Ask about {trade} if you want to see!",
}
