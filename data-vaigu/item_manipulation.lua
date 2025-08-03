local forceUntradeability = {
	[43946] = true,
	[43947] = true,
	[43948] = true,
	[43949] = true,
	[43950] = true,
}

local leverSwapMap = {
	[ItemId.LEVER_LEFT] = ItemId.LEVER_RIGHT,
	[ItemId.LEVER_RIGHT] = ItemId.LEVER_LEFT,
}
function FlipLever(item)
	if not item then
		logger.warn(debug.traceback("[FlipLever] not item provided"))
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
	if forceUntradeability[id] and actionid == 0 then
		actionid = 1000
	end
	return { id = id, count = count, aid = actionid, uid = uniqueid, key = key }
end
local function extractBagItems(items)
	local result = {}
	for _, item in pairs(items) do
		if item:isContainer() then
			result[item:getId()] = extractBagItems(item:getItems())
		else
			result[#result + 1] = extractItemData(item)
		end
	end
	return result
end
local bagId = 2853
local backpackId = 2854
function ExtractChestContent(chest)
	local chestItems = chest:getItems()
	local addItems = extractBagItems(chestItems)
	local addItemsSize = TableSize(addItems) - CountNotAddableItems(addItems)
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

function ItemExList:Get()
	return self.items
end
function ItemExList:First()
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

function ItemExList:AddAnyAmount(itemEx)
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

function Container:AddItems(items, bag, localizer, addedItems)
	addedItems = addedItems or ItemExList()
	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local nextBag = (bag or self):addItem(containerId, 1)
			self:AddItems(itemOrItems, nextBag, localizer, addedItems) --Item table
		else
			addedItems:AddAnyAmount(self:AddCustomItem(itemOrItems, localizer)) -- one item
		end
	end
	return addedItems:Get()
end

local function normalizedItem(item)
	item.count = item.count or 1
	item.aid = item.aid or item.actionid or 0
	item.desc = item.desc or item.description
	item.uid = item.uid or item.uniqueid or 0
	item.key = item.key or ""
	return item
end

local customItemAction = {}

local function setItemAttributes(addedItem, itemAttributes, localizer)
	local id = itemAttributes.id
	local count = itemAttributes.count
	local aid = itemAttributes.aid
	local key = itemAttributes.key
	local desc = itemAttributes.desc
	local text = itemAttributes.text
	local uid = itemAttributes.uid
	local fluidType = itemAttributes.fluidType

	for k, value in pairs(itemAttributes) do
		if IsCustomAttribute(k) then
			addedItem:setCustomAttribute(k, value)
		end
		if IsSetableAttribute(k) then
			addedItem:setAttribute(k, value)
		end
	end

	local iType = ItemType(id)
	if iType and iType:isFluidContainer() then
		addedItem:transform(id, 0)
	end

	addedItem:setActionId(aid)
	if uid ~= 0 then
		addedItem:setUniqueId(uid)
	end
	if desc and count == 1 then
		addedItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
	end
	if text and count == 1 then
		addedItem:setText(ITEM_ATTRIBUTE_TEXT, text)
	end
	if key and count == 1 then
		addedItem:setAttribute(ITEM_ATTRIBUTE_KEY, key)
	end
	if fluidType then
		addedItem:transform(id, fluidType)
	end

	if text or desc then
		addedItem:setCustomAttribute("localizer", localizer)
	end
end

---@param itemAttributes table
---@param localizer string
function Container:AddCustomItem(itemAttributes, localizer)
	itemAttributes = normalizedItem(itemAttributes)
	local id = itemAttributes.id
	local aid = itemAttributes.aid
	local key = itemAttributes.key
	local count = itemAttributes.count

	local actionOnAdd = customItemAction[id]
	if actionOnAdd then
		local context = { item = itemAttributes, localizer = localizer }
		if actionOnAdd(context) == DONT_ADD_ITEM_TO_INVENTORY then
			return
		end
	end

	local addedItem = Game.createItem(id, count)
	local itemPile = {}
	if type(addedItem) ~= "table" then
		itemPile = { addedItem }
	else
		itemPile = addedItem
	end

	for _, itemEx in pairs(itemPile) do
		setItemAttributes(itemEx, itemAttributes, localizer)

		self:addItemEx(itemEx)
		if aid == 0 then
			itemEx:setAttribute(ITEM_ATTRIBUTE_ACTIONID, nil)
		end
		if key == "" then
			itemEx:setAttribute(ITEM_ATTRIBUTE_KEY, nil)
		end
	end

	return addedItem
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
