local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	gatepos = { x = 5773, y = 1321, z = 10, stackpos = 1 }
	getgate = getThingfromPos(gatepos)

	if item.uid == 2009 and item.itemid == 2772 and getgate.itemid == 2184 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	elseif item.uid == 2009 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(2184, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		doPlayerSendCancel(player, "Sorry, not possible.")
	end
	return 1
end

action:uid(2009)
action:register()
