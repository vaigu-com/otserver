local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	local zulSzczurowState = CreatureStateRegistry:getState(creature)
	zulSzczurowState.currentZulZulowDmg = zulSzczurowState.currentZulZulowDmg  + zulSzczurowState.zulZulowDmgIncreasePerTick
	return true
end

spell:name("zul szczurow increment")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
