local langConfig = nil
local lang_to_config = {
	["PL"] = {
		["NOREWARD"] = "Aktualnie nie posiadasz zadnej nagrody.",
		["FREESLOTS"] = "Upewnij sie, ze masz wolne miejsce.",
		["FREECAP"] = "Upewnij sie, ze udzwigniesz conajmniej 100 oz.",
		["NEXTREW"] = "Mozesz odebrac jeszcze jedna nagrode.",
		["TAKEN"] = "Odebrales nagrode oraz 10min exp boosta.",
	},
	["EN"] = {
		["NOREWARD"] = " Currently you dont have any rewards.",
		["FREESLOTS"] = "Make sure you have free spot in backpack.",
		["FREECAP"] = "Make sure you have 100 oz. of capacity.",
		["NEXTREW"] = "You can get another reward.",
		["TAKEN"] = "You got your reward and 10mins of exp boost.",
	},
}

local config = {
	scriptDebug = false, -- no chest use limit

	[2405] = {
		storage = Storage.DailyBossReward, -- 25591
		items = {
			{ -- 100% for one of following items
				chance = 100,
				levelRestriction = true,
				itemId = {
					36729,
					36730,
					36731,
					36732,
					36733,
					36734,
					36735, -- resist cocotions
					36736,
					36737,
					36738,
					36739,
					36740,
					36741,
					36742, -- atak cocotions
					23544,
					23542,
					23543,
					23533,
					23531,
					23529, -- collary i ringi
					3043, -- 1cc
					22516, -- silver token
				},
			},
			{ chance = 1, levelRestriction = true, itemId = { 36727, 36725 } }, -- wealth(2xloot 1h), stamina 1h
			{ chance = 5, levelRestriction = true, itemId = { 36726 } }, -- charm upgr
			{ chance = 10, levelRestriction = true, itemId = { 36723, 36724, 36728 } }, -- kooldown, strike ench, bestiary2x
			{ chance = 20, levelRestriction = true, itemId = { 25360, 25361 }, count = 1 }, -- blood, heart of the mountain
			{ chance = 10, itemId = { 9598, 9596, 9594 } }, -- scyzoryki
			{ chance = 5, itemId = { 18339 } }, -- zao chess box
			{ chance = 20, itemId = { 9058, 3038, 3041 }, count = 1 }, -- ignot, blue, green gem
			{ chance = 100, itemId = { 3032, 3028, 9057 }, count = 5 }, -- blyskotki
			{ chance = 100, itemId = { 3033, 3029, 3030 }, count = 5 }, -- blyskotki
			{ chance = 100, itemId = { 16125, 16126, 16127 }, count = 4 }, -- crystal fragments
			{ chance = 100, itemId = { 3052, 3098, 3049, 3053 }, count = 1 }, -- ringi
		},
	},
}

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lang = getPlayerLanguage(player)
	langConfig = lang_to_config[lang]

	local reward = config[item.actionid]
	if not reward then
		return true
	end

	if not config.scriptDebug and player:getStorageValue(reward.storage) <= 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, langConfig["NOREWARD"])
		return true
	end

	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if backpack and backpack:getEmptySlots(true) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, langConfig["FREESLOTS"])
		return true
	end

	if player:getFreeCapacity() < 100 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, langConfig["FREECAP"])
		return true
	end

	local cont = Container(player:addItem(8861):getUniqueId())

	for i = 1, #reward.items do
		local items = reward.items[i]
		if items.chance then
			if items.chance >= math.random(1, 100) then
				if items.levelRestriction then
					if player:getLevel() >= 25 then -- dont add rare items below 25 lvl (prevent noobchars)
						cont:addItem(items.itemId[math.random(#items.itemId)], items.count or 1)
					end
				else
					cont:addItem(items.itemId[math.random(#items.itemId)], items.count or 1)
				end
			end
		else
			cont:addItem(items.itemId, items.count or 1)
		end
	end

	player:setStorageValue(reward.storage, (player:getStorageValue(reward.storage) - 1))
	if player:getStorageValue(reward.storage) >= 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, langConfig["NEXTREW"])
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, langConfig["TAKEN"])
	end

	-- Xp boost
	local exprate = getRateFromTable(experienceStages, player:getLevel(), configManager.getNumber(configKeys.RATE_EXPERIENCE))
	if player:getExpBoostStamina() <= 28800 then
		player:setExpBoostStamina(player:getExpBoostStamina() + (10 * 60))
		player:setStoreXpBoost(50 * exprate)
	end

	player:getPosition():sendMagicEffect(CONST_ME_STUN)
	return true
end

action:aid(2405)
action:register()
