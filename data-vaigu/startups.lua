function LoadStartupNpcs(npcs, anchor)
	for _, npcData in pairs(npcs) do
		local pos = npcData.pos or npcData.position or npcData.offset
		if anchor then
			pos = anchor:Moved(pos)
		else
			pos = ExtractCoords(pos)
		end
		if not Tile(pos) then
			print(T("TRYING TO CREATE NPC :name: ON NONEXISTANT TILE POSITION:", { name = npcData.name }))
			PrintPosition(pos, true)
		end
		local npc = Game.createNpc(npcData.name, pos)
		if not npc then
			print(T("Could not create npc :name:", { name = npcData.name }))
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
			print(T("TRYING TO CREATE MONSTER :name: ON NONEXISTING TILE POSITION:", { name = monsterData.ame }))
			PrintPosition(pos, true)
		end
		if not monster then
			print(T("Could not create monster :name:", { name = monsterData.name }))
			PrintPosition(pos, true)
		end
	end
end

local function createCustomItemOnMap(context)
	local id = context.id
	local count = context.count
	local aid = context.aid
	local uid = context.uid
	local desc = context.desc
	local text = context.text

	local pos = context.pos
	local item = Game.createItem(id, count, pos)
	if not item then
		print(debug.traceback(T("Cannot create item :id:, on position :pos:", { id = id, pos = pos:ToString() })))
		return
	end
	if context.immovable == true then
		item:setUniqueId(1000)
	end
	if aid and aid ~= 0 then
		item:setActionId(aid)
		item:setUniqueId(1000)
	end
	if uid and uid ~= 0 then
		item:setUniqueId(uid)
	end

	if desc and type(desc) == "string" then
		item:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
	end
	if text and type(text) == "string" then
		item:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
	end
end

local function normalizeItemData(itemData, anchor)
	local context = {}
	context.id = itemData.id
	context.count = itemData.count or 1
	context.aid = itemData.actionid or itemData.aid or itemData.actionId
	context.uid = itemData.uniqueid or itemData.uid or itemData.uniqueId
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
			pos = nil
		end
	end
	context.pos = pos
	return context
end

local function itemWontBeCreatedOrRegistered(context)
	if context.pos then
		return false
	end
	if context.aid and context.aid ~= 0 then
		return false
	end
	return true
end

local function loadStartupItem(itemConfig, anchor)
	local context = normalizeItemData(itemConfig, anchor)

	if context.pos then
		createCustomItemOnMap(context)
	end
	if context.aid and context.aid ~= 0 then
		CustomItemRegistry():Register(context)
	end
	if itemWontBeCreatedOrRegistered(context) then
		logger.debug(T("[loadStartupItem] Item declared wont be created of registered. This renders this item declaration useless."))
		logger.debug(debug.traceback())
	end
end

function LoadStartupItems(items, anchor)
	for _, itemData in pairs(items) do
		loadStartupItem(itemData, anchor)
	end
end
