---@class UnlockableOutfitAddon
UnlockableOutfitAddon = {}
UnlockableOutfitAddon.__index = UnlockableOutfitAddon
function UnlockableOutfitAddon.New()
	local newObj = {
		lookType = {},
		name = {},
		addonRequiredItems = {},
	}
	setmetatable(newObj, UnlockableOutfitAddon)
	return newObj
end
setmetatable(UnlockableOutfitAddon, {
	__call = function(t, ...)
		return UnlockableOutfitAddon.New(...)
	end,
})

function UnlockableOutfitAddon:Male(lookType)
	local name = Game.getOutfitNameByLookType(lookType)
	self.name[PLAYERSEX_MALE] = name
	self.lookType[PLAYERSEX_MALE] = lookType
	return self
end
function UnlockableOutfitAddon:Female(lookType)
	local name = Game.getOutfitNameByLookType(lookType)
	self.name[PLAYERSEX_FEMALE] = name
	self.lookType[PLAYERSEX_FEMALE] = lookType
	return self
end
local addonOne = 1
local addonTwo = 2
function UnlockableOutfitAddon:AddonOne(requiredItems)
	self.addonRequiredItems[addonOne] = requiredItems
	return self
end
function UnlockableOutfitAddon:AddonTwo(requiredItems)
	self.addonRequiredItems[addonTwo] = requiredItems
	return self
end

function UnlockableOutfitAddon:GetNameBySex(sex)
	return self.name[sex]
end

function UnlockableOutfitAddon:GetLooktypeByPlayer(player)
	return self.lookType[player:getSex()]
end

function UnlockableOutfitAddon:GetAll(addon)
	local outfitAndAddons = {}
	for sex, sexLookType in pairs(self.lookType) do
		table.insert(outfitAndAddons, { lookType = sexLookType, addon = addon })
	end
	return outfitAndAddons
end

