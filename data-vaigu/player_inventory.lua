TAKE_ALL_AVAILABLE = "TAKE_ALL_AVAILABLE"

function Player:canRemoveMoney(amount)
	local balance = Bank.balance(self)
	local playerMoney = self:getMoney()
	return (balance + playerMoney) >= amount
end

function Player:GetWildcardPrice()
	local level = self:getLevel()
	local price = level * 75
	if level < 80 then
		price = price * (100 + level) / 100
		price = price * 5 / 9
	end
	if level >= 200 then
		price = 15000
	end
	return math.floor(price)
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
			if Container(item.uid) then
				table.insert(containers, item)
			end
			items:Add(item)
		end
		::continue::
	end

	while #containers > 0 do
		local containerItems = containers[1]:getItems()
		for _, item in pairs(containerItems) do
			if Container(item.uid) then
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
	local key = item.key
	if not (id or aid or fluidType or key) then
		logger.error(debug.traceback("[Player::CountItem] trying to count items by no search criteria!"))
		return -1
	end
	local filteredItems = self:GetAllItems():FilterById(id):FilterByAid(aid):FilterByFluidtype(fluidType):FilterByKey(key):Get()
	local count = 0
	for _, fiteredItem in pairs(filteredItems) do
		count = count + fiteredItem:getCount()
	end
	return count
end

local function normalizeItemCount(item)
	item.count = item.count or 1
	return item
end

function Player:HasItem(item)
	item = normalizeItemCount(item)

	local requiredCount = item.count
	local count = self:CountItem(item)
	return count >= requiredCount
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

local function matchAnySucceeded(hasItems)
	if hasItems then
		return true
	end
	return false
end

local function matchAllSucceeded(hasItems)
	return hasItems
end

---@param items table item list
---@param quantifier string? Default: REQUIRE_ALL
---@return boolean hasItems
---@return ItemExList|nil takenItems
function Player:HasItems(items, quantifier)
	quantifier = quantifier or REQUIRE_ALL
	local hasItems = false
	local takeableItems = ItemExList()
	for subgroupQuantifier, node in pairs(items) do
		local candidateTakenitems
		if nodeIsItem(node) then
			node = normalizeItemCount(node)
			hasItems = self:HasItem(node)
		else
			subgroupQuantifier = parseGroupQuantifier(subgroupQuantifier)
			hasItems, candidateTakenitems = self:HasItems(node, subgroupQuantifier)
		end

		if hasItems then
			if candidateTakenitems then
				takeableItems:AddMultiple(candidateTakenitems)
			else
				takeableItems:Add(node)
			end
		end

		if quantifier == REQUIRE_ANY and matchAnySucceeded(hasItems) then
			return true, takeableItems:Get()
		end

		if quantifier == REQUIRE_ALL and not matchAllSucceeded(hasItems) then
			return false, nil
		end
	end
	return hasItems, takeableItems:Get()
end

function Player:ParseRemovalCriteria(items)
	local _, removalCriteria = self:HasItems(items)
	return removalCriteria
end

function Player:TryRemoveItems(items)
	if not self:HasItems(items) then
		return false
	end
	return self:RemoveItems(items)
end

local function parseItemCountToRemove(player, item)
	if item.take == TAKE_ALL_AVAILABLE then
		return player:CountItem(item)
	end
	return item.count or 1
end

function Player:RemoveEquippedItemByCriteria(removalCriteria)
	local id = removalCriteria.id
	local itemCountToRemove = parseItemCountToRemove(self, removalCriteria)
	local aid = removalCriteria.actionid or removalCriteria.aid
	local fluidType = removalCriteria.fluidType
	local key = removalCriteria.key

	if not (id or aid or fluidType) then
		logger.error(debug.traceback("[Player::RemoveEquippedItemByCriteria] Trying to remove item with null id, aid and fluidtype. This would remove player's whole inventory!"))
		return
	end

	local filteredItems = self:GetAllItems():FilterById(id):FilterByAid(aid):FilterByKey(key):FilterByFluidtype(fluidType):Get()

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

function Player:RemoveItem(itemData)
	local removalCriteria = self:ParseRemovalCriteria({ itemData })
	for _, removalCriterion in pairs(removalCriteria) do
		if removalCriterion.remove ~= false then
			self:RemoveEquippedItemByCriteria(removalCriterion)
		end
	end
	return true
end

function Player:RemoveItems(itemsData)
	local removalCriteria = self:ParseRemovalCriteria(itemsData)
	for _, removalCriterion in pairs(removalCriteria) do
		if removalCriterion.remove ~= false then
			self:RemoveEquippedItemByCriteria(removalCriterion)
		end
	end
	return true
end

