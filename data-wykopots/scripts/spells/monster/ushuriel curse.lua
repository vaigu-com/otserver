local minValue = 1
local maxValue = 1.1
local increaseValue = 0.1

local area = createCombatArea(AREA_CIRCLE3X3)

local function configureCombat(combat, damage)
	combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
	combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_SMALLCLOUDS)
	combat:setArea(area)
end

local doCombatFunc = MonsterSpellCreateCursedCombatList(minValue, maxValue, increaseValue, 28, 28, 1.2, 4000, configureCombat)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	return doCombatFunc():execute(creature, variant)
end

spell:name("ushuriel curse")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
