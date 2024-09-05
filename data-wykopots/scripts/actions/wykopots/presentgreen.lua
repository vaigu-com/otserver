local items = {
	{ 6569, 15 }, -- 15 candies
	{ 3598, 20 }, -- 20 cookies
	{ 3599, 10 }, -- 10 candy canes
	{ 3586, 10 }, -- 10 oranges
	{ 3585, 5 }, -- 5 apples
	{ 6500, 1 }, -- gingerbreadman
	{ 6501, 1 }, -- wreath
	{ 6502, 1 }, -- garland
	{ 6387, 1 }, -- christmas card
	{ 6488, 1 }, -- christmas branch
	{ 6509, 1 }, -- green present
}

local function tableContains(table, value)
	for i = 1, #table do
		if table[i] == value then
			return true
		end
	end

	return false
end

local function getItemsReward()
	local tmpTable = { count = 0 }
	local newTable = {}
	while tmpTable.count < 7 do
		local itemId = items[math.random(#items)][1]
		if not tableContains(tmpTable, itemId) then
			tmpTable[#tmpTable + 1] = itemId
			tmpTable.count = tmpTable.count + 1
		end
	end

	for i = 1, #items do
		for j = 1, #tmpTable do
			if tmpTable[j] == items[i][1] then
				newTable[#newTable + 1] = items[i]
			end
		end
	end

	return newTable
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local rand = math.random(1, 100)
	local itemsSort = getItemsReward()

	for i = 1, #itemsSort do
		player:addItem(itemsSort[i][1], itemsSort[i][2])
	end

	item:remove(1)

	return true
end
action:id(6508)
action:register()
