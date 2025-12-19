local vialId = 2874
local fluidJuice = 14
local fluidCononut = 15
local coconut = 3589

local fruits = { 3584, 3585, 3586, 3587, 3588, 3589, 3590, 3591, 3592, 3593, 3595, 3596, 5096, 8011, 8012, 8013 }

local juiceSqueezer = Action()
function juiceSqueezer.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	-- The Dream Courts Quest
	if target.itemid == 29995 then
		target:transform(30003)
		return ONUSE_OK
	end

	if not table.contains(fruits, target.itemid) then
		return YOU_CANNOT_USE_THIS_OBJECT
	end

	local fluidType = fluidJuice
	if target:getId() == coconut then
		fluidType = fluidCononut
	end
	if player:HasItems({ { id = vialId, fluidType = 0 } }) then
		player:TryTradeInItems({ { id = vialId, fluidType = 0 }, { id = target:getId(), count = 1 } }, { { id = vialId, fluidType = fluidType } })
		return ONUSE_OK
	else
		player:sendTextMessage(MESSAGE_STATUS_DEFAULT, "You need an empty vial in order to squeeze the juices.")
		return YOU_CANNOT_USE_THIS_OBJECT
	end
end
juiceSqueezer:id(5865)
juiceSqueezer:register()
