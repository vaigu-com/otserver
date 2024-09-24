	:Script(function(storageToRequiredState)
local bossRoomPos = SCIEZKA_NIEUMARLYCH_ANCHOR:Moved({ x = -60, y = -14, z = 0 })

local workingTeleportId = 23483

local nextRequiredThrowId = { 5901, 3465, 5467, 10316, 18935, 7993 }

local ritualStateToNextPotId = { [2] = 1997, [3] = 2002, [4] = 2003 }

local ritualState = 1

local ritualPot = nil

local function openPortal(pos)
	local portal = Game.createItem(workingTeleportId, 1, pos)
	portal:setActionId(Storage.PathOfTheUndead.RitualLocus)
	ritualPot:remove()
end

local function tryProgressRitualPot(pos)
	local nextRitualPotId = ritualStateToNextPotId[ritualState]
	if nextRitualPotId then
		ritualPot:transform(nextRitualPotId)
	else
		pos:sendMagicEffect(CONST_ME_WATERSPLASH)
	end
end

local ritualLocus = MoveEvent()
function ritualLocus.onAddItem(moveitem, tileitem, position)
	if not moveitem then
		return false
	end

	if ritualPot == nil then
		ritualPot = Tile(SCIEZKA_NIEUMARLYCH_ANCHOR:Moved(1, -35, -1)):getItemById(1996)
	end

	local nextThrowId = nextRequiredThrowId[ritualState]
	local moveitemId = moveitem:getId()

	if moveitemId ~= nextThrowId then
		return false
	end

	ritualState = ritualState + 1
	moveitem:remove()
	tryProgressRitualPot(tileitem:getPosition())
	if ritualState > #nextRequiredThrowId then
		openPortal(tileitem:getPosition())
	end
	return true
end

ritualLocus:type("additem")
ritualLocus:aid(Storage.PathOfTheUndead.RitualLocus)
ritualLocus:register()

local step_tile = MoveEvent()

function step_tile.onStepIn(player, stepInItem, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end
	local portal = Tile(toPosition):getItemById(workingTeleportId)
	if not portal then
		return
	end
	player:teleportTo(bossRoomPos)
	player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

step_tile:aid(Storage.PathOfTheUndead.RitualLocus)
step_tile:type("stepin")
step_tile:register()
end)
