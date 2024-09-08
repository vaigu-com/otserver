local config = {
	[7905] = { storage = Storage.TheDreamCourts.WardStones.Stone1 },
	[7906] = { storage = Storage.TheDreamCourts.WardStones.Stone2 },
	[7907] = { storage = Storage.TheDreamCourts.WardStones.Stone3 },
	[7908] = { storage = Storage.TheDreamCourts.WardStones.Stone4 },
	[7909] = { storage = Storage.TheDreamCourts.WardStones.Stone5 },
	[7910] = { storage = Storage.TheDreamCourts.WardStones.Stone6 },
	[7911] = { storage = Storage.TheDreamCourts.WardStones.Stone7 },
	[7912] = { storage = Storage.TheDreamCourts.WardStones.Stone8 },
}

local function revertYellow(position)
	local caskItem = Tile(position):getItemById(29335)
	if caskItem then
		caskItem:transform(29334)
		position:sendMagicEffect(CONST_ME_THUNDER)
	end
end
local function revertBlue(position)
	local caskItem = Tile(position):getItemById(29337)
	if caskItem then
		caskItem:transform(29336)
		position:sendMagicEffect(CONST_ME_THUNDER)
	end
end

local dreamTalisman = Action()

function dreamTalisman.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetItem = config[target.uid]
	if not targetItem then
		return true
	end

	if player:getStorageValue(Storage.TheDreamCourts.QuestLine) > 0 then
		if target.uid == 7906 and player:getStorageValue(Storage.TheDreamCourts.FacelessKilled) <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Faceless Bane wont let you empower this stone..")
			return true
		end
		if player:getStorageValue(targetItem.storage) <= 0 then
			if target.itemid == 29334 then
				target:transform(29335)
				toPosition:sendMagicEffect(CONST_ME_THUNDER)
				addEvent(revertYellow, 30 * 60 * 1000, toPosition) --10min
			elseif target.itemid == 29336 then
				target:transform(29337)
				toPosition:sendMagicEffect(12)
				addEvent(revertBlue, 30 * 60 * 1000, toPosition) --10min
			end
			if player:getStorageValue(Storage.TheDreamCourts.WardStones.WardStones) <= 0 then
				player:setStorageValue(Storage.TheDreamCourts.WardStones.WardStones, 1)
			else
				player:setStorageValue(Storage.TheDreamCourts.WardStones.WardStones, (player:getStorageValue(Storage.TheDreamCourts.WardStones.WardStones) + 1))
			end
			player:setStorageValue(targetItem.storage, 1)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Tego juz uzylem..")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nie wiem jak tego uzyc..")
	end
end

dreamTalisman:id(30132)
dreamTalisman:register()
