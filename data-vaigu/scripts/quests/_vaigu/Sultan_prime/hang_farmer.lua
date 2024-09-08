-- unused
local function wiggle(monster, pos)
	local base_timer = 500
	local timer = 1245
	local interval_count = 24
	local interval = math.pi / 2
	local dir_pool = { 0, 1, 2 }
	local dir
	local temp = 3
	local idx

	local _sin = math.sin
	for _ = 1, interval_count - 2 do
		interval = interval - math.pi / (interval_count * 2)
		timer = timer + base_timer * _sin(interval)

		idx = math.random(1, #dir_pool)
		dir = dir_pool[idx]
		dir_pool[idx] = temp
		temp = dir

		addEvent(function(dir)
			monster:setDirection(dir)
		end, timer, dir)
	end

	for i = 1, interval_count - 4 do
		interval = interval + math.pi / (interval_count * 2)
		timer = timer + base_timer * _sin(interval)

		idx = math.random(1, 3)
		dir = dir_pool[idx]
		dir_pool[idx] = temp
		temp = dir

		addEvent(function(dir)
			monster:setDirection(dir)
		end, timer, dir)
	end

	addEvent(function()
		monster:remove()
		Game.createItem(18114, 1, pos)
	end, timer + 2000)
end

local chair = MoveEvent()

function chair.onAddItem(moveitem, tileitem, position)
	if not moveitem then
		return false
	end
	local id = moveitem.itemid
	if id ~= 3003 then
		return true
	end

	local pos = moveitem:getPosition()
	moveitem:remove()

	local top_left = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.topLeft)
	local down_right = CAMEL_FARM_ANCHOR:Moved(SULTAN_PRIME_CAMEL_FARM.downRight)

	IterateBetweenPositions(top_left, down_right, function(context)
		local tile = Tile(context.pos)
		if not tile then
			return
		end
		local creature = tile:getTopCreature()
		if not creature then
			return
		end
		if creature:getPlayer() then
			if creature:getStorageValue(Storage.SultanPrime.Questline) == 7 then
				creature:setStorageValue(Storage.SultanPrime.Mission02, 6)
				creature:setStorageValue(Storage.SultanPrime.Questline, 8)
			end
		end
	end)

	Game.createItem(18114, 1, pos)
	return true
end

chair:type("additem")
chair:aid(Storage.SultanPrime.FarmerChair)
chair:register()
