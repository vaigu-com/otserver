local altars = {
	Position(6056, 1786, 12),
	Position(6054, 1791, 12),
	Position(6058, 1791, 12),
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.TheInquisition.Questline) == 8 then
		player:setStorageValue(Storage.TheInquisition.Questline, 9)
		player:setStorageValue(Storage.TheInquisition.Mission03, 4) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
		local k = {}
		for i = 1, #altars do
			local tmp = Tile(altars[i]):getItemById(3083)
			if not tmp then
				Game.createMonster("The Count", toPosition)
				return true
			else
				k[#k + 1] = tmp
			end
		end
		for i = 1, #k do
			k[i]:remove()
		end
		Game.createMonster("The Weakened Count", toPosition)
		return true
	end
end
action:aid(2002)
action:register()
