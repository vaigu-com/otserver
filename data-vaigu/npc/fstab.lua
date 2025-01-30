local voices = {
	interval = 15000,
	chance = 50,
	{
		text = "Szwagier jak ostatnio eliksir wypil to dwa dni nieprzytomny lezal takiego ma kopa...",
	},
	{ text = "Przyjdz do mnie z kolegami, pohandlujemy uhami." },
	{
		text = "Prawda jest taka ze Panoramix bral ode mnie przepisy na magiczny napoj...",
	},
	{
		text = "Runy magiczne, mikstury syntetyczne, pelen wybor w najnizszych cenach!",
	},
	{ text = "Jesli szukasz magicznej rozdzki to u mnie masz pelen wybor." },
}

local additionalJob = nil
if DAYS_SINCE_START >= 7 then
	additionalJob = JOB_EXERCISE
end

local outfit = {
	lookType = 130,
	lookHead = 39,
	lookBody = 122,
	lookLegs = 125,
	lookFeet = 57,
	lookAddons = 0,
}
local context = {
	name = "Fstab",
	greetJob = JOB_MAGIC_WILDCARD,
	jobs = { JOB_WILDCARD, JOB_MAGIC, additionalJob },
	outfit = outfit,
	dialogs = dialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