local unlockableOutfitAddons = {
	-- Outfits unlocked by default
	UnlockableOutfitAddon("Summoner(F)/Mage(M)")
		:Male(130)
		:Female(141)
		:AddonOne({
			{ id = 3066, count = 1 },
			{ id = 3070, count = 1 },
			{ id = 3069, count = 1 },
			{ id = 3065, count = 1 },
			{ id = 3067, count = 1 },
			{ id = 3074, count = 1 },
			{ id = 3075, count = 1 },
			{ id = 3072, count = 1 },
			{ id = 3073, count = 1 },
			{ id = 3071, count = 1 },
			{ id = 3077, count = 20 },
			{ id = 5809, count = 1 },
			{ id = 5904, count = 10 },
		})
		:AddonTwo({ { id = 5903, count = 1 } }),
	UnlockableOutfitAddon("Mage(F)/Summoner(M)"):Female(138):Male(133):AddonOne({ { id = 5958, count = 1 } }):AddonTwo({ { id = 5894, count = 70 }, { id = 5911, count = 20 }, { id = 5883, count = 40 }, { id = 5922, count = 35 }, { id = 5881, count = 60 }, { id = 5882, count = 40 }, { id = 5905, count = 30 }, { id = 5904, count = 15 }, { id = 5886, count = 10 } }),
	UnlockableOutfitAddon("Citizen"):Female(136):Male(128):AddonOne({ { id = 5878, count = 100 } }):AddonTwo({ { id = 3374, count = 1 }, { id = 5902, count = 50 }, { id = 5890, count = 100 } }),
	UnlockableOutfitAddon("Hunter"):Female(137):Male(129):AddonOne({ { id = 5876, count = 100 }, { id = 5948, count = 100 }, { id = 5891, count = 5 }, { id = 5887, count = 1 }, { id = 5889, count = 1 }, { id = 5888, count = 1 } }):AddonTwo({ { id = 5875, count = 1 } }),
	UnlockableOutfitAddon("Knight"):Female(139):Male(131):AddonOne({ { id = 5880, count = 100 }, { id = 5892, count = 1 } }):AddonTwo({ { id = 5893, count = 100 }, { id = 5887, count = 1 }, { id = 5924, count = 1 }, { id = 5885, count = 1 } }),
	UnlockableOutfitAddon("Noblewman(F)/Nobleman(M)"):Female(140):Male(132):AddonOne({ { id = 3043, count = 15 } }):AddonTwo({ { id = 3043, count = 15 } }),
	UnlockableOutfitAddon("Warrior"):Female(142):Male(134):AddonOne({ { id = 5925, count = 100 }, { id = 5899, count = 100 }, { id = 5919, count = 1 }, { id = 5884, count = 1 } }):AddonTwo({ { id = 5880, count = 100 }, { id = 5887, count = 1 } }),
	UnlockableOutfitAddon("Barbarian"):Female(147):Male(143):AddonOne({ { id = 5884, count = 1 }, { id = 5885, count = 1 }, { id = 5911, count = 50 }, { id = 5910, count = 50 }, { id = 5886, count = 10 } }):AddonTwo({ { id = 5880, count = 100 }, { id = 5876, count = 50 }, { id = 5893, count = 50 }, { id = 5892, count = 1 } }),
	UnlockableOutfitAddon("Druid"):Female(148):Male(144):AddonOne({ { id = 5896, count = 50 }, { id = 5897, count = 50 } }):AddonTwo({ { id = 5906, count = 100 }, { id = 5940, count = 1 }, { id = 5937, count = 1 }, { id = 5938, count = 1 } }),
	UnlockableOutfitAddon("Wizard"):Female(149):Male(145):AddonOne({ { id = 5922, count = 50 } }):AddonTwo({ { id = 3436, count = 1 }, { id = 3386, count = 1 }, { id = 3382, count = 1 }, { id = 3006, count = 1 } }),
	UnlockableOutfitAddon("Oriental"):Female(150):Male(146):AddonOne({ { id = 5945, count = 1 } }):AddonTwo({ { id = 5883, count = 100 }, { id = 5895, count = 100 }, { id = 5912, count = 100 }, { id = 5891, count = 2 } }),

	-- Requires pre-quest for outfit
	UnlockableOutfitAddon("Assassin"):Female(156):Male(152):AddonOne({ { id = 5910, count = 50 }, { id = 5912, count = 50 }, { id = 5886, count = 10 }, { id = 5909, count = 50 }, { id = 5913, count = 50 }, { id = 5914, count = 50 }, { id = 5911, count = 50 } }):AddonTwo({ { id = 5930, count = 1 }, { id = 5804, count = 1 } }),
	UnlockableOutfitAddon("Pirate"):Female(155):Male(151):AddonOne({ { id = 6098, count = 100 }, { id = 6126, count = 100 }, { id = 6097, count = 100 } }):AddonTwo({ { id = 6101, count = 1 }, { id = 6102, count = 1 }, { id = 6100, count = 1 }, { id = 6099, count = 1 } }),
	--UnlockableOutfitAddon("Beggar"):Female(157):Male(153):AddonOne({ { id = 5913, count = 20 }, { id = 5878, count = 50 }, { id = 5894, count = 10 }, { id = 5921, count = 30 } }):AddonTwo({ { id = 5883, count = 100 } }),
	UnlockableOutfitAddon("Shaman"):Female(158):Male(154):AddonOne({ { id = 3348, count = 5 }, { id = 3403, count = 5 } }):AddonTwo({ { id = 5810, count = 5 }, { id = 3002, count = 5 }, { id = 5014, count = 1 } }),
	--UnlockableOutfitAddon("Makeshift Warrior"):Female(1043):Male(1042):AddonOne({ { id = 19082, count = 5 } }):AddonTwo({ { id = 19082, count = 5 } }),
	UnlockableOutfitAddon("Battle Mage"):Female(1070):Male(1069):AddonOne({ { id = 19082, count = 5 } }):AddonTwo({ { id = 19082, count = 5 } }),
	UnlockableOutfitAddon("Death Herald"):Female(666):Male(667):AddonOne({ { id = 8082, count = 1 } }):AddonTwo({ { id = 3203, count = 1 }, { id = 5727, count = 1 } }),
	UnlockableOutfitAddon("Field Surgeon"):Female(1815):Male(1814):AddonOne({ { id = 7419, count = 1 }, { id = 11473, count = 50 } }):AddonTwo({ { id = 3210, count = 1 }, { id = 12517, count = 10 } }),
	UnlockableOutfitAddon("Beastmaster"):Female(636):Male(637):AddonOne({ { id = 24937, count = 30 } }):AddonTwo({ { id = 32073, count = 1 } }),
	UnlockableOutfitAddon("Jouster"):Female(1332):Male(1331):AddonOne({ { id = 22652, count = 1 }, { id = 14683, count = 1 } }):AddonTwo({ { id = 7461, count = 1 } }),
	UnlockableOutfitAddon("Frost Tracer"):Female(1613):Male(1612):AddonOne({ { id = 16118, count = 1 } }):AddonTwo({ { id = 7446, count = 1 } }),
	UnlockableOutfitAddon("Forest Warden"):Female(1416):Male(1415):AddonOne({ { id = 3130, count = 30 } }):AddonTwo({ { id = 830, count = 1 } }),
	UnlockableOutfitAddon("Winged Druid"):Female(1832):Male(1831):AddonOne({ { id = 3038, count = 10 }, { id = 22183, count = 1 }, { id = 25742, count = 100 } }):AddonTwo({ { id = 3345, count = 1 }, { id = 5741, count = 1 } }),
	UnlockableOutfitAddon("Norsewoman(F)/Norseman(M)"):Female(252):Male(251):AddonOne({ { id = 12683, count = 1 } }):AddonTwo({ { id = 7459, count = 1 } }),
	UnlockableOutfitAddon("Celestial Avenger"):Female(1726):Male(1725):AddonOne({ { id = 7438, count = 1 }, { id = 25694, count = 100 } }):AddonTwo({ { id = 8103, count = 1 }, { id = 5922, count = 30 } }),
}

