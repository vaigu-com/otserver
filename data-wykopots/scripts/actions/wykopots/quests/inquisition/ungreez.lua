local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid ~= 5113 then
		return true
	end

	if player:getStorageValue(Storage.TheInquisition.Questline) == 18 then
		player:teleportTo(toPosition, true)
		item:transform(5114)
	end
	return true
end
action:aid(1004)
action:register()
