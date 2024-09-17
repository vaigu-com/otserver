TAKE_ALL_AVAILABLE = "TAKE_ALL_AVAILABLE"

function Player:GetWildcardPrice()
	return math.min((self:getLevel() / 2) * 150, 7500)
end

function Player:GetTotalMoney()
	local balance = Bank.balance(self)
	local playerMoney = self:getMoney()
	return balance + playerMoney
end

function Player:GetAllItems()
	local containers = {}
	local items = ItemExList()
	for i = CONST_SLOT_FIRST, CONST_SLOT_LAST do
		local item = self:getSlotItem(i)
		if not item then
			goto continue
		end
		if item.uid > 0 then
			if isContainer(item.uid) then
				table.insert(containers, item)
			end
			items:Add(item)
		end
		::continue::
	end

	while #containers > 0 do
		local containerItems = containers[1]:getItems()
		for _, item in pairs(containerItems) do
			if isContainer(item.uid) then
				table.insert(containers, item)
			end
			items:Add(item)
		end
		table.remove(containers, 1)
	end

	return items
end

function Player:CountItem(item)
	local id = item.id
	local aid = item.aid
	local fluidType = item.fluidType
	local filteredItems = self:GetAllItems():FilteredById(id):FilteredByAid(aid):FilteredByFluidtype(fluidType):Get()
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

REQUIRE_ANY = "REQUIRE_ANY"
REQUIRE_ALL = "REQUIRE_ALL"
local function parseGroupQuantifier(quantfier)
	if type(quantfier) ~= "string" then
		return REQUIRE_ALL
	end
	if quantfier == "any" or quantfier == REQUIRE_ANY then
		return REQUIRE_ANY
	end
	if quantfier == "all" or quantfier == REQUIRE_ALL then
		return REQUIRE_ALL
	end
	return REQUIRE_ALL
end

local function matchAnySucceeded(requirement, hasItems)
	if requirement ~= REQUIRE_ANY then
		return false
	end
	if hasItems then
		return true
	end
	return false
end

local function matchAllSucceeded(quantfier, hasItems)
	if quantfier ~= REQUIRE_ALL then
		return false
	end
	return hasItems
end

---@param items table item list
---@param quantifier string? Default: false
---@return boolean hasItems
---@return ItemExList|nil takenItems
function Player:HasItems(items, quantifier)
	local hasItems = false
	local takeableItems = ItemExList()
	for subgroupQuantifier, node in pairs(items) do
		local candidateTakenitems
		if nodeIsItem(node) then
			node = normalizeItemData(node)
			hasItems = self:HasItem(node)
		else
			subgroupQuantifier = parseGroupQuantifier(subgroupQuantifier)
			hasItems, candidateTakenitems = self:HasItems(node, subgroupQuantifier)
		end

		if hasItems then
			takeableItems:AddMultipleElseSingle(candidateTakenitems, node)
		end

		if matchAnySucceeded(quantifier, hasItems) then
			return true, takeableItems
		end

		if not matchAllSucceeded(quantifier, hasItems) then
			return false, nil
		end
	end
	return hasItems, takeableItems
end

function Player:TryRemoveItems(items)
	if not self:HasItems(items) then
		return false
	end
	return self:RemoveItems(items)
end

local function parseItemCountToRemove(player, item)
	if item.take == TAKE_ALL_AVAILABLE then
		return player:CountItem(item.id, item.aid, item.fluidType)
	end
	return item.count or 1
end

function Player:RemoveItem(item)
	local id = item.id
	local itemCountToRemove = parseItemCountToRemove(self, item)
	local aid = item.actionid or item.aid or 0
	local fluidType = item.fluidType

	local filteredItems = self:GetAllItems():FilteredById(id):FilteredByAid(aid):FilteredByFluidtype(fluidType):Get()

	for _, removableItem in pairs(filteredItems) do
		if itemCountToRemove <= 0 then
			return
		end
		local maxRemovableCount = removableItem:getCount()
		if maxRemovableCount > itemCountToRemove then
			maxRemovableCount = itemCountToRemove
		end
		removableItem:remove(maxRemovableCount)
		itemCountToRemove = itemCountToRemove - maxRemovableCount
	end
end

function Player:RemoveItems(items)
	local _, chosenItems = self:HasItems(items)
	for _, item in pairs(chosenItems) do
		if item.remove then
			self:RemoveItem(item)
		end
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
	local canAdd, errorMessage = self:CanAddItems(items)
	if canAdd ~= true then
		self:sendTextMessage(MESSAGE_FAILURE, errorMessage)
		return canAdd
	end
	return self:AddItems(items)
