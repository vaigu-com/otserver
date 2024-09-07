local conditions = {}

do
	local condition = Condition(CONDITION_FREEZING)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)
	condition:addDamage(5000, 3000, -50)

	conditions[#conditions + 1] = condition
end

do
	local condition = Condition(CONDITION_DROWN)
	condition:setParameter(CONDITION_PARAM_DELAYED, 1)
	condition:addDamage(5000, 2000, -50)

	conditions[#conditions + 1] = condition
end

local chest = Action()

function chest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return true
	end
	for _, condition in pairs(conditions) do
		player:addCondition(condition)
	end
	player:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
	return true
end

chest:aid(Storage.SciezkaNieumarlych.CursedChest)
chest:register()
