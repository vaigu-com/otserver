local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	if item.uid > 0 and item.uid <= 65535 then
		if fromPosition ~= toPosition then
			creature:teleportTo(fromPosition, false)
		else
			print("error walkback on pos: " .. toPosition.x, toPosition.y, toPosition.z, creature:getName())
			if creature:isPlayer() then
				creature:teleportTo(creature:getTown():getTemplePosition())
			end
		end
	end
	return true
end

movement:type("stepin")
movement:id(2472, 2478, 2480, 2481, 2482)
movement:register()
