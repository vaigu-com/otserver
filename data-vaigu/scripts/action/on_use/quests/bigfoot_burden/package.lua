local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	item:transform(item.itemid - 1)
	return true
end

action:id(15802)
action:register()
