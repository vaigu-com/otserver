local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isMonster(itemEx.uid) and getCreatureName(itemEx.uid) == "Sin Devourer" then
		doSendMagicEffect(getCreaturePosition(itemEx.uid), CONST_ME_HOLYAREA)
		doCreatureSay(itemEx.uid, "The Sin Devourer has been driven out!", TALKTYPE_ORANGE_1)
		doRemoveItem(item.uid, 1)
		doRemoveCreature(itemEx.uid)
	end
	return true
end
action:id(15697)
action:register()