end

---@param requiredCapTotal number
---@return boolean hasEnoughCap
---@return string|nil errorMessageIfHasNoCap
function Player:HasEnoughCapacity(context)
	local requiredCapTotal = context.requiredCapTotal
	local playerFreeCapacityOz = self:getFreeCapacity() / 100
	if requiredCapTotal > playerFreeCapacityOz then
		local lackingCap = tostring(math.abs(playerFreeCapacityOz - requiredCapTotal))
		return false, T("The total weight of the items You are trying to pick up is :requiredCapTotal: oz. Therefore You need another :lackingCap: oz.", { requiredCapTotal = requiredCapTotal, lackingCap = lackingCap })
	end
	return true
end

function Player:HasEnoughSlots(context)
	local requiredItemSlots = context.requiredItemSlots
	local freeSlots = self:getFreeBackpackSlots()
	if requiredItemSlots > freeSlots then
		local lackingSlots = requiredItemSlots - freeSlots
		return false, T("Items you are trying to pick up take up :totalItemSlots: inventory slots. You need another :lackingSlots: free slots in your inventory.", {
			totalItemSlots = requiredItemSlots,
			lackingSlots = lackingSlots,
		})
	end

	return true
end

local canAddItemsChecks = {
	Player.HasEnoughCapacity,
	Player.HasEnoughSlots,
}

function Player:CanAddItems(items)
	local context = {
		totalItemWeight = CalculateItemsWeight(items),
		totalItemSlots = CalculateItemsRequiredSlots(items),
	}
	local canProceed, message
	for _, check in pairs(canAddItemsChecks) do
		canProceed, message = check(self, context)

		if not canProceed then
			return canProceed, message
		end
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
	item.desc = item.desc or item.description
	item.uid = item.uid or item.uniqueid
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

local explodingCookie = 130
local explodingCookieCount = {
	grantExpDefaultFormula = 1,
	grantBoostMinutesEqualToActionId = 2,
}
local explodingCookieCountToAction = {
	[explodingCookieCount.grantExpDefaultFormula] = function(context)
		local aid = context.item.aid
		local uid = context.item.aid
		local expAmount = aid * 10 ^ uid
		AddExperienceWithAnnouncement(context.player, expAmount)
	end,
	[explodingCookieCount.grantBoostMinutesEqualToActionId] = function(context)
		local aid = context.item.aid
		local boostMinutes = aid * 60
		context.player:addXpBoostTime(boostMinutes)
	end,
}
local function addExplodingCookieContent(context)
	local count = context.item.count
	local action = explodingCookieCountToAction[count]
	action(context)
end

local itemIdToActionOnAdd = {
	[explodingCookie] = function(context)
		addExplodingCookieContent(context)
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

-- For any non-standard key k with value v, this will be performed: setCustomAttribute(k, v)
---@param item table
---@param container Container|nil
function Player:AddCustomItem(item, container)
	item = normalizedItem(item)
	local id = item.id
	local count = item.count
	local aid = item.aid
	local showCustomDescOnAcquire = item.showCustomDescOnAcquire
	local desc = item.desc
	local text = item.text
	local uid = item.uid
	local fluidType = item.fluidType

	local actionOnAdd = itemIdToActionOnAdd[id]
	if actionOnAdd then
		local context = { player = self, item = item }
		if actionOnAdd(context) == DONT_CONTINUE_ON_ADD then
			return
		end
	end

	local addItem = nil
	if shouldAddToStore(item) then
		container = nil
		local inbox = self:getStoreInbox()
		addItem = inbox:addItem(id, count)
		addItem:setOwner(self)
		addItem:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
	else
		container = container or self:getSlotItem(CONST_SLOT_BACKPACK) or self
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
	if fluidType then
		addItem:transform(id, fluidType)
	end

	local name = addItem:getName()
	if showCustomDescOnAcquire then
		name = desc
	end

	if name and item.dontAnnounce == false then
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. name .. ".")
	end
end

function CalculateItemsRequiredSlots(items)
	local slotsCount = 0
	local storeSlotsCount = 0
	for containerId, item in pairs(items) do
		local count = 1
		local stackable = false
		if ItemType(containerId):isContainer() then
			count = CalculateItemsRequiredSlots(item)
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

function CalculateItemsWeight(items)
	local totalWeight = 0
	for containerId, item in pairs(items) do
		local count = 1
		local weight = 0
		if ItemType(containerId):isContainer() then
			weight = CalculateItemsWeight(item)
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
