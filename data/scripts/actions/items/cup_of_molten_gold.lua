local goldenFirConeId = 12550

local cupOfMoltenGold = Action()
function cupOfMoltenGold.onUse(player, cup, fromPosition, target, toPosition, isHotkey)
	local targetId = target.itemid
	if not table.contains({ 3614, 19111 }, targetId) then
		return false
	end

	if math.random(100) <= 10 then
		if targetId == 19111 then
			cup:transform(goldenFirConeId)
		else
			player:addItem(goldenFirConeId, 1)
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Drizzling all over a fir cone you picked from the tree, the molten gold only covers about half of it - not enough.")

		if targetId == 19111 then
			target:remove(1)
		end

		cup:remove(1)
	end
	return true
end

cupOfMoltenGold:id(12804)
cupOfMoltenGold:register()
