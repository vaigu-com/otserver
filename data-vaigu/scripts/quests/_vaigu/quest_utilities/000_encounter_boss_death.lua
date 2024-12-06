print("000_encounter_boss_death.lua")
local bossDeath = CreatureEvent("EncounterOnSuccessfulCompletion")

function bossDeath.onDeath(creature)
	if not creature then
		return true
	end

	local activeEncounter = ActiveEncounterRegistry:GetByCreature(creature)
	if not activeEncounter then
		return true
	end

	local encounterData = EncounterDataRegistry:GetByEncounterName(activeEncounter.encounterName)

	encounterData:onSuccessfulCompletion()

	return true
end

bossDeath:register()
