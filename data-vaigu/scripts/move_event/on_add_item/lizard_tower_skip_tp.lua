Storage.LizardTower = {
	Basin = {},
}

local offering = 11673

local drakenHuntingPlace = Position(6571, 990, 9)

local tombCoalBasin = MoveEvent()
function tombCoalBasin.onAddItem(moveitem, tileitem, position)
	if moveitem:getId() ~= offering then
		position:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local topCreature = Tile(position:Moved(-1, 0, 0)):getTopCreature()
	if not topCreature then
		return true
	end

	local topPlayer = topCreature:getPlayer()
	if not topPlayer then
		return true
	end

	moveitem:remove(1)
	position:sendMagicEffect(CONST_ME_HITBYFIRE)
	topPlayer:teleportTo(drakenHuntingPlace)
	return true
end
tombCoalBasin:type("additem")
tombCoalBasin:key(Storage.LizardTower.Basin)
tombCoalBasin:register()
