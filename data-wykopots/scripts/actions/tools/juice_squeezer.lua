local fruits = { 3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3595, 3596, 5096, 8011, 8012, 8013, 29995 }
local fruitToFluid = {
	[3589] = 15,
}
local fruitToSpecialItem = {
	[29995] = 30003,
}
local defaultFluid = 14

local juiceSqueezer = Action()
function juiceSqueezer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local targetId = target:getId()
	if not table.contains(fruits, targetId) then
		return
	end

	local fluid = fruitToFluid[targetId] or defaultFluid
	local specialItem = fruitToSpecialItem[targetId]

	if specialItem then
		target:remove(1)
		player:addItem(specialItem)
	elseif player:TryRemoveItems({ { id = 2874 } }) then
		target:remove(1)
		player:addItem(2874, fluid)
		return true
	end
end

juiceSqueezer:id(5865)
juiceSqueezer:register()
