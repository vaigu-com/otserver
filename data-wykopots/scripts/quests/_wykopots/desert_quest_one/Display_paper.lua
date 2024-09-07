local vectorToMessage = {
	["90, 66, -1"] = "I just discovered a pattern that will help me identify correct hints. Phantasms can use our human language, but they aren't fluent at it. Phantasms' hints can be identified by many linguistic errors  more or less obvious. Therefore if you encounter a message with a lot of errors, you can be sure it was forged by a phantasm. However, if you find a message with no mistakes at all, you can't be sure about its genuinity. It only works one way. \n\n~Page 57 of Germi Journal.",
	["71, 54, -1"] = "I tested the information left by Fifonz Kuciapa with my dog companion's assistance, and thanks to it we made it out alive with no problem at all. \n\n~Patrycja Suchodolska",
	["117, 103, -2"] = "I measured every array for every tile until I found the correct combination. The correct sign was the one located at the place second from the bottom. \n\n~Page 89 from Eustachy Wiertara journal",
	["96, 84, -1"] = "I analyzed a few things and I conclude that Patrycja Suchodolska's notes are trustworthy. ~Miroslaw of Ankhar",
	["54, 72, 0"] = "Main labyrinth with rewards. \n\n~Bogdan Boner",
	["52, 71, 0"] = "This hole leads to four sections for each class. \n\n~Sierotka Marysia.",
	["58, 75, 0"] = "One person has to watch over the one  going down this hole. \n\n~Patrycja Suchodolska",
	["51, 75, 0"] = "Way intended only for a druid. \n\n~Jan Pawel Drugi",
	["58, 72, 0"] = "The only people who can go there are those of the Intelligentsia group and read Olga Tokarczuk. \n\n~Anna Niewypchnieta",
	["61, 73, 0"] = "Way for all four classes. Stay close together. \n\n~Bogdan Boner",
	["55, 78, 0"] = "Sections for every individual class. \n\n~Anna Niewypchana",
	["47, 53, 1"] = "Milked a bull already?",
	["44, 50, 1"] = "Exani hur up x2 near stained glass.",
	["39, 66, 1"] = "Message left by Wojciech Szpara is intended to misdirect them from staying alive. \n\n~Sierotka Marysia",
	["25, 70, 2"] = "From my map i derived that nearby tiles will let through only people of certain professions. Past those, we found a portal leading to the room with a puzzle. If you pass the puzzle, you will be further split. At the end you will find yourself on an island with a lever. \n\n PS lever deactivates the magic wall in the main room of this dungeon, but only for about a minute. \n\n~page 65 from Germi journal",
	["34, 74, 2"] = "Upper doors is barred. Pleased use the door on the south. \n\n~Edward Tatarata",
	["55, 81, 1"] = "This teleport leeds back to the room above. \n\n~Bogdan Boner",
	["59, 81, 1"] = "This teleport leads back to room above. \n\n~Jan Pawel Drugi",
	["57, 83, 1"] = "You can have use this teleport to be escaped from the caves. \n\n~Wojciech Szpara",
	["57, 76, 1"] = "Turn out that Messages left by Sierotka Marysia are correct. \n\n~Miroslaw of Ankhar",
	["51, 109, -1"] = "In next room, for each portal not locatered next to a dead bush, its the correct portal.",
	["73, 114, 1"] = "Reward room entrence. \n\n~Bogdan Boner",
	["8, -46, -2"] = "Come back when its dimmed here.",
	["-2, 61, 2"] = "Something weird is happening to Cezary. The longer we stay there, the more he grows insane. If it wasn't for this i would probably marry him after we escape these tunnels... Sierotka Baryka Marysia... Anyway, I can still say that hints he is leaving are still intact and helpful. \n\n~Sierotka Marysia",
	["-35, 49, 2"] = "I realized about two facts: I have never heard about anyone making it out alive from this dungeon and there were a lot of hints left in past rooms. I couldn't find anything in this room yet. I should  be on guard. I'm writing this in the ice labyrinth. \n\n~Fifonz kuciapa",
	["-52, 125, 2"] = "##My ears are ringing still.\nI managed to turn off all portals but one.\n##I can't keep my balance, can't walk on my own.\nI think that no sound is coming out of that portal.\n\n##I'm gonna kill that useless loser, she is just slowing us down.\n\nI believe that I was there with someone. Perhaps it just my delusions.",
	["-21, 132, 2"] = "I found even more mysterious portals. There are voices coming from within persuading me to go in. My senses are going crazy. \n\n~Sierotka Marysia",
	["-59, -18, 1"] = "Below I'm gonna present how I came to conclusions on the previous page. On the starting signs (with colored floor) there are tables with numbers 0, 1, 2 and letter x. The letter x means a center position. The numbers mean how many chains are going across a given tile, relative to the x tile. \n\nAs I mentioned on earlier pages, tiles have 0, 1 or 2 chains going over them. Usually, there is only 1 chain going over a tile. \n\nI tried to find a place where the surrounding tiles would have same numbers of chains as on one of the tables on signs.\n\n~Pages 89, 90 of Eustachy Wiertary journal.",
	["-53, -33, 1"] = "I noticed that there is a total of 7 signs in this room, each with different colored tiles. Each sign points to the next sign, which is pointing to another one, ultimately ending on the last sign with white floor. This way someone set 7 different chains of signs. \n\nI also noticed that every chain goes over black marble tiles. However, not every black marble has a chain going across it, and some have up to two chains going across. This knowledge might be essential later.\n\n~Pages 85, 86 of Eustachy Wiertara journal.",
	["-37, -7, 1"] = "Choosing the wrong portal is not going to put you in a safe place.",
	["-25, 54, 0"] = "Here lies an attention whore. She always dreamed of whiteknightning cucks.",
	["-35, 53, 0"] = "Let eight ghosts surround you, take off your sword and cast exori. This will help you pass this room.\n\n~engraved with nails. there is clotted blood in the crevices.",
	["-21, 37, 0"] = "Ghouls ideas are idiotic, and you should rather trust Eustachy Wiertara. \n\n~Miroslaw o Ankhar",
	["-69, 59, 0"] = "To proceed further, you need to move the knight statues, so they are placed on special tiles, facing the Oracle. After that, grab her ass.\n\n~Eustachy Wiertara",
	["-118, -35, -1"] = "Talking from my experience, standing on the plate makes another person able to pass through a magic wall. `\n\n~Germi",
	["-89, -57, 0"] = "Messages left by Janusz Cyc are misleading and malicious. \n\n~Germi",
	["12, 155, 1"] = "This puzzle is meant for four and four adventurers only, each of distinct vocations. Doom upon thee who dares to... \n\n???",
	["-85, 139, 2"] = "Stairs seen near center of the room are dubious. Use those at west side of room. \n\n ~printed with typewriter",
}

