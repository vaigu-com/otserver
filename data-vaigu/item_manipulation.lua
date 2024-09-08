---@class ItemExList
---@field items table
ItemExList = {}
ItemExList.__index = ItemExList
function ItemExList:new()
	local newObj = {}
	newObj.__index = self
	newObj.items = {}
	setmetatable(newObj, self)
	return newObj
end
setmetatable(ItemExList, {
	__call = function(class, ...)
		return class:new(...)
	end,
})

function ItemExList:Area(pos1, pos2)
	IterateBetweenPositions(pos1, pos2, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		self:AddMultiple(tile:getItems())
	end)
	return self
end

function ItemExList:Add(itemEx)
	table.insert(self.items, itemEx)
	return self
end

function ItemExList:AddMultiple(itemsEx)
	for _, itemEx in pairs(itemsEx) do
		self:Add(itemEx)
	end
	return self
end

function ItemExList:AddMultipleElseSingle(multipleItems, item)
	if multipleItems then
		self:AddMultiple(multipleItems)
		return self
	end

	self:Add(item)
	return self
end

function ItemExList:Count()
	local count = 0
	for _ in pairs(self.items) do
		count = count + 1
	end
	return count
end

function ItemExList:FilteredByAid(aid)
	if not aid then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self) do
		if item:getActionId() == aid then
			table.insert(result, item)
		end
	end
	return result
end

function ItemExList:FilteredByFluidtype(fluidtype)
	if not fluidtype then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self) do
		if item:getFluidType() == fluidtype then
			table.insert(result, item)
		end
	end
	return result
end

function ItemExList:FilteredById(id)
	if not id then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self) do
		if item:getId() == id then
			table.insert(result, item)
		end
	end
	return result
end

function ItemExList:Copied(destination)
	local copiedList = ItemExList()
	for _, item in pairs(self.items) do
		copiedList:Add(item:clone():moveTo(destination))
	end
	return copiedList
end

-- Old dependency
function RemoveItems(items, anchor)
	for _, item in pairs(items) do
		local pos = item.offPos or item.pos or item.offpos
		if anchor then
			pos = anchor:Moved(pos)
		end
		pos:RemoveItem(item.id)
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
