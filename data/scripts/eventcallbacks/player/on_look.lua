Storage.DebugOnLook = {}

local OnLookMessageBuilder = {}
function OnLookMessageBuilder:new(player, inspectedThing, inspectedPosition, lookDistance)
	local newObj = {}
	self.player = player
	self.inspectedThing = inspectedThing
	self.inspectedPosition = inspectedPosition
	self.lookDistance = lookDistance
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(OnLookMessageBuilder, {
	__call = function(class, ...)
		return class:new(...)
	end,
})

local _nextModalWindowId = 1000
local function nextModalWindowId()
	_nextModalWindowId = _nextModalWindowId + 1
	return _nextModalWindowId
end

function SimpleTextDisplay(player, message)
	local title = "You read the following."
	if message == nil then
		logger.error(debug.traceback(T("[SimpleTextDisplay] Trying to display nil message :message:"), { message = message }))
		return
	end
	local close = "Close"

	player:registerEvent("SimpleDisplayOnLook")

	local window = ModalWindow(nextModalWindowId(), title, message)
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

local specialItemRanges = {
	{ rangeStart = ITEM_HEALTH_CASK_START, rangeEnd = ITEM_HEALTH_CASK_END },
	{ rangeStart = ITEM_MANA_CASK_START, rangeEnd = ITEM_MANA_CASK_END },
	{ rangeStart = ITEM_SPIRIT_CASK_START, rangeEnd = ITEM_SPIRIT_CASK_END },
	{ rangeStart = ITEM_KEG_START, rangeEnd = ITEM_KEG_END },
}
local function isRefiller(itemId)
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

function OnLookMessageBuilder:ParseItemDescription()
	local inspectedThing = self.inspectedThing
	local lookDistance = self.lookDistance
	local player = self.player

	local descriptionText = inspectedThing:getDescription(lookDistance, player) --player for translation
	if isRefiller(inspectedThing.itemid) then
		local itemCharges = inspectedThing:getCharges()
		if itemCharges > 0 then
			return T("You see :descriptionText:\nIt has :charges: refillings left.", { descriptionText = descriptionText, charges = itemCharges })
		end
	end
	return "You see " .. descriptionText
end

function OnLookMessageBuilder:ParseCreatureDescription()
	local inspectedThing = self.inspectedThing
	local lookDistance = self.lookDistance
	local descriptionText = inspectedThing:getDescription(lookDistance)

	if inspectedThing:isMonster() then
		local monsterMaster = inspectedThing:getMaster()
		if monsterMaster and table.contains({ "sorcerer familiar", "knight familiar", "druid familiar", "paladin familiar" }, inspectedThing:getName():lower()) then
			local summonTimeRemaining = monsterMaster:kv():get("familiar-summon-time") or 0
			descriptionText = string.format("%s (Master: %s). It will disappear in %s", descriptionText, monsterMaster:getName(), Game.getTimeInWords(summonTimeRemaining - os.time()))
		end
	end

	return "You see " .. descriptionText
end

function OnLookMessageBuilder:ParseHiddenDetails()
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

		local itemKey = inspectedThing:getAttribute("key")
		if itemKey and itemKey ~= "" then
			descriptionText = string.format("%s, Key: %s", descriptionText, itemKey)
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
			-- RODO?
			-- descriptionText = string.format("%s\nIP: %s", descriptionText, Game.convertIpToString(inspectedThing:getIp()))
		end
	end

	return descriptionText
end

function OnLookMessageBuilder:Build()
	if self.inspectedThing:isItem() then
		self.normalDescription = self:ParseItemDescription()
	elseif self.inspectedThing:isCreature() then
		self.normalDescription = self:ParseCreatureDescription()
	end

	if self.player:getGroup():getAccess() or self.player:getStorageValueByKey(Storage.DebugOnLook) == ACCESS_GRANTED then
		self.adminDescription = self:ParseHiddenDetails()
	end
	return self
end

function OnLookMessageBuilder:Get()
	local finalMessage = ""
	if self.normalDescription and self.dontShowOnLook ~= true then
		finalMessage = finalMessage .. self.normalDescription
	end
	if self.adminDescription then
		finalMessage = finalMessage .. self.adminDescription
	end
	return finalMessage
end

-- Item description is always treated as potential string identifier
-- If no matching translation is found, then the description is shown normally
-- Else the translation is put in description place
local callback = EventCallback("playerOnLook")
function callback.playerOnLook(player, inspectedThing, inspectedPosition, lookDistance)
	local onLookDescriptionBuilder = OnLookMessageBuilder(player, inspectedThing, inspectedPosition, lookDistance)
	local message = onLookDescriptionBuilder:Build():Get()

	if message and message ~= "" then
		player:sendTextMessage(MESSAGE_LOOK, message)
	end
end

callback:register()
