local t = {
	Position(5670, 1379, 15), -- stone position
	Position(5671, 1377, 15), -- teleport creation position
	Position(5684, 1396, 14), -- where the teleport takes you
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == 2772 then
		local tile = t[1]:getTile()
		if tile then
			local stone = tile:getItemById(1842)
			if stone then
				stone:remove()
			end
		end

		local teleport = Game.createItem(1949, 1, t[2])
		if teleport then
			teleport:setDestination(t[3])
			t[2]:sendMagicEffect(CONST_ME_TELEPORT)
		end
	elseif item.itemid == 2773 then
		local tile = t[2]:getTile()
		if tile then
			local teleport = tile:getItemById(1949)
			if teleport and teleport:isTeleport() then
				teleport:remove()
			end
		end
		t[2]:sendMagicEffect(CONST_ME_POFF)
		Game.createItem(1842, 1, t[1])
	end
	return item:transform(item.itemid == 2772 and 2773 or 2772)
end

action:uid(2005)
action:register()
