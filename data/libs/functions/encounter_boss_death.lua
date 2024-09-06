local onBossDeath = CreatureEvent("EncounterOnSuccessfulCompletion")

function onBossDeath.onDeath(creature)
	if not creature then
		return true
	end

	local encounterData = EncounterDataRegistry():getStateByCreature(creature)
	if not encounterData then
		return true
	end

	encounterData:onSuccessfulCompletion()

	return true
end

onBossDeath:register()
