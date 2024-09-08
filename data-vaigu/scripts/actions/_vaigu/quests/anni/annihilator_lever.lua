local config = {
	centerDemonRoomPosition = Position(5686, 1458, 14),
	entranceTiles = {
		Position(5687, 1470, 14),
		Position(5688, 1470, 14),
		Position(5689, 1470, 14),
		Position(5690, 1470, 14),
	},
	newPositions = {
		Position(5684, 1458, 14),
		Position(5685, 1458, 14),
		Position(5686, 1458, 14),
		Position(5687, 1458, 14),
	},
	demonPositions = {
		Position(5684, 1456, 14),
		Position(5686, 1456, 14),
		Position(5685, 1460, 14),
		Position(5687, 1460, 14),
		Position(5689, 1458, 14),
		Position(5688, 1458, 14),
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2773 then
		local storePlayers, playerTile = {}

		for i = 1, #config.entranceTiles do
			playerTile = Tile(config.entranceTiles[i]):getTopCreature()
			if not playerTile or not playerTile:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Potrzebujesz czterech graczy.")
				return true
			end

			storePlayers[#storePlayers + 1] = playerTile
		end

		local specs, spec = Game.getSpectators(config.centerDemonRoomPosition, false, false, 3, 3, 2, 2)
		for i = 1, #specs do
			spec = specs[i]
			if spec:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Poczekaj, az poprzednia druzyna skonczy.")
				return true
			end

			spec:remove()
		end

		for i = 1, #config.demonPositions do
			Game.createMonster("Demon", config.demonPositions[i], true, true)
		end

		local players
		for i = 1, #storePlayers do
			players = storePlayers[i]
			config.entranceTiles[i]:sendMagicEffect(CONST_ME_POFF)
			players:teleportTo(config.newPositions[i])
			config.newPositions[i]:sendMagicEffect(CONST_ME_ENERGYAREA)
			players:setDirection(DIRECTION_EAST)
		end
	end

	item:transform(item.itemid == 2773 and 2772 or 2773)
	return true
end

action:uid(2208)
action:register()
