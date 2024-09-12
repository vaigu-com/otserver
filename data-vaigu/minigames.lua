---@enum MINIGAME_STATE
MINIGAME_STATE = {
	not_running = "not_running",
	is_running = "is_running",
	maintenance_mode = "maintenance_mode",
}

---@class Minigame
---@field minigameState MINIGAME_STATE
---@field waitingRoom Position[]
---@field minPlayersToStart integer
---@field zone Zone
Minigame = {}
Minigame.__index = Minigame
function Minigame:New(minigameState, context)
	local newObj = {}
	newObj.minigameState = minigameState
	newObj.minigameState = MINIGAME_STATE.not_running
	newObj.waitingRoom = context.waitingRoom
	newObj.minPlayersToStart = context.minPlayersToStart or 3
	newObj.zone = context.zone
	for key, value in pairs(context) do
		newObj[key] = value
	end
	self.__index = self
	setmetatable(newObj, self)
	return newObj
end
setmetatable(Minigame, {
	__call = function(class, ...)
		return class:New(...)
	end,
})

function Minigame:IsRunning()
	return self.minigameState == MINIGAME_STATE.is_running
end

function Minigame:CanStart()
	local playersCount =
		CreatureList():Area(self.waitingRoom.corner1, self.waitingRoom.corner2):FilterByPlayer():Count()
	return playersCount >= self.minPlayersToStart
end

function Minigame:Start()
	self.minigameState = MINIGAME_STATE.is_running
	self.participants = CreatureList():Area(self.waitingRoom.corner1, self.waitingRoom.corner2):FilterByPlayer()
	for _, player in pairs(self.participants) do
		player:teleportTo(self.zone:randomPosition())
		
	end
end
