local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if creature:getHealth() < 10000 then
		creature:addHealth(math.random(45000, 50000))
	else
		return
	end
	return true
end

spell:name("fake monk heal")
spell:words(NextSpellId())
spell:isAggressive(false)
spell:blockWalls(true)
spell:needTarget(false)
spell:needLearn(true)
spell:register()
