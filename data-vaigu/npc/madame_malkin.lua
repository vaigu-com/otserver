local name = "Madame Malkin"
local outfit = {
	lookType = 279,
	lookHead = 114,
	lookBody = 132,
	lookLegs = 132,
	lookFeet = 132,
	lookAddons = 0,
}
local voices = {
	interval = 15000,
	chance = 50,
	{ text = "Naprawie twoje soft bootsy, bez obaw beda jak nowe" },
	{
		text = "Piekna wiosna, wszystko kwitnie, piechurzy wracaja z pierwszych polowan..",
	},
	{
		text = "Slyszalam , ze pierwsze wyprawy po magiczne buty zakonczyly sie pomyslnie",
	},
	{ text = "Tylko czekac az ktos przyniesie buty do regeneracji..." },
}
local context = {
	name = name,
	greetJob = JOB_SOFT_BOOTS_RECHARGE,
	jobs = { JOB_SOFT_BOOTS_RECHARGE },
	outfit = outfit,
	customDialogs = customDialogs,
	voices = voices,
}
NpcRegistry:AppendNpcData(context)
