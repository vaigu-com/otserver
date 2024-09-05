local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local combat2 = Combat()
combat2:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat2:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat2:setArea(createCombatArea(AREA_WALLFIELD))

local combat3 = Combat()
combat3:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat3:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
combat3:setArea(createCombatArea(AREA_BACK_WALLFIELD))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	runSpell(creature:getId(), combat, var)
	addEvent(runSpell, 1500, creature:getId(), combat2, var)
	addEvent(runSpell, 3000, creature:getId(), combat3, var)
	return true
end

function runSpell(cid, combat, var)
	local creature = Creature(cid)
	if creature then
		combat:execute(creature, var)
	end
end

spell:name("nieumarly krol summon tornado")
spell:words(NextSpellId())
spell:needDirection(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
