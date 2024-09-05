local exitPosition = Position(7276, 1965, 12)

local spell = Spell("instant")

function spell.onCastSpell(creature, target)
	local spectators, spectator = Game.getSpectators(Position(7281, 1937, 11), false, true, 15, 15, 15, 15)
	for i = 1, #spectators do
		spectator = spectators[i]
		spectator:teleportTo(exitPosition)
		exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
	end
end

spell:name("tarbaz teleport")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
