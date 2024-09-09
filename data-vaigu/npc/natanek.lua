-- ToDo: convert trySomething into canSomething (condition) an doSomething (action)

local internalNpcName = "Father Natanek"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 432,
	lookHead = 0,
	lookBody = 95,
	lookLegs = 20,
	lookFeet = 38,
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Zaczal diabel jak wsciekniety atakowac, wiedz ze cos sie dzieje...",
	},
	{ text = "Lepiej dac na tace i kupic te blessy, licho nie spi..." },
	{
		text = "Harry Potter, Gwiezdne Wojny, akupunktura,astrologia, bioenergoterapia...",
	},
	{ text = "Horoskopy, Magia, Numerologia, Okultyzm, Tarot, Techno..." },
}

local function markMap(player)
	local configMarks = {
		{
			mark = "tools",
			position = Position(5862, 1559, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{
			mark = "tools",
			position = Position(6692, 1340, 7),
			markId = MAPMARK_SHOVEL,
			description = "Sklep z narzedziami",
		},
		{
			mark = "fluids",
			position = Position(5872, 1557, 7),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{
			mark = "fluids",
			position = Position(6712, 1319, 7),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{
			mark = "fluids",
			position = Position(7053, 768, 5),
			markId = MAPMARK_STAR,
			description = "Zaopatrzenie magiczne",
		},
		{
			mark = "depo",
			position = Position(5890, 1557, 7),
			markId = MAPMARK_LOCK,
			description = "Depo",
		},
		{
			mark = "depo",
			position = Position(6707, 1326, 7),
			markId = MAPMARK_LOCK,
			description = "Depo",
		},
		{
			mark = "depo",
			position = Position(7049, 772, 6),
			markId = MAPMARK_LOCK,
			description = "Depo",
		},
		{
			mark = "post",
			position = Position(5891, 1563, 7),
			markId = MAPMARK_FLAG,
			description = "Poczta",
		},
		{
			mark = "post",
			position = Position(6713, 1325, 7),
			markId = MAPMARK_FLAG,
			description = "Poczta",
		},
		{
			mark = "arm",
			position = Position(5854, 1560, 7),
			markId = MAPMARK_SWORD,
			description = "Skup uzbrojenia",
		},
		{
			mark = "arm",
			position = Position(6700, 1318, 7),
			markId = MAPMARK_SWORD,
			description = "Skup uzbrojenia",
		},
		{
			mark = "arm",
			position = Position(7053, 776, 5),
			markId = MAPMARK_SWORD,
			description = "Skup uzbrojenia",
		},
		{
			mark = "jewelry",
			position = Position(5850, 1574, 7),
			markId = MAPMARK_KISS,
			description = "Jubiler",
		},
		{
			mark = "creatureproducts",
			position = Position(5840, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Sprzedaz creatureproducts",
		},
		{
			mark = "creatureproducts",
			position = Position(7039, 788, 6),
			markId = MAPMARK_BAG,
			description = "Sprzedaz creatureproducts",
		},
		{
			mark = "paladinshop",
			position = Position(5864, 1575, 7),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{
			mark = "paladinshop",
			position = Position(6727, 1344, 6),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{
			mark = "paladinshop",
			position = Position(6996, 767, 6),
			markId = MAPMARK_BAG,
			description = "Zaopatrzenie dla lucznikow",
		},
		{
			mark = "bank",
			position = Position(5893, 1558, 9),
			markId = MAPMARK_DOLLAR,
			description = "Bank",
		},
		{
			mark = "shophouse",
			position = Position(5840, 1560, 7),
			markId = MAPMARK_TICK,
			description = "Wyposazenie domu",
		},
		{
			mark = "food",
			position = Position(5874, 1574, 7),
			markId = MAPMARK_TICK,
			description = "Sklep z jedzeniem",
		},
		{
			mark = "food",
			position = Position(6726, 1345, 7),
			markId = MAPMARK_TICK,
			description = "Prince kebab",
		},
		{
			mark = "food",
			position = Position(7006, 765, 6),
			markId = MAPMARK_TICK,
			description = "Sklep z jedzeniem",
		},
		{
			mark = "komisarz",
			position = Position(5849, 1609, 7),
			markId = MAPMARK_TICK,
			description = "Komisarz Ryba",
		},
		{
			mark = "statue",
			position = Position(5824, 1514, 7),
			markId = MAPMARK_SWORD,
			description = "Trening offline",
		},
		{
			mark = "temple",
			position = Position(5836, 1502, 7),
			markId = MAPMARK_TICK,
			description = "Swiatynia",
		},
		{
			mark = "temple",
			position = Position(6726, 1248, 4),
			markId = MAPMARK_TICK,
			description = "Swiatynia",
		},
		{
			mark = "temple",
			position = Position(7034, 734, 3),
			markId = MAPMARK_TICK,
			description = "Swiatynia",
		},
		{
			mark = "taski",
			position = Position(5892, 1590, 7),
			markId = MAPMARK_TICK,
			description = "Tropiciel Wielki",
		},
		{
			mark = "burmistrz",
			position = Position(5842, 1548, 7),
			markId = MAPMARK_TICK,
			description = "Burmistrz",
		},
	}

	for i = 1, #configMarks do
		local mark = configMarks[i]
		player:addMapMark(mark.position, mark.markId, mark.description)
	end
end

local function getEngageError(context)
	local player = context.player
	local playerId = getPlayerGUIDByName(player:getName())
	local candidateName = context.msg
	local candidateId = getPlayerGUIDByName(candidateName)
	local candidateSpouseId = getPlayerSpouse(candidateId)

	if candidateId == -1 then
		return "I dont think thats the correct name."
	end

	if getPlayerMarriageStatus(playerId) == MARRIED_STATUS then
		return "You are married already. Do you want to get a {divorce} now?"
	end

	if getPlayerMarriageStatus(playerId) == PROPOSED_STATUS then
		return "NO_PROPOSAL_RESPONSE"
	end

	if candidateId ~= -1 then
		if getPlayerMarriageStatus(candidateId) == MARRIED_STATUS then
			return "That person is already married"
		end
		if getPlayerMarriageStatus(candidateId) == PROPOSED_STATUS and candidateSpouseId ~= playerId then
			return "That person is someone else's fiance/fiancee."
		end
		if getPlayerMarriageStatus(candidateId) == PROPACCEPT_STATUS then
			return "That person is someone else's fiance/fiancee."
		end

		if candidateId == playerId then
			return "Thats not funny.."
		end
	end

	if player:getItemCount(ITEM_WEDDING_RING) == 0 or player:getItemCount(9586) == 0 then
		return "You need to get {wedding ring} and {wedding outfit box} first. Then we can continue."
	end
end

local function performProaccept(players)
	for _, player in pairs(players) do
		if player:getItemCount(ITEM_WEDDING_RING) == 0 or player:getItemCount(9586) == 0 then
			return false
		end
	end

	for _, player in pairs(players) do
		player:RemoveItems({
			{ id = 9586, count = 1 },
			{ id = ITEM_WEDDING_RING, count = 1 },
		})
		player:addOutfit(329) -- Wife
		player:addOutfit(328) -- Husb
	end
	return true
end

local function tryEngage(context)
	local player = context.player
	local playerId = player:getGuid()
	local errorMessage = getEngageError(context)
	if not errorMessage then
		local translatedMessage = player:Localizer(nil):Get(errorMessage)
		addEvent(function()
			context.npcHandler:say(translatedMessage, context.npc, player)
		end, 50)
		return false
	end
	local candidateName = context.msg
	local candidateId = getPlayerGUIDByName(candidateName)
	local candidateSpouseId = getPlayerSpouse(candidateId)
	if candidateSpouseId ~= playerId then
		setPlayerMarriageStatus(player:getGuid(), PROPOSED_STATUS)
		setPlayerSpouse(player:getGuid(), candidateId)
		local translatedMessage = player:Localizer(nil):Get("INITIATE_PROPOSAL")
		addEvent(function()
			context.npcHandler:say(translatedMessage, context.npc, player)
		end, 50)

		return false
	end

	local candidate = Player(candidateId)
	if not performProaccept({ candidate, player }) then
		local translatedMessage = player:Localizer(nil):Get("At least one of you doens't have their wedding ring or wedding outfit box.")
		addEvent(function()
			context.npcHandler:say(translatedMessage, context.npc, player)
		end, 50)
		return false
	end
	setPlayerMarriageStatus(playerId, PROPACCEPT_STATUS)
	setPlayerMarriageStatus(candidateId, PROPACCEPT_STATUS)
	setPlayerSpouse(player:getGuid(), candidateId)
	return true
end

local function tryConfirmWedding(context)
	local player = context.player
	local playerStatus = getPlayerMarriageStatus(player:getGuid())
	if playerStatus ~= PROPACCEPT_STATUS then
		return false
	end

	local candidateId = getPlayerSpouse(player:getGuid())
	local candidate = Player(candidateId)
	setPlayerMarriageStatus(player:getGuid(), MARRIED_STATUS)
	setPlayerMarriageStatus(candidateId, MARRIED_STATUS)
	setPlayerSpouse(player:getGuid(), candidateId)
	setPlayerSpouse(candidateId, player:getGuid())

	local item1 = player:addItem(ITEM_ENGRAVED_WEDDING_RING, 1)
	local item2 = candidate:addItem(ITEM_ENGRAVED_WEDDING_RING, 1)
	local trophy1 = player:addItem(7370, 1)
	local trophy2 = candidate:addItem(7370, 1)

	trophy1:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:Localizer(nil):Get("TROPHY_DESC"))
	trophy2:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, candidate:Localizer(nil):Get("TROPHY_DESC"))

	item1:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, player:Localizer(nil):Get("RING_DESC"))
	item2:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, candidate:Localizer(nil):Get("RING_DESC"))

	return true
end

local config = {
	[Storage.AssassinsCreedSkurwoala.Questline] = {
		[1] = {
			[{ "mission", "duch", "Ghasstly Princess", "ghasstly princess" }] = {
				text = "If what you're saying is true - and I have no reason to doubt the words of my faithful |PLAYERNAME| - go to {Oldrak}. He will surely know how to help you.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Mission01] = 2,
					[Storage.AssassinsCreedSkurwoala.Questline] = 2,
				},
			},
		},
		[{ min = 2 }] = {
			[{ "oldrak" }] = {
				text = "Oldrak has currently gone to the steppes. He is teaching the villagers there.",
			},
		},
		[17] = {
			[{ "krol krypty", "crypt king", "king of the crypt", "king", "krol" }] = {
				text = "I will be the harbinger of bad news. The Crypt King has managed to regain a portion of power by consuming the essence of a defeated angel. The Crypt King may attempt to regain strength in the Down's Labyrinth. To prevent this, you will need the assistance of Gandalf.",
				nextState = {
					[Storage.AssassinsCreedSkurwoala.Questline] = 18,
					[Storage.AssassinsCreedSkurwoala.Mission05] = 5,
				},
			},
		},
	},
	[Storage.SultanPrime.Questline] = {
		[{ "mission", "misja", "naszyjnik", "amulet", "necklace" }] = {
			text = "So you know what happened 50 years ago. Yes, it was me who threw John Paul's socks at the Undying Crypt King. I'd prefer this information to stay between us. Let's agree that you'll take what I received from the faithful today, and in exchange, you'll forget what Sultan showed you.",
			nextTopic = 10,
		},
		[{ "dosatlem", "donated" }] = {
			requiredtopic = { min = 10, max = 10 },
			nextTopic = 0,
			text = "Here, this is your reward.",
			nextState = {
				[Storage.SultanPrime.Questline] = 14,
				[Storage.SultanPrime.Mission03] = 6,
			},
			rewards = { { id = 3043, count = 2 } },
			expReward = 800000,
		},
	},
	[LOCALIZER_UNIVERSAL] = {
		[GREET] = "Hello, you need some help? Check {services} that I offer...",
		-- misc
		[{ "pomoc", "uslug", "uslugi", "help", "services" }] = {
			text = "You are in the MirkoTown temple. If you wish, I can {bless} you, {heal}, {promote} and {mark} most important civilians of this city on your map.\nYou can also get a {marriage} here.",
		},
		[{ "mark", "map", "zaznacz", "zaznaczyc" }] = {
			text = "I marked few points of interest on your map.",
			specialActionsOnSuccess = {
				{ action = markMap },
			},
		},
		[{
			"bless",
			"blessy",
			"blessing",
			"blessings",
			"blogoslawienstwo",
			"blogoslawienstwa",
			"blogoslaw",
			"poblogoslawic",
			"poblogoslaw",
		}] = { text = "BLESS_PRICE_TEXT", nextTopic = 1 },
		[{ "yes", "tak" }] = {
			text = "Thank you.",
			requiredTopic = { min = 1, max = 1 },
			nextTopic = 0,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.canBuyBless,
					requiredOutcome = true,
					textNoRequiredCondition = "BLESS_INSUFFICIENT_MONEY",
				},
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasBlessings,
					count = ALL_BLESSINGS_COUNT,
					requiredOutcome = false,
					textNoRequiredCondition = "You have been blessed already.",
				},
			},
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.grantBless,
					min = 2,
					max = 6,
				},
			},
		},
		[{ "promotion", "promocja", "promote", "awans", "awansowac" }] = {
			text = "PROMOTION_TEXT",
			nextTopic = 2,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.isPromoted,
					requiredOutcome = true,
					textNoRequiredCondition = "You are already promoted!",
				},
			},
		},
		[{ "yes" }] = {
			text = "Here is your promotion, good luck!",
			requiredTopic = { min = 2, max = 2 },
			nextTopic = 0,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMoney,
					requiredOutcome = true,
					textNoRequiredCondition = "PROMOTION_INSUFFICIENT_MONEY",
					price = PROMOTION_PRICE,
				},
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.playerHasLevel,
					requiredOutcome = true,
					textNoRequiredCondition = "You need at least 20 level to get promoted!",
					minLevel = PROMOTION_LEVEL,
				},
			},
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_UNIVERSAL.buyPromotion },
			},
		},
		[{ "heal", "uleczyc" }] = {
			text = "You have been healed.",
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.clearConditions,
				},
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.heal,
				},
			},
		},
		-- marriage
		[{
			"stroj",
			"pierscien",
			"pierscionek",
			"wedding ring",
			"wedding outfit box",
		}] = {
			text = "You can buy wedding ring from local jewellery store, and wedding outfit box from Michael Dumplings clothing store.",
		},
		[{ "marriage", "malzenstwo", "malzenstwa" }] = {
			text = "Just ask me to get a {wedding} ceremony!",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMarriedStatus,
					requiredOutcome = false,
					textNoRequiredCondition = "My chronicles suggest that you are married already. Do you want to get a {divorce} now?",
				},
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasProposedStatus,
					requiredOutcome = false,
					textNoRequiredCondition = "NO_PROPOSAL_RESPONSE",
				},
			},
		},
		[{ "wedding", "slub" }] = {
			text = "Thats great! So you want to {marry} someone?",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMarriedStatus,
					requiredOutcome = false,
					textNoRequiredCondition = "My chronicles suggest that you are married already. Do you want to get a {divorce} now?",
				},
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasProposedStatus,
					requiredOutcome = false,
					textNoRequiredCondition = "NO_PROPOSAL_RESPONSE",
				},
			},
		},
		[{ "marry", "poslubic" }] = {
			text = "Would you like to get married? Make sure you have a {wedding ring} and the {wedding outfit box} with you.",
			nextTopic = 3,
		},
		[{ "no", "nie" }] = {
			requiredTopic = { min = 3, max = 3 },
			nextTopic = 0,
			text = "That's fine.",
		},
		[{ "yes", "tak" }] = {
			requiredTopic = { min = 3, max = 3 },
			nextTopic = 4,
			text = "And who would you like to marry?",
		},
		[{ ANY_MESSAGE }] = {
			requiredTopic = { min = 4, max = 4 },
			text = "Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}.",
			specialConditions = {
				{
					condition = tryEngage,
					requiredOutcome = true,
					textNoRequiredCondition = "",
				},
			},
		},
		[{ "celebration", "ceremonia" }] = {
			text = "Is your soulmate and friends here with you for the celebration?",
			nextTopic = 5,
		},
		[{ "no", "nie" }] = {
			requiredTopic = { min = 5, max = 5 },
			nextTopic = 5,
			text = "Then go bring them here!",
		},
		[{ "yes" }] = {
			requiredTopic = { min = 5, max = 5 },
			nextTopic = 6,
			text = "Good, let's {begin} then!",
			specialConditions = {
				{
					condition = tryConfirmWedding,
					requiredOutcome = true,
					textNoRequiredCondition = "Your partner did not accept your proposal yet.",
				},
			},
		},
		[{ "begin", "rozpocznijmy" }] = {
			text = "",
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.npcSay,
					talkType = TALKTYPE_SAY,
					text = "MARRIAGE_TALKTYPE_SAY_TEXT",
				},
			},
		},
		-- cancel proposal
		[{ "cancel", "anuluj", "anulowac" }] = {
			nextTopic = 7,
			text = "Are sure you want to cancel your proposal?",
		},
		[{ "yes", "tak" }] = {
			text = "It's cancelled.",
			requiredTopic = { min = 7, max = 7 },
			nextTopic = 0,
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_UNIVERSAL.cancelMarriage },
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasProposedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not proposed to anyone.",
				},
			},
		},
		[{ "no", "nie" }] = {
			text = "I won't be doing anything about that then.",
			requiredTopic = { min = 7, max = 7 },
			nextTopic = 0,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasProposedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not proposed to anyone.",
				},
			},
		},
		-- cancel marriage
		[{ "divorce", "rozwod" }] = { nextTopic = 8, text = "CONFIRM_DIVORCE" },
		[{ "yes", "tak" }] = {
			text = "Well. I hope you wont regret it.",
			requiredTopic = { min = 8, max = 8 },
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_UNIVERSAL.divorce },
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMarriedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not married to anyone.",
				},
			},
		},
		[{ "no", "nie" }] = {
			text = "I'm very happy with your decision.",
			requiredTopic = { min = 8, max = 8 },
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMarriedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not married to anyone.",
				},
			},
		},
	},
}
local function greetCallback(npc, creature, type, message)
	InitializeResponses(creature, config, npcHandler, npc)
	return false
end

local function creatureSayCallback(npc, creature, type, msg)
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end
	return TryResolveDialog(creature, msg, config, npcHandler, npc)
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
