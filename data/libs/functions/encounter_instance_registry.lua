local singleton
EncounterInstanceRegistry = {}
function EncounterInstanceRegistry:New()
	if singleton then
		return singleton
	end
	singleton = {}
	singleton.__index = self
	setmetatable(singleton, self)
	return singleton
end
setmetatable(EncounterInstanceRegistry, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
EncounterInstanceRegistry()

EncounterInstanceRegistry.states = {}
---@param encounter EncounterData
function EncounterInstanceRegistry:Register(encounter)
	self.states[encounter.displayName] = encounter
	return self
end

function EncounterInstanceRegistry:MapBossToEncounter(displayName, bossName)
	self.states[bossName] = self:GetStateByEncounterName(displayName)
end

function EncounterInstanceRegistry:GetStateByCreature(creature)
	local creatureName = creature:getName()
	return self.states[creatureName]
end

function EncounterInstanceRegistry:GetStateByCreatureName(creatureName)
	return self.states[creatureName]
end

function EncounterInstanceRegistry:GetStateByEncounterName(displayName)
	return self.states[displayName]
end
