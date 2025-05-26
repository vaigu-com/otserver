Storage.WerelionSanctum = {
	Basin = {},
}

local innerSanctum = Position(6463, 1136, 8)

local tombCoalBasin = MoveEvent()
function tombCoalBasin.onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= ItemId.SCARAB_COIN then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local topCreature = Tile(position:Moved(0, 1, 0)):getTopCreature()
	if not topCreature then
		return true
	end

	local topPlayer = topCreature:getPlayer()
	if not topPlayer then
		return true
	end

	moveitem:remove()
	position:sendMagicEffect(CONST_ME_HITBYFIRE)
	topPlayer:teleportTo(innerSanctum)
	return true
end
tombCoalBasin:type("additem")
tombCoalBasin:key(Storage.WerelionSanctum.Basin)
tombCoalBasin:register()
