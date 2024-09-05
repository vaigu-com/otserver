local combat = createCombatObject()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ENERGYAREA)

arr = {
	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0 },
	{ 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0 },
}

local area = createCombatArea(arr)
setCombatArea(combat, area)

local spell = Spell("instant")

function spell.onCastSpell(cid, var)
	return doCombat(cid, combat, var)
end

spell:name("arachnophobicawaveenergy")
spell:words(NextSpellId())
spell:needDirection(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
