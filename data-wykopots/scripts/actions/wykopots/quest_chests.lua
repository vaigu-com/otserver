-- This function will capitalize the first letter of every word.
function capAll(str)
	local newStr = ""
	wordSeparate = string.gmatch(str, "([^%s]+)")
	for v in wordSeparate do
		v = v:gsub("^%l", string.upper)
		if newStr ~= "" then
			newStr = newStr .. " " .. v
		else
			newStr = v
		end
	end
	return newStr
end

local config = nil
local lang_to_config = {
	["PL"] = {
		["ALREADY_OPENED"] = "Nic tu dla ciebie nie ma.",
		["LEVEL1"] = "Potrzebujesz przynajmniej ",
		["LEVEL2"] = " poziom, aby otworzyc.",
		["STORAGE_WRONG"] = "Nic tu dla ciebie nie ma.",
		["CAP1"] = "Potrzebujesz przynajmniej ",
		["CAP2"] = " oz udzwigu, aby uniesc przedmioty.",
	},
	["EN"] = {
		["ALREADY_OPENED"] = "Nothing here for you.",
		["LEVEL1"] = "You need ",
		["LEVEL2"] = " level to open.",
		["STORAGE_WRONG"] = "Nothing here for you.",
		["CAP1"] = "You need ",
		["CAP2"] = " oz of capacity to get this reward.",
	},
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lang = getPlayerLanguage(player)
	config = lang_to_config[lang]

	-- Local Variables --
	local questChest = item:getUniqueId()
	-- Check if player has already opened box --
	if player:getStorageValue(questChest) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["ALREADY_OPENED"])
		return true
	end
	-- Check if player meets level requirment
	local playerLevel = player:getLevel()
	local minLevel = questChests[questChest].minLevel
	if questChests[questChest].minLevel > playerLevel then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["LEVEL1"] .. minLevel .. config["LEVEL2"])
		return true
	end
	-- storages
	local storageId = questChests[questChest].storageId
	if questChests[questChest].storageId then
		if player:getStorageValue(questChests[questChest].storageId) <= 0 then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["STORAGE_WRONG"])
			return true
		end
	end
	-- Check if player have enough capacity
	local neededCap = 0
	for i = 1, #questChests[questChest].items do
		local rewardType = questChests[questChest].items[i].type
		if rewardType == "item" then
			local item = questChests[questChest].items[i].item
			local count = questChests[questChest].items[i].count
			neededCap = neededCap + ((ItemType(item):getWeight()) * count)
		end
	end
	if player:getFreeCapacity() < neededCap then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config["CAP1"] .. (neededCap / 100) .. config["CAP2"])
		return true
	end
	-- Give reward if player has not yet opened box --
	for i = 1, #questChests[questChest].items do
		local rewardType = questChests[questChest].items[i].type
		-- Item Type Reward --
		if rewardType == "item" then
			local item = questChests[questChest].items[i].item
			local count = questChests[questChest].items[i].count
			if questChests[questChest].items[i].aid then
				local aid = questChests[questChest].items[i].aid
			end
			local desc = nil
			if questChests[questChest].items[i].desc then
				desc = questChests[questChest].items[i].desc[lang]
			end

			local addItem = player:addItem(item, count)
			if aid then
				addItem:setActionId(aid)
			end
			if desc then
				addItem:setDescription(desc)
			end
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You earned [" .. count .. "x] " .. capAll(getItemName(item)))
		end
		-- Experience Type Reward --
		if rewardType == "experience" then
			local amount = questChests[questChest].items[i].amount
			player:addExperience(amount)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You gained " .. amount .. " experience!")
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
			--player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained "..amount.." experience points.")
		end
		-- Outfit Type Reward --
		if rewardType == "outfit" then
			local outfitName = questChests[questChest].items[i].name
			local maleOutfit = questChests[questChest].items[i].maleId
			local femaleOutfit = questChests[questChest].items[i].femaleId
			if player:getSex() == 0 then
				player:addOutfit(femaleOutfit)
			else
				player:addOutfit(maleOutfit)
			end
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained the " .. outfitName .. " outfit.")
		end
		-- Addon Type Reward --
		if rewardType == "addon" then
			local outfitName = questChests[questChest].items[i].outfit
			local addon = questChests[questChest].items[i].addonNumber
			local maleAddon = questChests[questChest].items[i].maleId
			local femaleAddon = questChests[questChest].items[i].femaleId
			if player:getSex() == 0 then
				player:addOutfitAddon(femaleAddon, addon)
			else
				player:addOutfitAddon(maleAddon, addon)
			end
			if addon == 1 then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained the first " .. outfitName .. " outfit addon.")
			elseif addon == 2 then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained the second " .. outfitName .. " outfit addon.")
			elseif addon == 3 then
				player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You gained the third " .. outfitName .. " outfit addon.")
			end
		end
		-- Mount Type Reward --
		if rewardType == "mount" then
			local mountName = questChests[questChest].items[i].mountName
			local mountId = questChests[questChest].items[i].mountId
			player:addMount(mountId)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, "You have unlocked the " .. mountName .. " mount.")
		end
	end
	-- Add in any cooldowns/storages --
	player:setStorageValue(questChest, 1)
	return true
end

for uniqueRange = 5000, 5100 do
	action:uid(uniqueRange)
end
action:register()
