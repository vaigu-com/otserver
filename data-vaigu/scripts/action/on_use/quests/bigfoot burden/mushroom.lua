local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local spore = Game.createItem(math.random(15705, 15708), 1, toPosition)
	if spore then
		spore:decay()
	end
	return true
end

action:id(15704)
action:register()
