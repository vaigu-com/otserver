local firelever1 = Action()

function firelever1.onUse(cid, item, frompos, item2, topos)
	gatepos = { x = 6376, y = 1399, z = 9, stackpos = 1 } --{x = 6376, y = 1399, z = 9}
	getgate = getThingfromPos(gatepos)

	if item.uid == 2003 and item.itemid == 2772 and getgate.itemid == 1791 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	elseif item.uid == 2003 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(1791, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end
	return 1
end

firelever1:uid(2003)
firelever1:register()

local firelever2 = Action()

function firelever2.onUse(cid, item, frompos, item2, topos)
	gatepos = { x = 6416, y = 1437, z = 9, stackpos = 1 } --{x = 6416, y = 1437, z = 9}
	getgate = getThingfromPos(gatepos)

	if item.uid == 2006 and item.itemid == 2772 and getgate.itemid == 1791 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	elseif item.uid == 2006 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(1791, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end
	return 1
end

firelever2:uid(2006)
firelever2:register()

local firelever3 = Action()

function firelever3.onUse(cid, item, frompos, item2, topos)
	gatepos = { x = 6435, y = 1420, z = 9, stackpos = 2 } --{x = 6435, y = 1420, z = 9}
	getgate = getThingfromPos(gatepos)

	if item.uid == 2007 and item.itemid == 2772 and getgate.itemid == 1791 then
		doRemoveItem(getgate.uid, 1)
		doTransformItem(item.uid, item.itemid + 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	elseif item.uid == 2007 and item.itemid == 2773 and getgate.itemid == 0 then
		doCreateItem(1791, 1, gatepos)
		doTransformItem(item.uid, item.itemid - 1)
		Position(gatepos):sendMagicEffect(CONST_ME_BLOCKHIT)
	else
		doPlayerSendCancel(cid, "Sorry, not possible.")
	end
	return 1
end

firelever3:uid(2007)
firelever3:register()
