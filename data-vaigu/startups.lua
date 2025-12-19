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

local function registerOnUseDeclaration(context)
	context = normalizedItemData(context)
	local action = Action()
	function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
		local resolutionContext = ResolutionContext.FromCustomItemState(context)
		resolutionContext:SetPlayer(player):SetTargetItem(item):SetTargetCreature(target)
		local status = resolutionContext:Resolve()
		if status ~= SUCCESS_RESOLVE then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("The :itemName: is empty.", { itemName = ItemType(item:getId()):getName() }))
		end
		return DONT_OPEN_CONTAINER_ON_USE
	end
	action:key(context.key)
	action:register()
end

function RegisterOnUseDeclarations(contexts)
	for _, context in pairs(contexts) do
		registerOnUseDeclaration(context)
	end
end
