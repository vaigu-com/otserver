local minotaurskull = Action()
function minotaurskull.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.MinotaurSkull) <= 0 then
		player:setStorageValue(Storage.TheDreamCourts.MinotaurSkull, 1)
		player:addItem(29988, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Minotaur Skull.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz to wzialem..")
	end
	return true
end
minotaurskull:uid(7923)
minotaurskull:register()

local orcskull = Action()
function orcskull.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.OrcSkull) <= 0 then
		player:setStorageValue(Storage.TheDreamCourts.OrcSkull, 1)
		player:addItem(29989, 1)
		player:addItem(29990, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Troll and Orc Skull.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz to wzialem..")
	end
	return true
end
orcskull:uid(7924)
orcskull:register()

local minotauruse = Action()
function minotauruse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.uid == 7927 then
		if player:getStorageValue(Storage.TheDreamCourts.MinotaurSkullUse) <= 0 then
			if player:getItemCount(29991) > 0 then
				player:setStorageValue(Storage.TheDreamCourts.MinotaurSkullUse, 1)
				item:remove(1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You put the minotaur skull into the coffin.")
				if (player:getStorageValue(Storage.TheDreamCourts.OrcSkullUse) == 1) and (player:getStorageValue(Storage.TheDreamCourts.TrollSkullUse) == 1) then
					player:setStorageValue(Storage.TheDreamCourts.AllSkullUsed, 1)
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You wont succeed without anatomy book.")
			end
		end
		return true
	end
end
minotauruse:id(29988)
minotauruse:register()

local orcuse = Action()
function orcuse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.uid == 7928 then
		if player:getStorageValue(Storage.TheDreamCourts.OrcSkullUse) <= 0 then
			if player:getItemCount(29991) > 0 then
				player:setStorageValue(Storage.TheDreamCourts.OrcSkullUse, 1)
				item:remove(1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You put the orc skull into the coffin.")
				if (player:getStorageValue(Storage.TheDreamCourts.TrollSkullUse) == 1) and (player:getStorageValue(Storage.TheDreamCourts.MinotaurSkullUse) == 1) then
					player:setStorageValue(Storage.TheDreamCourts.AllSkullUsed, 1)
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You wont succeed without anatomy book.")
			end
		end
		return true
	end
end
orcuse:id(29989)
orcuse:register()

local trolluse = Action()
function trolluse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.uid == 7929 then
		if player:getStorageValue(Storage.TheDreamCourts.TrollSkullUse) <= 0 then
			if player:getItemCount(29991) > 0 then
				player:setStorageValue(Storage.TheDreamCourts.TrollSkullUse, 1)
				item:remove(1)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You put the troll skull into the coffin.")
				if (player:getStorageValue(Storage.TheDreamCourts.OrcSkullUse) == 1) and (player:getStorageValue(Storage.TheDreamCourts.MinotaurSkullUse) == 1) then
					player:setStorageValue(Storage.TheDreamCourts.AllSkullUsed, 1)
				end
			else
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You wont succeed without anatomy book.")
			end
		end
		return true
	end
end
trolluse:id(29990)
trolluse:register()
