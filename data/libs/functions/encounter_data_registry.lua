EncounterDataRegistry = {}
EncounterDataRegistry.__index = EncounterDataRegistry
EncounterDataRegistry.registry = {}

---@param encounter EncounterData
function EncounterDataRegistry:Register(encounter)
	self.registry[encounter.encounterName] = encounter
	return self
end

function EncounterDataRegistry:GetByEncounterName(encounterName)
	return self.registry[encounterName]
end
