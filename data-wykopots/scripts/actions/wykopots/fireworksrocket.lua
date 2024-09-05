local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if fromPosition.x ~= CONTAINER_POSITION then
		local rand = math.random(1, 3)
		if rand == 1 then
			fromPosition:sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
		elseif rand == 2 then
			local radius = 2
			for dx = -radius, radius do
				for dy = -radius, radius do
					if dx * dx + dy * dy <= radius * radius then
						local newPosition = Position(fromPosition.x + dx, fromPosition.y + dy, fromPosition.z)
						newPosition:sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
					end
				end
			end
		elseif rand == 3 then
			fromPosition:sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
			Position(fromPosition.x + 1, fromPosition.y, fromPosition.z):sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
			Position(fromPosition.x - 1, fromPosition.y, fromPosition.z):sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
			Position(fromPosition.x, fromPosition.y + 1, fromPosition.z):sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
			Position(fromPosition.x, fromPosition.y - 1, fromPosition.z):sendMagicEffect(math.random(CONST_ME_FIREWORK_YELLOW, CONST_ME_FIREWORK_BLUE))
		end
	else
		local position = player:getPosition()
		position:sendMagicEffect(CONST_ME_HITBYFIRE)
		position:sendMagicEffect(CONST_ME_EXPLOSIONAREA)
		player:say("Ouch! Rather place it on the ground next time.", TALKTYPE_MONSTER_SAY)
		player:addHealth(-10)
	end
	item:remove()

	return true
end

action:id(6576)
action:register()
