function CopyItemsArea(corner1, corner2, destinationTopLeft)
	local copiedItem = {}
	IterateBetweenPositions(corner1, corner2, function(context)
		local currentOriginalPos = context.pos
		local currentDestinationPos = destinationTopLeft:Moved(context.xi, context.yi, context.zi)
		copiedItem[#copiedItem + 1] = currentOriginalPos:CopyItems(currentDestinationPos)
	end)
	return copiedItem
end

function RemoveItems(items, anchor)
	for _, item in pairs(items) do
		local pos = item.offPos or item.pos or item.offpos
		if anchor then
			pos = anchor:Moved(pos)
		end
		pos:RemoveItemById(item.id)
	end
end

function CreateItems(items, anchor)
	for _, item in pairs(items) do
		local pos = item.offPos or item.pos or item.offpos
		if anchor then
			pos = anchor:Moved(pos)
		end
		pos:CreateItem(item.id, pos)
	end
end

function ItemsArePresentOnPositions(items, anchor)
	for _, item in pairs(items) do
		local pos = item.offPos or item.pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local id = item.id
		if not Position(pos):hasItem(id) then
			return false
		end
	end
	return true
end

function ChangeItemsActionId(items, aid, anchor)
	if not (items and aid) then
		return false
	end

	for _, item in pairs(items) do
		local pos = item.offPos or item.pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local id = item.id
		local tile = Tile(pos)
		if not tile then
			goto continue
		end
		local changeMyAid = tile:getItemById(id)
		changeMyAid:setActionId(aid)
		::continue::
	end
end

function ChangeItemsUniqueId(items, uid, anchor)
	if not (items and uid) then
		return false
	end

	for _, item in pairs(items) do
		local pos = item.offPos or item.pos
		if anchor then
			pos = anchor:Moved(pos)
		end
		local id = item.id
		local tile = Tile(pos)
		if not tile then
			goto continue
		end
		local changeMyUid = tile:getItemById(id)
		changeMyUid:setUniqueId(uid)
		::continue::
	end
end