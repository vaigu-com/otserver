local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_GROUNDSHAKER)
combat:setArea(createCombatArea(AREA_CIRCLE5X5V2))

local rageBaseDamage = 100
local rageCurrentDamage = 100

local spell = Spell("instant")
function spell.onCastSpell(creature, var)
	local rukcaState = CreatureStateRegistry:getState(creature)
	if rukcaState.rukcaIsHungry then
		rageCurrentDamage = rageCurrentDamage + 70
		combat:setFormula(COMBAT_FORMULA_DAMAGE, -rageCurrentDamage, 0, -rageCurrentDamage, 0)
		return combat:execute(creature, var)
	end

	rageCurrentDamage = rageBaseDamage
end

spell:name("rukca hunger rage")
spell:words(NextSpellId())
spell:needTarget(false)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(false)
spell:register()
