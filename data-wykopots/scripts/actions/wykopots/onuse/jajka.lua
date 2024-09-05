local function revertCask(position)
	local caskItem = Tile(position):getItemById(12676)
	if caskItem then
		caskItem:transform(12677)
		position:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local szansa = math.random(100)
	if szansa <= 30 then
		item:transform(12676)
	elseif szansa > 30 and szansa <= 50 then
		item:transform(12676)
		player:addItem(5890, 1)
	elseif szansa > 50 and szansa <= 80 then
		item:transform(12676)
		player:addItem(3606, 1)
	elseif szansa > 80 and szansa <= 97 then
		item:transform(12676)
		player:addItem(3606, 2)
	elseif szansa >= 98 then
		item:transform(12676)
		player:addItem(6545, 1)
	end
	addEvent(revertCask, 10 * 60 * 1000, toPosition) --10min
	fromPosition:sendMagicEffect(CONST_ME_POFF)
	return true
end

action:id(12677)
action:register()
