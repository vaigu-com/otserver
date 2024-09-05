local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ENERGYDAMAGE)
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGYBALL)

local seeingRange = 2
local seeingRadius = 1

local function tryCatchPlayers(guard)
	local lookingDirection = guard:getDirection()
	local lookingVector = Vector.FromDirection(lookingDirection, seeingRange)

	local guardPos = guard:getPosition()
	local gazeCenter = guardPos:Moved(lookingVector)
	local gazeCorner1, gazeCorner2 = gazeCenter:GetBoundariesByRadius(seeingRadius)

	IterateBetweenPositions(gazeCorner1, gazeCorner2, function(context)
		local playerPos = context.pos
		local player = playerPos:GetTopCreature()
		if not (player and player:isPlayer()) then
			return
		end
		PER_IUSTITIA_AD_ASTRA_SPECIAL_ACTIONS.officerCaughtYou({ player = player })
	end)
end

local spell = Spell("instant")
function spell.onCastSpell(creature, var, isHotkey)
	tryCatchPlayers(creature)
	return combat:execute(creature, var)
end

spell:name("hugo house guard scan")
spell:words(NextSpellId())
spell:needTarget(true)
spell:isAggressive(true)
spell:blockWalls(true)
spell:needLearn(false)
spell:needDirection(true)
spell:register()
