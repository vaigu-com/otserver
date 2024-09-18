local metalPile = Action()
function metalPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.stoneTrash, 1, player:getPosition())
	return true
end
metalPile:aid(Storage.ProdigalSon.CalculatorMaking.MetalPile)
metalPile:register()

local woodPile = Action()
function woodPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.woodTrash, 1, player:getPosition())
	return true
end
woodPile:aid(Storage.ProdigalSon.CalculatorMaking.WoodPile)
woodPile:register()

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local materialsPos = fromPosition:Moved(-1, -1, 0)
	local materialTile = Tile(materialsPos)
	local wood = materialTile:getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.woodTrash)
	local metal = materialTile:getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.stoneTrash)

	if wood and metal then
		wood:remove(1)
		metal:remove(1)
		Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.doneCalculator, 1, materialsPos)
		materialsPos:sendMagicEffect(CONST_ME_LOSEENERGY)
	end
	return true
end
lever:aid(Storage.ProdigalSon.CalculatorMaking.Lever)
lever:register()
