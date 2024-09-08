--[[local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	print'1'
	if target.actionid ~= 2023 then
		return false
	end
print'2'
	if not Tile(toPosition):getItemById(2886, 5) then
		return true
	end
print'3'
	toPosition.z = toPosition.z + 1
	player:teleportTo(toPosition)
	toPosition:sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

action:aid(2023)
action:register()
]]
