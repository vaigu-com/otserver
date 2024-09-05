local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 3614 then
		return false
	end

	item:remove(1)
	player:addItem(12550, 1)
	toPosition:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
	return true
end

action:id(12804)
action:register()
