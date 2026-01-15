TAKE_ALL_AVAILABLE = "TAKE_ALL_AVAILABLE"

function Player:canRemoveMoney(amount)
	local balance = Bank.balance(self)
	local playerMoney = self:getMoney()
	return (balance + playerMoney) >= amount
end

local minPreycardPrice = 200
local maxPreycardPrice = 20000
function Player:GetWildcardPrice()
	local level = self:getLevel()

	if level <= 150 then
		price = math.floor(10 * level ^ 1.4 / math.log(level + 5, 9))
	elseif level > 150 then
		price = level * 33
	end

	return math.clamp(price, minPreycardPrice, maxPreycardPrice)
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
---@return table|nil takenItems
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

---@return table
function Player:ParseRemovalCriteria(items)
	local _, removableItems = self:HasItems(items)
	return removableItems
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
	local takeableItems = self:ParseRemovalCriteria({ itemData })
	for _, removalCriterion in pairs(takeableItems) do
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

function Player:TryTradeInItems(givenUpItems, receivedItems)
	if not self:HasItems(givenUpItems) then
		return false
	end
	if not self:CanAddItems(receivedItems) then
		return false
	end
	-- success
	self:RemoveItems(givenUpItems)
	self:AddItemsAnnounce(receivedItems)
	return true
end

function Player:TryAddItems(items)
	local canAdd, status = self:CanAddItems(items)
	if canAdd ~= true then
		self:sendTextMessage(MESSAGE_FAILURE, status)
		return canAdd
	end
	return self:AddItemsAnnounce(items)
end

---@param requiredCap number
---@return boolean hasEnoughCap
---@return string|nil errorMessageIfHasNoCap
function Player:ErrorIfHasNotEnoughCapacity(requiredCap)
	local playerFreeCap = self:getFreeCapacity()
	if requiredCap > playerFreeCap then
		local lackingCap = math.abs(playerFreeCap - requiredCap)
		return false, T("The total weight of the items You are trying to pick up is :requiredCap: oz. Therefore You need another :lackingCap: oz.", { requiredCap = requiredCap / 100, lackingCap = lackingCap / 100 })
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

local function setFields(addedItems, itemData, localizer)
	local aid = itemData.aid
	local key = itemData.key
	local desc = itemData.desc
	local text = itemData.text
	local uid = itemData.uid
	local tier = itemData.tier
	localizer = itemData.localizer or localizer

	--cpp Player::addItems will return table of ItemEx when count > 100; this makes sure that both cases (single item and table) are handled the same way
	if type(addedItems) ~= "table" then
		addedItems = { addedItems }
	end

	for _, addedItem in pairs(addedItems) do
		for k, v in pairs(itemData) do
			if IsCustomAttribute(k) then
				addedItem:setCustomAttribute(k, v)
			end
			if IsSetableAttribute(k) then
				addedItem:setAttribute(k, v)
			end
		end
		if uid and uid ~= 0 then
			addedItem:setUniqueId(uid)
		end
		if desc and desc ~= "" then
			addedItem:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, desc)
		end
		if text and text ~= "" then
			addedItem:setAttribute(ITEM_ATTRIBUTE_TEXT, text)
		end
		if key and key ~= "" then
			addedItem:setAttribute(ITEM_ATTRIBUTE_KEY, key)
		end
		if aid and aid ~= 0 then
			addedItem:setAttribute(ITEM_ATTRIBUTE_ACTIONID, aid)
		end
		if tier then
			addedItem:setTier(tier)
		end
		if addedItem:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
			addedItem:decay()
		end

		if localizer then
			addedItem:setCustomAttribute("localizer", localizer)
		end
	end
end
---@param container Container
---@param normalizedData table
---@return ItemEx[]
local function addItemContainerHandleFluid(container, normalizedData)
	local addedItems = {}
	if IsFluidContainer(normalizedData.id) then
		for _ = 1, normalizedData.count do
			table.insert(addedItems, container:addItem(normalizedData.id, normalizedData.fluidType, nil, nil, normalizedData.key))
		end
	else
		addedItems = container:addItem(normalizedData.id, normalizedData.count, nil, nil, normalizedData.key)
	end

	return addedItems
end

---@param container Container
---@param normalizedData table
---@return ItemEx[]
local function addItemStoreInboxHandleFluid(container, normalizedData)
	local addedItems = {}
	if IsFluidContainer(normalizedData.id) then
		for _ = 1, normalizedData.count do
			table.insert(addedItems, container:addItem(normalizedData.id, normalizedData.fluidType, INDEX_WHEREEVER, FLAG_NOLIMIT, normalizedData.key))
		end
	else
		addedItems = container:addItem(normalizedData.id, normalizedData.count, INDEX_WHEREEVER, FLAG_NOLIMIT, normalizedData.key)
	end

	return addedItems
end

---@param player Player
---@param normalizedData table
---@return ItemEx[]
function addItemPlayerHandleFluid(player, normalizedData)
	local addedItems = {}
	if IsFluidContainer(normalizedData.id) then
		for _ = 1, normalizedData.count do
			table.insert(addedItems, player:addItem(normalizedData.id, normalizedData.fluidType, nil, nil, nil, nil, normalizedData.key))
		end
	else
		addedItems = player:addItem(normalizedData.id, normalizedData.count, nil, nil, nil, nil, normalizedData.key)
	end

	return addedItems
end

