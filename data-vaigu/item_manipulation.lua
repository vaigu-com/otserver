local forceUntradeability = {
	[43946] = true,
	[43947] = true,
	[43948] = true,
	[43949] = true,
	[43950] = true,
	[2967] = true,
	[2968] = true,
	[2969] = true,
	[2970] = true,
	[2971] = true,
	[2972] = true,
	[2973] = true,
	[130] = true,
}

local leverSwapMap = {
	[ItemId.LEVER_LEFT] = ItemId.LEVER_RIGHT,
	[ItemId.LEVER_RIGHT] = ItemId.LEVER_LEFT,
}
function FlipLever(item)
	if not item then
		logger.warn(debug.traceback("[FlipLever] item not provided"))
		return
	end

	local id = item:getId()
	if not leverSwapMap[id] then
		logger.warn(debug.traceback("[FlipLever] lever has no other flip state"))
		return
	end

	item:transform(leverSwapMap[id])
end

local function extractItemData(item)
	local id = item:getId()
	local count = item:getCount()
	local actionid = item:getActionId()
	local uniqueid = item:getUniqueId()
	local key = item:getKey()
	local addToStore = nil
	if forceUntradeability[id] then
		addToStore = true
	end
	return { id = id, count = count, aid = actionid, uid = uniqueid, key = key, addToStore = addToStore }
end
local function extractBagItems(bagItemsEx)
	local extractedItems = {}
	for _, item in pairs(bagItemsEx) do
		if item:isContainer() then
			extractedItems[item:getId()] = extractBagItems(item:getItems())
		else
			table.insert(extractedItems, extractItemData(item))
		end
	end
	return extractedItems
end

local bagId = 2853
local backpackId = 2854
function ExtractChestContent(chest)
	local chestItems = chest:getItems()
	local addItems = extractBagItems(chestItems)
	local addItemsSize = TableSize(addItems)
	local wrapId = nil
	if addItemsSize > 1 then
		wrapId = bagId
	end
	if addItemsSize > 8 then
		wrapId = backpackId
	end
	if addItemsSize > 20 then
		wrapId = chest:getId()
	end
	if wrapId then
		addItems = { [wrapId] = addItems }
	end
	return addItems
end

---@class ItemExList
---@field items table
ItemExList = {}
ItemExList.__index = ItemExList
function ItemExList:New()
	local newObj = {}
	newObj.__index = self
	newObj.items = {}
	setmetatable(newObj, self)
	return newObj
end
setmetatable(ItemExList, {
	__call = function(ItemExList, ...)
		return ItemExList:New(...)
	end,
})

function ItemExList:CalculateRequiredCap()
	local totalCap = 0
	for _, itemEx in pairs(self:Get()) do
		totalCap = totalCap + itemEx:getWeight()
	end
	return totalCap
end

function ItemExList:Get()
	return self.items
end
function ItemExList:First()
	return self.items[1]
end
function ItemExList:Last()
	return self.items[#self.items]
end

function ItemExList:RadiusSquare(pos, radius)
	radius = radius or 1
	IterateBetweenPositions(pos:Moved(radius, radius), pos:Moved(-radius, -radius), function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		self:AddMultiple(tile:getItems())
	end)
	return self
end

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

function ItemExList:AddItemOrTable(itemEx)
	if type(itemEx) == "table" then
		self:AddMultiple(itemEx)
	else
		self:Add(itemEx)
	end
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

function ItemExList:Count()
	local count = 0
	for _ in pairs(self.items) do
		count = count + 1
	end
	return count
end

function ItemExList:FilterByAid(aid)
	if not aid then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self.items) do
		if item:getActionId() == aid then
			result:Add(item)
		end
	end
	return result
end

function ItemExList:FilterByKey(key)
	if not key then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self.items) do
		if (item:getKey() or "") == key then
			result:Add(item)
		end
	end
	return result
end

function ItemExList:FilterByFluidtype(fluidtype)
	if not fluidtype then
		return self
	end
	local result = ItemExList()
	for _, item in pairs(self.items) do
		if item:getFluidType() == fluidtype then
			result:Add(item)
		end
	end
	return result
end

function ItemExList:FilterById(id)
	if not id then
		return self
	end

	local result = ItemExList()
	for _, item in pairs(self.items) do
		if item:getId() == id then
			result:Add(item)
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

function ItemExList:Remove()
	for _, value in pairs(self.items) do
		value:remove()
	end
	return self
end

local nonCustomAttributes = {
	id = true,
	count = true,
	aid = true,
	description = true,
	text = true,
	uid = true,
	key = true,
	dontAnnounce = true,
}

local setableAtribute = {
	name = true,
}
function IsCustomAttribute(key)
	return nonCustomAttributes[key] ~= true
end

function IsSetableAttribute(key)
	return setableAtribute[key]
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

function ChangeItemsKey(items, key, anchor)
	if not (items and key) then
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
		local changeMyKey = tile:getItemById(id)
		changeMyKey:setKey(key)
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
