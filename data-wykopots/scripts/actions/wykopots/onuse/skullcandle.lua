local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local itemId = item:getId()
	local targetId = target:getId()
	if itemId == 3114 and targetId == 2917 then
		item:remove(1)
		target:transform(5813)
		return true
	end
end

action:id(3114)
action:register()
