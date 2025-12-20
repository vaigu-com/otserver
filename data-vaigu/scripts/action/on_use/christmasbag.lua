local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	player:AddCustomItem({ id = 6526, count = 1 })
	item:remove()
	player:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
	return true
end

action:id(6496)
action:register()
