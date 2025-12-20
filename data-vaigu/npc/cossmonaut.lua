local outfit = {
	lookType = 1568,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 9,
	lookFeet = 0,
	lookAddons = 1,
}
local context = {
	name = "Cossmonaut",
	greetJob = JOB_ARMOR_WEAPON,
	jobs = { JOB_ARMOR_WEAPON },
	outfit = outfit,
}

NpcRegistry:AppendNpcData(context)
