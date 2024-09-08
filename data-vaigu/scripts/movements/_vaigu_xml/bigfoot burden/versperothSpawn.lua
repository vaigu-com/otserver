local versperothPosition = Position(7488, 1378, 11) --{x = 7488, y = 1378, z = 11}

local function removeMinion(mid)
	local monster = Monster(mid)
	if monster then
		monster:getPosition():sendMagicEffect(CONST_ME_POFF)
		monster:remove()
	end
end

local function executeVersperothBattle(mid)
	if Game.getStorageValue(GlobalStorage.Versperoth.Battle) ~= 1 then
		return
	end

	if mid then
		local monster = Monster(mid)
		if not monster then
			return
		end

		Game.setStorageValue(GlobalStorage.Versperoth.Health, monster:getMaxHealth() - monster:getHealth())
		monster:remove()
		versperothPosition:sendMagicEffect(CONST_ME_POFF)
		local hole = Game.createItem(16172, 1, versperothPosition)

		local position, minionMonster
		for i = 1, math.random(8, 10) do
			position = Position(math.random(7479, 7499), math.random(1370, 1387), 11)
			minionMonster = Game.createMonster("Minion of Versperoth", position)
			position:sendMagicEffect(CONST_ME_TELEPORT)
			if minionMonster then
				addEvent(removeMinion, 20 * 1000, minionMonster.uid)
			end
		end
		addEvent(executeVersperothBattle, 10 * 1000)
		return
	end

	local monster = Game.createMonster("Versperoth", versperothPosition, false, true)
	if monster then
		versperothPosition:sendMagicEffect(CONST_ME_GROUNDSHAKER)
		monster:addHealth(-Game.getStorageValue(GlobalStorage.Versperoth.Health))
		local hole = Tile(versperothPosition):getItemById(16172)
		if hole then
			hole:remove()
		end
		addEvent(executeVersperothBattle, 20 * 1000, monster.uid)
	end
end

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if false and Game.getStorageValue(GlobalStorage.Versperoth.Battle) >= 1 then
		return true
	end

	player:teleportTo(Position(7485, 1377, 11)) --{x = 7485, y = 1377, z = 11}
	Game.setStorageValue(GlobalStorage.Versperoth.Battle, 1)
	Game.setStorageValue(GlobalStorage.Versperoth.Health, 0)
	executeVersperothBattle()
	if item then
		item:remove()
	end
	return true
end

movement:type("stepin")
movement:id(16173)
movement:register()
