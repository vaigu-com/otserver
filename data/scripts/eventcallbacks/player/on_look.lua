local OnLookMessage = {}
function OnLookMessage:new(player, inspectedThing, inspectedPosition, lookDistance)
	local newObj = {}
	self.player = player
	self.inspectedThing = inspectedThing
	self.inspectedPosition = inspectedPosition
	self.lookDistance = lookDistance
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(OnLookMessage, {
	__call = function(class, ...)
		return class:new(...)
	end,
})

function SimpleTextDisplay(player, item, message)
	local title = "You read the following."
	if message == nil then
		message = message or ("Report this bug to the gamemaster. Debug info: AID:" .. item:getActionId())
		logger.debug(T("[SimpleTextDisplay] Trying to display nil message. item: :item:, aid: :aid:", { item = item, aid = item:getActionId() }))
	end
	local close = "Close"
	local aid = item:getActionId()

	player:registerEvent("SimpleDisplayOnLook")

	local window = ModalWindow(aid, title, message)
	window:addButton(101, close)
	window:setDefaultEscapeButton(101)

	window:sendToPlayer(player)
	player:unregisterEvent("SimpleDisplayOnLook")
	return DONT_SHOW_ONLOOK
end

-- usage: [storage] = "english description",
local aidToCustomDesc = {
	-- keys
	[5003] = "Don't let the skeletons out!",
	-- misc
	[5640] = "a honeyflower patch.",
	[5641] = "a banana palm.",
	[5642] = "a gargoyle statue.\n You read: \n\n Either loved or hated \n\nCitizen Honoris Causa\n\nPtaaq",
	[11082] = "Map of burried spell.",
	[11083] = "Map of brasilian Ratland.",
	[11085] = "Overdue package.\nThis is a big parcel with lot of orders. The recipient is the Mirkotown depot, 2nd floor",
	[11086] = "Bait in a can.",
	[11088] = "Anon's father's float.",
	[11090] = "Anon's father's fishing reel.",
	[11092] = "Anon's father's stool.",
}

local function tryFindAnyDescription(player, item)
	local description = aidToCustomDesc[item:getActionId()] or item:getAttribute(ITEM_ATTRIBUTE_DESCRIPTION)
	local translatedDescription = player:Localizer(nil):Context({ item = item }):Get(description)
	if translatedDescription and translatedDescription ~= "" then
		return translatedDescription
	end
	if description and description ~= "" then
		return description
	end
end

-- This allows to display translated text on "look" for items with overriden onUse
local function tryDisplayItemText(player, item)
	local text = item:getAttribute(ITEM_ATTRIBUTE_TEXT)
	if text == nil or text == "" then
		return
	end

	local translatedText = player:Localizer(nil):Context({ item = item }):Get(text)
	if translatedText and translatedText ~= "" then
		SimpleTextDisplay(player, item, translatedText)
		return DONT_SHOW_ONLOOK
	end
	return text
end

local function shouldDisplayReadableContent(item)
	local itemType = ItemType(item:getId())
	if itemType:getAllowDistRead() then
		return true
	end
	if itemType:isKey() then
		return true
	end

	return false
end

local specialItemRanges = {
	{ rangeStart = ITEM_HEALTH_CASK_START, rangeEnd = ITEM_HEALTH_CASK_END },
	{ rangeStart = ITEM_MANA_CASK_START, rangeEnd = ITEM_MANA_CASK_END },
	{ rangeStart = ITEM_SPIRIT_CASK_START, rangeEnd = ITEM_SPIRIT_CASK_END },
	{ rangeStart = ITEM_KEG_START, rangeEnd = ITEM_KEG_END },
}
local function isSpecialItem(itemId)
	for _, range in ipairs(specialItemRanges) do
		if itemId >= range.rangeStart and itemId <= range.rangeEnd then
			return true
		end
	end
	return false
end

local function getPositionDescription(position)
	if position.x == 65535 then
		return "Position: In your inventory."
	else
		return string.format("Position: (%d, %d, %d)", position.x, position.y, position.z)
	end
end

function OnLookMessage:ParseCustomOnLook()
	local inspectedThing = self.inspectedThing
	local player = self.player
	local aid = inspectedThing:getActionId()
	if not aid or aid <= 0 then
		return nil
	end

	local itemConfig = CustomItemRegistry():GetState(aid)
	if itemConfig and itemConfig.onLook then
		local onLookFunc = itemConfig.onLook
		local result = onLookFunc({ player = player, aid = aid, item = inspectedThing })
		if result == DONT_SHOW_ONLOOK then
			return DONT_SHOW_ONLOOK
		end
	end

	if tryDisplayItemText(player, inspectedThing) == DONT_SHOW_ONLOOK then
		return DONT_SHOW_ONLOOK
	end

	local finalDescription = tryFindAnyDescription(player, inspectedThing)
	if not finalDescription or finalDescription == "" then
		return nil
	end

	return finalDescription
end

function OnLookMessage:ParseCustomDescription(customDescription)
	if shouldDisplayReadableContent(self.inspectedThing) then
		return T("You see :name:. You read: :customDescription:", { name = self.inspectedThing:getNameDescription(), customDescription = customDescription })
	end
	return T("You see :name:.", { name = self.inspectedThing:getNameDescription() })
end

