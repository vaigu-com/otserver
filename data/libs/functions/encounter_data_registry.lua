EncounterDataRegistry = {}
EncounterDataRegistry.__index = EncounterDataRegistry
EncounterDataRegistry.registry = {}

---@param encounter EncounterData
function EncounterDataRegistry:Register(encounter)
	encounter:FixEnounterStages()
	self.registry[encounter.displayName] = encounter
	self.registry[encounter.encounterId] = encounter
	return self
end

function EncounterDataRegistry:GetByDisplayName(displayName)
	return self.registry[displayName]
end
function EncounterDataRegistry:GetByEncounterId(id)
	return self.registry[id]
end
