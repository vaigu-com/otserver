local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local roll = math.random(10)
	if roll <= 6 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif roll >= 7 and roll <= 8 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:AddCustomItem({ id = 3587, count = 1 })
	elseif roll >= 9 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		player:AddCustomItem({ id = 3587, count = 2 })
	end
	item:transform(5091)
	return true
end
action:id(5093)
action:register()
