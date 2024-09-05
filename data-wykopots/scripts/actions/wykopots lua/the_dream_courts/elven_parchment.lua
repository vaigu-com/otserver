local elvenparchment = Action()
function elvenparchment.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.QuestLine) >= 3 then -- questline
		if player:getStorageValue(Storage.TheDreamCourts.ElvenParchment) <= 0 then
			player:setStorageValue(Storage.TheDreamCourts.ElvenParchment, 1)
			player:addItem(22865, 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Elven Parchment.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz go wzialem..")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nic tu dla mnie nie ma..")
	end
	return true
end
elvenparchment:uid(7918)
elvenparchment:register()

local text = "Plant rosebush into place to activate the portal..\nFind old lock by removing it from some doors..\nFind three skulls of common hostile creatures..\nUse magical paint to restore some painting..\nPlace skulls into coffins with help of anatomy book.\nUse old lock on doors to restore them."

local parchmentread = Action()
function parchmentread.onUse(player, item, fromPosition, itemEx, toPosition)
	player:showTextDialog(item.itemid, text)
	return true
end
parchmentread:id(22865)
parchmentread:register()

local anatomybook = Action()
function anatomybook.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.AnatomyBook) <= 0 then
		player:setStorageValue(Storage.TheDreamCourts.AnatomyBook, 1)
		player:addItem(29991, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Anatomy Book.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Juz ja wzialem..")
	end
	return true
end
anatomybook:uid(7919)
anatomybook:register()

local rosebush = Action()
function rosebush.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.Rosebush) <= 0 then
		player:setStorageValue(Storage.TheDreamCourts.Rosebush, 1)
		player:addItem(29993, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Rosebush.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nic wiecej tu nie ma..")
	end
	return true
end
rosebush:uid(7920)
rosebush:register()

local recipe = Action()
function recipe.onUse(player, item, fromPosition, itemEx, toPosition)
	if player:getStorageValue(Storage.TheDreamCourts.Recipe) <= 0 then
		player:setStorageValue(Storage.TheDreamCourts.Recipe, 1)
		player:addItem(30147, 1)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found Recipe for Magical Paint.")
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nic wiecej tu nie ma..")
	end
	return true
end
recipe:uid(7921)
recipe:register()
