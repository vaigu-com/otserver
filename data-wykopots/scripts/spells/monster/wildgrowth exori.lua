local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_PHYSICALDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HITAREA)
combat:setArea(createCombatArea(AREA_SQUARE1X1))

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	local creatpos = creature:getPosition()
	for x = (creatpos.x - 1), (creatpos.x + 1) do
		for y = (creatpos.y - 1), (creatpos.y + 1) do
			local tile = Tile(x, y, creatpos.z)
			if tile then
				local thing = tile:getItemById(2130)
				if thing then
					local rand = math.random(1, 2)
					if rand == 1 then
						thing:remove()
					end
				end
			end
		end
	end
	return combat:execute(creature, var)
end

spell:name("wildgrowth exori")
spell:words(NextSpellId())
spell:isAggressive(true)
spell:needLearn(true)
spell:cooldown("2000")
spell:isSelfTarget(true)
spell:register()