function Player:TryTradeInItems(givenUpItems, addedItems)
	if not self:HasItems(givenUpItems) then
		return false
	end
	if not self:CanAddItems(addedItems) then
		return false
	end
	-- success
	self:RemoveItems(givenUpItems)
	self:AddItems(addedItems)
	return true
end

function Player:TryAddItems(items)
	local canAdd, status = self:CanAddItems(items)
	if canAdd ~= true then
		self:sendTextMessage(MESSAGE_FAILURE, status)
		return canAdd
	end
	return self:AddItems(items)
end

---@param requiredCap number
---@return boolean hasEnoughCap
---@return string|nil errorMessageIfHasNoCap
function Player:ErrorIfHasNotEnoughCapacity(requiredCap)
	local playerFreeCap = self:getFreeCapacity() / 100
	if requiredCap > playerFreeCap then
		local lackingCap = tostring(math.abs(playerFreeCap - requiredCap))
		return false, T("The total weight of the items You are trying to pick up is :requiredCap: oz. Therefore You need another :lackingCap: oz.", { requiredCap = requiredCap, lackingCap = lackingCap })
	end
	return true
end

function Player:ErrorIfHasNotEnoughSlots(requiredSlots)
	local freeSlots = self:getFreeBackpackSlots()
	if requiredSlots > freeSlots then
		local lackingSlots = requiredSlots - freeSlots
		return false, T("Items you are trying to pick up take up :requiredSlots: inventory slots. You need another :lackingSlots: free slots in your inventory.", {
			requiredSlots = requiredSlots,
			lackingSlots = lackingSlots,
		})
	end

	return true
end

---@nodiscard
local function hasAnyStoreAttribute(item)
	local aid = item.aid
	if aid and aid > 0 then
		return true
	end
	local key = item.key
	if key and key ~= "" then
		return true
	end
	return false
end

---@nodiscard
local function shouldAddToStore(item)
	if item.addToStore == false then
		return false
	elseif item.addToStore == true then
		return true
	elseif item.addToStore == nil then
		return hasAnyStoreAttribute(item)
	end
	return false
end

local function parseDestinationSlotId(item)
	do
		return nil
	end
	if shouldAddToStore(item) then
		return CONST_SLOT_STORE_INBOX
	end

	return CONST_SLOT_WHEREEVER
end

local function parseSubtype(item)
	return item.subtype or item.subType or item.count or item.fluidType or item.fluid or item.charges
end

local cantDropOnMap = false
local subtypeNone = nil
local tierNone = nil
function Player:CanAddItemsCpp(items)
	for containerId, item in pairs(items) do
		if ItemType(containerId):isContainer() then
			local status = self:canAddItem(containerId, 1, cantDropOnMap, subtypeNone, parseDestinationSlotId(item), tierNone)
			if status ~= RETURNVALUE_NOERROR then
				return status, containerId
			end
		else
			local status = self:canAddItem(item.id, item.count, cantDropOnMap, parseSubtype(item), parseDestinationSlotId(item), item.tier)
			if status ~= RETURNVALUE_NOERROR then
				return status, item.id
			end
		end
	end
	return RETURNVALUE_NOERROR
end

function Player:CanAddItems(items)
	local requiredCap = CalculateItemsWeight(items)
	local hasCap, capMessage = self:ErrorIfHasNotEnoughCapacity(requiredCap)
	if not hasCap then
		return false, capMessage
	end

	local requiredSlots = CalculateItemsRequiredSlots(items)
	local hasSlots, slotMessage = self:ErrorIfHasNotEnoughSlots(requiredSlots)
	if not hasSlots then
		return false, slotMessage
	end

	local status, lastitemId = self:CanAddItemsCpp(items)
	if status ~= RETURNVALUE_NOERROR then
		return false, T("[Player::CanAddItems] Cannot add items to player :playerName:. Last item id: :lastitemId: Status: :status:. Please contact an admin.", { playerName = self:getName(), status = status, lastitemId = lastitemId })
	end

	return true, RETURNVALUE_NOERROR
end

function Player:AddItems(items, bag, localizer)
	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local nextBag = (bag or self):addItem(containerId, 1)
			self:AddItems(itemOrItems, nextBag,localizer)
		else
			self:AddCustomItem(itemOrItems, bag, localizer)
		end
	end
	return true
end

local function normalizedItem(item)
	item.count = item.count or 1
	item.aid = item.aid or item.actionid or 0
	item.desc = item.desc or item.description
	item.uid = item.uid or item.uniqueid or 0
	item.key = item.key or ""
	return item
end

DONT_ADD_ITEM_TO_INVENTORY = "DONT_ADD_ITEM_TO_INVENTORY"

local explodingCookie = 130
local function onAddExplodingcookie(context)
	local exp = tonumber(context.item.key or 1000)
	if not exp then
		logger.error(T("[onAddExplodingcookie] Exp cookie key (:key:) cannot be converted to number. Chest position :pos:", { key = context.item:getKey(), pos = context.item:getPosition():ToString() }))
	end
	AddExperienceWithAnnouncement(context.player, exp)
	return DONT_ADD_ITEM_TO_INVENTORY
