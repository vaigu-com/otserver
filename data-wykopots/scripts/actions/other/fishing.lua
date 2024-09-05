local config = nil
local lang_to_config = {
	["PL"] = {
		text = "Nic tu po mnie.",
		noworm = "Nie posiadasz robakow.",
		haczyk = "Wbil ci sie haczyk w noge!",
		marlin = "Piekna ryba! Niektorzy wedkarze duzo by dali za taki okaz, popytaj w miescie.",
		pstrag = "No no, zlapac takiego pstraga to jak wygrac zycie.",
		szczupak = "Ooo, jebany szczupak, a jakie ma zeby! Uwazaj, bo chaps i reka ujebana!",
		okon = "Zlapales okonia.",
		smieci = "Same smieci..",
	},
	["EN"] = {
		text = "Nothing for me here.",
		noworm = "You don't have any worms.",
		haczyk = "You've got a hook in your leg!",
		marlin = "Beautiful fish! Some anglers would give a lot for such a catch, ask around in town.",
		pstrag = "Oh, oh, catching such a trout is like winning the life.",
		szczupak = "Wow, that damn pike, and what teeth it has! Be careful, it can bite and mess up your hand!",
		okon = "You've caught a perch.",
		smieci = "There was just rubbish in it.",
	},
}

local waterIds = { 622, 4597, 4598, 4599, 4600, 12561, 12563, 4601, 4602, 4609, 4610, 4611, 4612, 4613, 4614, 629, 630, 631, 632, 633, 634, 7236, 9582, 13988, 13989, 12560, 21414, 11520 }
local lootTrash = { 3119, 3123, 3264, 3409, 3578 }
local lootCommon = { 3035, 3051, 3052, 3580, 236, 237 }
local lootRare = { 3026, 3029, 3032, 7158, 7159 }
local lootVeryRare = { 281, 282, 9303 }
local lootVeryRare1 = { 281, 12557 }
local lootRare1 = { 3026, 12557 }
local lootCommon1 = { 3035, 237, 12557 }

local elementals = {
	chances = {
		{ from = 0, to = 500, itemId = 3026 }, -- white pearl
		{ from = 501, to = 801, itemId = 3029 }, -- small sapphire
		{ from = 802, to = 1002, itemId = 3032 }, -- small emerald
		{ from = 1003, to = 1053, itemId = 281 }, -- giant shimmering pearl (green)
		{ from = 1054, to = 1104, itemId = 282 }, -- giant shimmering pearl (brown)
		{ from = 1105, to = 1115, itemId = 9303 }, -- leviathan's amulet
	},
}

local useWorms = true

local function refreeIceHole(position)
	local iceHole = Tile(position):getItemById(7237)
	if iceHole then
		iceHole:transform(7200)
	end
end

local fishing = Action()

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(waterIds, target.itemid) then
		return false
	end

	config = GetConfigByPlayer(player, lang_to_config)
	local targetId = target.itemid

	local crateAid = target.actionid
	if targetId == 11520 then
		if crateAid == 11084 then
			if player:getStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain) == 1 then
				player:AddCustomItem({ id = 3504, aid = 3504, addToStore = true }) 
				player:setStorageValue(Storage.Biodegradowalny.BiodegradowalnyMain, 2)
			else
				config = GetConfigByPlayer(player, lang_to_config)
				player:sendTextMessage(MESSAGE_STATUS_SMALL, config.text)
			end
			return true
		end
	end

	if targetId == 9582 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player.uid then
			player:sendTextMessage(MESSAGE_FAILURE, "You are not the owner.")
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:transform(target.itemid + 1)

		local chance = math.random(10000)
		for i = 1, #elementals.chances do
			local randomItem = elementals.chances[i]
			if chance >= randomItem.from and chance <= randomItem.to then
				player:addItem(randomItem.itemId, 1)
			end
			if chance > 1115 then
				player:say(config.smieci, TALKTYPE_MONSTER_SAY)
				return true
			end
		end
	end

	if targetId == 12560 then
		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		local rareChance = math.random(100)
		if rareChance == 1 then
			player:addItem(lootVeryRare1[math.random(#lootVeryRare1)], 1)
		elseif rareChance <= 3 then
			player:addItem(lootRare1[math.random(#lootRare1)], 1)
		elseif rareChance <= 10 then
			player:addItem(lootCommon1[math.random(#lootCommon1)], 1)
		else
			player:addItem(lootTrash[math.random(#lootTrash)], 1)
		end
		return true
	end

	if targetId ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if targetId == 622 or targetId == 13989 then
		return true
	end

	if useWorms and not player:removeItem("worm", 1) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, config.noworm)
		return true
	end

	player:addSkillTries(SKILL_FISHING, 1)

	-- Prevent macro
	if math.random(300) <= 2 then
		local condition = Condition(CONDITION_BLEEDING)
		condition:setParameter(CONDITION_PARAM_DELAYED, 1)
		condition:addDamage(5, 10, -10)
		player:getPosition():sendMagicEffect(CONST_ME_DRAWBLOOD)
		player:addCondition(condition)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.haczyk)
		return true
	end

	if math.random(200) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		local range = math.random(100)
		if range > 99 then
			player:addItem(901, 1) --marlin
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.malin)
		elseif range > 94 then
			player:addItem(7158, 1) --pstrag
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.pstrag)
		elseif range > 84 then
			player:addItem(3580, 1) --szczupak
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.szczupak)
		elseif range > 65 then
			player:addItem(7159, 1) --okon
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.okon)
		elseif range < 30 then
			player:addItem(3578, 1)
		end
	end
	return true
end

fishing:id(3483)
fishing:allowFarUse(true)
fishing:register()
