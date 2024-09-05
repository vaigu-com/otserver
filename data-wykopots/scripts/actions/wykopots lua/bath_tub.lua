local bathtubDrain = Action()
function bathtubDrain.onUse(player, item, fromPosition, itemEx, toPosition)
	local tile = Tile(fromPosition)
	if tile and tile:getTopCreature() then
		return false
	end

	item:transform(BATHTUB_EMPTY)
	item:getPosition():sendMagicEffect(CONST_ME_LOSEENERGY)
end

bathtubDrain:id(BATHTUB_FILLED)
bathtubDrain:register()

local bathtubFill = Action()
function bathtubFill.onUse(player, item, fromPosition, itemEx, toPosition)
	local tile = Tile(fromPosition)
	if tile and tile:getTopCreature() then
		return false
	end

	item:transform(BATHTUB_FILLED)
	item:getPosition():sendMagicEffect(CONST_ME_WATERSPLASH)
end

bathtubFill:id(BATHTUB_EMPTY)
bathtubFill:register()
