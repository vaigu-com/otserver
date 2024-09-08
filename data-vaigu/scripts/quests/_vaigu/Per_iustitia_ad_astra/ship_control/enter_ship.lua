local shipPos = STARSHIP_ANCHOR:Moved(15, 6, -1)

local blockage = {}

local function removeBlockage(position)
	for _, item in pairs(blockage[position:ToString()]) do
		item:remove()
	end
	blockage = {}
end

local function spawnBlockage(centerPos)
	local posString = centerPos:ToString()
	blockage[posString] = {}
	for i = -1, 1 do
		for j = -1, 1 do
			local item = Game.createItem(2187, 1, centerPos:Moved(i, j, 0))
			table.insert(blockage[posString], item)
		end
	end
end

local function sendShipEnterCountdown(player)
	for i = 1, 3 do
		addEvent(function()
			if player then
				player:say(4 - i, TALKTYPE_MONSTER_SAY)
			end
		end, i * 1000)
	end
end

local enterShipTile = MoveEvent()
function enterShipTile.onStepIn(player, item, toPosition, fromPosition)
	if not player:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) < 7 then
		return false
	end

	sendShipEnterCountdown(player)

	spawnBlockage(toPosition)
	addEvent(function()
		if player then
			player:teleportTo(shipPos)
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			toPosition:sendMagicEffect(CONST_ME_POFF)
		end
		removeBlockage(toPosition)
	end, 4000)
end

enterShipTile:aid(Storage.PerIustitiaAdAstra.ShipControl.Enter)
enterShipTile:register()
