local pseudoQuest = Quest(LOCALIZERS.NONE)

local powerfulImbueUnlockCost = 15

pseudoQuest
	:NoQuestlog()
	:Constant(function()
		JOB_UNIVERSAL_DIALOGS = {}
	end)
	:Script(function()
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
				local translatedMessage = player:Localizer(LOCALIZERS.Priest):Get(errorMessage)
				return false, translatedMessage
			end

			local candidateName = context.msg
			local candidateId = getPlayerGUIDByName(candidateName)
			local candidateSpouseId = getPlayerSpouse(candidateId)
			if candidateSpouseId == playerId then
				setPlayerMarriageStatus(player:getGuid(), PROPOSED_STATUS)
				setPlayerSpouse(player:getGuid(), candidateId)
				local translatedMessage = player:Localizer(LOCALIZERS.Priest):Get("INITIATE_PROPOSAL")
				return false, translatedMessage
			end

			local candidate = Player(candidateId)
			if not canPerformProaccept({ candidate, player }) then
				local translatedMessage = player:Localizer(LOCALIZERS.Priest):Get("At least one of you doens't have their wedding ring or wedding outfit box.")
				return false, translatedMessage
			end

			return true
		end

		local function confirmWedding(context)
			local player = context.player
			local playerGuid = player:getGuid()
			local candidateGuid = getPlayerSpouse(playerGuid)
			local candidate = Player(candidateGuid)

			setPlayerMarriageStatus(playerGuid, MARRIED_STATUS)
			setPlayerMarriageStatus(candidateGuid, MARRIED_STATUS)

			setPlayerSpouse(playerGuid, candidateGuid)
			setPlayerSpouse(candidateGuid, playerGuid)

			player:sendMagicEffect(CONST_ME_POWERFUL_HEARTS)
			candidate:sendMagicEffect(CONST_ME_POWERFUL_HEARTS)

			player:AddCustomItem({
				id = 7370,
				ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(LOCALIZERS.Priest):Get("MARRIAGE_TROPHY_DESC"),
			})
			candidate:AddCustomItem({
				id = 7370,
				ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(LOCALIZERS.Priest):Get("MARRIAGE_TROPHY_DESC"),
			})

			player:AddCustomItem({
				id = ITEM_ENGRAVED_WEDDING_RING,
				ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(LOCALIZERS.Priest):Get("MARRIAGE_MARRIAGE_RING_DESC"),
			})
			candidate:AddCustomItem({
				id = ITEM_ENGRAVED_WEDDING_RING,
				ITEM_ATTRIBUTE_DESCRIPTION = player:Localizer(LOCALIZERS.Priest):Get("MARRIAGE_MARRIAGE_RING_DESC"),
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

		JOB_UNIVERSAL_DIALOGS[JOB_SOULORB] = {
			[{ "soul orb", "soul orbs", "soul" }] = {
				text = "I can craft infernal bolts out of {soul orb} for you. I learned that from the Devil himself. Do you want to exchange all of your soul orbs?",
				nextTopic = QuestTopics.JOB_TOPICS.confirmExchangeSoulorbToInfernalbolt,
			},
			[{ "yes", "tak" }] = {
				text = "You're welcome! Use them wisely.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmExchangeSoulorbToInfernalbolt,
				requiredItems = { { id = 5944, take = TAKE_ALL_AVAILABLE } },
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_SOULORB.soulOrbToInfernalBolt },
				},
				textNoRequiredItems = "I can see you don't have them! I can only craft infernal bolts from {soul orb}.",
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_WILDCARD] = {
			[{ "wildcard", "wildcards" }] = {
				text = "Here you go",
				specialActionsOnSuccess = {
					{
						action = function(context)
							local wildCardPrice = context.player:GetWildcardPrice()
							local shop = { { itemName = "Prey Wildcard", clientId = ItemId.PREY_WILDCARD_ITEM_SUBSTITUTE, buy = wildCardPrice } }
							context.npc:openShopWindowTable(context.player, shop)
						end,
					},
				},
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_SOFT_BOOTS_RECHARGE] = {
			[{ "soft boots" }] = {
				text = "Would you like to exchange {worn soft boots}, or {charge} active ones? Cost of both services is 20k of gold.",
				nextTopic = QuestTopics.JOB_TOPICS.confirmBuySoftbootsrecharge,
			},
			[{ "worn soft boots" }] = {
				text = "Here you are. There are your soft boots.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuySoftbootsrecharge,
				rewards = { { id = 6529 } },
				requiredItems = { { id = 6530 } },
				requiredMoney = 20000,
				textNoRequiredMoney = "What?! I wont do it for free.",
				textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
			},
			[{ "doladowac", "charge" }] = {
				text = "Here are your soft boots.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuySoftbootsrecharge,
				rewards = { { id = 6529 } },
				requiredItems = { { id = 6529 } },
				requiredMoney = 20000,
				textNoRequiredMoney = "I wont do it for free.",
				textNoRequiredItems = "Sorry, but you dont have such item. I can only fix {soft boots}.",
			},
			[{ "medicine", "belongings", "medicine pouch" }] = {
				text = "You have medicine pouch for me?",
				nextTopic = QuestTopics.JOB_TOPICS.confirmMedicinepouchExchance,
				requiredItems = { { id = 12517, remove = false } },
				textNoRequiredItems = "I can give you {belongings of deceased} for your {medicine puch}. Come back if you get one.",
			},
			[{ "yes", "tak" }] = {
				text = "Here you are.",
				requiredItems = { { id = 12517 } },
				rewards = {
					{ id = 12413 },
				},
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_JEWELLER] = {
			[{ "life crystal", "life ring", "life" }] = {
				text = "I can exchange your life crystals for a life rings. Is that what youre interested in?",
				nextTopic = QuestTopics.JOB_TOPICS.confirmLifecrystalExchange,
			},
			[{ "yes", "tak" }] = {
				text = "Here you go.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmLifecrystalExchange,
				requiredItems = { { id = 3061, min = 1, take = TAKE_ALL_AVAILABLE } },
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_JEWELER.exchangeLifeCrystal },
				},
				textNoRequiredItems = "Im sorry, but you dont have such crystal. Only life crystal counts.",
			},
			[{ "red gem", "czerwony klejnot", "czerwone klejnoty" }] = {
				text = "I can exchange your red gems for a three rings of healing. Is that what youre interested in?",
				nextTopic = QuestTopics.JOB_TOPICS.ConfirmExchangeRedGem,
				requiredState = {
					[Storage.LocalSupport.RedGemExchange] = ACCESS_GRANTED,
				},
			},
			[{ "yes", "tak" }] = {
				text = "Here you go.",
				requiredTopic = QuestTopics.JOB_TOPICS.ConfirmExchangeRedGem,
				requiredItems = { { id = 3039, min = 1, take = TAKE_ALL_AVAILABLE } },
				requiredState = {
					[Storage.LocalSupport.RedGemExchange] = ACCESS_GRANTED,
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_JEWELER.exchangeRedGems },
				},
				textNoRequiredItems = "Im sorry, but you dont have such crystal. Only life crystal counts.",
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_IMBUING] = {
			[{ "mozliwosc", "ability" }] = {
				text = "YOU_WANT_BUY_ABILITY_POWEFUL_IMBUEMENT",
				nextTopic = QuestTopics.JOB_TOPICS.confirmUnlockPowerfulimbue,
				requiredState = {
					[Storage.powerfulImbue] = { max = 0 },
				},
				cost = powerfulImbueUnlockCost,
			},
			[{ "yes", "tak" }] = {
				text = "Here you are.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmUnlockPowerfulimbue,
				requiredState = {
					[Storage.Task.TaskPoints] = powerfulImbueUnlockCost,
					[Storage.powerfulImbue] = { max = 0 },
				},
				nextState = {
					[Storage.powerfulImbue] = 1,
					[Storage.Task.TaskPoints] = "-" .. tostring(powerfulImbueUnlockCost),
				},
				textNoRequiredState = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
				cost = powerfulImbueUnlockCost,
			},
			[{ "mozliwosc", "ability" }] = {
				text = "You already got it.",
				requiredState = {
					[Storage.powerfulImbue] = { min = 1 },
				},
			},
			[{ "yes", "tak" }] = {
				text = "You already got it.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmUnlockPowerfulimbue,
				requiredState = {
					[Storage.powerfulImbue] = { min = 1 },
				},
			},
			[{ "imbuing", "imbuings", "imbuingow" }] = {
				text = "LIST_IMBUING_NAMES",
				nextTopic = QuestTopics.JOB_TOPICS.chooseImbuingname,
			},
			[{ ANY_MESSAGE }] = {
				text = "YOU_SELECTED_IMBUING_NAME",
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.saidImbuingName,
						requiredOutcome = true,
					},
				},
				requiredTopic = QuestTopics.JOB_TOPICS.chooseImbuingname,
				nextTopic = QuestTopics.JOB_TOPICS.chooseImbuinglevel,
			},
			[{ ANY_MESSAGE }] = {
				text = "YOU_SELECTED_IMBUING_LEVEL",
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.saidImbuingLevel,
						requiredOutcome = true,
					},
				},
				requiredTopic = QuestTopics.JOB_TOPICS.chooseImbuinglevel,
				nextTopic = QuestTopics.JOB_TOPICS.confirmBuyImbuing,
			},
			[{ "yes", "tak" }] = {
				text = "Here you go.",
				nextTopic = TOPIC_DEFAULT,
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuyImbuing,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.canPurchaseThisImbuingLevel,
						requiredOutcome = true,
						textFailedRequirement = "You don't yet have the {ability} to buy this level of bundle yet.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.hasEnoughTaskPoints,
						requiredOutcome = true,
						textFailedRequirement = "YOU_DONT_HAVE_ENOUGH_TASK_POINTS",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.hasEnoughMoney,
						requiredOutcome = true,
						textFailedRequirement = "You dont have enough money.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_IMBUING.hasEnoughCapSlots,
						requiredOutcome = true,
						NOT_ENOUGH_CAP_OR_SLOTS,
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_IMBUING.addproductsRemovemoneypoints },
				},
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_MARRIAGE] = {
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
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasMarriedStatus,
						requiredOutcome = false,
						textFailedRequirement = "My chronicles suggest that you are married already. Do you want to get a {divorce} now?",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasProposedStatus,
						requiredOutcome = false,
						textFailedRequirement = "NO_PROPOSAL_RESPONSE",
					},
				},
			},
			[{ "wedding", "slub" }] = {
				text = "Thats great! So you want to {marry} someone?",
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasMarriedStatus,
						requiredOutcome = false,
						textFailedRequirement = "My chronicles suggest that you are married already. Do you want to get a {divorce} now?",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasProposedStatus,
						requiredOutcome = false,
						textFailedRequirement = "NO_PROPOSAL_RESPONSE",
					},
				},
			},
			[{ "marry", "poslubic" }] = {
				text = "Would you like to get married? Make sure you have a {wedding ring} and the {wedding outfit box} with you.",
				nextTopic = QuestTopics.JOB_TOPICS.wouldYouLikeToGetMarried,
			},
			[{ "no", "nie" }] = {
				requiredTopic = QuestTopics.JOB_TOPICS.wouldYouLikeToGetMarried,
				text = "That's fine.",
			},
			[{ "yes", "tak" }] = {
				requiredTopic = QuestTopics.JOB_TOPICS.wouldYouLikeToGetMarried,
				nextTopic = QuestTopics.JOB_TOPICS.playerWouldLikeToGetMarried,
				text = "And who would you like to marry?",
			},
			[{ ANY_MESSAGE }] = {
				text = "Since both young souls are willing to marry - get ready. Let me know if you are willing to start the {celebration}.",
				requiredTopic = QuestTopics.JOB_TOPICS.playerWouldLikeToGetMarried,
				specialRequirements = {
					{
						requirement = canEngage,
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
				nextTopic = QuestTopics.JOB_TOPICS.isYourSoulMateHere,
			},
			[{ "no", "nie" }] = {
				requiredTopic = QuestTopics.JOB_TOPICS.isYourSoulMateHere,
				nextTopic = QuestTopics.JOB_TOPICS.isYourSoulMateHere,
				text = "Then go bring them here!",
			},
			[{ "yes" }] = {
				requiredTopic = QuestTopics.JOB_TOPICS.isYourSoulMateHere,
				nextTopic = QuestTopics.JOB_TOPICS.confirmBeginCelebration,
				text = "Good, let's {begin} then!",
				specialRequirements = {
					{
						requirement = canConfirmWedding,
						requiredOutcome = true,
						textFailedRequirement = "Your partner did not accept your proposal yet.",
					},
				},
				specialActionsOnSuccess = {
					{ action = confirmWedding },
				},
			},
			[{ "begin", "rozpocznijmy" }] = {
				text = NO_TEXT,
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBeginCelebration,
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.npcSay,
						talkType = TALKTYPE_SAY,
						text = "MARRIAGE_TALKTYPE_SAY_TEXT",
					},
				},
			},
			[{ "cancel", "anuluj", "anulowac" }] = {
				nextTopic = QuestTopics.JOB_TOPICS.confirmProposalCancel,
				text = "Are sure you want to cancel your proposal?",
			},
			[{ "yes", "tak" }] = {
				text = "It's cancelled.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmProposalCancel,
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.cancelMarriage },
				},
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasProposedStatus,
						requiredOutcome = true,
						textFailedRequirement = "You are not proposed to anyone.",
					},
				},
			},
			[{ "no", "nie" }] = {
				text = "I won't be doing anything about that then.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmProposalCancel,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasProposedStatus,
						requiredOutcome = true,
						textFailedRequirement = "You are not proposed to anyone.",
					},
				},
			},
			[{ "divorce", "rozwod" }] = {
				nextTopic = QuestTopics.JOB_TOPICS.confirmDivorce,
				text = "CONFIRM_DIVORCE",
			},
			[{ "yes", "tak" }] = {
				text = "Well. I hope you wont regret it.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmDivorce,
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_UNIVERSAL.divorce },
				},
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasMarriedStatus,
						requiredOutcome = true,
						textFailedRequirement = "You are not married to anyone.",
					},
				},
			},
			[{ "no", "nie" }] = {
				text = "I'm very happy with your decision.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmDivorce,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasMarriedStatus,
						requiredOutcome = true,
						textFailedRequirement = "You are not married to anyone.",
					},
				},
			},
		}
		JOB_UNIVERSAL_DIALOGS[JOB_BLESS] = {
			[{ GREET }] = {
				text = "Hello, you need some help? Check {services} that I offer...",
			},
			[{ "pomoc", "uslug", "uslugi", "help", "services" }] = {
				text = "You are in a temple. If you wish, I can {bless} you with regular blessings or a {twist of fate}, {heal}, {promote} and {mark} most important civilians of this city on your map.\nYou can also get a {marriage} here.",
			},

			--Automatic on language change
			--[[
				[{ "mark", "map", "zaznacz", "zaznaczyc" }] = {
					text = "I marked few points of interest on your map.",
					specialActionsOnSuccess = {
						{ action = markMap },
					},
				},
				]]

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
				nextTopic = QuestTopics.JOB_TOPICS.confirmBuyAllregularblessings,
			},
			[{ "yes", "tak" }] = {
				text = "Thank you.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuyAllregularblessings,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.canAffordBless,
						requiredOutcome = true,
						textFailedRequirement = "BLESS_INSUFFICIENT_MONEY",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasBlessings,
						min = 2,
						max = 6,
						requiredOutcome = false,
						textFailedRequirement = "You have been blessed already.",
					},
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.grantBless,
						min = 2,
						max = 6,
					},
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.chargeForBless,
					},
				},
			},
			[{ "twist of fate" }] = {
				text = "TWIST_OF_FATE_PRICE_TEXT",
				nextTopic = QuestTopics.JOB_TOPICS.confirmBuyTwistoffate,
			},
			[{ "yes", "tak" }] = {
				text = "Here you go.",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuyTwistoffate,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.canAffordTwistOfFate,
						requiredOutcome = true,
						textFailedRequirement = "TWIST_OF_FATE_INSUFFICIENT_MONEY",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasTwistOfFate,
						requiredOutcome = false,
						textFailedRequirement = "You have already been blessed with twist of fate.",
					},
				},
				specialActionsOnSuccess = {
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.grantBless,
						min = 1,
						max = 1,
					},
					{
						action = SPECIAL_ACTIONS_UNIVERSAL.chargeForTwistOfFate,
					},
				},
			},
			[{ "promotion", "promocja", "promote", "awans", "awansowac" }] = {
				text = "PROMOTION_TEXT",
				nextTopic = QuestTopics.JOB_TOPICS.confirmBuyPromotion,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.isPromoted,
						requiredOutcome = false,
						textFailedRequirement = "You are already promoted!",
					},
				},
			},
			[{ "yes", "tak" }] = {
				text = "Here is your promotion, good luck!",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmBuyPromotion,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.hasMoney,
						requiredOutcome = true,
						textFailedRequirement = "PROMOTION_INSUFFICIENT_MONEY",
						price = PROMOTION_PRICE,
					},
					{
						requirement = SPECIAL_REQUIREMENTS_UNIVERSAL.playerHasLevel,
						requiredOutcome = true,
						textFailedRequirement = "You need at least 20 level to get promoted!",
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
		}
		JOB_UNIVERSAL_DIALOGS[JOB_BANK] = {
			[{ "yes" }] = {
				text = "You can {deposit}, {withdraw} and {transfer} your money here. If you need to monitor your finances, ask be for {balance}.",
				requiredTopic = DEFAULT_TOPIC,
			},
			--balance
			[{ "balance" }] = {
				text = "ACCOUNT_BALANCE",
			},
			--deposit
			[{ "deposit <amount>" }] = {
				text = "CONFIRM_DEPOSIT",
				nextTopic = QuestTopics.JOB_TOPICS.confirmDeposit,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyininventory,
						requiredOutcome = true,
						textFailedRequirement = "You do not have enough gold.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountDeposit },
				},
			},
			[{ "deposit" }] = {
				text = "DECLARE_DEPOSIT_AMOUNT",
				nextTopic = QuestTopics.JOB_TOPICS.declareAmountdeposit,
			},
			[{ "<amount>" }] = {
				text = "CONFIRM_DEPOSIT",
				nextTopic = QuestTopics.JOB_TOPICS.confirmDeposit,
				requiredTopic = QuestTopics.JOB_TOPICS.declareAmountdeposit,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyininventory,
						requiredOutcome = true,
						textFailedRequirement = "You do not have enough gold.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountDeposit },
				},
			},
			[{ "yes" }] = {
				text = "DEPOSIT_OK",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmDeposit,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyininventory,
						requiredOutcome = true,
						textFailedRequirement = "You do not have enough gold.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.depositMoney },
				},
			},
			[{ "no" }] = {
				text = "DEPOSIT_CANCEL",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmDeposit,
			},
			--withdraw
			[{ "withdraw <amount>" }] = {
				text = "CONFIRM_WITHDRAW",
				nextTopic = QuestTopics.JOB_TOPICS.confirmWithdraw,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountWithdrawTransfer },
				},
			},
			[{ "withdraw" }] = {
				text = "DECLARE_WITHDRAW_AMOUNT",
				nextTopic = QuestTopics.JOB_TOPICS.declareAmountwithdraw,
			},
			[{ "<amount>" }] = {
				text = "CONFIRM_WITHDRAW",
				nextTopic = QuestTopics.JOB_TOPICS.confirmWithdraw,
				requiredTopic = QuestTopics.JOB_TOPICS.declareAmountwithdraw,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountWithdrawTransfer },
				},
			},
			[{ "yes" }] = {
				text = "WITHDRAW_OK",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmWithdraw,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.canCarryWithdrawnMoney,
						requiredOutcome = true,
						textFailedRequirement = NOT_ENOUGH_CAP_OR_SLOTS,
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.withdrawMoney },
				},
			},
			[{ "no" }] = {
				text = "WITHDRAW_CANCEL",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmWithdraw,
			},
			--transfer
			[{ "transfer <amount> to <recipient>", "transfer <amount> <recipient> [recipientNameSegment2] [recipientNameSegment3]" }] = {
				text = "CONFIRM_TRANSFER",
				nextTopic = QuestTopics.JOB_TOPICS.confirmTransfer,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.recipientIsnotself,
						requiredOutcome = true,
						textFailedRequirement = "You can't do that.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.recipientExists,
						requiredOutcome = true,
						textFailedRequirement = "You cannot transfer money to this account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountWithdrawTransfer },
					{ action = SPECIAL_ACTIONS_BANK.setRecipient },
				},
			},
			[{ "transfer" }] = {
				text = "DECLARE_TRANSFER_AMOUNT",
				nextTopic = QuestTopics.JOB_TOPICS.declareAmounttransfer,
			},
			[{ "<amount>" }] = {
				text = "DECLARE_TRANSFER_RECIPIENT",
				nextTopic = QuestTopics.JOB_TOPICS.declareRecipient,
				requiredTopic = QuestTopics.JOB_TOPICS.declareAmounttransfer,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setAmountWithdrawTransfer },
				},
			},
			[{ "<recipient> [recipientNameSegment2] [recipientNameSegment3]" }] = {
				text = "CONFIRM_TRANSFER",
				requiredTopic = QuestTopics.JOB_TOPICS.declareRecipient,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.recipientIsnotself,
						requiredOutcome = true,
						textFailedRequirement = "You can't do that.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.recipientExists,
						requiredOutcome = true,
						textFailedRequirement = "You cannot transfer money to this account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.setRecipient },
				},
			},
			[{ "yes" }] = {
				text = "TRANSFER_OK",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmTransfer,
				specialRequirements = {
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.declaredMoneyIsParsable,
						requiredOutcome = true,
						textFailedRequirement = "Thats not a correct amount.",
					},
					{
						requirement = SPECIAL_REQUIREMENTS_BANK.hasMoneyinbank,
						requiredOutcome = true,
						textFailedRequirement = "There is not enough gold in your account.",
					},
				},
				specialActionsOnSuccess = {
					{ action = SPECIAL_ACTIONS_BANK.transferMoney },
				},
			},
			[{ "no" }] = {
				text = "TRANSFER_CANCEL",
				requiredTopic = QuestTopics.JOB_TOPICS.confirmTransfer,
			},
		}
	end)
	:Register()