function OnLookMessage:ParseItemDescription()
	local inspectedThing = self.inspectedThing
	local lookDistance = self.lookDistance
	local customDescription = self:ParseCustomOnLook()
	if customDescription == DONT_SHOW_ONLOOK then
		return nil
	end

	if customDescription then
		return self:ParseCustomDescription(customDescription)
	end

	local descriptionText = inspectedThing:getDescription(lookDistance)

	if isSpecialItem(inspectedThing.itemid) then
		local itemCharges = inspectedThing:getCharges()
		if itemCharges > 0 then
			return string.format("You see %s\nIt has %d refillings left.", descriptionText, itemCharges)
		end
	else
		return "You see " .. descriptionText
	end

	return descriptionText
end

function OnLookMessage:ParseCreatureDescription()
	local inspectedThing = self.inspectedThing
	local lookDistance = self.lookDistance
	local descriptionText = inspectedThing:getDescription(lookDistance)

	if inspectedThing:isMonster() then
		local monsterMaster = inspectedThing:getMaster()
		if monsterMaster and table.contains({ "sorcerer familiar", "knight familiar", "druid familiar", "paladin familiar" }, inspectedThing:getName():lower()) then
			local summonTimeRemaining = monsterMaster:kv():get("familiar-summon-time") or 0
			descriptionText = string.format("%s (Master: %s). It will disappear in %s", descriptionText, monsterMaster:getName(), getTimeInWords(summonTimeRemaining - os.time()))
		end
	end

	return "You see " .. descriptionText
end

function OnLookMessage:ParseAdminDetails()
	local descriptionText = ""
	local inspectedThing = self.inspectedThing
	local inspectedPosition = self.inspectedPosition
	if inspectedThing:isItem() then
		descriptionText = string.format("%s\nClient ID: %d", descriptionText, inspectedThing:getId())

		local itemActionId = inspectedThing:getActionId()
		if itemActionId ~= 0 then
			descriptionText = string.format("%s, Action ID: %d", descriptionText, itemActionId)
		end

		local itemUniqueId = inspectedThing:getUniqueId()
		if itemUniqueId > 0 and itemUniqueId < 65536 then
			descriptionText = string.format("%s, Unique ID: %d", descriptionText, itemUniqueId)
		end

		local itemType = inspectedThing:getType()
		local transformOnEquipId = itemType:getTransformEquipId()
		local transformOnDeEquipId = itemType:getTransformDeEquipId()

		if transformOnEquipId ~= 0 then
			descriptionText = string.format("%s\nTransforms to: %d (onEquip)", descriptionText, transformOnEquipId)
		elseif transformOnDeEquipId ~= 0 then
			descriptionText = string.format("%s\nTransforms to: %d (onDeEquip)", descriptionText, transformOnDeEquipId)
		end

		local itemDecayId = itemType:getDecayId()
		if itemDecayId ~= -1 then
			descriptionText = string.format("%s\nDecays to: %d", descriptionText, itemDecayId)
		end
	elseif inspectedThing:isCreature() then
		local healthDescription = "%s\n%s\nHealth: %d / %d"
		local creatureId = nil
		if inspectedThing:isPlayer() and inspectedThing:getMaxMana() > 0 then
			creatureId = string.format("Player ID: %i", inspectedThing:getGuid())
			healthDescription = string.format("%s, Mana: %d / %d", healthDescription, inspectedThing:getMana(), inspectedThing:getMaxMana())
		elseif inspectedThing:isMonster() then
			creatureId = string.format("Monster ID: %i", inspectedThing:getId())
		elseif inspectedThing:isNpc() then
			creatureId = string.format("NPC ID: %i", inspectedThing:getId())
		end

		descriptionText = string.format(healthDescription, descriptionText, creatureId, inspectedThing:getHealth(), inspectedThing:getMaxHealth())
	end

	descriptionText = string.format("%s\n%s", descriptionText, getPositionDescription(inspectedPosition))

	if inspectedThing:isCreature() then
		local creatureBaseSpeed = inspectedThing:getBaseSpeed()
		local creatureCurrentSpeed = inspectedThing:getSpeed()
		descriptionText = string.format("%s\nSpeed Base: %d\nSpeed: %d", descriptionText, creatureBaseSpeed, creatureCurrentSpeed)

		if inspectedThing:isPlayer() then
			descriptionText = string.format("%s\nIP: %s", descriptionText, Game.convertIpToString(inspectedThing:getIp()))
		end
	end

	return descriptionText
end

function OnLookMessage:Build()
	if self.inspectedThing:isItem() then
		self.normalDescription = self:ParseItemDescription()
	elseif self.inspectedThing:isCreature() then
		self.normalDescription = self:ParseCreatureDescription()
	end

	if self.player:getGroup():getAccess() then
		self.adminDescription = self:ParseAdminDetails()
	end
	return self
end

function OnLookMessage:Get()
	local finalMessage = self.normalDescription or ""
	if self.player:getGroup():getAccess() and self.adminDescription then
		finalMessage = finalMessage .. self.adminDescription
	end
	return finalMessage
end

local callback = EventCallback()
function callback.playerOnLook(player, inspectedThing, inspectedPosition, lookDistance)
	local onLookDescriptionBuilder = OnLookMessage(player, inspectedThing, inspectedPosition, lookDistance)
	local description = onLookDescriptionBuilder:Build():Get()
	if description then
		player:sendTextMessage(MESSAGE_LOOK, description)
	end
end

callback:register()
