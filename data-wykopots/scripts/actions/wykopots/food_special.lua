local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.GrimEvent.Joined) >= 1 or player:getStorageValue(Storage.hasteLock) == 1 or player:getStorageValue(Storage.healLock) == 1 then
		player:sendCancelMessage("You cannot eat dishes on this event.")
		return true
	end

	local sayParam, textParam, removeItem = "", "", true
	if item.itemid == 9080 then -- Hydra Tongue Salad
		local condition = { CONDITION_POISON, CONDITION_FIRE, CONDITION_ENERGY, CONDITION_BLEEDING, CONDITION_PARALYZE, CONDITION_DRUNK, CONDITION_DROWN, CONDITION_FREEZING, CONDITION_DAZZLED, CONDITION_CURSED, CONDITION_PACIFIED }
		for i = 1, #condition do
			if player:getCondition(condition[i]) then
				player:removeCondition(condition[i])
			end
		end

		textParam = ""
		sayParam = "Crunch."
	elseif item.itemid == 9081 then -- Roasted Dragon Wings
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 10)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)

		player:addCondition(condition)
		textParam = ""
		sayParam = "Chomp."
	elseif item.itemid == 9082 then -- Tropical Fried Terrorbird
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 5)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)

		player:addCondition(condition)
		textParam = ""
		sayParam = "Chomp."
	elseif item.itemid == 9083 then -- Banana Chocolate Shake
		player:getPosition():sendMagicEffect(CONST_ME_HEARTS)
		textParam = "You don't really know what this did to you, but suddenly you feel very happy"
		sayParam = "Slurp."
	elseif item.itemid == 9084 then -- Veggie Casserole
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
		condition:setParameter(CONDITION_PARAM_SKILL_MELEE, 10)

		player:addCondition(condition)
		textParam = ""
		sayParam = "Yum."
	elseif item.itemid == 9085 then -- Filled Jalapeno Peppers
		local condition = Condition(CONDITION_HASTE)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
		condition:setParameter(CONDITION_PARAM_SPEED, 200)

		player:addCondition(condition)
		textParam = ""
		sayParam = "Munch."
	elseif item.itemid == 9087 then -- Carrot Cake
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
		condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 10)

		player:addCondition(condition)
		textParam = ""
		sayParam = "Mmmm."
	elseif item.itemid == 9088 then -- Northern Fishburger
		local condition = Condition(CONDITION_ATTRIBUTES)
		condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
		condition:setParameter(CONDITION_PARAM_SKILL_FISHING, 20)

		player:addCondition(condition)
		textParam = "Umiejetnosc lowienia zostala zwiekszona na godzine o 20 poziomow."
		sayParam = "Smack."
	elseif item.itemid == 11584 then -- Coconut Shrimp Bake
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
		player:setStorageValue(Storage.ShrimpBake, os.time() + 86400)
		textParam = "Underwater walking speed increased."
		sayParam = "Smack."
		return false
	elseif item.itemid == 11587 then -- Demonic Candy Ball
		local number = math.random(7)
		if number == 1 then
			local condition = Condition(CONDITION_ATTRIBUTES)
			condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
			condition:setParameter(CONDITION_PARAM_SKILL_MELEE, 6)
			player:addCondition(condition)
		elseif number == 2 then
			local condition = Condition(CONDITION_ATTRIBUTES)
			condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
			condition:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 6)
			player:addCondition(condition)
		elseif number == 3 then
			local condition = Condition(CONDITION_ATTRIBUTES)
			condition:setParameter(CONDITION_PARAM_SKILL_SHIELD, 6)
			condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
			player:addCondition(condition)
		elseif number == 4 then
			local condition = Condition(CONDITION_ATTRIBUTES)
			condition:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
			condition:setParameter(CONDITION_PARAM_TICKS, 60 * 60 * 1000)
			player:addCondition(condition)
		elseif number == 5 then
			local condition = Condition(CONDITION_HASTE)
			condition:setParameter(CONDITION_PARAM_TICKS, 22000)
			condition:setFormula(0.7, -56, 0.7, -56)
			player:addCondition(condition)
		elseif number == 6 then
			local condition = Condition(CONDITION_LIGHT)
			condition:setParameter(CONDITION_PARAM_LIGHT_LEVEL, 10)
			condition:setParameter(CONDITION_PARAM_LIGHT_COLOR, 215)
			condition:setParameter(CONDITION_PARAM_TICKS, 2 * 60 * 60 * 1000)
			player:addCondition(condition)
		elseif number == 7 then
			local condition = Condition(CONDITION_INVISIBLE)
			condition:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
			player:addCondition(condition)
		end
		textParam = ""
		sayParam = "Smack."
	elseif item.itemid == 11588 then -- Sweet Mangonaise Elixir
		local slotItem = player:getSlotItem(CONST_SLOT_RING)
		if slotItem then
			if not slotItem:hasAttribute(ITEM_ATTRIBUTE_DURATION) then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This ring cannot be multiplied.")
				return true
			end

			for i = 1, 10 do
				if slotItem:getId() == 23534 or slotItem:getId() == 23532 or slotItem:getId() == 23530 then
					player:addItem((slotItem:getId() - 1), 1)
				else
					player:addItem(slotItem:getId(), 1)
				end
			end
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You need to equip a ring to use this item.")
			return true
		end

		textParam = ""
		sayParam = "Slurp!"
	end

	if textParam ~= "" then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, textParam)
	end

	if removeItem then
		item:remove(1)
	end

	player:say(sayParam, TALKTYPE_MONSTER_SAY)
	return true
end

action:id(9080, 9081, 9082, 9083, 9084, 9085, 9087, 9088, 11584, 11587, 11588)
action:register()
