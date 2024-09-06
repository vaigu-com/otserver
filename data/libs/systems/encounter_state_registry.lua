local singleton = nil
EncounterStateRegistry = {}
function EncounterStateRegistry:new()
	if singleton then
		return singleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(EncounterStateRegistry, {
	__call = function(class, ...)
		return class:new(...)
	end,
})
singleton = EncounterStateRegistry()
EncounterStateRegistry.states = {}
function EncounterStateRegistry:Register(encounter)
	self.states[encounter.name] = encounter
	return self
end

function EncounterStateRegistry:GetStateByCreature(creature)
	local name = creature:getName()
	return self.states[name]
end

function EncounterStateRegistry:Unregister(creature)
	local id = creature:getId()
	self.states[id] = nil
	return self
end
