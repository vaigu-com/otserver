local pitsOfInfernoMazeLever = Action()
function pitsOfInfernoMazeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local portal = Tile(Position(6118, 1910, 13)):getItemById(1949)
	if not portal then
		local item = Game.createItem(1949, 1, Position(6118, 1910, 13))
		if item:isTeleport() then
			item:setDestination(Position(6069, 1930, 15))
		end
	else
		portal:remove()
	end
	item:transform(item.itemid == 2772 and 2773 or 2772)
	return true
end

pitsOfInfernoMazeLever:uid(50105)
pitsOfInfernoMazeLever:register()