local function createPermanentItemsInner(items, destinationContainerEx, storeInbox, localizer)
	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local containerEx = Game.createItem(containerId)
			createPermanentItemsInner(itemOrItems, containerEx, storeInbox)
		else
			local normalizedData = normalizedItemData(itemOrItems, localizer)
			if shouldAddToStore(normalizedData) then
				local addedItems = addItemStoreInboxHandleFluid(storeInbox, normalizedData)
				setFields(addedItems, normalizedData)
			else
				local addedItems = addItemContainerHandleFluid(destinationContainerEx, normalizedData)
				setFields(addedItems, normalizedData)
			end
		end
	end
end

local function generateItemsPermanent(player, items, localizer)
	local itemsToAdd = ItemExList()
	local itemsToAddStore = ItemExList()
	local storeInbox = player:getStoreInbox()

	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local containerEx = player:addItem(containerId)
			itemsToAdd:AddItemOrTable(containerEx)
			createPermanentItemsInner(itemOrItems, containerEx, storeInbox, localizer)
		else
			local normalizedData = normalizedItemData(itemOrItems, localizer)
			if shouldAddToStore(normalizedData) then
				local addedItems = addItemStoreInboxHandleFluid(storeInbox, normalizedData)
				setFields(addedItems, normalizedData)
				if normalizedData.dontAnnounce ~= true then
					itemsToAddStore:AddItemOrTable(addedItems)
				end
			else
				local addedItems = addItemPlayerHandleFluid(player, normalizedData)
				setFields(addedItems, normalizedData)
				if normalizedData.dontAnnounce ~= true then
					itemsToAdd:AddItemOrTable(addedItems)
				end
			end
		end
	end
	return itemsToAdd, itemsToAddStore
end

local function createTemporaryItemsInner(items, destinationContainerEx)
	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local containerEx = Game.createItem(containerId)
			createTemporaryItemsInner(itemOrItems, containerEx)
		else
			if shouldAddToStore(itemOrItems) then
				logger.warn(debug.traceback(T("Item :id: that is determined to go to store was put inside inner container :containerId:", { id = itemOrItems.id, containerId = destinationContainerEx:getId() })))
				local storeItemEx = Game.createItem(itemOrItems.id, itemOrItems.count or 1)
				destinationContainerEx:addItemEx(storeItemEx, INDEX_WHEREEVER)
			else
				local normalItemEx = Game.createItem(itemOrItems.id, itemOrItems.count or 1)
				destinationContainerEx:addItemEx(normalItemEx, INDEX_WHEREEVER)
			end
		end
	end
end

local function generateItemsTemporary(items)
	local itemsToAddNonStore = ItemExList()
	local itemsToAddStore = ItemExList()

	for containerId, itemOrItems in pairs(items) do
		if ItemType(containerId):isContainer() then
			local containerEx = Game.createItem(containerId)
			itemsToAddNonStore:AddItemOrTable(containerEx)
			createTemporaryItemsInner(itemOrItems, containerEx)
		else
			if shouldAddToStore(itemOrItems) then
				local storeItemEx = Game.createItem(itemOrItems.id, itemOrItems.count or 1)
				itemsToAddStore:AddItemOrTable(storeItemEx)
			else
				local normalItemEx = Game.createItem(itemOrItems.id, itemOrItems.count or 1)
				itemsToAddNonStore:AddItemOrTable(normalItemEx)
			end
		end
	end
	return itemsToAddNonStore, itemsToAddStore
end

function Player:CanAddItemsCapacity(items)
	local itemsToAddNonStore, itemsToAddStore = generateItemsTemporary(items)

	local requiredCap = itemsToAddNonStore:CalculateRequiredCap()
	local hasCap, capMessage = self:ErrorIfHasNotEnoughCapacity(requiredCap)
	if not hasCap then
		return false, capMessage
	end
	return true
end

function Player:CanAddItems(items)
	local itemsToAddNonStore, itemsToAddStore = generateItemsTemporary(items)

	local requiredCap = itemsToAddNonStore:CalculateRequiredCap()
	local hasCap, capMessage = self:ErrorIfHasNotEnoughCapacity(requiredCap)
	if not hasCap then
		return false, capMessage
	end

	local requiredSlots = #itemsToAddNonStore:Get()
	local hasSlots, slotMessage = self:ErrorIfHasNotEnoughSlots(requiredSlots)
	if not hasSlots then
		return false, slotMessage
	end

	return true
end

function Player:AnnounceAddedItemsNonStore(addedItemsNonStore)
	for _, item in pairs(addedItemsNonStore) do
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You have found :name:.", { name = item:getName() }))
	end
end
function Player:AnnounceAddedItemsStore(addedItemsStore)
	for _, item in pairs(addedItemsStore) do
		self:sendTextMessage(MESSAGE_EVENT_ADVANCE, T("You have found :name:. (Your Store Inbox)", { name = item:getName() }))
	end
end

function Player:AddItemsAnnounce(items, localizer)
	local addedItemsNonStore, addedItemsStore = generateItemsPermanent(self, items, localizer)
	self:AnnounceAddedItemsNonStore(addedItemsNonStore:Get())
	self:AnnounceAddedItemsStore(addedItemsStore:Get())
	return true
end

-- For any non-standard key k with value v, this will be performed: setCustomAttribute(k, v)
---@param itemData table
function Player:AddCustomItem(itemData, localizer)
	self:AddItemsAnnounce({ itemData }, localizer)
	return true
end

-- For any non-standard key k with value v, this will be performed: setCustomAttribute(k, v)
---@param itemData table
function Player:TryAddCustomItem(itemData, localizer)
	if not self:CanAddItems({ itemData }) then
		return false
	end

	self:AddItemsAnnounce({ itemData }, localizer)
	return true
end
