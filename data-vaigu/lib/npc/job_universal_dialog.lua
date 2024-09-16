local topicsWildcard = { sayingWildcardNumber = 1, confirmingNwildcards = 2 }

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

local function canPerformProaccept(players)
	for _, player in pairs(players) do
		if player:getItemCount(ITEM_WEDDING_RING) == 0 or player:getItemCount(9586) == 0 then
			return false
		end
	end
	return true
end

local function performProaccept(players)
	for _, player in pairs(players) do
		player:RemoveItems({
			{ id = 9586, count = 1 },
			{ id = ITEM_WEDDING_RING, count = 1 },
		})
		player:addOutfit(329) -- Wife
		player:addOutfit(328) -- Husb
	end
end

local function engage(context)
	local player = context.player
	local playerId = player:getGuid()
	local candidateName = context.msg
	local candidateId = getPlayerGUIDByName(candidateName)
	local candidate = Player(candidateId)

	performProaccept({ player, candidate })
	setPlayerMarriageStatus(playerId, PROPACCEPT_STATUS)
	setPlayerMarriageStatus(candidateId, PROPACCEPT_STATUS)
	setPlayerSpouse(player:getGuid(), candidateId)
end

local function canEngage(context)
	local player = context.player
	local playerId = player:getGuid()
	local errorMessage = getEngageError(context)
	if errorMessage then
		local translatedMessage = player:Localizer(nil):Get(errorMessage)
		return false, translatedMessage
	end

	local candidateName = context.msg
	local candidateId = getPlayerGUIDByName(candidateName)
	local candidateSpouseId = getPlayerSpouse(candidateId)
	if candidateSpouseId == playerId then
		setPlayerMarriageStatus(player:getGuid(), PROPOSED_STATUS)
		setPlayerSpouse(player:getGuid(), candidateId)
		local translatedMessage = player:Localizer(nil):Get("INITIATE_PROPOSAL")
		return false, translatedMessage
	end

	local candidate = Player(candidateId)
	if not canPerformProaccept({ candidate, player }) then
		local translatedMessage = player:Localizer(nil):Get("At least one of you doens't have their wedding ring or wedding outfit box.")
		return false, translatedMessage
	end

	return true
end

local function confirmWedding(context)
	local player = context.player
	local candidateId = getPlayerSpouse(player:getGuid())
	local candidate = Player(candidateId)
	setPlayerMarriageStatus(player:getGuid(), MARRIED_STATUS)
	setPlayerMarriageStatus(candidateId, MARRIED_STATUS)
	setPlayerSpouse(player:getGuid(), candidateId)
	setPlayerSpouse(candidateId, player:getGuid())

	player:AddCustomItem({
		id = 7370,
		ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(nil):Get("MARRIAGE_TROPHY_DESC"),
	})
	candidate:AddCustomItem({
		id = 7370,
		ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(nil):Get("MARRIAGE_TROPHY_DESC"),
	})

	player:AddCustomItem({
		id = ITEM_ENGRAVED_WEDDING_RING,
		ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(nil):Get("MARRIAGE_MARRIAGE_RING_DESC"),
	})
	candidate:AddCustomItem({
		id = ITEM_ENGRAVED_WEDDING_RING,
		ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(nil):Get("MARRIAGE_MARRIAGE_RING_DESC"),
	})
end

local function canConfirmWedding(context)
	local player = context.player
	local playerStatus = getPlayerMarriageStatus(player:getGuid())
	if playerStatus ~= PROPACCEPT_STATUS then
		return false
	end
	return true
end

