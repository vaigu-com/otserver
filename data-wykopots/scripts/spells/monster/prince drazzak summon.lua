local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_NONE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_NONE)

local area = createCombatArea(AREA_CIRCLE3X3)
combat:setArea(area)

local summonsPositions = {
	Position(6122, 651, 12),
	Position(6125, 659, 12),
	Position(6132, 657, 12),
}

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	creature:say("CRUSH THEM ALL!", TALKTYPE_ORANGE_2)

	for _, position in ipairs(summonsPositions) do
		Game.createMonster("Demon", position, false, true)
	end

	return combat:execute(creature, variant)
end

spell:name("prince drazzak summon")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
