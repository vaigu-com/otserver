local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_EXPLOSIONHIT)
local arr = AREA_CIRCLE2X2
local area = createCombatArea(arr)
combat:setArea(area)

local function setNextDamage(creature)
	local state = CreatureStateRegistry:getState(creature)
	local damage = state.currentZulZulowDmg
	combat:setFormula(COMBAT_FORMULA_DAMAGE, -damage, 0, -damage, 0)
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	setNextDamage(creature)
	local result = combat:execute(creature, var)
	return result
end

spell:name("zul zulow aoe")
spell:words(NextSpellId())
spell:needTarget(false)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(false)
spell:register()
