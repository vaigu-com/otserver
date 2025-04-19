local saw = Action()

function saw.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 5901 then
		return false
	end

	target:transform(target.itemid, target.type - 1)
	player:AddCustomItem({id = 9114, count = 1})
	toPosition:sendMagicEffect(CONST_ME_POFF) --Not sure if there's any magic effect when you use saw?
	return true
end

saw:id(3461)
saw:register()
