local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:getHealth() < creature:getMaxHealth() then
		creature:addHealth(600)
	else
		return
	end
	return true
end

spell:name("mage familiar heal")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
