local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)

local function tryEatBabySeal(centerPos)
	local eatenBaby = IterateBetweenPositions(centerPos:Moved(-2, -2, 0), centerPos:Moved(2, 2, 0), function(context)
		local pos = context.pos
		local babySeal = Tile(pos):getItemById(7178)
		if babySeal then
			pos:sendMagicEffect(CONST_ME_DRAWBLOOD)
			babySeal:remove()
			return true
		end
	end, { stopCondition = STOP_CONDITIONS.isTrue })
	return eatenBaby
end

local function canEat(rukcaState)
	if os.time() > rukcaState.nextMealTime then
		return true
	else
		return false
	end
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	local rukcaState = CreatureStateRegistry:getState(creature)
	if not canEat(rukcaState) then
		return
	end

	if not tryEatBabySeal(creature:getPosition()) then
		rukcaState.rukcaIsHungry = true
	else
		rukcaState.rukcaIsHungry = false
		rukcaState.nextMealTime = os.time() + 10
	end
	return combat:execute(creature, var)
end

spell:name("rukca eating")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
