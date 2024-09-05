local destinations = {
	[2002] = Position(6093, 1896, 10),
	[2001] = Position(6093, 1892, 10),
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	if player:getItemCount(2836) < 1 then
		player:teleportTo(fromPosition)
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Bez ksiazki z instrukcjami nawet sie nie wybieraj!")
		return true
	end

	player:teleportTo(destinations[item.uid])
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	return true
end

movement:type("stepin")

for i, v in pairs(destinations) do
	movement:uid(i)
end

movement:register()
