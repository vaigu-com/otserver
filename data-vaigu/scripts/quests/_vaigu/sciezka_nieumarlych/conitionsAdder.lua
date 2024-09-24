	:Script(function(storageToRequiredState)
local conditions = {
	CONDITION_POISON, -- utori pox
	CONDITION_FIRE, -- utori flam
	CONDITION_ENERGY, -- utori vis
	CONDITION_BLEEDING, -- utori kor
	CONDITION_HASTE, -- utani hur
	CONDITION_INVISIBLE, -- utana vid/stealth ring
	CONDITION_MANASHIELD, -- utamo vita/ering
	CONDITION_INFIGHT, -- any attack spell
	CONDITION_DRUNK, -- drink beer
	CONDITION_DROWN, -- special chest
	CONDITION_MUTED, -- spam
	CONDITION_FREEZING, -- special chest
	CONDITION_DAZZLED, -- utori san
	CONDITION_CURSED, -- utori mort
}

local lever = Action()

function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	for _, identifier in pairs(conditions) do
		local condition = Condition(identifier)
		condition:setParameter(CONDITION_PARAM_DELAYED, 1)
		condition:setParameter(CONDITION_PARAM_TICKS, 200000)
		condition:addDamage(5000, 2000, -50)
		player:addCondition(condition)
	end
end

lever:aid(44433)
lever:register()
end)
