	:Script(function(storageToRequiredState)
local gateLever = Action()
function gateLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local gatePos = JANUSZEX_ANCHOR:Moved(-183, 2, 2)
	local gateTile = Tile(gatePos)
	local gate = gateTile:getItemById(2185)
	if gate then
		gate:remove()
	else
		Game.createItem(2185, 1, gatePos)
	end
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	return true
end
gateLever:aid(Storage.ProdigalSon.BlackBoardLever1)
gateLever:register()

local waterfallLever = Action()
function waterfallLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local waterfallPos = JANUSZEX_ANCHOR:Moved(-174, 5, 5)
	local waterfallTile = Tile(waterfallPos)
	local waterfall = waterfallTile:getItemById(1717)
	if waterfall then
		waterfall:remove()
		addEvent(function()
			Game.createItem(1717, 1, waterfallPos)
		end, 60 * 2 * 1000)
		fromPosition:sendMagicEffect(CONST_ME_MAGIC_BLUE)
	end
	return true
end
waterfallLever:aid(Storage.ProdigalSon.BlackBoardLever2)
waterfallLever:register()
end)
