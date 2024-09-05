local config = {
	snake = {
		{ position = Position(6435, 591, 11), itemId = 2086 },
		{ position = Position(6436, 591, 11), itemId = 2087 },
	},
}

local function revertSnake(toPosition)
	for i = 1, #config.snake do
		local createSnake = Game.createItem(config.snake[i].itemId, 1, config.snake[i].position)
		if createSnake then
			createSnake:setActionId(2158)
		end
		local thrash = Tile(toPosition):getItemById(3141)
		if thrash then
			thrash:remove()
		end
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 2086 or target.itemid == 2087 then
		local snakeAid = target.actionid
		if snakeAid == 2158 then
			if player:getStorageValue(Storage.TheApeCity.QuestProgress) ~= 17 or player:getStorageValue(Storage.TheApeCity.SnakeDestroyer) == 1 then
				return false
			end
			player:setStorageValue(Storage.TheApeCity.SnakeDestroyer, 1)
			target:transform(3141)
			item:remove()
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			addEvent(revertSnake, 60 * 1000, toPosition)
			return true
		end
	end
end

action:id(4835)
action:register()
