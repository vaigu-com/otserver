local stoneId = 15824
local corner1 = Position(6298, 2594, 13)
local corner2 = Position(6217, 2493, 13)

local function forceStonesDecay()
	IterateBetweenPositions(corner1, corner2, function(context)
		local pos = context.pos
		local stone = pos:GetItemById(stoneId)
		if stone then
			stone:remove()
			addEvent(function()
				Game.createItem(stoneId, 1, pos):decay()
			end, math.random(1, 20) * 1000)
		end
	end)
end

local grindStones = GlobalEvent("WarzoneDailyForceGrindstoneDecay")
function grindStones.onStartup()
	forceStonesDecay()
end

grindStones:register()
