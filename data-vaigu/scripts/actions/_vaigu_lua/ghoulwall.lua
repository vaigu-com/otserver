local ghoulWall = Action()

function ghoulWall.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	gatepos = { x = 5823, y = 1628, z = 9, stackpos = 1 }
	getgate = getThingfromPos(gatepos)

	if item.itemid == 2772 and getgate.itemid == 2185 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	elseif item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(2185, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		doPlayerSendCancel(player, "Sorry, not possible.")
	end
	return 1
end

ghoulWall:aid(2100)
ghoulWall:register()
