local function getJobStateDialogues(jobs)
	local totalDialogues = {}
	for _, job in pairs(jobs) do
		totalDialogues = MergedTable(totalDialogues, NPC_STATE_DIALOGUES[job])
	end
	return totalDialogues
end

local function getJobConfigs(jobs)
	local totalShop = {}
	local totalDialogues = {}
	for _, job in pairs(jobs) do
		totalShop = MergedTable(totalShop, NPC_SHOP_TABLES[job])
		totalDialogues = MergedTable(totalDialogues, NPC_UNIVERSAL_DIALOGUES[job])
	end

	return totalShop, totalDialogues
end

---@param internalNpcName string string required
---@param npcName string? optional - display name on screen/battle window, Default: same as internalNpcName
---@param npcDescription string? optional - greentext when using look on npc, Default: "a " + internalNpcName
---@param greetJob string? sets default greet message based on this job
---@param jobs table? jobs that will determine dialogues and shop content
---@param outfit table outfit required
---@param dialogues table? custom dialogues that can override job dialogues
---@param voices table? orange color text that npc may or may not say from time to time
function CreateNpcDefinition(context)
	local name = context.internalNpcName or context.name
	local displayName = context.npcName or context.displayname or name
	local onlookName = context.npcDescription or context.onlookname or ("a " .. name)

	local greetJob = context.greetJob
	local jobs = context.jobs
	local outfit = context.outfit
	local userDialogues = context.dialogues
	local customShop = context.shop
	local voices = context.voices

	local shop, jobDialoguesUniversal = getJobConfigs(jobs)
	--ToDo: check if this should be removed
	--jobDialogues = MergedTable(jobDialogues, userDialogues)
	shop = MergedTable(shop, customShop)

	local jobStateDialogues = getJobStateDialogues(jobs)

	local allDialogues = {}
	allDialogues[LOCALIZER_UNIVERSAL] = jobDialoguesUniversal
	allDialogues[LOCALIZER_UNIVERSAL][{ GREET }] = JOBS_GREETINGS[greetJob]
	allDialogues = MergedTable(allDialogues, jobStateDialogues)
	allDialogues = MergedTable(allDialogues, userDialogues)

	local npcConfig = {}
	npcConfig.shop = shop
	npcConfig.dialogues = allDialogues

	npcConfig.name = displayName or name
	npcConfig.description = onlookName or ("a " .. name)

	npcConfig.health = 100
	npcConfig.maxHealth = npcConfig.health
	npcConfig.walkInterval = 2000
	npcConfig.walkRadius = 2

	npcConfig.outfit = outfit

	npcConfig.voices = voices

	npcConfig.flags = { floorchange = 0 }

	local keywordHandler = KeywordHandler:new()
	local npcHandler = NpcHandler:new(keywordHandler)

	local npcType = Game.createNpcType(name)

	npcType.onThink = function(npc, interval)
		npcHandler:onThink(npc, interval)
	end

	npcType.onAppear = function(npc, creature)
		npcHandler:onAppear(npc, creature)
	end

	npcType.onDisappear = function(npc, creature)
		npcHandler:onDisappear(npc, creature)
	end

	npcType.onMove = function(npc, creature, fromPosition, toPosition)
		npcHandler:onMove(npc, creature, fromPosition, toPosition)
	end

	npcType.onSay = function(npc, creature, type, message)
		npcHandler:onSay(npc, creature, type, message)
	end

	npcType.onCloseChannel = function(npc, creature)
		npcHandler:onCloseChannel(npc, creature)
	end
	-- On buy npc shop message
	npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
		npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
	end
	-- On sell npc shop message
	npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, itemName, totalCost)
		player:sendTextMessage(MESSAGE_INFO_DESCR, string.format("Sold %ix %s for %i gold.", amount, itemName, totalCost))
	end
	-- On check npc shop message (look item)
	npcType.onCheckItem = function(npc, player, clientId, subType) end

	local function greetCallback(npc, creature, type, message)
		InitializeResponses(creature, npcConfig.dialogues, npcHandler, npc)
		return true
	end

	local function creatureSayCallback(npc, creature, type, msg)
		if not npcHandler:checkInteraction(npc, creature) then
			return false
		end
		return TryResolveConversation(creature, msg, npcConfig.dialogues, npcHandler, npc)
	end

	npcHandler:setCallback(CALLBACK_GREET, greetCallback)
	npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

	npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

	return npcType, npcConfig
end
