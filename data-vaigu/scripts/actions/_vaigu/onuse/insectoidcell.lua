local function revertCask(position)
	local caskItem = Tile(position):getItemById(12959)
	if caskItem then
		caskItem:transform(12937)
		position:sendMagicEffect(CONST_ME_HITBYPOISON)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 5 then
		item:remove()
		Game.createItem(12959, 1, toPosition)
	elseif szansa > 5 and szansa <= 8 then
		item:remove()
		Game.createItem(12959, 1, toPosition)
		player:addItem(14172, 1)
	elseif szansa > 8 then
		item:remove()
		Game.createItem(12959, 1, toPosition)
		player:addItem(14172, 2)
	end
	addEvent(revertCask, 10 * 60 * 1000, toPosition) --10min
	fromPosition:sendMagicEffect(CONST_ME_HITBYPOISON)
	return true
end

action:id(12937, 12938)
action:register()
