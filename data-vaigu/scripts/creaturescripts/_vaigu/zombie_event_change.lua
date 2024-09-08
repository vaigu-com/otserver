local zombiehealthChange = CreatureEvent("ZombieLifeSteal")

function zombiehealthChange.onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType)
	if creature:getStorageValue(ze_joinStorage) == 1 then
		if attacker and attacker:getName() == "Zombie" then
			if creature and creature:isPlayer() then
				local dmgPercent = 40
				local maxHealth = creature:getMaxHealth()
				local zombieDamage = (maxHealth / 100) * dmgPercent -- - damage percent
				creature:addHealth(-zombieDamage, COMBAT_UNDEFINEDDAMAGE)

				primaryDamage = 0
				primaryType = COMBAT_UNDEFINEDDAMAGE

				local pos = creature:getPosition()
				pos:sendMagicEffect(CONST_ME_DRAWBLOOD)
			end
		end
	end
	return primaryDamage, primaryType, secondaryDamage, secondaryType
end

zombiehealthChange:register()
