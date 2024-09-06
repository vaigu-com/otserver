local singleton = nil
EncounterDefinitionRegistry = {}
function EncounterDefinitionRegistry:new()
	if singleton then
		return singleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(EncounterDefinitionRegistry, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
singleton = EncounterDefinitionRegistry()
EncounterDefinitionRegistry.states = {}
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
