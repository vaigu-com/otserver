local function getJobStateDialogs(jobs)
	local totalDialogs = {}
	for _, job in pairs(jobs) do
		totalDialogs = MergedTable(totalDialogs, NPC_STATE_DIALOGS[job])
	end
	return totalDialogs
end

local function getJobConfigs(jobs)
	local totalShop = {}
	local totalDialogs = {}
	for _, job in pairs(jobs) do
		totalShop = MergedTable(totalShop, NPC_SHOP_TABLES[job])
		totalDialogs = MergedTable(totalDialogs, NPC_UNIVERSAL_DIALOGS[job])
	end

	return totalShop, totalDialogs
end

---@param internalNpcName string string REQUIRED
---@param npcName string? optional - display name on screen/battle window, Default: same as internalNpcName
---@param npcDescription string? optional - greentext when using look on npc, Default: "a " + internalNpcName
---@param greetJob string? sets default greet message based on this job
---@param jobs table? jobs that will determine dialogs and shop content
---@param outfit table outfit
---@param dialogs table? custom dialogs that can override job dialogs
---@param voices table? orange color text that npc may or may not say from time to time
function RegisterNpcDefinition(npc)
	local name = npc.internalNpcName or npc.name
	local displayName = npc.npcName or npc.displayname or npc.displayName or name
	local onlookName = npc.npcDescription or npc.onlookname or ("a " .. name)

	local greetJob = npc.greetJob
	local jobs = npc.jobs or {}
	local outfit = npc.outfit or { lookType = 136, lookHead = 1, lookBody = 1, lookLegs = 1, lookFeet = 1, lookAddons = 0 }
	local npcSpecificDialogs = npc.dialogs
	local customShop = npc.shop
	local voices = npc.voices
	local currency = npc.currency or npc.shopCurrency

	local jobShop, jobUniversalDialogs = getJobConfigs(jobs)
	--ToDo: check if this should be indeed removed
	--jobDialogs = MergedTable(jobDialogs, npcSpecificDialogs)
	local totalShop = MergedTable(jobShop, customShop)

	local jobStateDialogs = getJobStateDialogs(jobs)

	local allDialogs = {}
	allDialogs[LOCALIZERS.LOCALIZER_UNIVERSAL] = jobUniversalDialogs
	allDialogs[LOCALIZERS.LOCALIZER_UNIVERSAL][{ GREET }] = JOBS_GREETINGS[greetJob]
	allDialogs = MergedTable(allDialogs, jobStateDialogs)
	allDialogs = MergedTable(allDialogs, npcSpecificDialogs)

	local npcConfig = {}
	npcConfig.shop = totalShop
	npcConfig.currency = currency

	npcConfig.dialogs = allDialogs

	npcConfig.name = displayName or name
	npcConfig.description = onlookName or ("a " .. name)

	npcConfig.health = 100
	npcConfig.maxHealth = npcConfig.health
	npcConfig.walkInterval = npc.walkInterval or 2000
	npcConfig.walkRadius = npc.walkInterval or 2

	npcConfig.outfit = outfit

	npcConfig.voices = voices

	npcConfig.flags = { floorchange = npc.floorchange or 0 }

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

	-- On look at npc shop item
	npcType.onCheckItem = function(npc, player, clientId, subType) end

	local greetCallback = npc.greetCallback or function(npc, creature, type, message)
		InitializeResponses(creature, npcConfig.dialogs, npcHandler, npc)
		return true
	end

	local creatureSayCallback = npc.creatureSayCallback or function(npc, creature, type, msg)
		if not npcHandler:checkInteraction(npc, creature) then
			return false
		end
		return TryResolveDialog(creature, msg, npcConfig.dialogs, npcHandler, npc)
	end

	npcHandler:setCallback(CALLBACK_GREET, greetCallback)
	npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

	npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

	npcType:register(npcConfig)
end
