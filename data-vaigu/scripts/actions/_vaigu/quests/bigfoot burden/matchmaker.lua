local function revertCrystal(position, itemId, transformId)
	local item = Tile(position):getItemById(itemId)
	if item then
		item:transform(transformId)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 15810 then
		return false
	end

	if player:getStorageValue(Storage.BigfootBurden.MatchmakerStatus) == 1 or player:getStorageValue(Storage.BigfootBurden.MissionMatchmaker) ~= 1 then
		return false
	end

	target:transform(15809)
	addEvent(revertCrystal, 40000, toPosition, 15809, 15810)

	if math.random(3) ~= 3 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "To nie ten!")
		return true
	end

	player:setStorageValue(Storage.BigfootBurden.MatchmakerStatus, 1)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Gratulacje! Twoja misja wykonana!")
	return true
end

action:id(15801)
action:register()
