local callback = EventCallback("MonsterOnDropLootSoulCore")

function callback.monsterOnDropLoot(monster, corpse)
	if not monster or not corpse then
		return
	end
<<<<<<< HEAD
=======

>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
	local player = Player(corpse:getCorpseOwner())
	if not player or not player:canReceiveLoot() then
		return
	end
<<<<<<< HEAD
=======

>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
	if monster:getMonsterForgeClassification() ~= FORGE_FIENDISH_MONSTER then
		return
	end

<<<<<<< HEAD
	local soulCoreId = nil
=======
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
	local trySameMonsterSoulCore = math.random(100) <= SoulPit.SoulCoresConfiguration.chanceToGetSameMonsterSoulCore
	local mType = monster:getType()
	local lootTable = {}

	if math.random(100) < SoulPit.SoulCoresConfiguration.chanceToDropSoulCore then
<<<<<<< HEAD
		if trySameMonsterSoulCore then
			local itemName = monster:getName():lower() .. " soul core"
			soulCoreId = getItemIdByName(itemName)
=======
		local soulCoreId
		if trySameMonsterSoulCore then
			soulCoreId = getItemIdByName(string.format("%s soul core", monster:getName():lower()))
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		end

		if not soulCoreId and not trySameMonsterSoulCore then
			local race = mType:Bestiaryrace()
			local monstersInCategory = Game.getMonstersByRace(race)

			if monstersInCategory and #monstersInCategory > 0 then
				local randomMonster = monstersInCategory[math.random(#monstersInCategory)]
<<<<<<< HEAD
				local itemName = randomMonster:name():lower() .. " soul core"
				soulCoreId = getItemIdByName(itemName)
				logger.info("soulcoreId: " .. soulCoreId)
=======
				soulCoreId = getItemIdByName(string.format("%s soul core", randomMonster:name():lower()))
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
			end
		end

		if soulCoreId then
<<<<<<< HEAD
			lootTable[soulCoreId] = {
				count = 1,
			}
=======
			lootTable[soulCoreId] = { count = 1 }
			logger.debug("[monsterOnDropLoot.MonsterOnDropLootSoulCore] {} dropped {} for {}.", monster:getName(), ItemType(soulCoreId):getName(), player:getName())
>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
		else
			return {}
		end
	end

	if math.random(100) < SoulPit.SoulCoresConfiguration.chanceToDropSoulPrism then
		local soulPrismId = getItemIdByName("soul prism")
		if soulPrismId then
<<<<<<< HEAD
			lootTable[soulPrismId] = {
				count = 1,
			}
		end
	end
=======
			lootTable[soulPrismId] = { count = 1 }
			logger.debug("[monsterOnDropLoot.MonsterOnDropLootSoulCore] {} dropped {} for {}.", monster:getName(), ItemType(soulPrismId):getName(), player:getName())
		end
	end

>>>>>>> c3bafd85d37e25814e6a6548e2252b64f9f7f33a
	corpse:addLoot(mType:generateLootRoll({}, lootTable, player))
end

callback:register()
