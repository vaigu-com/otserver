local combat = createCombatObject()
setCombatParam(combat, COMBAT_PARAM_TYPE, COMBAT_NONE)
setCombatParam(combat, COMBAT_PARAM_EFFECT, CONST_ME_BATS)

local area = createCombatArea(AREA_SQUARE1X1)
setCombatArea(combat, area)

local spell = Spell("instant")

function spell.onCastSpell(cid, var)
	for i = 1, math.random(4, 5) do
		local position = Position(math.random(7300, 7313), math.random(1874, 1885), 13)
		Game.createMonster("Sin Devourer", position)
	end
	for i = 1, math.random(5, 5) do
		local position = Position(math.random(7300, 7313), math.random(1874, 1885), 13)
		Game.createMonster("Damned Soul", position)
	end

	return doCombat(cid, combat, var)
end

--{x = 7300, y = 1874, z = 13}
--{x = 7313, y = 1885, z = 13}

spell:name("shulgrax summon")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
