local boneFiddleBase = Action()

function boneFiddleBase.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 28489 then
		target:remove(1)
		item:remove(1)
		player:addItem(28492)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		return true
	end
end

boneFiddleBase:id(28491)
boneFiddleBase:register()

local boneFiddleString = Action()

function boneFiddleString.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 28492 then
		target:remove(1)
		item:remove(1)
		player:addItem(28493)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		return true
	end
end

boneFiddleString:id(28490)
boneFiddleString:register()
