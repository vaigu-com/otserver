local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:addItem(6526, 1)
	item:remove()
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	return true
end

action:id(6496)
action:register()
