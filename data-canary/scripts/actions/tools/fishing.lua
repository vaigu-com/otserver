local waterIds = { 629, 630, 631, 632, 633, 634, 4597, 4598, 4599, 4600, 4601, 4602, 4609, 4610, 4611, 4612, 4613, 4614, 7236, 9582, 12560, 12562, 12561, 12563, 13988, 13989 }
local lootTrash = { 3119, 3123, 3264, 3409, 3578 }
local lootCommon = { 3035, 3051, 3052, 3580, 236, 237 }
local lootSemiRare = { 281, 282, 9303 }
local lootRare = { 3026, 3029, 3032, 7158, 7159 }
local lootVeryRare = { 281, 282, 9303, 12557 }
local useWorms = true

local fishing = Action()

function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not table.contains(waterIds, target.itemid) then
		return false
	end

	if target.itemid == 9582 then
		local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
		if owner ~= 0 and owner ~= player:getId() then
			player:sendTextMessage(MESSAGE_FAILURE, "You are not the owner.")
			return true
		end

		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
		target:transform(target.itemid + 1)
		target:decay()

		local rareChance = math.random(1, 100)
		if rareChance == 1 then
			player:AddCustomItem({id = lootVeryRare[math.random(#lootVeryRare)], count = 1})
		elseif rareChance <= 3 then
			player:AddCustomItem({id = lootRare[math.random(#lootRare)], count = 1})
		elseif rareChance <= 10 then
			player:AddCustomItem({id = lootCommon[math.random(#lootCommon)], count = 1})
		else
			player:AddCustomItem({id = lootTrash[math.random(#lootTrash)], count = 1})
		end
		return true
	end

	if target.itemid ~= 7236 then
		toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
	end

	if target.itemid == 622 or target.itemid == 13989 then
		return true
	end

	if player:getItemCount(3492) > 0 then
		player:addSkillTries(SKILL_FISHING, 1, true)
	end

	if math.random(1, 100) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		if useWorms and not player:removeItem(3976, 1) then
			return true
		end

		if target.itemid == 13988 then
			target:transform(target.itemid + 1)
			target:decay()

			if math.random(1, 100) >= 97 then
				player:AddCustomItem({id = 13992, count = 1})
				return true
			end
		elseif target.itemid == 7236 then
			target:transform(target.itemid + 1)
			target:decay()

			local rareChance = math.random(1, 100)
			if rareChance == 1 then
				player:AddCustomItem({id = 7158, count = 1})
				return true
			elseif rareChance <= 4 then
				player:AddCustomItem({id = 3580, count = 1})
				return true
			elseif rareChance <= 10 then
				player:AddCustomItem({id = 7159, count = 1})
				return true
			end
		end
		player:AddCustomItem({id = 3578, count = 1})
	end
	return true
end

fishing:id(3483)
fishing:allowFarUse(true)
fishing:register()
