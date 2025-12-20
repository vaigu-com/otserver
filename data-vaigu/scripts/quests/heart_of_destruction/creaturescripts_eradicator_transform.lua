local eradicatorTransform = CreatureEvent("EradicatorTransform")

function eradicatorTransform.onThink(creature)
	if not creature or not creature:isMonster() then
		return false
	end

	local eradicatorReleaseT = Game.getStorageValueByKey(GlobalStorage.HeartOfDestruction.EradicatorReleaseT)
	if eradicatorReleaseT > 0 then
		local bossPosition = creature:getPosition()
		local bossHealth = creature:getHealth()
		creature:remove()

		local eradicatorWeak = Game.getStorageValueByKey(GlobalStorage.HeartOfDestruction.EradicatorWeak) > 0 and 1 or 0
		local monsterName = eradicatorWeak == 1 and "Eradicator" or "Eradicator2"
		local monster = Game.createMonster(monsterName, bossPosition, false, true)
		if not monster then
			logger.error("Cannot create " .. monsterName)
			return false
		end
		monster:addHealth(-monster:getHealth() + bossHealth, COMBAT_PHYSICALDAMAGE)

		if eradicatorWeak == 0 then
			Game.createMonster("Spark of Destruction", Position(32304, 31282, 14), false, true)
			Game.createMonster("Spark of Destruction", Position(32305, 31287, 14), false, true)
			Game.createMonster("Spark of Destruction", Position(32312, 31287, 14), false, true)
			Game.createMonster("Spark of Destruction", Position(32314, 31282, 14), false, true)
		end

		eradicatorEvent = addEvent(function()
			Game.setStorageValueByKey(GlobalStorage.HeartOfDestruction.EradicatorReleaseT, 1)
		end, eradicatorWeak == 1 and 74000 or 9000)

		Game.setStorageValueByKey(GlobalStorage.HeartOfDestruction.EradicatorWeak, eradicatorWeak == 1 and -1 or 1)
		Game.setStorageValueByKey(GlobalStorage.HeartOfDestruction.EradicatorReleaseT, -1)
	end
	return true
end

eradicatorTransform:register()
