local function revertCask(position)
	local caskItem = Tile(position):getItemById(5155)
	if caskItem then
		caskItem:transform(5156)
		position:sendMagicEffect(CONST_ME_SMALLPLANTS)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 5 then
		item:transform(5155)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif szansa >= 6 and szansa <= 8 then
		item:transform(5155)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(5096, 1)
	elseif szansa >= 9 then
		item:transform(5155)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(5096, 2)
	end
	addEvent(revertCask, 5 * 60 * 1000, toPosition) --5min
	return true
end

action:id(5156)
action:register()
