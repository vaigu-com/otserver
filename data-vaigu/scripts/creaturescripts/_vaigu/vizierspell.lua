local vizierSpell = CreatureEvent("VizierSpell")
function vizierSpell.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
	if attacker and attacker:isPlayer() then
		local chance = math.random(2)
		if chance == 1 then
			local creaturePos = creature:getPosition()
			local path = creaturePos:getPathTo(attacker:getPosition(), 0, 0, true, true, 3)
			if not path or #path == 0 then
				return false
			end
			for i = 1, #path do
				creaturePos:getNextPosition(path[i], 1)
				doAreaCombatHealth(creature, COMBAT_DEATHDAMAGE, creaturePos, 0, -400, -600, CONST_ME_WHITE_ENERGY_SPARK)
			end
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

vizierSpell:register()
