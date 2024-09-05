local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)

local slamPositionLeft = KRAKEN_ANCHOR:Moved(-51, 0, 0)
local positions = {}
for i = 0, 6 do
	table.insert(positions, slamPositionLeft:Moved(i, -3, 0))
	table.insert(positions, slamPositionLeft:Moved(i, 3, 0))
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	Game.createMonster("Kraken tentacles slammer", positions[math.random(1, #positions)])
	return true
end

spell:name("kraken tentacle spawn slammer")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(true)
spell:register()
