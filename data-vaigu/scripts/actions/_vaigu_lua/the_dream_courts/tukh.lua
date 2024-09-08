local config = {
	[9008] = { storage = Storage.TheDreamCourts.Tukh1 },
	[9009] = { storage = Storage.TheDreamCourts.Tukh2 },
}

local function revertIdol(position)
	local caskItem = Tile(position):getItemById(29300)
	if caskItem then
		caskItem:remove()
		position:sendMagicEffect(CONST_ME_THUNDER)
	end
end

local goldenidol = Action()
function goldenidol.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetItem = config[target.uid]
	if not targetItem then
		return true
	end

	if player:getStorageValue(targetItem.storage) <= 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Zaladowales Golden idol of Tukh.")
		toPosition:sendMagicEffect(CONST_ME_THUNDER)
		item:remove()
		Game.createItem(29300, 1, toPosition)
		addEvent(revertIdol, 1 * 60 * 1000, toPosition) --2min
		player:setStorageValue(targetItem.storage, 1)
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz to zrobilem..")
	end
	return true
end
goldenidol:id(29299)
goldenidol:register()
