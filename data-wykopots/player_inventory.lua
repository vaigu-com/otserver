TAKE_ALL_AVAILABLE = "TAKE_ALL_AVAILABLE"

function Player:GetWildcardPrice()
	return math.min((self:getLevel() / 2) * 150, 7500)
end

function Player:GetTotalMoney()
	local balance = Bank.balance(self)
	local playerMoney = self:getMoney()
	return balance + playerMoney
end

local ItemList = {}
function ItemList:new()
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(ItemList, {
	__call = function(class, ...)
		return class:new(...)
	end,
})

function ItemList:FilteredByAid(aid)
	if not aid then
		return self
	end
	local result = ItemList()
	for _, item in pairs(self) do
		if item:getActionId() == aid then
			table.insert(result, item)
		end
	end
	return result
end

function ItemList:FilteredByFluidtype(fluidtype)
	if not fluidtype then
		return self
	end
	local result = ItemList()
	for _, item in pairs(self) do
		if item:getFluidType() == fluidtype then
			table.insert(result, item)
		end
	end
	return result
end

function ItemList:FilteredById(id)
	if not id then
		return self
	end
	local result = ItemList()
	for _, item in pairs(self) do
		if item:getId() == id then
			table.insert(result, item)
		end
	end
	return result
end

function Player:GetAllItems()
	local containers = {}
	local items = ItemList()
	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
		local item = self:getSlotItem(i)
		if not item then
			goto continue
		end
		if item.uid > 0 then
			if isContainer(item.uid) then
				table.insert(containers, item)
			end
			table.insert(items, item)
		end
		::continue::
	end

	while #containers > 0 do
		local containerItems = containers[1]:getItems()
		for _, item in pairs(containerItems) do
			if isContainer(item.uid) then
				table.insert(containers, item)
			end
			table.insert(items, item)
		end
		table.remove(containers, 1)
	end

	return items
end

function Player:CountItem(item)
	local id = item.id
	local aid = item.aid
	local fluidType = item.fluidType
	local filteredItems = self:GetAllItems():FilteredById(id):FilteredByAid(aid):FilteredByFluidtype(fluidType)
	local count = 0
	for _, fiteredItem in pairs(filteredItems) do
		count = count + fiteredItem:getCount()
	end
	return count
end

function Player:HasItem(item)
	local requiredCount = item.count

	local count = self:CountItem(item)
	return count >= requiredCount
end

local function normalizeItemData(item)
	local requiredCount = item.count or 1
	item.count = requiredCount
	return item
end

local function nodeIsItem(node)
	return node.id ~= nil
end

local function parseGroupQuantifier(quantifier)
	if type(quantifier) == "string" and quantifier == "any" then
		return true
	end
	return false
end

local function appendNewItems(chosenitems, node, newChosenItems)
	if not newChosenItems then
		table.insert(chosenitems, node)
		return
	end

	for _, item in pairs(newChosenItems) do
		table.insert(chosenitems, item)
	end
end

local function succeededMatchAny(requiresAny, hasItems)
	if requiresAny and hasItems then
		return true
	end
	return false
end

local function failedMatchAll(requiresAny, hasItems)
	if not requiresAny and not hasItems then
		return false
	end
end

function Player:HasItems(items, requiresAny)
	local hasItems = false
	local takenItems = {}
	for groupQuantifier, node in pairs(items) do
		local candidateTakenitems
		if nodeIsItem(node) then
			node = normalizeItemData(node)
			hasItems = self:HasItem(node)
		else
			local requiredGroup = parseGroupQuantifier(groupQuantifier)
			hasItems, candidateTakenitems = self:HasItems(node, requiredGroup)
		end

		if hasItems then
			appendNewItems(takenItems, node, candidateTakenitems)
		end

		if succeededMatchAny(requiresAny, hasItems) then
			return true, takenItems
		end
		if failedMatchAll() then
			return false
		end
	end
	return hasItems, takenItems
