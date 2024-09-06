local customItemRegistrySingleton = nil
---@class CustomItemRegistry
---@field player Player
---@field questlineAid integer
---@field requirements table
CustomItemRegistry = {}
function CustomItemRegistry:New()
	if customItemRegistrySingleton then
		return customItemRegistrySingleton
	end
	local newObj = {}
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(CustomItemRegistry, {
	__call = function(class, ...)
		return class:Newew(...)
	end,
})
customItemRegistrySingleton = CustomItemRegistry()
CustomItemRegistry.states = {}

local registerIfNil = {
	["pos"] = true,
}

local ignoredFields = {
	["id"] = true,
	["aid"] = true,
	["uid"] = true,
}

local function shouldRegisterRevscriptAid(item)
	for key in pairs(registerIfNil) do
		if not item[key] then
			return true
		end
	end

	for key in pairs(item) do
		if not ignoredFields[key] then
			return true
		end
	end

	return false
end

function CustomItemRegistry:Register(item)
	self.states[item.aid] = {}

	for key, value in pairs(item) do
		self.states[item.aid][key] = value
	end

	if shouldRegisterRevscriptAid(item) then
		local chestAction = Action()
		function chestAction.onUse(player, chest, fromPosition, target, toPosition, isHotkey)
			ChestQuestTryAddItems(player, chest)
			return true
		end
		chestAction:aid(item.aid)
		chestAction:register()
	end

	return self
end

function CustomItemRegistry:GetState(aid)
	return self.states[aid]
end

function CustomItemRegistry:Unregister(aid)
	self.states[aid] = nil
	return self
end
