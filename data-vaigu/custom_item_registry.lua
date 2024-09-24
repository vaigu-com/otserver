local customItemRegistrySingleton = nil
---@class CustomItemRegistry
---@field player Player
---@field localizerName integer
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
		return class:New(...)
	end,
})
customItemRegistrySingleton = CustomItemRegistry()
CustomItemRegistry.states = {}

local function shouldRegisterRevscript(item)
	local context = ResolutionContext():FromCustomItemState(item)
	if #context.requirements > 0 then
		return true
	end
	if #context.actionsOnSuccess > 0 then
		return true
	end
	return false
end

function CustomItemRegistry:Register(item)
	self.states[item.aid] = {}

	for key, value in pairs(item) do
		self.states[item.aid][key] = value
	end

	if not shouldRegisterRevscript(item) then
		return self
	end

	local chestAction = Action()
	function chestAction.onUse(player, chest, fromPosition, target, toPosition, isHotkey)
		ChestQuestTryAddItems(player, chest)
		return true
	end
	if item.aid then
		chestAction:aid(item.aid)
	end
	if item.uid then
		chestAction:uid(item.aid)
	end

	if not (item.uid or item.aid) then
		logger.error("[CustomItemRegistry:Register] item has no aid/uid but has requirements of actions declared")
	end
	chestAction:register()

	return self
end

function CustomItemRegistry:GetState(aid)
	return self.states[aid]
end

function CustomItemRegistry:Unregister(aid)
	self.states[aid] = nil
	return self
end
