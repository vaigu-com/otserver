local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_BLUE_ENERGY_SPARK)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local target = Creature(var.number)
	if not target then
		return false
	end
	local creaturePos = creature:getPosition()
	local path = creaturePos:getPathTo(target:getPosition(), 0, 0, true, true, 8)
	if not path or #path == 0 then
		return false
	end
	for i = 1, #path do
		creaturePos:getNextPosition(path[i], 1)
		doAreaCombatHealth(creature, COMBAT_ICEDAMAGE, creaturePos, 0, -240, -300, CONST_ME_BLUE_ENERGY_SPARK)
	end
	return combat:execute(creature, var)
end

spell:name("crazed winter chain")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
