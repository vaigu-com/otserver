local destination = Position(6249, 1009, 6) -- tp do magika npc {x = 6249, y = 1009, z = 6}

local chairteleport = Action()

function chairteleport.onUse(player, item, frompos, item2, topos)
	if player:getStorageValueByKey(Storage.LiquidBlack.Visitor) == 2 then
		player:teleportTo(destination)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleport.")
		player:setStorageValueByKey(Storage.LiquidBlack.Visitor, 3)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Empty.")
	end

	return true
end

chairteleport:uid(57744)
chairteleport:register()

