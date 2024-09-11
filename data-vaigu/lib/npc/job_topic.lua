FIRST_AVAILABLE_JOB_TOPIC = 100000
function NextJobTopic()
	FIRST_AVAILABLE_JOB_TOPIC = FIRST_AVAILABLE_JOB_TOPIC + 1
	return FIRST_AVAILABLE_JOB_TOPIC
end

JOB_TOPICS = {
	-- JOB_TASKS_IMBUING
	chooseImbuingName = NextJobTopic(),
	chooseImbuingLevel = NextJobTopic(),
	confirmBuyingImbuing = NextJobTopic(),
	confirmPowerfulimbueUnlock = NextJobTopic(),
	confirmAntelopeBuy = NextJobTopic(),
	buyingTropies = NextJobTopic(),
	confirmTrophyBuy = NextJobTopic(),
	-- JOB_WILDCARD
	sayingWildcardNumber = NextJobTopic(),
	confirmingNwildcards = NextJobTopic(),
	-- JOB_SOFT_BOOTS
	buyingSoftBootsRecharge = NextJobTopic(),
	confirmMedicinepouchExchance = NextJobTopic(),
	-- JOB_JEWELLER
	confirmLifecrystalExchange = NextJobTopic(),
	-- JOB_SOULORB
	exchangingSoulorbToInfernalbolts = NextJobTopic(),
	-- JOB_GOLDENOUTFIT
	confirmExplaingoldenoutfit = NextJobTopic(),
	confirmGoldenoutfitchestBuy = NextJobTopic(),
	confirmGoldenoutfithelmetBuy = NextJobTopic(),
	confirmGoldenoutfitbootsBuy = NextJobTopic(),
}
