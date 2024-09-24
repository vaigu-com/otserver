	:Script(function(storageToRequiredState)
local metalPile = Action()
function metalPile.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local metalPiece = Tile(fromPosition):getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.metalPiece)
	if metalPiece then
		return
	end
	Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.metalPiece, 1, fromPosition)

	return true
end
metalPile:aid(Storage.ProdigalSon.PliersMaking.MetalPile)
metalPile:register()

local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local metalPiecePos = fromPosition:Moved(-3, 3, 0)
	local metalPiece = Tile(metalPiecePos):getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.metalPiece)
	if metalPiece then
		metalPiece:remove(1)
		Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.donePliers, 1, player:getPosition())
		fromPosition:sendMagicEffect(CONST_ME_POFF)
	end
	return true
end
lever:aid(Storage.ProdigalSon.PliersMaking.Lever)
lever:register()
end)
