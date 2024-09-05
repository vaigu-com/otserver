local outfit = {
	lookType = 955,
	lookHead = 0,
	lookBody = 116,
	lookLegs = 99,
	lookFeet = 98,
	lookAddons = 0,
}
local context = {
	name = "Hash'Ish",
	greetJob = JOB_CREATURE_PRODUCT,
	jobs = { JOB_CREATURE_PRODUCT },
	outfit = outfit,
}
local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
