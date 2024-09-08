local function revertCask(position)
	local caskItem = Tile(position):getItemById(9822)
	if caskItem then
		caskItem:transform(5677)
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 5 then
		item:transform(9822)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		addEvent(revertCask, 3 * 60 * 1000, toPosition)
	elseif szansa >= 6 and szansa <= 7 then
		item:transform(9822)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(5678, 1)
		addEvent(revertCask, 3 * 60 * 1000, toPosition)
	elseif szansa >= 9 then
		item:transform(9822)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(5678, 2)
		addEvent(revertCask, 3 * 60 * 1000, toPosition)
	end
	return true
end

action:id(5677)
action:register()