UnlockableOutfitAddonRegistry = {}
UnlockableOutfitAddonRegistry.__index = UnlockableOutfitAddonRegistry
UnlockableOutfitAddonRegistry.registry = {}
for _, sex in pairs({ PLAYERSEX_MALE, PLAYERSEX_FEMALE }) do
	UnlockableOutfitAddonRegistry.registry[sex] = {}
end

---@param outfitAddon UnlockableOutfitAddon
function UnlockableOutfitAddonRegistry:Add(outfitAddon)
	for sex, sexOutfits in pairs(self.registry) do
		sexOutfits[outfitAddon:GetNameBySex(sex)] = outfitAddon
	end
end

function UnlockableOutfitAddonRegistry:Initialize(outfitAddons)
	for _, outfitAddon in pairs(outfitAddons) do
		self:Add(outfitAddon)
	end
end
UnlockableOutfitAddonRegistry:Initialize(unlockableOutfitAddons)

function UnlockableOutfitAddonRegistry:Get(sex, name)
	if self.registry[sex] then
		return self.registry[sex][name]
	end
end

function Player:HasBaseOutfit(outfitAddon)
	return self:hasOutfit(outfitAddon.lookType[self:getSex()], 0)
end

function Player:HasFullOutfitAddons(outfitAddon)
	return self:hasOutfit(outfitAddon.lookType[self:getSex()], 3)
end

local function clickBackToAllOutfits(player, button, choice, context)
	UnlockableOutfitAddonRegistry:SendAllOutfitsWindow(player, context)
end

local function sendSpecificAddonDontHaveItems(player, addonRequiredItems, previousChoice, context)
	local requiredItemsStr = RequiredItemNamesCountToString(addonRequiredItems)
	local modalWindow = ModalWindow({ title = outfitName, message = "You dont have the required items for this addon. You will need:\n" .. requiredItemsStr, context = context })
	local backToSpecificOutfit = modalWindow:addButton("Back", clickSendSpecificOutfitWindow)
	modalWindow:setDefaultEnterButton(backToSpecificOutfit.id - 1)
	modalWindow:setDefaultEscapeButton(backToSpecificOutfit.id - 1)
	local dummyChoice = modalWindow:addChoice("")
	dummyChoice.outfitData = previousChoice.outfitData
	dummyChoice.outfitName = previousChoice.outfitName

	modalWindow:sendToPlayer(player)
end
local function onAcceptSpecificOutfit(player, button, choice, context)
	local outfitData = choice.outfitData
	local addon = choice.addon
	if player:HasItems(choice.addonRequiredItems) then
		player:RemoveItems(choice.addonRequiredItems)
		player:AddOutfitsAndAddons(outfitData:GetAll(addon))
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_BLUE)
		context.npcHandler:say("Here you go.", context.npc, player)
	else
		sendSpecificAddonDontHaveItems(player, choice.addonRequiredItems, choice, context)
	end
end

local function sendSpecificAddonHelp(player, addonRequiredItems, previousChoice, context)
	local requiredItemsStr = RequiredItemNamesCountToString(addonRequiredItems)
	local modalWindow = ModalWindow({ title = outfitName, message = "You need the following items to unlock this addon:\n" .. requiredItemsStr, context = context })
	local backToSpecificOutfit = modalWindow:addButton("Back", clickSendSpecificOutfitWindow)
	modalWindow:setDefaultEnterButton(backToSpecificOutfit.id - 1)
	modalWindow:setDefaultEscapeButton(backToSpecificOutfit.id - 1)
	local dummyChoice = modalWindow:addChoice("")
	dummyChoice.outfitData = previousChoice.outfitData
	dummyChoice.outfitName = previousChoice.outfitName

	modalWindow:sendToPlayer(player)
