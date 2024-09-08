local sapphireDust = Action()

function sapphireDust.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 30003 then
		target:remove(1)
		item:remove(1)
		player:addItem(30006)
		return true
	end
end

sapphireDust:id(30004)
sapphireDust:register()

local dreamEgg = Action()

function dreamEgg.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 30006 then
		target:remove(1)
		item:remove(1)
		player:addItem(29994)
		return true
	end
end

dreamEgg:id(30005)
dreamEgg:register()

local magicalPaint = Action()
function magicalPaint.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 29997 or target.itemid == 29996 then
		player:setStorageValue(Storage.TheDreamCourts.Painting, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It looks now like a room you can enter.")
		item:remove(1)
		return true
	end
end

magicalPaint:id(29994)
magicalPaint:register()

local paintingTp = Action()
function paintingTp.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.Painting) == 1 then
		player:teleportTo(Position(6371, 1809, 13)) --{x = 6371, y = 1809, z = 13}
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
end

paintingTp:aid(7926)
paintingTp:register()

local paintingTp2 = Action()
function paintingTp2.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.Painting) == 1 then
		player:teleportTo(Position(6382, 1901, 13)) --{x = 6382, y = 1901, z = 13}
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
end

paintingTp2:aid(7925)
paintingTp2:register()

local lastDoor = Action()
function lastDoor.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheDreamCourts.AllSkullUsed) == 1 then
		if player:getStorageValue(Storage.TheDreamCourts.LastDoor) < 1 then
			item:remove(1)
			player:setStorageValue(Storage.TheDreamCourts.LastDoor, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Now you can enter.")
			return true
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to put skulls into coffins first.")
		return false
	end
end

lastDoor:id(29992)
lastDoor:register()