end

local customItemActionContainer = {
	[explodingCookie] = onAddExplodingcookie,
}

function CountNotAddableItems(items)
	local count = 0
	for _, item in pairs(items) do
		if customItemActionContainer[item.id] then
			count = count + 1
		end
	end
	return count
end

-- For any non-standard key k with value v, this will be performed: setCustomAttribute(k, v)
---@param itemData table
---@param container Container|nil
function Player:AddCustomItem(itemData, container, localizer)
	itemData = normalizedItem(itemData)
	local id = itemData.id
	local count = itemData.count
	local aid = itemData.aid
	local key = itemData.key
	local showCustomDescOnAcquire = itemData.showCustomDescOnAcquire
	local desc = itemData.desc
	local text = itemData.text
	local uid = itemData.uid
	local fluidType = itemData.fluidType
	local tier = itemData.tier
	local flags = itemData.flags

	local actionOnAdd = customItemActionContainer[id]
	if actionOnAdd then
		local context = { player = self, item = itemData }
		if actionOnAdd(context) == DONT_ADD_ITEM_TO_INVENTORY then
			return
		end
	end

	local addedItems = Game.createItem(id, count)
	if type(addedItems) ~= "table" then
		addedItems = { addedItems }
	end

	local lastErrorCode = RETURNVALUE_NOERROR
	for _, addedItem in pairs(addedItems) do
		for key, value in pairs(itemData) do
			if IsCustomAttribute(key) then
				addedItem:setCustomAttribute(key, value)
			end
			if IsSetableAttribute(key) then
				addedItem:setAttribute(key, value)
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
			addedItem:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
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

		if tier then
			addedItem:setTier(tier)
		end

		if shouldAddToStore(itemData) then
			addedItem:setOwner(self)
			addedItem:setAttribute(ITEM_ATTRIBUTE_STORE, systemTime())
			local inbox = self:getStoreInbox()
			lastErrorCode = inbox:addItemEx(addedItem)
		else
			-- container = container or self:getSlotItem(CONST_SLOT_BACKPACK)
			if container then
				lastErrorCode = container:addItemEx(addedItem, INDEX_WHEREEVER, flags)
			else
				lastErrorCode = self:addItemEx(addedItem, false, CONST_SLOT_WHEREEVER, flags)
			end
		end

		if aid == 0 then
			addedItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, nil)
		end
		if key == "" then
			addedItem:setAttribute(ITEM_ATTRIBUTE_KEY, nil)
		end

		if addedItem:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
			addedItem:decay()
		end

		local name = addedItem:getName()
		if showCustomDescOnAcquire then
			name = desc
		end

		if name and itemData.dontAnnounce ~= true and lastErrorCode == RETURNVALUE_NOERROR then
			self:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have found " .. name .. ".")
		end
	end
	return lastErrorCode
end

function CalculateItemsRequiredSlots(items)
	local slotsCount = 0
	local storeSlotsCount = 0
	for containerId, item in pairs(items) do
		local takenSlots = 1
		local stackable = false
		local chargesPerItem = 1
		if ItemType(containerId):isContainer() then
			takenSlots = CalculateItemsRequiredSlots(item)
			takenSlots = takenSlots + 1
		else
			takenSlots = item.count or takenSlots
			stackable = ItemType(item.id):isStackable()
			chargesPerItem = ItemType(item.id):getCharges()
		end

		local requiredSlots = 0
		if stackable then
			requiredSlots = math.ceil(takenSlots / 100)
		elseif chargesPerItem > 1 then
			requiredSlots = math.ceil(takenSlots / chargesPerItem)
		else
			requiredSlots = takenSlots
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
		local chargesPerItem = 1
		if ItemType(containerId):isContainer() then
			weight = CalculateItemsWeight(item)
			weight = weight + getItemWeight(tonumber(containerId))
		else
			count = item.count or count
			chargesPerItem = ItemType(item.id):getCharges()

			count = item.count or count
			local chargesPerItem = ItemType(item.id):getCharges()
			if chargesPerItem > 1 then
				count = math.ceil(count / chargesPerItem)
			end
			weight = getItemWeight(item.id) or weight
		end

		local requiredWeight = 0
		-- Do not set weight to 0 if its store item
		--[[
		if shouldAddToStore(item) then
			requiredWeight = 0
		elseif chargesPerItem > 1 then
		]]
		if chargesPerItem > 1 then
			requiredWeight = weight * math.ceil(count / chargesPerItem)
		else
			requiredWeight = weight * count
		end

		totalWeight = totalWeight + requiredWeight
	end
	return totalWeight
end
