local function revert(position)
	local caskItem = Tile(position):getItemById(29306)
	if caskItem then
		caskItem:transform(29305)
		position:sendMagicEffect(CONST_ME_POISONAREA)
	end
end
local ectoplasmBucket = Action()

function ectoplasmBucket.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid == 29305 then
		local chance = math.random(1, 2)
		if chance == 1 then
			if item.itemid == 29310 then
				local it = player:addItem(29307, 1)
				if it then
					it:decay()
				end
			elseif item.itemid == 29307 then
				local it = player:addItem(29308, 1)
				if it then
					it:decay()
				end
			elseif item.itemid == 29308 then
				local it = player:addItem(29309, 1)
				if it then
					it:decay()
				end
			end
			target:transform(29306)
			item:remove(1)
			toPosition:sendMagicEffect(CONST_ME_POISONAREA)
			addEvent(revert, 2 * 60 * 1000, toPosition) --5min
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The ectoplasm all over this egg was already seeping inside the cocoon itself. You manage to fill some of it into the bucket.")
		elseif chance == 2 then
			target:transform(29306)
			toPosition:sendMagicEffect(CONST_ME_POISONAREA)
			addEvent(revert, 2 * 60 * 1000, toPosition) --5min
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There is not enough ectoplasm left to fill it in the bucket.")
		end
		return true
	end
end

ectoplasmBucket:id(29310, 29307, 29308)
ectoplasmBucket:register()

local ectoplasmEntrance = Action()
function ectoplasmEntrance.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.uid == 7932 then
		if player:getStorageValue(Storage.TheDreamCourts.StrickenMission) >= 1 then
			player:teleportTo(Position(5847, 873, 11))
			item:transform(29310)
			player:setStorageValue(Storage.TheDreamCourts.StrickenMission, 2)
			player:setStorageValue(Storage.TheDreamCourts.StrickenDoor, 1)
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have no business here..")
		end
		return true
	end
end

ectoplasmEntrance:id(29309)
ectoplasmEntrance:register()

local ectoplasmEntranceBack = Action()
function ectoplasmEntranceBack.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getPosition() == Position(5847, 873, 11) then
		player:teleportTo(Position(5847, 875, 11))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

ectoplasmEntranceBack:uid(9001)
ectoplasmEntranceBack:register()
