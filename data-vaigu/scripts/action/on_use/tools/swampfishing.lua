local swampIds = { 16301, 16302, 16303, 16304, 16305, 16306, 16307, 16308, 16309, 16310 }
-- wymagac larw?
local useLarvaes = true

local action = Action()
function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInArray(swampIds, target:getId()) then
		return false
	end
	if useLarvaes and not player:removeItem(14084, 1) then
		player:sendTextMessage(MESSAGE_STATUS_SMALL, "Nie posiadasz larw.")
		return true
	end

	toPosition:sendMagicEffect(CONST_ME_HITBYPOISON)
	player:addSkillTries(SKILL_FISHING, 1)
	local playerWeightedSkill = math.max(10 + (player:getEffectiveSkillLevel(SKILL_FISHING) - 10) * 0.597, 10)
	local roll = math.min(playerWeightedSkill, 50)
	if math.random(200) <= roll then
		local range = math.random(100)
		if range > 96 then
			player:AddCustomItem({ id = 17858, count = 1 }) --pijawka
		elseif range > 90 then
			player:AddCustomItem({ id = 3028, count = 1 }) --diament
		elseif range > 86 then
			player:AddCustomItem({ id = 12557, count = 1 }) --shimmer swimmer
		elseif range > 80 then
			player:AddCustomItem({ id = 3112, count = 1 }) --syf
		elseif range > 70 then
			player:AddCustomItem({ id = 2238, count = 1 }) --syf
		elseif range > 60 then
			player:AddCustomItem({ id = 3998, count = 1 }) --syf
		elseif range > 40 then
			player:AddCustomItem({ id = 3125, count = 1 }) --syf
		elseif range < 30 then
			player:AddCustomItem({ id = 19148, count = 1 }) --syf
		end
		toPosition:sendMagicEffect(CONST_ME_STONES)
	end
	return true
end
action:id(9306)
action:allowFarUse(true)
action:register()
