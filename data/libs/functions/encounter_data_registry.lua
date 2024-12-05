EncounterDataRegistry = {}
EncounterDataRegistry.__index = EncounterDataRegistry
EncounterDataRegistry.registry = {}

EncounterDataRegistry.states = {}
---@param encounter EncounterData
function EncounterDataRegistry:Register(encounter)
	self.states[encounter.encounterName] = encounter
	return self
end

function EncounterDataRegistry:GetByEncounterName(encounterName)
	return self.registry[encounterName]
end
