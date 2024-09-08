local function doCreateDummy(cid, position)
	local player = Player(cid)
	if not player then
		return true
	end

	local tile = Tile(position)
	if tile then
		local thing = tile:getTopVisibleThing()
		if thing and isInArray({ 15710, 15711 }, thing.itemid) then
			thing:remove()
		end
	end

	if player:getStorageValue(Storage.BigfootBurden.Shooting) >= 5 then
		player:setStorageValue(Storage.BigfootBurden.QuestLine, 9)
		return
	end

	position:sendMagicEffect(CONST_ME_POFF)
	Game.createItem(math.random(15710, 15711), 1, position)
	addEvent(doCreateDummy, 2 * 1000, cid, position)
end

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValue(Storage.BigfootBurden.QuestLine) ~= 8 then
		player:teleportTo(fromPosition)
		return true
	end

	local playerPosition = player:getPosition()
	player:setStorageValue(Storage.BigfootBurden.Shooting, 0)
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	doCreateDummy(player.uid, Position(playerPosition.x, playerPosition.y - 5, 9))
	return true
end

movement:type("stepin")
movement:aid(8030)
movement:register()
