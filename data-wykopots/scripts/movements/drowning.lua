local condition = Condition(CONDITION_DROWN)
condition:setParameter(CONDITION_PARAM_PERIODICDAMAGE, -20)
condition:setParameter(CONDITION_PARAM_TICKS, -1)
condition:setParameter(CONDITION_PARAM_TICKINTERVAL, 2000)

local drowning = MoveEvent()
drowning:type("stepin")

function drowning.onStepIn(player, item, position, fromPosition)
	if player:isPlayer() then
		if player:getStorageValue(Storage.ShrimpBake) > os.time() then
			if player:getStorageValue(Storage.ShrimpScript) < 1 then
				doChangeSpeed(player, 600)
				player:setStorageValue(Storage.ShrimpScript, 1)
			end
		end

		local headItem = player:getSlotItem(CONST_SLOT_HEAD)
		if headItem and isInArray({ 5461, 12541, 15408 }, headItem.itemid) then
			return true
		elseif math.random(1, 10) == 1 then
			position:sendMagicEffect(CONST_ME_BUBBLES)
		end
		player:addCondition(condition)
	end
	return true
end

drowning:id(5405, 5406, 5407, 5408, 5409, 5743, 5744, 5764, 8755, 8756, 8757, 5404, 21575, 21576, 21577, 21578, 21579, 21580, 21581, 21582, 21583, 21584, 21585, 13533, 13534, 13535, 13536, 13537, 13538, 13539, 800)
drowning:register()

local drowningOut = MoveEvent()
drowningOut:type("stepout")

function drowningOut.onStepOut(creature, item, position, fromPosition)
	if creature:isPlayer() then
		creature:removeCondition(CONDITION_DROWN)
		if creature:getStorageValue(Storage.ShrimpScript) == 1 then
			doChangeSpeed(creature, 600 * -1)
			creature:setStorageValue(Storage.ShrimpScript, 0)
		end
	end
	return true
end

drowningOut:id(5405, 5406, 5407, 5408, 5409, 5743, 5744, 5764, 8755, 8756, 8757, 5404, 21575, 21576, 21577, 21578, 21579, 21580, 21581, 21582, 21583, 21584, 21585, 13533, 13534, 13535, 13536, 13537, 13538, 13539, 800)
drowningOut:register()
