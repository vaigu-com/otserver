local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	if (item.actionid > 6000 and item.actionid < 6004) or (item.actionid >= 6007 and item.actionid <= 6008) then
		if not creature:isPlayer() then
			return false
		end
		local town = Town(item.actionid - 6000)
		if not town then
			return true
		end
		local player = creature:getPlayer()
		player:setTown(town)
		player:teleportTo(town:getTemplePosition())
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, (player:getSex() == PLAYERSEX_FEMALE and "Zostalas" or "Zostales") .. " obywatelem tej krainy.")
	end
	return true
end

movement:type("stepin")
movement:aid(6001, 6002, 6003, 6007, 6008)
movement:register()
