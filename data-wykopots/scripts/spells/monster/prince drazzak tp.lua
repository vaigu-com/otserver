local bossPos = Position(6127, 654, 12)
local playersPos = Position(6128, 654, 12)

local fromPosition = Position(6118, 647, 12)
local toPosition = Position(6137, 662, 12)

local centerRectPosition = buildRectArea(fromPosition, toPosition)

local spell = Spell("instant")

function spell.onCastSpell(creature, variant)
	creature:teleportTo(bossPos, true)
	creature:say("GET OVER HERE!", TALKTYPE_ORANGE_2, false, 0, bossPos)
	creature:setDirection(DIRECTION_EAST)

	local creatures = getCreaturesInArea(centerRectPosition.position, true, centerRectPosition.width, centerRectPosition.height, centerRectPosition.fromZ, centerRectPosition.toZ)

	if creatures then
		for _, player in ipairs(creatures) do
			player:teleportTo(playersPos, true)
		end
	end

	return true
end

spell:name("prince drazzak tp")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:blockWalls(true)
spell:needTarget(true)
spell:needLearn(true)
spell:register()
