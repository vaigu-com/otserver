local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item:getId() == 7183 then
		item:transform(7184)
	else
		item:transform(7183)
	end
	return true
end

action:id(7183, 7184)
action:register()
