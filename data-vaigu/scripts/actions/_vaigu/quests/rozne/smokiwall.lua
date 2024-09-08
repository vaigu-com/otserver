local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	gatepos = { x = 5965, y = 1601, z = 11, stackpos = 1 }
	getgate = getThingfromPos(gatepos)

	if item.uid == 2012 and item.itemid == 2772 and getgate.itemid == 1791 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_FIREAREA)
	elseif item.uid == 2012 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(1791, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_FIREAREA)
	else
		doPlayerSendCancel(player, "Sorry, not possible.")
	end
	return 1
end

action:uid(2012)
action:register()
