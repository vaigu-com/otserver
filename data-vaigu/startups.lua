function LoadStartupNpcs(npcs, anchor)
	for _, npcData in pairs(npcs) do
		local pos = npcData.pos or npcData.position or npcData.offset
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end
		if not Tile(pos) then
			logger.warn(T("TRYING TO CREATE NPC :name: ON NONEXISTANT TILE POSITION:", { name = npcData.name }))
			PrintPosition(pos, true)
		end
		local npc = Game.createNpc(npcData.name, pos)
		if not npc then
			logger.warn(T("Could not create npc :name:", { name = npcData.name }))
			PrintPosition(pos, true)
		end
		npc:setMasterPos(pos)
	end
end

function LoadStartupMonsters(monsters, anchor)
	for _, monsterData in pairs(monsters) do
		local pos = monsterData.pos or monsterData.position or monsterData.offset
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end

		local monster = Game.createMonster(monsterData.name, pos)
		if not Tile(pos) then
			logger.warn(T("TRYING TO CREATE MONSTER :name: ON NONEXISTING TILE POSITION:", { name = monsterData.ame }))
			PrintPosition(pos, true)
		end
		if not monster then
			logger.warn(T("Could not create monster :name:", { name = monsterData.name }))
			PrintPosition(pos, true)
		end
	end
end

local function normalizeItemData(itemData, anchor)
	local context = {}
	context.id = itemData.id
	context.count = itemData.count or 1
	context.aid = itemData.actionid or itemData.aid or itemData.actionId
	context.uid = itemData.uniqueid or itemData.uid or itemData.uniqueId
	context.key = itemData.key
	context.desc = itemData.description or itemData.desc
	context.text = itemData.text
	context.rewards = itemData.rewards
	context.requiredState = itemData.requiredState
	context.nextState = itemData.nextState
	context.expReward = itemData.expReward or itemData.exp or itemData.experience
	context.specialActionsOnSuccess = itemData.specialActionsOnSuccess
	context.specialActionsOnFail = itemData.specialActionsOnFail
	context.onLook = itemData.onLook or itemData.onlook
	context.immovable = itemData.immovable
	local pos = itemData.pos or itemData.offset or itemData.position or itemData.offpos or itemData.vector
	if pos then
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end
		if pos.x == 0 or pos.y == 0 then
			logger.warn("[normalizeItemData] Resulting pos has x or y equal to 0")
		end
	end
	context.pos = pos
	context.source = itemData.source
	return context
end

local function hasId(context)
	return context.id
end

---@deprecated
local function registerOnUseDeclaration(context, anchor)
	context = normalizeItemData(context, anchor)
	logger.warn("[loadStartupItem] is deprecated, item id: " .. context.id)
	-- CustomItemRegistry:Register(context)

	local itemHasId = false
	if hasId(context) then
		itemHasId = true
	end

	if itemHasId then
		print("---------------------")
		if itemHasId then
			logger.warn("[loadStartupItem] item has id. Not registering.")
		end
		PrintAnything(context)
		return
	end

	local action = Action()
	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		ResolutionContext.FromCustomItemState(context):Resolve()
	end
	action:key(context.key)
	action:register()
end

function RegisterOnUseDeclaration(items, anchor)
	for _, itemData in pairs(items) do
		registerOnUseDeclaration(itemData, anchor)
	end
end
