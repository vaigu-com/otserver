---@class CustomItemRegistry
---@field player Player
---@field localizerName integer
---@field requirements table
CustomItemRegistry = {}
CustomItemRegistry.__index = CustomItemRegistry
CustomItemRegistry.states = {}

local function shouldRegisterRevscript(item)
	local context = ResolutionContext.FromCustomItemState(item)

	if TableSize(context.requirements) > 0 then
		return true
	end
	if TableSize(context.actionsOnSuccess) > 0 then
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
	chestAction:aid(item.aid)
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
