local function revertCask(position)
	local caskItem = Tile(position):getItemById(3640)
	if caskItem then
		caskItem:transform(5095)
		position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 8 then
		item:transform(3640)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif szansa >= 9 then
		item:transform(3640)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3589, 1)
	end
	addEvent(revertCask, 15 * 60 * 1000, toPosition) --15min
	return true
end

action:id(5095)
action:register()
