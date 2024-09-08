local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2773 then
		return false
	end

	toPosition.x = toPosition.x - 1
	toPosition.y = toPosition.y + 1

	local stone = Tile(toPosition):getItemById(1791)
	if stone then
		stone:remove()
	end

	item:remove()
	return true
end

action:aid(50160)
action:register()
