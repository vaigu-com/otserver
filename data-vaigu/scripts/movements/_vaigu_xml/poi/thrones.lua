local config = {
	[2080] = { storage = Storage.PitsOfInferno.ThroneInfernatil, boss = "The Imperor", effect = CONST_ME_FIREAREA, toPosition = Position(6211, 1775, 15) },
	[2081] = { storage = Storage.PitsOfInferno.ThroneTafariel, boss = "Mr. Punish", effect = CONST_ME_MORTAREA, toPosition = Position(6063, 1808, 15) },
	[2082] = { storage = Storage.PitsOfInferno.ThroneVerminor, boss = "The Plasmother", effect = CONST_ME_POISONAREA, toPosition = Position(6142, 1893, 15) },
	[2083] = { storage = Storage.PitsOfInferno.ThroneApocalypse, boss = "Massacre", effect = CONST_ME_EXPLOSIONAREA, toPosition = Position(6177, 1832, 15) },
	[2084] = { storage = Storage.PitsOfInferno.ThroneBazir, boss = "Countess Sorrow", effect = CONST_ME_MAGIC_GREEN, toPosition = Position(6047, 1949, 15) },
	[2085] = { storage = Storage.PitsOfInferno.ThroneAshfalor, boss = "Dracola", effect = CONST_ME_FIREAREA, toPosition = Position(6141, 1875, 15) },
	[2086] = { storage = Storage.PitsOfInferno.ThronePumin, boss = "The Handmaiden", effect = CONST_ME_MORTAREA, toPosition = Position(6087, 1843, 15) },
}

local movement = MoveEvent()

function movement.onStepIn(creature, item, toPosition, fromPosition)
	if not creature:isPlayer() then
		return true
	end

	local throne = config[item.uid]
	if not throne then
		return true
	end

	local cStorage = throne.storage
	if creature:getStorageValue(cStorage) ~= 1 then
		local chance = math.random(50)
		if chance < 2 then
			local position = creature:getPosition()
			local monster = Game.createMonster(throne.boss, position, true, true)
			if monster ~= nil then
				monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				creature:say("Bestia nie odda tak latwo tronu!", TALKTYPE_MONSTER_SAY)
			end
			--return true
		end
		creature:setStorageValue(cStorage, 1)
		creature:getPosition():sendMagicEffect(throne.effect)
		creature:say("Tron zaliczony!", TALKTYPE_MONSTER_SAY)
		if creature:getStorageValue(Storage.PitsOfInferno.OneThrone) <= 0 then
			creature:setStorageValue(Storage.PitsOfInferno.OneThrone, 1)
		end
	else
		creature:teleportTo(throne.toPosition)
		creature:getPosition():sendMagicEffect(CONST_ME_MORTAREA)
		creature:say("Tron zostal juz zaliczony!", TALKTYPE_MONSTER_SAY)
	end
	return true
end

movement:type("stepin")

for i, v in pairs(config) do
	movement:uid(i)
end

movement:register()
