local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:getHealth() < creature:getMaxHealth() then
		creature:addHealth(380)
	else
		return
	end
	return true
end

spell:name("paladin familiar heal")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
