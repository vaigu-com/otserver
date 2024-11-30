local singleton
EncounterDefinitionRegistry = {}
function EncounterDefinitionRegistry:New()
	if singleton then
		return singleton
	end
	singleton = {}
	singleton.__index = self
	self.states = {}
	setmetatable(singleton, self)
	return singleton
end
setmetatable(EncounterDefinitionRegistry, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
EncounterDefinitionRegistry()

function EncounterDefinitionRegistry:Register(encounter)
	self.states[encounter.name] = encounter
    return self
end

function EncounterDefinitionRegistry:GetStateByCreature(creature)
	local name = creature:getName()
	return self.states[name]
end

function EncounterDefinitionRegistry:Unregister(creature)
	local id = creature:getId()
	self.states[id] = nil
    return self
end
