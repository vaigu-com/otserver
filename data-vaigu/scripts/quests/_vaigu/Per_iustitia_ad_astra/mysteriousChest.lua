	:Script(function(storageToRequiredState)
local runeId = 3164
local failDmg = 500

local function canOpenChest(player, toPosition)
	if player:getStorageValue(Storage.PerIustitiaAdAstra.Questline) ~= 22 then
		return false
	end

	local runePos = toPosition:Moved(2, 0, 0)
	local rune = Tile(runePos):getItemById(runeId)
	if not rune then
		return false
	end

	runePos:sendMagicEffect(CONST_ME_POFF)
	rune:remove()
	return true
end

local updateStorages = {
	[Storage.PerIustitiaAdAstra.Questline] = 23,
	[Storage.PerIustitiaAdAstra.Mission05] = 8,
}

local mysteriousChest = Action()
function mysteriousChest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	if not canOpenChest(player, toPosition) then
		doTargetCombatHealth(0, player, COMBAT_ENERGYDAMAGE, -failDmg, -failDmg, CONST_ME_LOSEENERGY)
		Game.createMonster("Old Giant Spider", fromPosition)
		return false
	end

	player:UpdateStorages(updateStorages)
	player:addExperience(250 * 1000, true)
	player:getPosition():sendMagicEffect(CONST_ME_BLUE_ENERGY_SPARK)
	return true
end

mysteriousChest:aid(Storage.PerIustitiaAdAstra.MysteriousChest)
mysteriousChest:register()
end)
