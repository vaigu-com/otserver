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
	self.states[encounter.encounterName] = encounter
	return self
end

function EncounterInstanceRegistry:MapBossToEncounter(encounterName, bossName)
	self.states[bossName] = self:GetStateByEncounterName(encounterName)
end

function EncounterInstanceRegistry:GetStateByCreature(creature)
	local creatureName = creature:getName()
	return self.states[creatureName]
end

function EncounterInstanceRegistry:GetStateByCreatureName(creatureName)
	return self.states[creatureName]
end

function EncounterInstanceRegistry:GetStateByEncounterName(encounterName)
	return self.states[encounterName]
end

--[[
function EncounterInstanceRegistry:unregister(name)
	local encounterName = self.states[name].encounterName
	for key, encounter in pairs(self.states) do
		if encounter.encounterName == encounterName then
			self.states[key] = nil
		end
	end
	return self
end
]]
