local function checkFlowers(player)
	local heaven_blossoms = { 11012, 11013, 11014, 11015, 11016 }
	for key, value in pairs(heaven_blossoms) do -- sprawdznie czy alles wziete
		if player:getStorageValue(value) < 1 then
			return false
		end
	end
	player:setStorageValue(Storage.Firestarter.Mission3, 2)
	return true
end

-- The Ape City Quest --
local campfirePosition = Position(6501, 592, 7)
local function revertCampfire(position)
	local tile = Tile(position)
	if tile then
		local campfire = tile:getItemById(1998)
		if campfire then
			campfire:transform(1997)
		end
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local removeItem = true
	-- The Ape City
	if (toPosition == campfirePosition) and (target.itemid == 1997) and (player:getStorageValue(Storage.TheApeCity.CampfireMission) == 1) then
		target:transform(1998)
		Game.createMonster("Draken Spellweaver", Position(6499, 589, 7))
		Game.createMonster("Draken Spellweaver", Position(6497, 593, 7))
		player:setStorageValue(Storage.TheApeCity.CampfireMission, 2)
		player:say("Kto?! Kto osmielil sie rozpalic przedwczesnie ogien?", TALKTYPE_MONSTER_SAY, false, player, toPosition)
		addEvent(revertCampfire, 1000 * 60, campfirePosition)
	end
	-- Sezon na Jelenie
	if target.itemid == 2742 and player:getStorageValue(Storage.SciezkaDruida.SezonNaJelenie) == 1 then
		if target.uid == 11008 or target.uid == 11009 then
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			player:setStorageValue(Storage.SciezkaDruida.SezonNaJelenie, 2)
		else
			removeItem = false
			player:say("To nie te.", TALKTYPE_MONSTER_SAY)
		end
	end
	-- Firestarter
	if target.itemid == 5546 and player:getStorageValue(Storage.Firestarter.Mission1) == 1 and target.uid == 11010 then
		removeItem = false
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		player:setStorageValue(Storage.Firestarter.Mission1, 2)
	end
	if target.itemid == 3954 and player:getStorageValue(Storage.Firestarter.Mission2) == 1 and target.uid == 11011 then
		removeItem = false
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		player:setStorageValue(Storage.Firestarter.Mission2, 2)
	end
	if target.itemid == 3657 and player:getStorageValue(Storage.Firestarter.Mission3) == 1 then
		removeItem = false
		if target.uid >= 11012 and target.uid <= 11016 then
			if player:getStorageValue(target.uid) < 1 then
				local drunk = Condition(CONDITION_DRUNK)
				drunk:setParameter(CONDITION_PARAM_TICKS, 60 * 1000)
				player:addCondition(drunk)
				toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
				player:setStorageValue(target.uid, 1)
			else
				player:say("Ten juz sie wyraznie jara.", TALKTYPE_MONSTER_SAY)
			end
			if checkFlowers(player) then
				player:say("To chyba juz wszystkie.", TALKTYPE_MONSTER_SAY)
			end
		else
			player:say("To nie ten!", TALKTYPE_MONSTER_SAY)
		end
	end

	-- Regular usage and remove chance
	local random = math.random(10)
	if random >= 4 then --success 60% chance
		if target.itemid == 182 then --Destroy spider webs/North - South
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(188)
			target:decay()
		elseif target.itemid == 183 then --Destroy spider webs/EAST- West
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(189)
			target:decay()
		elseif target.itemid == 5465 then --Burn Sugar Cane
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			target:transform(5464)
			target:decay()
		elseif target.itemid == 2114 then --Light Up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(2113)
		end
	elseif random == 2 then --it remove the fire bug 20% chance
		if removeItem then
			item:remove(1)
		end
		toPosition:sendMagicEffect(CONST_ME_POFF)
	elseif random == 1 then --it explode on the user 10% chance
		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say("OUCH!", TALKTYPE_MONSTER_SAY)
		if removeItem then
			item:remove(1)
		end
	else
		toPosition:sendMagicEffect(CONST_ME_POFF) --it fails, but dont get removed 3% chance
	end
	return true
end

action:id(5467)
action:register()