NPC_UNIVERSAL_DIALOGS = {
	[JOB_SOULORB] = {
		[{ "soul orb", "soul orbs", "soul" }] = {
			text = "I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?",
			nextTopic = JOB_TOPICS.confirmExchangeSoulorbToInfernalbolt,
		},
		[{ "yes", "tak" }] = {
			text = "You're welcome! Use them wisely.",
			requiredTopic = JOB_TOPICS.confirmExchangeSoulorbToInfernalbolt,
			requiredItems = { { id = 5944, take = TAKE_ALL_AVAILABLE } },
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_SOULORB.soulOrbToInfernalBolt },
			},
			textNoRequiredItems = "I can see you don't have them! I can only craft infernal bolts from {soul orb}.",
		},
	},
	[JOB_WILDCARD] = {
		[{ "wildcard", "card", "prey wildcard", "prey", "karta" }] = {
			text = "WILDCARD_COST_QUESTION",
			nextTopic = topicsWildcard.sayingWildcardNumber,
		},
		[{ ANY_MESSAGE }] = {
			text = "WILDCARD_CHOSEN_COUNT",
			requiredTopic = topicsWildcard.sayingWildcardNumber,
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_UNIVERSAL.SetCustomDialogDataAsNumber, key = "orderedCards" },
			},
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.saidPositiveInteger,
					requiredOutcome = true,
					textNoRequiredCondition = "You need to tell me the number of wildcards you'd like to buy.",
				},
			},
			nextTopic = topicsWildcard.confirmingNwildcards,
		},
		[{ "yes", "tak" }] = {
			text = "Here are your wildcards!",
			requiredTopic = topicsWildcard.confirmingNwildcards,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_WILDCARD.hasMoneyForWildcards,
					requiredOutcome = true,
					textNoRequiredCondition = "You dont have enough money.",
				},
			},
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_WILDCARD.addWilcard },
				{ action = SPECIAL_ACTIONS_WILDCARD.removeMoneyPreycards },
			},
		},
	},
	[JOB_SOFT_BOOTS_RECHARGE] = {
		[{ "soft boots" }] = {
			text = "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.",
			nextTopic = JOB_TOPICS.confirmBuySoftbootsrecharge,
		},
		[{ "worn soft boots" }] = {
			text = "Here you are. There are your soft boots.",
			requiredTopic = JOB_TOPICS.confirmBuySoftbootsrecharge,
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6530 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "What?! I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "doladowac", "charge" }] = {
			text = "Here are your soft boots.",
			requiredTopic = JOB_TOPICS.confirmBuySoftbootsrecharge,
			rewards = { { id = 6529 } },
			requiredItems = { { id = 6529 } },
			requiredMoney = 20000,
			textNoRequiredMoney = "I wont do it for free.",
			textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
		},
		[{ "medicine", "belongings" }] = {
			text = "You have medicine pouch for me?",
			nextTopic = JOB_TOPICS.confirmMedicinepouchExchance,
			requiredItems = { { id = 12517, remove = false } },
			textNoRequiredItems = "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.",
		},
	},
	[JOB_JEWELLER] = {
		[{ "life crystal", "life ring", "life" }] = {
			text = "I can exchange your life crystals for a life rings. Is that what youre interested in?",
			nextTopic = JOB_TOPICS.confirmLifecrystalExchange,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			requiredTopic = JOB_TOPICS.confirmLifecrystalExchange,
			requiredItems = { { id = 3061, min = 1 } },
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_JEWELER.exchangeLifeCrystal },
			},
			textNoRequiredItems = "Im sorry, but you dont have such crystal. Only life crystal counts.",
		},
	},
	[JOB_TASKS] = {
		[{ "zadanie", "zadania", "nagroda", "wykonane", "reward" }] = {
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.hasDoneAnyTask,
					requiredOutcome = true,
					textNoRequiredCondition = "Finish one of {tasks}, then we can talk about reward.",
				},
			},
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_TASKS.grantTaskRewards,
				},
			},
		},
		[{ "tasks", "taski", "biore", "task", "taskow" }] = {
			text = "",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.canTakeAnotherTask,
					requiredOutcome = true,
					textNoRequiredCondition = "YOU_HAVE_MAX_ONGOING_TASKS",
				},
			},
			specialActionsOnSuccess = { { action = SPECIAL_ACTIONS_TASKS.openTaskWindow } },
		},
		[{ "zakoncz", "koniec", "cancel", "anuluj", "Anuluj" }] = {
			text = "",
			specialActionsOnSuccess = { { action = SPECIAL_ACTIONS_TASKS.openTaskCancelWindow } },
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_TASKS.hasAnyOngoingTask,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't have any active tasks. Ask me for {tasks} to sign up for one.",
				},
			},
		},
	},
	[JOB_IMBUING] = {
		[{ "imbuing", "imbuings" }] = {
			text = "LIST_IMBUING_NAMES",
			nextTopic = JOB_TOPICS.chooseImbuingname,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_NAME",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.saidImbuingName,
					requiredOutcome = true,
				},
			},
			requiredTopic = JOB_TOPICS.chooseImbuingname,
			nextTopic = JOB_TOPICS.chooseImbuinglevel,
		},
		[{ ANY_MESSAGE }] = {
			text = "YOU_SELECTED_IMBUING_LEVEL",
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.saidImbuingLevels,
					requiredOutcome = true,
				},
			},
			requiredTopic = JOB_TOPICS.chooseImbuinglevel,
			nextTopic = JOB_TOPICS.confirmBuyImbuing,
		},
		[{ "yes", "tak" }] = {
			text = "Here you go.",
			nextTopic = TOPIC_DEFAULT,
			requiredTopic = JOB_TOPICS.confirmBuyImbuing,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_IMBUING.canPurchaseThisImbuingLevel,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't yet have the {ability} to buy this level of bundle yet.",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughTaskPoints,
					requiredOutcome = true,
					textNoRequiredCondition = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughMoney,
					requiredOutcome = true,
					textNoRequiredCondition = "You dont have enough money.",
				},
				{
					condition = SPECIAL_CONDITIONS_IMBUING.hasEnoughCapSlots,
					requiredOutcome = true,
					NOT_ENOUGH_CAP_OR_SLOTS,
				},
			},
			specialActionsOnSuccess = {
				{ action = SPECIAL_ACTIONS_IMBUING.removeTaskPointsByImbuing },
			},
		},
	},
	[JOB_DAILYTASK] = {
		[{ "anuluj", "zrezygnowac", "cancel" }] = {
			specialActionsOnSuccess = { { SPECIAL_ACTIONS_DAILY_TASK.openDailyTaskCancelWindow } },
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_DAILY_TASK.hasAnyOngoingDailyTask,
					requiredOutcome = true,
					textNoRequiredCondition = "You don't have any active daily tasks. You can sign up for daily task on the daily task board. Please report me if you finish one of them.",
				},
			},
		},
		[{ "ogloszenie", "task", "nagroda", "reward" }] = {
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_DAILY_TASK.grantDailyTaskRewards,
				},
			},
		},
	},
	-- ToDo: changed topics to refs
	[JOB_MARRIAGE] = {
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
			nextTopic = JOB_TOPICS.wouldYouLikeToGetMarried,
		},
		[{ "no", "nie" }] = {
			requiredTopic = JOB_TOPICS.wouldYouLikeToGetMarried,
			text = "That's fine.",
		},
		[{ "yes", "tak" }] = {
			requiredTopic = JOB_TOPICS.wouldYouLikeToGetMarried,
			nextTopic = JOB_TOPICS.playerWouldLikeToGetMarried,
			text = "And who would you like to marry?",
		},
		[{ ANY_MESSAGE }] = {
			text = "Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}.",
			requiredTopic = JOB_TOPICS.playerWouldLikeToGetMarried,
			specialConditions = {
				{
					condition = canEngage,
					requiredOutcome = true,
				},
			},
			specialActionsOnSuccess = {
				{
					action = engage,
				},
			},
		},
		[{ "celebration", "ceremonia" }] = {
			text = "Is your soulmate and friends here with you for the celebration?",
			nextTopic = JOB_TOPICS.isYourSoulMateHere,
		},
		[{ "no", "nie" }] = {
			requiredTopic = JOB_TOPICS.isYourSoulMateHere,
			nextTopic = JOB_TOPICS.isYourSoulMateHere,
			text = "Then go bring them here!",
		},
		[{ "yes" }] = {
			requiredTopic = JOB_TOPICS.isYourSoulMateHere,
			nextTopic = JOB_TOPICS.confirmBeginCelebration,
			text = "Good, let's {begin} then!",
			specialConditions = {
				{
					condition = canConfirmWedding,
					requiredOutcome = true,
					textNoRequiredCondition = "Your partner did not accept your proposal yet.",
				},
			},
			specialActionsOnSuccess = {
				{ action = confirmWedding },
			},
		},
		[{ "begin", "rozpocznijmy" }] = {
			text = "",
			requiredTopic = JOB_TOPICS.confirmBeginCelebration,
			specialActionsOnSuccess = {
				{
					action = SPECIAL_ACTIONS_UNIVERSAL.npcSay,
					talkType = TALKTYPE_SAY,
					text = "MARRIAGE_TALKTYPE_SAY_TEXT",
				},
			},
		},
		[{ "cancel", "anuluj", "anulowac" }] = {
			nextTopic = JOB_TOPICS.confirmProposalCancel,
			text = "Are sure you want to cancel your proposal?",
		},
		[{ "yes", "tak" }] = {
			text = "It's cancelled.",
			requiredTopic = JOB_TOPICS.confirmProposalCancel,
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
			requiredTopic = JOB_TOPICS.confirmProposalCancel,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasProposedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not proposed to anyone.",
				},
			},
		},
		[{ "divorce", "rozwod" }] = {
			nextTopic = JOB_TOPICS.confirmDivorce,
			text = "CONFIRM_DIVORCE",
		},
		[{ "yes", "tak" }] = {
			text = "Well. I hope you wont regret it.",
			requiredTopic = JOB_TOPICS.confirmDivorce,
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
			requiredTopic = JOB_TOPICS.confirmDivorce,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.hasMarriedStatus,
					requiredOutcome = true,
					textNoRequiredCondition = "You are not married to anyone.",
				},
			},
		},
	},
	[JOB_BLESS] = {
		[GREET] = {
			text = "Hello, you need some help? Check {services} that I offer...",
		},
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
		}] = {
			text = "BLESS_PRICE_TEXT",
			nextTopic = JOB_TOPICS.confirmBuyAllregularblessings,
		},
		[{ "yes", "tak" }] = {
			text = "Thank you.",
			requiredTopic = JOB_TOPICS.confirmBuyAllregularblessings,
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
			nextTopic = JOB_TOPICS.confirmBuyPromotion,
			specialConditions = {
				{
					condition = SPECIAL_CONDITIONS_UNIVERSAL.isPromoted,
					requiredOutcome = false,
					textNoRequiredCondition = "You are already promoted!",
				},
			},
		},
		[{ "yes" ,"tak"}] = {
			text = "Here is your promotion, good luck!",
			requiredTopic = JOB_TOPICS.confirmBuyPromotion,
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
	},
}
