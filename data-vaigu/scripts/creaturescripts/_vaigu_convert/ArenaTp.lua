local function spawnMonster(arenaroom, monster)
	local monster = Game.createMonster(monster, rooms[arenaroom].centerPosition, true, true)
end

local function clearFields(arenaroom)
	local upX = (rooms[arenaroom].centerPosition).x - 5
	local downX = (rooms[arenaroom].centerPosition).x + 5
	local upY = (rooms[arenaroom].centerPosition).y - 5
	local downY = (rooms[arenaroom].centerPosition).y + 5

	local upCorner = { x = upX, y = upY, z = 7 }
	local downCorner = { x = downX, y = downY, z = 7 }
	for i = upCorner.x, downCorner.x do
		for j = upCorner.y, downCorner.y do
			for k = upCorner.z, downCorner.z do
				local tile = Tile(i, j, k)
				if tile then
					local fireBomb = tile:getItemById(2118)
					local fireBomb2 = tile:getItemById(2119)
					local poisBomb = tile:getItemById(105)
					local eneBomb = tile:getItemById(2122)
					if fireBomb then
						fireBomb:remove()
					elseif fireBomb2 then
						fireBomb2:remove()
					elseif poisBomb then
						poisBomb:remove()
					elseif eneBomb then
						eneBomb:remove()
					end
				end
			end
		end
	end
end

local creatureevent = CreatureEvent("ArenaMonsterDeath")

function creatureevent.onDeath(creature)
	local targetMonster = creature:getMonster()
	if not targetMonster or targetMonster:getMaster() then
		return true
	end

	local targetName = targetMonster:getName():lower()
	onDeathForDamagingPlayers(creature, function(creature, player)
		if isInArray(arena_bosses, targetName) then
			for i = 1, 30 do
				if arena_bosses[i] == targetName then
					local event_id = player:getStorageValue(299)
					stopEvent(event_id)
					local arenaroom = player:getStorageValue(300)
					if i == 10 or i == 20 or i == 30 then
						i = i / 10
						player:setStorageValue(300 + i, 2)
						player:setStorageValue(26099 + i, 1)
						player:teleportTo(Position(6918, 630, 7))
						player:say("Wrogowie zostali pokonani!", TALKTYPE_MONSTER_SAY)
						clearFields(arenaroom)
						return true
					end
					player:addHealth(player:getMaxHealth())
					player:addMana(500)
					local monster = arena_bosses[i + 1]
					if i <= 10 then
						addEvent(spawnMonster, 5 * 1000, arenaroom, monster)
						player:say("Kolejny przeciwnik pojawi sie w ciagu 5sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
					elseif i > 10 and i <= 20 then
						addEvent(spawnMonster, 7 * 1000, arenaroom, monster)
						player:say("Kolejny przeciwnik pojawi sie w ciagu 7sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
					elseif i > 20 then
						addEvent(spawnMonster, 10 * 1000, arenaroom, monster)
						player:say("Kolejny przeciwnik pojawi sie w ciagu 10sek. Masz 7min na jego pokonanie.", TALKTYPE_MONSTER_SAY)
					end
					event_id = addEvent(clearArena, 7 * 60 * 1000, player.uid, monster.uid, arenaroom)
					player:setStorageValue(299, event_id)
					return true
				end
			end
		end
	end)

	return true
end
creatureevent:register()
