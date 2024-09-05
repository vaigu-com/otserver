local smallArea = createCombatArea(AREA_PLUS3)
local exori = Combat()
exori:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
exori:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MORTAREA)
exori:setArea(smallArea)
exori:setFormula(COMBAT_FORMULA_DAMAGE, -1500, 0, -1500, 0)

local lagaDyga = CreatureEvent("LagaDygaDeath")
function lagaDyga.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	doCombat(creature, exori, { type = 2, pos = creature:getPosition() })
	return true
end

lagaDyga:register()
