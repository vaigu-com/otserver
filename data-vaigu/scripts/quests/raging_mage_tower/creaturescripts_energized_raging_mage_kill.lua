local deathEvent = CreatureEvent("EnergizedRagingMageDeath")
function deathEvent.onDeath(creature)
	if getStorageValueByKey(673003) < 2000 then
		return true
	end

	local monster = Game.createMonster("Raging Mage", creature:getPosition())
	monster:setReward(true)

	doCreatureSayWithRadius(creature, "GNAAAAAHRRRG!! WHAT? WHAT DID YOU DO TO ME!! I... I feel the energies crawling away... from me... DIE!!!", TALKTYPE_MONSTER_SAY, 35, 71)
	setStorageValueByKey(673003, 0)

	return true
end

deathEvent:register()