end

function Player:TryRemoveItems(items)
	if not self:HasItems(items) then
		return false
	end
	return self:RemoveItems(items)
end

local function countItemsToTake(player, item)
	if item.take == TAKE_ALL_AVAILABLE then
		return player:CountItem(item.id, item.aid, item.fluidType)
	end
	return item.count or 1
end

function Player:RemoveItem(item)
	local id = item.id
	local itemsToTakeCount = countItemsToTake(self, item)
	local aid = item.actionid or item.aid or 0
	local fluidType = item.fluidType

	local filteredItems = self:GetAllItems():FilteredById(id):FilteredByAid(aid):FilteredByFluidtype(fluidType)
	for i = 1, #filteredItems do
		if itemsToTakeCount <= 0 then
			return
		end
		local itemToRemove = filteredItems[i]
		local currentCountToremove = itemToRemove:getCount()
		if currentCountToremove > itemsToTakeCount then
			currentCountToremove = itemsToTakeCount
		end
		itemToRemove:remove(currentCountToremove)
		itemsToTakeCount = itemsToTakeCount - currentCountToremove
	end
end

function Player:RemoveItems(items)
	local _, chosenItems = self:HasItems(items)
	for _, item in pairs(chosenItems) do
		if item.remove == false then
			goto continue
		end
		self:RemoveItem(item)
		::continue::
	end
	return true
end

function Player:TryTradeInItems(givenUpItems, newItems)
	if not self:HasItems(givenUpItems) then
		return false
	end
	if not self:CanAddItems(newItems) then
		return false
	end
	-- success
	self:RemoveItems(givenUpItems)
	self:AddItems(newItems)
	return true
end

function Player:TryAddItems(items)
	local result, errorMessage = self:CanAddItems(items)
	if result ~= true then
		self:sendTextMessage(MESSAGE_FAILURE, errorMessage)
		return result
	end
	return self:AddItems(items)
end

function Player:HasEnoughCapacity(desiredCap)
	local playerFreeCapacityOz = self:getFreeCapacity() / 100
	if desiredCap > playerFreeCapacityOz then
		return false, "The total weight of the items You are trying to pick up is " .. desiredCap .. " oz. Therefore You need another " .. tostring(math.abs(playerFreeCapacityOz - desiredCap)) .. " oz."
	end
	return true
end

function Player:HasEnoughSlots(requiredItemSlots)
	local freeSlots = self:getFreeBackpackSlots()
	if requiredItemSlots > freeSlots then
		local requiredMoreSlots = requiredItemSlots - freeSlots
		return false, T("Items you are trying to pick up take up :totalItemSlots: inventory slots. You need another :requiredMoreSlots: free slots in your inventory.", {
			totalItemSlots = requiredItemSlots,
			requiredMoreSlots = requiredMoreSlots,
		})
	end

	return true
end

function Player:CanAddItems(items)
	local totalItemWeight = GetItemsWeight(items)
	local canProceed, message

	canProceed, message = self:HasEnoughCapacity(totalItemWeight)
	if not canProceed then
		return canProceed, message
	end

	local totalItemSlots = ItemsRequiredSlots(items)
	canProceed, message = self:HasEnoughSlots(totalItemSlots)
	if not canProceed then
		return canProceed, message
	end

	return true
end

function Player:AddItems(items, bag)
	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local nextBag = (bag or self):addItem(containerId, 1)
			self:AddItems(itemOrItems, nextBag)
		else
			self:AddCustomItem(itemOrItems, bag)
		end
	end
	return true
end

local function shouldAddToStore(item)
	if item.addToStore == false then
		return false
	end
	if item.addToStore == true then
		return true
	end
	local aid = item.aid
	if aid == nil then
		return false
	end
	if aid <= 0 then
		return false
	end
	return true
end

local function normalizedItem(item)
	item.count = item.count or 1
	item.aid = item.aid or item.actionid
	return item
