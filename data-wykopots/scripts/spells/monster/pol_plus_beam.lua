local plusArea = createCombatArea(AREA_PLUS5)
local params = Combat()
params:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
params:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
params:setArea(plusArea)
params:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isMonster() then
		return true
	end
	var.pos = creature:getPosition()
	for i = 1, 10, 0.5 do
		addEvent(function()
			doCombat(creature, params, var)
		end, i * 1000)
	end
	return true
end

spell:name("pol plus beam")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
