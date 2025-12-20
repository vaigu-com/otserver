local config = {
	[11040] = { flamePosition = Position(6629, 1112, 7), toPosition = Position(6556, 1238, 10) },
}
local tombCoalBasin = MoveEvent()

function tombCoalBasin.onAddItem(moveitem, tileitem, position)
	local targetCoalBasin = config[tileitem.uid]
	if not targetCoalBasin then
		return true
	end

	if moveitem.itemid ~= 3042 then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	moveitem:remove()
	position:sendMagicEffect(CONST_ME_HITBYFIRE)

	Tile(targetCoalBasin.flamePosition):relocateTo(targetCoalBasin.toPosition)
	targetCoalBasin.toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

tombCoalBasin:type("additem")
tombCoalBasin:id(2114)
tombCoalBasin:register()
