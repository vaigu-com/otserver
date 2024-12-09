FIRST_AVAILABLE_JOB_TOPIC = 100000
function NextJobTopic()
	FIRST_AVAILABLE_JOB_TOPIC = FIRST_AVAILABLE_JOB_TOPIC + 1
	return FIRST_AVAILABLE_JOB_TOPIC
end

JOB_TOPICS = {
	-- JOB_TASKS_IMBUING
	chooseImbuingname = NextJobTopic(),
	chooseImbuinglevel = NextJobTopic(),
	confirmBuyImbuing = NextJobTopic(),
	confirmUnlockPowerfulimbue = NextJobTopic(),
	confirmBuyAntelope = NextJobTopic(),
	browsingTrophies = NextJobTopic(),
	confirmBuyTrophy = NextJobTopic(),
	-- JOB_WILDCARD
	sayingWildcardNumber = NextJobTopic(),
	confirmingNwildcards = NextJobTopic(),
	-- JOB_SOFT_BOOTS
	confirmBuySoftbootsrecharge = NextJobTopic(),
	confirmMedicinepouchExchance = NextJobTopic(),
	-- JOB_JEWELLER
	confirmLifecrystalExchange = NextJobTopic(),
	-- JOB_SOULORB
	confirmExchangeSoulorbToInfernalbolt = NextJobTopic(),
	-- JOB_GOLDENOUTFIT
	confirmExplaingoldenoutfit = NextJobTopic(),
	confirmBuyGoldenoutfitbody = NextJobTopic(),
	confirmBuyGoldenoutfithelmet = NextJobTopic(),
	confirmGoldenoutfitbootsBuy = NextJobTopic(),
	-- JOB_MARRIAGE
	wouldYouLikeToGetMarried = NextJobTopic(),
	playerWouldLikeToGetMarried = NextJobTopic(),
	isYourSoulMateHere = NextJobTopic(),
	confirmProposalCancel = NextJobTopic(),
	confirmDivorce = NextJobTopic(),
	-- JOB_BLESS
	confirmBuyAllregularblessings = NextJobTopic(),
	confirmBuyPromotion = NextJobTopic(),
	-- JOB_BANK
	confirmDeposit = NextJobTopic(),
	declareAmountdeposit = NextJobTopic(),
	confirmWithdraw = NextJobTopic(),
	declareAmountwithdraw = NextJobTopic(),
	confirmTransfer = NextJobTopic(),
	declareAmounttransfer = NextJobTopic(),
	confirmRecipient = NextJobTopic(),
}
