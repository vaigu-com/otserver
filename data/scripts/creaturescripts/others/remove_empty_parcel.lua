local function shouldRemove(parcel)
	if parcel:getId() ~= ITEM_PARCEL_STAMPED then
		return false
	end
	local key = parcel:getKey()
	if key and key ~= "" then
		return false
	end
	if parcel:getEmptySlots() ~= 10 then
		return false
	end
	return true
end

local removeEmptyParcelsEvent = CreatureEvent("RemoveEmptyParcelsOnLogin")
function removeEmptyParcelsEvent.onLogin(player)
	local removeUs = {}
	for _, item in ipairs(player:getStoreInbox():getItems(true)) do
		if shouldRemove(item) then
			table.insert(removeUs, item)
		end
	end

	if #removeUs > 0 then
		for _, parcel in pairs(removeUs) do
			parcel:remove()
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "A total of " .. #removeUs .. " empty parcels were removed from your store inbox!")
	end
	return true
end
removeEmptyParcelsEvent:register()
