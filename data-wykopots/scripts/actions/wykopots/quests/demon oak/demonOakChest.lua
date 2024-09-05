local chests = {
	[9008] = { itemid = 3389, count = 1 },
	[9009] = { itemid = 8077, count = 1 },
	[9010] = { itemid = 14768, count = 1 },
	[9011] = { itemid = 14769, count = 1 },
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if chests[item.uid] then
		if player:getStorageValue(Storage.DemonOak.Done) ~= 2 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It's empty.")
			return true
		end

		local chest = chests[item.uid]
		local itemType = ItemType(chest.itemid)
		if itemType then
			local article = itemType:getArticle()
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. (#article > 0 and article .. " " or "") .. itemType:getName() .. ".")
		end

		player:addItem(chest.itemid, chest.count)
		player:setStorageValue(Storage.DemonOak.Done, 3)
		player:setStorageValue(Storage.Finished.DemonOak, 1) -- quest done (website)
	end

	return true
end

action:uid(9008, 9009, 9010, 9011)
action:register()
