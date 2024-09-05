local lever = Action()
function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	local sawPos = JANUSZEX_ANCHOR:Moved(-90, -69, 2)
	if Tile(sawPos):getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.rawHammer) or Tile(sawPos):getItemById(SYN_MARNOTRAWNY_NORMAL_ITEMS.doneHammer) then
		return
	end
	local saw = Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.rawHammer, 1, sawPos)
	saw:setActionId(Storage.SynMarnotrawny.HammerMaking.Lever)
	saw:setUniqueId(1000)

	return true
end
lever:aid(Storage.SynMarnotrawny.HammerMaking.Lever)
lever:register()

local paint = Action()
function paint.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if target:getId() == SYN_MARNOTRAWNY_NORMAL_ITEMS.rawHammer then
		target:remove()
		Game.createItem(SYN_MARNOTRAWNY_NORMAL_ITEMS.doneHammer, 1, toPosition)
		toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
	end
	return true
end
paint:aid(Storage.SynMarnotrawny.HammerMaking.Paint)
paint:register()
