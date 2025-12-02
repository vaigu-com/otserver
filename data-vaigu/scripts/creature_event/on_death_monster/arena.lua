local function createMonsterArena(arenaroom, monster)
	Game.createMonster(monster, rooms[arenaroom].centerPosition, true, true)
end

local fieldIds = {
	2118,
	2119,
	105,
	2122,
}

local function clearFields(arenaroom)
	local area = Area.FromSquareRadius(rooms[arenaroom].centerPosition, 5)
	local corner1, corner2 = area:GetCorners()
	IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		local tile = Tile(pos)
		if not tile then
			return
		end

		for _, fieldId in pairs(fieldIds) do
			local item = tile:getItemById(fieldId)
			if item then
				item:remove()
			end
		end
	end)
end

local arenaMonsterDeathStartup = GlobalEvent("ArenaMonsterDeathStartup")
function arenaMonsterDeathStartup.onStartup()
	for _, monsterName in pairs(arena_bosses) do
		local mType = MonsterType(monsterName)
		if not mType then
			logger.error("[ArenaMonsterDeathStartup] monster with name {} is not a valid MonsterType", monsterName)
		else
			mType:registerEvent("ArenaMonsterDeath")
		end
	end
end
arenaMonsterDeathStartup:register()

local arenaMonsterEvent = CreatureEvent("ArenaMonsterDeath")
function arenaMonsterEvent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local targetName = targetMonster:getName():lower()
	onDeathForDamagingPlayers(creature, function(creature, player)
		if not isInArray(arena_bosses, targetName) then
			return
		end
		for i = 1, 30 do
			if arena_bosses[i] == targetName then
				local event_id = player:getStorageValueByKey("299")
				stopEvent(event_id)
				local arenaroom = player:getStorageValueByKey("300")
				if i == 10 or i == 20 or i == 30 then
					i = i / 10
					player:setStorageValueByKey(tostring(300 + i), 2)
					player:setStorageValueByKey(tostring(26099 + i), 1)
					player:teleportTo(Position(6918, 630, 7))
					player:say("Wrogowie zostali pokonani!", TALKTYPE_MONSTER_SAY)
					clearFields(arenaroom)
					return true
				end
				player:addHealth(player:getMaxHealth())
				player:addMana(500)
				local monster = arena_bosses[i + 1]
				if i <= 10 then
					addEvent(createMonsterArena, 5 * 1000, arenaroom, monster)
					player:say("Kolejny przeciwnik pojawi sie w ciagu 5sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
				elseif i > 10 and i <= 20 then
					addEvent(createMonsterArena, 7 * 1000, arenaroom, monster)
					player:say("Kolejny przeciwnik pojawi sie w ciagu 7sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
				elseif i > 20 then
					addEvent(createMonsterArena, 10 * 1000, arenaroom, monster)
					player:say("Kolejny przeciwnik pojawi sie w ciagu 10sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
				end
				event_id = addEvent(clearArena, 7 * 60 * 1000, player.uid, monster.uid, arenaroom)
				player:setStorageValueByKey("299", event_id)
				return true
			end
		end
	end)

	return true
end
arenaMonsterEvent:register()
