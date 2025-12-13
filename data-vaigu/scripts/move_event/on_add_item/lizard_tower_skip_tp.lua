Storage.LizardTower = {
	BasinToInside = {},
	BasinToOutside = {},
}

local offering = 11673

local drakenHuntingPlace = Position(6571, 990, 9)
local justOutsideTheTower = Position(6423, 932, 4)

local basinToDestination = {
	[Storage.LizardTower.BasinToInside] = drakenHuntingPlace,
	[Storage.LizardTower.BasinToOutside] = justOutsideTheTower,
}

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
	topPlayer:teleportTo(basinToDestination[tileitem:getKey()])
	return true
end
tombCoalBasin:type("additem")
tombCoalBasin:key(Storage.LizardTower.BasinToInside)
tombCoalBasin:register()
