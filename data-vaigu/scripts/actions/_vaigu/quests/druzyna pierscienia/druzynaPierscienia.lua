local rings = { 3048, 3049, 3050, 3051, 3052, 3053, 3091, 3092, 3093, 3097, 3098, 6299 }

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local part_id = player:getVocation():getId()
	if part_id < 5 then
		player:sendCancelMessage("Czarna magia wymaga doswiadczenia ktorego nie posiadasz.")
		return true
	end

	for i = 1, 12 do
		if player:getItemCount(rings[i]) < 1 then
			player:sendCancelMessage("Musisz miec 12 pierscieni w plecaku.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			return true
		end
	end

	for i = 1, 12 do
		player:removeItem(rings[i], 1)
	end
	part_id = part_id - 4
	local brokenRing = player:addItem(12737, 1)
	if brokenRing then
		brokenRing:setDescription("Jest to " .. (part_id == 1 and "pierwszy" or part_id == 2 and "drugi" or part_id == 2 and "trzeci" or "czwarty") .. " kawalek pierscienia.")
		brokenRing:setActionId(7000 + part_id)
	end
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Udalo ci sie uzyskac kawalek pierscienia Sam Wiesz Kogo.")

	local position = player:getPosition()
	local toPositionLow = { z = position.z }
	local toPositionHigh = { z = position.z }

	toPositionLow.x = position.x - 7
	toPositionHigh.x = position.x + 7
	for i = -5, 5 do
		toPositionLow.y = position.y + i
		toPositionHigh.y = toPositionLow.y
		position:sendDistanceEffect(toPositionLow, 31)
		position:sendDistanceEffect(toPositionHigh, 31)
		position:sendDistanceEffect(toPositionLow, 29)
		position:sendDistanceEffect(toPositionHigh, 29)
		position:sendDistanceEffect(toPositionLow, 4)
		position:sendDistanceEffect(toPositionHigh, 4)
	end

	toPositionLow.y = position.y - 5
	toPositionHigh.y = position.y + 5
	for i = -6, 6 do
		toPositionLow.x = position.x + i
		toPositionHigh.x = toPositionLow.x
		position:sendDistanceEffect(toPositionLow, 31)
		position:sendDistanceEffect(toPositionHigh, 31)
		position:sendDistanceEffect(toPositionLow, 29)
		position:sendDistanceEffect(toPositionHigh, 29)
		position:sendDistanceEffect(toPositionLow, 4)
		position:sendDistanceEffect(toPositionHigh, 4)
	end

	return true
end

for i = 1, #rings do
	action:id(rings[i])
end
action:register()