end
local function clickHelpSpecificAddon(player, button, choice, context)
	sendSpecificAddonHelp(player, choice.addonRequiredItems, choice, context)
end

---@param player Player
---@param outfitData UnlockableOutfitAddon
---@param outfitName string
local function sendSpecificOutfitWindow(player, outfitData, outfitName, context)
	local modalWindow = ModalWindow({ title = outfitName, message = "Choose addon you wish to unlock:", context = context })
	local acceptButton = modalWindow:addButton("Unlock", onAcceptSpecificOutfit)
	local helpButton = modalWindow:addButton("Help", clickHelpSpecificAddon)
	local cancelButton = modalWindow:addButton("Back", clickBackToAllOutfits)
	modalWindow:setDefaultEnterButton(acceptButton.id - 1)
	modalWindow:setDefaultEscapeButton(cancelButton.id - 1)

	local sex = player:getSex()
	if not player:hasOutfit(outfitData.lookType[sex], addonOne) then
		local choice = modalWindow:addChoice("First Addon")
		choice.addon = addonOne
		choice.addonRequiredItems = outfitData.addonRequiredItems[addonOne]
		choice.outfitData = outfitData
		choice.outfitName = outfitName
	end
	if not player:hasOutfit(outfitData.lookType[sex], addonTwo) then
		local choice = modalWindow:addChoice("Second Addon")
		choice.addon = addonTwo
		choice.addonRequiredItems = outfitData.addonRequiredItems[addonTwo]
		choice.outfitData = outfitData
		choice.outfitName = outfitName
	end

	modalWindow:sendToPlayer(player)
end
function clickSendSpecificOutfitWindow(player, button, choice, context)
	sendSpecificOutfitWindow(player, choice.outfitData, choice.outfitName, context)
end

local function onCancel(player, button, choice) end

local function onHelpAllOutfitsAddons(player, button, choice, context)
	local allOutfitsHelpWindow = ModalWindow({ title = "Outfits", message = "You can exchange materials for addons for certain outfits. Just choose an outfit and addo to unlock. If you are not sure what materials to bring, use help button.", context = context })
	local allOutfitsHelpWindowBackButton = allOutfitsHelpWindow:addButton("Back", clickBackToAllOutfits)
	allOutfitsHelpWindow:setDefaultEnterButton(allOutfitsHelpWindowBackButton.id - 1)
	allOutfitsHelpWindow:setDefaultEscapeButton(allOutfitsHelpWindowBackButton.id - 1)
	allOutfitsHelpWindow:sendToPlayer(player)
end

local function prepareModalWindowAllOutfitsAddons(context)
	local modalWindow = ModalWindow({ title = "Available outfits", message = "Choose outfit to unlock addons for:", context = context })
	local acceptButton = modalWindow:addButton("Select", clickSendSpecificOutfitWindow)
	local helpButton = modalWindow:addButton("Help", onHelpAllOutfitsAddons)
	local cancelButton = modalWindow:addButton("Cancel", onCancel)
	modalWindow:setDefaultEnterButton(acceptButton.id - 1)
	modalWindow:setDefaultEscapeButton(cancelButton.id - 1)
	return modalWindow
end

--Entry point
function UnlockableOutfitAddonRegistry:SendAllOutfitsWindow(player, context)
	local modalWindow = prepareModalWindowAllOutfitsAddons(context)

	local sex = player:getSex()
	for outfitName, outfitData in
		sortedkeypairs(self.registry[sex], function(a, b)
			return a < b
		end)
	do
		if player:HasBaseOutfit(outfitData) and not player:HasFullOutfitAddons(outfitData) then
			local addonsStr = "current: None"
			if player:hasOutfit(outfitData.lookType[sex], addonOne) then
				addonsStr = "owned: First"
			elseif player:hasOutfit(outfitData.lookType[sex], addonTwo) then
				addonsStr = "owned: Second"
			end
			local outfitAddonStr = T(":outfitName: (:addonsStr:)", { outfitName = outfitName, addonsStr = addonsStr })
			local choice = modalWindow:addChoice(outfitAddonStr)
			choice.outfitName = outfitName
			choice.outfitData = outfitData
		end
	end
	modalWindow:sendToPlayer(player)
end
