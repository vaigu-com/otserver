local config = {
	[7922] = { storage = Storage.TheDreamCourts.RosebushPlant },
}

local function revertYellow(position)
	local caskItem = Tile(position):getItemById(3677)
	if caskItem then
		caskItem:transform(30001)
		position:sendMagicEffect(CONST_ME_THUNDER)
	end
end
local rosebushPlant = Action()

function rosebushPlant.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetItem = config[target.uid]
	if not targetItem then
		return true
	end

	if player:getStorageValue(targetItem.storage) <= 0 then
		if target.itemid == 30001 then
			target:transform(3677)
			item:remove(1)
			toPosition:sendMagicEffect(CONST_ME_BIGPLANTS)
			addEvent(revertYellow, 5 * 60 * 1000, toPosition) --5min
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zasadziles Rosebush.")
		player:setStorageValue(targetItem.storage, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz je posadzilem.")
	end
end

rosebushPlant:id(29993)
rosebushPlant:register()
