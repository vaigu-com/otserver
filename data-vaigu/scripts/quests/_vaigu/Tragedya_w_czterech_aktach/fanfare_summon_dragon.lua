local beastId = nil

local spawnPos = RETRO_KNUROWO_ANCHOR:Moved(-26, -28, 6) -- 38f85df67705e9e59ab4b44bc8590644
local fanfareSacrificePos = RETRO_KNUROWO_ANCHOR:Moved(-29, -34, 6):Moved(-2, 0, 0)

local panpipeLever = Action()
function panpipeLever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end
	if Creature(beastId) then
		return
	end

	local fanfare = Tile(fanfareSacrificePos):getItemById(TRAGEDYA_W_CZTERECH_AKTACH_KEY_ITEMS.fanfare.id)

	if not fanfare then
		return false
	end
	if player:getStorageValue(Storage.TragedyaWCzterechAktach.Questline) ~= 5 then
		return false
	end

	beastId = Game.createMonster("Wawel Dragon", spawnPos):getId()
	player:getPosition():sendMagicEffect(CONST_ME_SOUND_GREEN)
	return true
end

panpipeLever:aid(Storage.TragedyaWCzterechAktach.FanfareLever)
panpipeLever:register()
