local holes = { 593, 606, 608, 867, 21341 }
local pools = { 2886, 2887, 2888, 2889, 2890, 2891, 2895, 2896, 2897, 2898, 2899, 2900 }

local shovel = Action()

function shovel.onUse(player, item, itemEx, fromPosition, target, toPosition, isHotkey)
	return onUseShovel(player, item, itemEx, fromPosition, target, toPosition, isHotkey)
end

shovel:id(3457, 5710)
shovel:register()
