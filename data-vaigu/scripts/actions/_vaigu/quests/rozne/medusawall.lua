local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	gatepos = { x = 6646, y = 811, z = 10, stackpos = 2 }
	getgate = getThingfromPos(gatepos)

	if item.uid == 2010 and item.itemid == 2772 and getgate.itemid == 1791 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_PLANTATTACK)
	elseif item.uid == 2010 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(1791, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_PLANTATTACK)
	else
		doPlayerSendCancel(player, "Sorry, not possible.")
	end
	return 1
end

action:uid(2010)
action:register()