local randomReadableItemId = { 21425, 21468, 21424, 22794, 2815, 2819, 639 }

local function getRandomBookId()
	return randomReadableItemId[math.random(1, #randomReadableItemId)]
end

function LoadDesertQuestBooks()
	local desertQuestBookOffsets = {}
	for offset, _ in pairs(vectorToMessage) do
		local parts = {}
		for part in offset:gmatch("([^,]+)") do
			table.insert(parts, part)
		end

		local numbers = {}
		for i = 1, #parts do
			table.insert(numbers, tonumber(parts[i]))
		end

		desertQuestBookOffsets[#desertQuestBookOffsets + 1] = { x = numbers[1], y = numbers[2], z = numbers[3] }
	end

	for _, offset in pairs(desertQuestBookOffsets) do
		local pos = DESERT_QUEST_ONE_ANCHOR:Moved(offset.x, offset.y, offset.z)
		local randomId = getRandomBookId()
		local book = Game.createItem(randomId, 1, pos)
		book:setActionId(Storage.DesertQuestOne.Readable.FloorBooks)
		book:setUniqueId(1000)
	end
end

local book = Action()

function book.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	player:registerEvent("DesertQuestBook_Modal_Window")

	local message = vectorToMessage[toPosition:VectorBetween(DESERT_QUEST_ONE_ANCHOR):ToStringShort()]
	local translatedMessage = player:Localizer(Storage.DesertQuestOne.Questline):Get(message)
	local title = "You read the following."

	local window = ModalWindow(item.actionid, title, translatedMessage)
	window:addButton(101, "Close")
	window:setDefaultEscapeButton(101)
	window:sendToPlayer(player)
	player:unregisterEvent("DesertQuestBook_Modal_Window")
	return true
end

book:aid(Storage.DesertQuestOne.Readable.FloorBooks)
book:register()
