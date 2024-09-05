local config = {
	[1] = Position(6186, 1066, 12), --{x = 6186, y = 1066, z = 12}
	[2] = Position(6334, 945, 12), --{x = 6334, y = 945, z = 12}
	[3] = Position(6268, 1071, 12), --{x = 6268, y = 1071, z = 12}
	[4] = Position(6088, 966, 12), --{x = 6088, y = 966, z = 12}
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if isInArray({ 842, 843 }, item.itemid) then
		local gemCount = player:getStorageValue(Storage.ElementalSphere.MachineGemCount)
		if isInArray({ 6230, 6231 }, toPosition.x) and toPosition.y == 1006 and toPosition.z == 10 and gemCount >= 20 then
			player:setStorageValue(Storage.ElementalSphere.MachineGemCount, gemCount - 20)
			player:teleportTo(config[player:getVocation():getBase():getId()], false)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
		toPosition.x = toPosition.x + (item.itemid == 842 and 1 or -1)
		local tile = toPosition:getTile()
		if tile then
			local thing = tile:getItemById(item.itemid == 842 and 843 or 842)
			if thing then
				thing:transform(thing.itemid + 4)
				player:say("OFF", TALKTYPE_MONSTER_SAY)
			end
		end
		item:transform(item.itemid + 4)
	else
		toPosition.x = toPosition.x + (item.itemid == 842 and 1 or -1)
		local tile = toPosition:getTile()
		if tile then
			local thing = tile:getItemById(item.itemid == 842 and 843 or 842)
			if thing then
				thing:transform(thing.itemid - 4)
				player:say("ON", TALKTYPE_MONSTER_SAY)
			end
		end
		item:transform(item.itemid - 4)
	end
	return true
end
action:id(842, 843, 846, 847)
action:register()
