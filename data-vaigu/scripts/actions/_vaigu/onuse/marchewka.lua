local function revertCask(position)
	local caskItem = Tile(position):getItemById(15636)
	if caskItem then
		caskItem:transform(15635)
		position:sendMagicEffect(CONST_ME_GREENSMOKE)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 4 then
		item:transform(15636)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif szansa >= 5 and szansa <= 7 then
		item:transform(15636)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3595, 1)
	elseif szansa >= 8 then
		item:transform(15636)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3595, 2)
	end
	addEvent(revertCask, 3 * 60 * 1000, toPosition) --3min
	return true
end

action:id(15635)
action:register()
