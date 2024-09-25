local quest = Quest("elevators")
quest:Script(function(storageToRequiredState)
	local hoist1 = Action()

	function hoist1.onUse(creature, item, fromPosition, itemEx, toPosition)
		local player = creature:getPlayer()

		if not player:isPlayer() then
			return false
		end

		local up = Position(6667, 1123, 8)
		local down = Position(6559, 1082, 9)

		if item.actionid == 11053 then
			player:teleportTo(up)
		elseif item.actionid == 11052 then
			player:teleportTo(down)
		else
			return false
		end

		player:getPosition():sendMagicEffect(CONST_ME_POFF)

		return true
	end

	hoist1:aid(11052, 11053)
	hoist1:register()

	local hoist2 = Action()

	function hoist2.onUse(creature, item, fromPosition, itemEx, toPosition)
		local player = creature:getPlayer()

		if not player:isPlayer() then
			return false
		end

		local up = Position(6605, 1079, 12)
		local down = Position(6659, 1083, 12)

		if item.actionid == 11054 then
			player:teleportTo(up)
		elseif item.actionid == 11055 then
			player:teleportTo(down)
		else
			return false
		end

		player:getPosition():sendMagicEffect(CONST_ME_POFF)

		return true
	end

	hoist2:aid(11054, 11055)
	hoist2:register()
end)
