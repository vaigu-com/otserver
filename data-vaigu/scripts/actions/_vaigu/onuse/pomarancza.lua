local function revertCask(position)
	local caskItem = Tile(position):getItemById(3744)
	if caskItem then
		caskItem:transform(3742)
		position:sendMagicEffect(CONST_ME_SMALLPLANTS)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(10)
	if szansa <= 4 then
		item:transform(3744)
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif szansa >= 5 and szansa <= 7 then
		item:transform(3744)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3586, 1)
	elseif szansa >= 8 then
		item:transform(3744)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:addItem(3586, 2)
	end
	addEvent(revertCask, 5 * 60 * 1000, toPosition) --5min
	return true
end

action:id(3742)
action:register()
