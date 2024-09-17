local singleton = nil
EncounterDataRegistry = {}
function EncounterDataRegistry:New()
	if singleton then
		return singleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(EncounterDataRegistry, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
singleton = EncounterDataRegistry()
EncounterDataRegistry.states = {}
---@param encounterData EncounterLever
function EncounterDataRegistry:register(encounterData)
	self.states[encounterData.encounterName] = encounterData
	return self
end

function EncounterDataRegistry:mapBossToEncounter(encounterName, bossName)
	self.states[bossName] = self:getStateByEncounterName(encounterName)
end

function EncounterDataRegistry:getStateByCreature(creature)
	local creatureName = creature:getName()
	return self.states[creatureName]
end

function EncounterDataRegistry:getStateByCreatureName(creatureName)
	return self.states[creatureName]
end

function EncounterDataRegistry:getStateByEncounterName(encounterName)
	return self.states[encounterName]
end

function EncounterDataRegistry:unregister(name)
	local encounterName = self.states[name].encounterName
	for key, encounterLever in pairs(self.states) do
		if encounterLever.encounterName == encounterName then
			self.states[key] = nil
		end
	end
	return self
end
