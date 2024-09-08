local outfit = {
	lookType = 140,
	lookHead = 0,
	lookBody = 91,
	lookLegs = 0,
	lookFeet = 113,
	lookAddons = 3,
}
local context = {
	name = "Mayor",
	greetJob = JOB_DAILYTASKS_GOLDENOUTFIT,
	jobs = { JOB_DAILYTASK, JOB_GOLDENOUTFIT },
	outfit = outfit,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
