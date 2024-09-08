local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	gatepos = { x = 5741, y = 1420, z = 12, stackpos = 1 }
	getgate = getThingfromPos(gatepos)

	if item.uid == 2004 and item.itemid == 2772 and getgate.itemid == 2129 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_FIREAREA)
	elseif item.uid == 2004 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(2129, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
	else
		doPlayerSendCancel(player, "Sorry, not possible.")
	end
	return 1
end
action:uid(2004)
action:register()
