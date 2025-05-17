-- Vaigu custom
local maxDmg = 12

-- the chiller
local chiller = Weapon(WEAPON_WAND)
local chillerCombat = Combat()
chillerCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
chillerCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ICE)
function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 0.4) + 3
	local max = (level / 5) + (maglevel * 0.7) + 7
	return -(math.min(maxDmg, min)), -(math.min(maxDmg, max))
end
chillerCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
chiller.onUseWeapon = function(player, variant)
	return chillerCombat:execute(player, variant)
end
chiller:id(21350)
chiller:mana(1)
chiller:range(3)
chiller:register()

-- the scorcher
local scorcher = Weapon(WEAPON_WAND)
local scorcherCombat = Combat()
scorcherCombat:setParameter(COMBAT_PARAM_TYPE, COMBAT_FIREDAMAGE)
scorcherCombat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_FIRE)
function onGetFormulaValues(player, level, maglevel)
	local min = (level / 5) + (maglevel * 0.4) + 3
	local max = (level / 5) + (maglevel * 0.7) + 7
	return -(math.min(maxDmg, min)), -(math.min(maxDmg, max))
end
scorcherCombat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
scorcher.onUseWeapon = function(player, variant)
	return scorcherCombat:execute(player, variant)
end
scorcher:id(21348)
scorcher:mana(1)
scorcher:range(3)
scorcher:register()
