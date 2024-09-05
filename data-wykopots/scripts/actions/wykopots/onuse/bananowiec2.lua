local function revertCask(position)
	local caskItem = Tile(position):getItemById(5092)
	if caskItem then
		caskItem:transform(5094)
		position:sendMagicEffect(CONST_ME_HITBYPOISON)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 6 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif szansa >= 7 and szansa <= 8 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3587, 1)
	elseif szansa >= 9 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3587, 2)
	end
	addEvent(revertCask, 5 * 60 * 1000, toPosition) --5min
	item:transform(5092)
	return true
end

action:id(5094)
action:register()
