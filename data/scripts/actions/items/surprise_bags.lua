--[[
local bags = {
	[6570] = { { 3598, 10 }, 6393, 6279, 6574, 6578, 6575, 6577, 6569, 6576, 6572, 2995, 14027, 14681 }, -- blue surprise bag
	[6571] = { 6574, 3079, 6393, 6576, 6578, 2995, 14027, 3036, 5944, 3386, 3420, 3039, 5080, 2993, 3392, 3057, 5791 }, -- red surprise bag
	[8853] = { { 3031, 10 }, 123, 2995, 2397, 651, 3218, 6574, 6393, 7377, 3578, 8778 }, -- suspicious surprise bag
	[14751] = { { 9642, 15 }, { 3581, 15 }, 5917, 3273, 10302, 9019, 5928, 5926, 5927, 6095, 5918, 6097, 6098, 5461, 5090 }, -- pirate's surprise
	[14759] = { { 6569, 10 }, { 6541, 10 }, { 6542, 10 }, { 6543, 10 }, { 6544, 10 }, { 6545, 10 }, 6574, 4839, 6570, 6571, 3215 }, -- surprise nest
}

local surpriseBag = Action()
function surpriseBag.onUse(player, item, fromPosition)
	local present = bags[item.itemid]
	if not present then
		return true
	end

	local gift = present[math.random(#present)]
	local count = 1

	if type(gift) == "table" then
		count = math.random(gift[2])
		gift = gift[1]
	end

	player:addItem(gift, count)
	fromPosition:sendMagicEffect(CONST_ME_GIFT_WRAPS)
	item:remove(1)
	return true
end
for bagId in pairs(bags) do
	surpriseBag:id(bagId)
end
surpriseBag:register()
]]
