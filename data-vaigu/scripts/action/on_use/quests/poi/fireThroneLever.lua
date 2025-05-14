local lava = {
	Position(6213, 1775, 15),
	Position(6214, 1774, 15),
	Position(6213, 1774, 15),
	Position(6214, 1775, 15),
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lavaTile
	for i = 1, #lava do
		lavaTile = Tile(lava[i]):getGround()
		if lavaTile and isInArray({ 410, 21477 }, lavaTile.itemid) then
			lavaTile:transform(lavaTile.itemid == 21477 and 410 or 21477)
			lava[i]:sendMagicEffect(CONST_ME_SMOKE)
		end
	end

	item:remove()
	return true
end

action:uid(50106)
action:register()