--[[
local function revert(position, itemId, transformId)
	local item = Tile(position):getItemById(itemId)
	if item then
		item:transform(transformId)
	end
end

local function revertAshes()
	local tile = Tile(Position(32849, 32233, 9))
	local item = tile:getItemById(1949)
	if tile and item then
		item:remove()
		local ashes = Game.createItem(3134, 1, Position(32849, 32233, 9))
		ashes:setAttribute(ITEM_ATTRIBUTE_UNIQUEID, 2243)
	end
end

local positions = {
	Position(32848, 32230, 9),
	Position(32849, 32230, 9),
	Position(32847, 32231, 9),
	Position(32848, 32231, 9),
	Position(32849, 32231, 9),
	Position(32850, 32231, 9),
	Position(32848, 32232, 9),
	Position(32849, 32232, 9),
}

local othersFireBug = Action()
function othersFireBug.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.actionid == 54387 and target.itemid == 22875 then
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) >= 8 or player:getStorageValue(Storage.FerumbrasAscension.BoneFlute) < 1 then
			return false
		end
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) < 0 then
			player:setStorageValue(Storage.FerumbrasAscension.BasinCounter, 0)
		end
		if player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) == 7 then
			player:say("You ascended the last basin.", TALKTYPE_MONSTER_SAY)
			item:remove()
			player:setStorageValue(Storage.FerumbrasAscension.MonsterDoor, 1)
		end
		target:transform(22876)
		player:setStorageValue(Storage.FerumbrasAscension.BasinCounter, player:getStorageValue(Storage.FerumbrasAscension.BasinCounter) + 1)
		toPosition:sendMagicEffect(CONST_ME_FIREAREA)
		addEvent(revert, 2 * 60 * 1000, toPosition, 22876, 22875)
		return true
	elseif target.uid == 2243 then
		local tile = Tile(Position(32849, 32233, 9))
		local item = tile:getItemById(3134)
		local createTeleport = Game.createItem(1949, 1, Position(32849, 32233, 9))
		for k, v in pairs(positions) do
			v:sendMagicEffect(CONST_ME_YELLOW_RINGS)
		end
		item:remove()
		addEvent(revertAshes, 5 * 60 * 1000) -- 5 minutes
		createTeleport:setDestination(Position(32857, 32234, 11))
		return true
	elseif target.uid == 2273 then
		if player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.RaysMission2) == 1 and player:getStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven) == 15 then
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.RaysMission2, 2)
			player:setStorageValue(Storage.Quest.U7_8.TheShatteredIsles.ReputationInSabrehaven, 16)
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			return true
		else
			return false
		end
	elseif target.actionid == 50119 then
		target:transform(7813)
		return true
	end

	local random = math.random(10)
	if random >= 4 then --success 6% chance
		if target.itemid == 182 then --Destroy spider webs/North - South
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(188)
			target:decay()
			return true
		elseif target.itemid == 183 then --Destroy spider webs/EAST- West
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(189)
			target:decay()
			return true
		elseif target.itemid == 5465 then --Burn Sugar Cane
			toPosition:sendMagicEffect(CONST_ME_FIREAREA)
			target:transform(5464)
			target:decay(5463)
			return true
		elseif target.itemid == 2114 then --Light Up empty coal basins
			toPosition:sendMagicEffect(CONST_ME_HITBYFIRE)
			target:transform(2113)
			return true
		elseif target.actionid == 12550 or target.actionid == 12551 then -- Secret Service Quest
			if player:getStorageValue(Storage.Quest.U8_1.SecretService.TBIMission01) == 1 then
				Game.createItem(2118, 1, Position(32893, 32012, 6))
				player:setStorageValue(Storage.Quest.U8_1.SecretService.TBIMission01, 2)
			end
		end
		return true
	elseif random == 2 then --it remove the fire bug 2% chance
		item:remove(1)
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	elseif random == 1 then --it explode on the user 1% chance
		doTargetCombatHealth(0, player, COMBAT_FIREDAMAGE, -5, -5, CONST_ME_HITBYFIRE)
		player:say("OUCH!", TALKTYPE_MONSTER_SAY)
		item:remove(1)
		return true
	else
		toPosition:sendMagicEffect(CONST_ME_POFF) --it fails, but dont get removed 3% chance
		return true
	end
	return false
end

othersFireBug:id(5467)
othersFireBug:register()
]]
