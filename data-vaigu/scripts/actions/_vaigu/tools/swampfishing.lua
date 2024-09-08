local swampIds = { 16301, 16302, 16303, 16304, 16305, 16306, 16307, 16308, 16309, 16310 }
-- wymagac larw?
local useLarvaes = true

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInArray(swampIds, target.itemid) then
		return false
	end

	local targetId = target.itemid

	if useLarvaes and not player:removeItem("larvae", 1) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Nie posiadasz larw.")
		return true
	end

	toPosition:sendMagicEffect(CONST_ME_HITBYPOISON)
	player:addSkillTries(SKILL_FISHING, 1)
	if math.random(200) <= math.min(math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10), 50) then
		local range = math.random(100)
		if range > 96 then
			player:addItem(17858, 1) --pijawka
		elseif range > 90 then
			player:addItem(3028, 1) --diament
		elseif range > 86 then
			player:addItem(12557, 1) --shimmer swimmer
		elseif range > 80 then
			player:addItem(3112, 1) --syf
		elseif range > 70 then
			player:addItem(2238, 1) --syf
		elseif range > 60 then
			player:addItem(3998, 1) --syf
		elseif range > 40 then
			player:addItem(3125, 1) --syf
		elseif range < 30 then
			player:addItem(19148, 1) --syf
		end
		toPosition:sendMagicEffect(CONST_ME_STONES)
	end
	return true
end

action:id(9306)
action:allowFarUse(true)
action:register()
