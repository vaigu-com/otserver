local dialogues = {}
local voices = {}

local outfit = {
	lookType = 136,
	lookHead = 20,
	lookBody = 100,
	lookLegs = 50,
	lookFeet = 99,
	lookAddons = 3,
}
local context = {
	name = "Bank Test",
	greetJob = JOB_BANK,
	jobs = { JOB_BANK },
	outfit = outfit,
	dialogues = dialogues,
	voices = voices,
}

local npcType, npcConfig = CreateNpcDefinition(context)
npcType:register(npcConfig)
