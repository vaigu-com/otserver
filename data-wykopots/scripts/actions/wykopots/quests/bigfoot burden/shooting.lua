local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local playerPos = player:getPosition()
	if player:getStorageValue(Storage.BigfootBurden.Shooting) < 6 then
		local pos = Position(playerPos.x, playerPos.y - 5, 9)
		local tile = Tile(pos)
		if tile:getItemById(15710) then
			player:setStorageValue(Storage.BigfootBurden.Shooting, player:getStorageValue(Storage.BigfootBurden.Shooting) + 1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Hit!")
			tile:getItemById(15710):remove()
			pos:sendMagicEffect(CONST_ME_FIREATTACK)
			for i = 2, 4 do
				Position(playerPos.x, playerPos.y - i, 9):sendMagicEffect(CONST_ME_TELEPORT)
			end
		elseif tile:getItemById(15711) then
			player:setStorageValue(Storage.BigfootBurden.Shooting, player:getStorageValue(Storage.BigfootBurden.Shooting) < 1 and 0 or player:getStorageValue(Storage.BigfootBurden.Shooting) - 1)
			tile:getItemById(15711):remove()
			pos:sendMagicEffect(CONST_ME_FIREATTACK)
			for i = 2, 4 do
				Position(playerPos.x, playerPos.y - i, 9):sendMagicEffect(CONST_ME_TELEPORT)
			end
		end
	end
	return true
end

action:id(15709)
action:register()
