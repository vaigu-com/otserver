local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	if creature:getName():lower() ~= "mushroom sniffer" then
		return true
	end

	local moldFloor = Tile(toPosition):getItemById(15829)
	if moldFloor.actionid == 100 then
		return true
	end

	if math.random(3) < 3 then
		moldFloor:transform(15701)
		moldFloor:decay()
		toPosition:sendMagicEffect(CONST_ME_POFF)
	else
		moldFloor:transform(15830)
		moldFloor:decay()
		toPosition:sendMagicEffect(CONST_ME_GROUNDSHAKER)
	end
	return true
end

movement:type("stepin")
movement:id(15829)
movement:register()
