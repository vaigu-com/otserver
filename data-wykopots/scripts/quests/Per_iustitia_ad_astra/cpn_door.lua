local leftDoorPos = FUEL_SHOP_ANCHOR:Moved(-1, -19, 0)

local closedDoor = { [14159] = { 0, 0, 0 }, [20435] = { 0, 0, 0 }, [1612] = { 0, 0, 0 }, [20429] = { 0, 1, 0 } }

local noDoors = 2

local function openCloseDoor(close, door)
	local show = close and -1 or 0
	local hide = close and 0 or -1
	for i = 0, noDoors - 1 do
		for id, offset in pairs(door) do
			local origin = leftDoorPos:Moved(offset):Moved(i, 0, show)
			local destination = leftDoorPos:Moved(offset):Moved(i, 0, hide)
			local item = Tile(origin):getItemById(id)
			if not item then
				return
			end
			item:moveTo(destination)
		end
	end
end

local doorCurentlyOpening = false

local openingTime

local function tryCloseDoor()
	if os.clock() > openingTime then
		doorCurentlyOpening = false
		openCloseDoor(true, closedDoor)
	else
		addEvent(function()
			tryCloseDoor()
		end, 1000)
	end
end

local beforeCpnDoor = MoveEvent()
function beforeCpnDoor.onStepIn(player, _, _, _)
	openingTime = os.clock() + 4
	if doorCurentlyOpening then
		return
	end
	doorCurentlyOpening = true

	openCloseDoor(false, closedDoor)
	tryCloseDoor()
end

beforeCpnDoor:aid(Storage.PerIustitiaAdAstra.CpnDoor)
beforeCpnDoor:register()
