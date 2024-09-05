local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	if itemId == 2116 then
		item:transform(2117)
		return true
	else
		item:transform(2116)
		return true
	end
end
action:id(2116, 2117)
action:register()