end

local nonCustomAttributes = {
	id = true,
	count = true,
	aid = true,
	description = true,
	text = true,
	uid = true,
}
local function isCustomAttribute(key)
	return nonCustomAttributes[key] ~= true
end

DONT_CONTINUE_ON_ADD = "DONT_CONTINUE_ON_ADD"

local itemIdToActionOnAdd = {
	[130] = function(context)
		local player = context.player
		local count = context.item.count
		local aid = context.item.aid

		local expAmount = aid * 10 ^ count
		AddExperienceWithAnnouncement(player, expAmount)
		return DONT_CONTINUE_ON_ADD
	end,
}

function CountNotAddableItems(items)
	local count = 0
	for _, item in pairs(items) do
		if itemIdToActionOnAdd[item.id] then
			count = count + 1
		end
	end
	return count
end

-- For any non-standard fields tries to set it with setCustomAttribute(key, value)
function Player:AddCustomItem(item, container)
	item = normalizedItem(item)
	local id = item.id
	local count = item.count
	local aid = item.aid
	local showCustomDescOnAcquire = item.showCustomDescOnAcquire
	local desc = item.desc or item.description
	local text = item.text
	local uid = item.uid or item.uniqueid

	local actionOnAdd = itemIdToActionOnAdd[id]
	if actionOnAdd then
		local context = { player = self, item = item }
		if actionOnAdd(context) == DONT_CONTINUE_ON_ADD then
			return true
		end
	end

	local addItem = nil
	if shouldAddToStore(item) then
		local inbox = self:getSlotItem(CONST_SLOT_STORE_INBOX)
		addItem = inbox:addItem(id, count)
		addItem:setOwner(self)
		addItem:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
	else
		container = container or self:getSlotItem(CONST_SLOT_BACKPACK)
		addItem = container:addItem(id, count)
	end

	for key, value in pairs(item) do
		if isCustomAttribute(key) then
			addItem:setCustomAttribute(key, value)
		end
	end

	local iType = ItemType(id)
	if iType and iType:isFluidContainer() then
		addItem:transform(id, 0)
	end

	if aid then
		addItem:setActionId(aid)
	end
	if uid then
		addItem:setUniqueId(uid)
	end
	if desc and count == 1 then
		addItem:setDescription(desc)
	end
	if text and count == 1 then
		addItem:setText(text)
	end

	local name = addItem:getName()
	if showCustomDescOnAcquire then
		name = desc
	end

	if name then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. name .. ".")
	end
end

function ItemsRequiredSlots(items)
	local slotsCount = 0
	local storeSlotsCount = 0
	for containerId, item in pairs(items) do
		local count = 1
		local stackable = false
		if ItemType(containerId):isContainer() then
			count = ItemsRequiredSlots(item)
			count = count + 1
		else
			count = item.count or count
			stackable = ItemType(item.id):isStackable() or stackable
		end

		local requiredSlots = 0
		if stackable then
			requiredSlots = math.ceil(count / 100)
		else
			requiredSlots = count
		end

		if shouldAddToStore(item) then
			storeSlotsCount = storeSlotsCount + requiredSlots
		else
			slotsCount = slotsCount + requiredSlots
		end
	end
	return slotsCount, storeSlotsCount
end

function GetItemsWeight(items)
	local totalWeight = 0
	for containerId, item in pairs(items) do
		local count = 1
		local weight = 0
		if ItemType(containerId):isContainer() then
			weight = GetItemsWeight(item)
			weight = weight + getItemWeight(tonumber(containerId))
		else
			count = item.count or count
			weight = getItemWeight(item.id) or weight
		end
		local requiredWeight = count * weight
		if item.addToStore == true or (item.aid and item.aid > 0 and item.addToStore ~= false) then
			requiredWeight = 0
		end

		totalWeight = totalWeight + requiredWeight
	end
	return totalWeight
end
