local internalNpcName = "Commander Stone"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 512,
	lookHead = 85,
	lookBody = 9,
	lookLegs = 9,
	lookFeet = 9,
	lookAddons = 3,
}

npcConfig.flags = {
	floorchange = false,
}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "mission") or MsgContains(message, "misja") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) == 14 then
			npcHandler:say({
				"For your {rank} there are two missions avaliable: {crystal keeper}, {spark hunting}.",
				"If you lose a mission item you can probably buy it from Gnomally. ",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.BigfootBurden.QuestLine) == 15 then
			npcHandler:say({
				"For your {rank} there are four missions avaliable: {crystal keeper}, {spark hunting}, {monster extermination} and {mushroom digging}.",
				"If you lose a mission item you can probably buy it from Gnomally. ",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 16 then
			npcHandler:say({
				"For your {rank} there are four missions avaliable: {crystal keeper}, {spark hunting}, {monster extermination} and {mushroom digging}. By the way, you {rank} now allows you to take aditional missions from Gnomeral in Gnomebase Alpha. ",
				"If you lose a mission item you can probably buy it from Gnomally. ",
			}, npc, creature)
			npcHandler:setTopic(playerId, 0)
		end
	-- Crystal Keeper
	elseif MsgContains(message, "rank") then
		npcHandler:say("Talk to Gnomerank about that.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif MsgContains(message, "keeper") then
		if player:getStorageValue(Storage.BigfootBurden.CrystalKeeperTimout) >= os.time() then
			return npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzis juz wykonales to zadanie." or "Sorry, you will have to wait before you can undertake this mission again.", npc, creature)
		end

		if player:getStorageValue(Storage.BigfootBurden.MissionCrystalKeeper) < 1 and player:getStorageValue(Storage.BigfootBurden.CrystalKeeperTimout) < os.time() then
			npcHandler:say({ "You will have to repair some damaged crystals. Go into the Crystal grounds and repair them, using this harmonic crystal. Repair five of them and return to me. ", "If you lose a mission item you can probably buy it from Gnomally. " }, npc, creature)
			player:setStorageValue(Storage.BigfootBurden.MissionCrystalKeeper, 1)
			player:setStorageValue(Storage.BigfootBurden.RepairedCrystalCount, 0)
			player:addItem(15703, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.BigfootBurden.RepairedCrystalCount) == 5 and player:removeItem(15703, 1) then
				player:setStorageValue(Storage.BigfootBurden.Rank, player:getStorageValue(Storage.BigfootBurden.Rank) + 5)
				player:addItem(16128, 1)
				player:addItem(15698, 1)
				player:setStorageValue(Storage.BigfootBurden.MissionCrystalKeeper, 0)
				player:setStorageValue(Storage.BigfootBurden.CrystalKeeperTimout, os.time() + 72000)
				player:setStorageValue(Storage.BigfootBurden.RepairedCrystalCount, -1)
				player:addExperience(20000, true) -- 20k expa
				--player:addAchievement('Crystal Keeper')
				--player:checkGnomeRank()
				npcHandler:say("You did well. That will help us a lot. Take your token and this gnomish supply package as a reward. ", npc, creature)
				--npcHandler:setTopic(playerId, 0)
			end
		end
	-- Raiders of the Lost Spark
	elseif MsgContains(message, "spark") then
		if player:getStorageValue(Storage.BigfootBurden.RaidersOfTheLostSparkTimeout) >= os.time() then
			return npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzis juz wykonales to zadanie." or "Sorry, you will have to wait before you can undertake this mission again.", npc, creature)
		end

		if player:getStorageValue(Storage.BigfootBurden.MissionRaidersOfTheLostSpark) < 1 and player:getStorageValue(Storage.BigfootBurden.RaidersOfTheLostSparkTimeout) < os.time() then
			npcHandler:say({ "Take this extractor and drive it into a body of a slain crystal crusher. This will charge your own body with energy sparks. Charge it with seven sparks and return to me. ...", "Don't worry. The gnomes assured me you'd be save. That is if nothing strange or unusual occurs! " }, npc, creature)
			player:setStorageValue(Storage.BigfootBurden.MissionRaidersOfTheLostSpark, 1)
			player:setStorageValue(Storage.BigfootBurden.ExtractedCount, 0)
			player:addItem(15696, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 1 or npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.BigfootBurden.ExtractedCount) == 7 and player:removeItem(15696, 1) then
				player:setStorageValue(Storage.BigfootBurden.Rank, player:getStorageValue(Storage.BigfootBurden.Rank) + 5)
				player:addItem(16128, 1)
				player:addItem(15698, 1)
				player:setStorageValue(Storage.BigfootBurden.MissionRaidersOfTheLostSpark, 0)
				player:setStorageValue(Storage.BigfootBurden.ExtractedCount, -1)
				player:setStorageValue(Storage.BigfootBurden.RaidersOfTheLostSparkTimeout, os.time() + 72000)
				player:addExperience(20000, true) -- 20k expa
				--player:addAchievement('Call Me Sparky')
				--player:checkGnomeRank()
				npcHandler:say("You did well. That will help us a lot. Take your token and this gnomish supply package as a reward. ", npc, creature)
				--npcHandler:setTopic(playerId, 0)
			end
		end
	-- Exterminators
	elseif MsgContains(message, "extermination") then
		if player:getStorageValue(Storage.BigfootBurden.ExterminatorsTimeout) >= os.time() then
			return npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzis juz wykonales to zadanie." or "Sorry, you will have to wait before you can undertake this mission again.", npc, creature)
		end

		if player:getStorageValue(Storage.BigfootBurden.MissionExterminators) < 1 and player:getStorageValue(Storage.BigfootBurden.ExterminatorsTimeout) < os.time() and player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 15 then
			npcHandler:say("The wigglers have become a pest that threaten our resources and supplies. Kill 10 wigglers in the caves like the mushroon gardens or the truffles ground. Report back to me when you are done. ", npc, creature)
			player:setStorageValue(Storage.BigfootBurden.MissionExterminators, 1)
			player:setStorageValue(Storage.BigfootBurden.ExterminatedCount, 0)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.BigfootBurden.ExterminatedCount) == 10 then
				player:setStorageValue(Storage.BigfootBurden.Rank, player:getStorageValue(Storage.BigfootBurden.Rank) + 5)
				player:addItem(16128, 1)
				player:addItem(15698, 1)
				player:setStorageValue(Storage.BigfootBurden.MissionExterminators, 0)
				player:setStorageValue(Storage.BigfootBurden.ExterminatedCount, -1)
				player:setStorageValue(Storage.BigfootBurden.ExterminatorsTimeout, os.time() + 72000)
				player:addExperience(20000, true) -- 20k expa
				--player:addAchievement('One Foot Vs. Many')
				--player:checkGnomeRank()
				npcHandler:say("You did well. That will help us a lot. Take your token and this gnomish supply package as a reward. ", npc, creature)
				--npcHandler:setTopic(playerId, 0)
			end
		end
	-- Mushroom Digger
	elseif MsgContains(message, "mushroom digging") then
		if player:getStorageValue(Storage.BigfootBurden.MushroomDiggerTimeout) >= os.time() then
			return npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzis juz wykonales to zadanie." or "Sorry, you will have to wait before you can undertake this mission again.", npc, creature)
		end

		if player:getStorageValue(Storage.BigfootBurden.MissionMushroomDigger) < 1 and player:getStorageValue(Storage.BigfootBurden.MushroomDiggerTimeout) < os.time() and player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 15 then
			npcHandler:say({
				"Take this little piggy here. It will one day become a great mushroom hunter for sure. For now it is depended on you and other pigs. ...",
				"Well other pigs then itself of course. I was not comparing you with a pig of course! Go to the truffels area and follow the truffel pigs there. When they dig up some truffels let the little pig eat the mushrooms. ...",
				"You'll have to feed it three times. Then return it to me. ...",
				"Keep in mind that the pig has to be returned to his mother after a while. When you don't do it, the gnomes will recall it via teleport cryrstals.",
			}, npc, creature)
			player:setStorageValue(Storage.BigfootBurden.MissionMushroomDigger, 1)
			player:setStorageValue(Storage.BigfootBurden.MushroomCount, 0)
			player:addItem(15828, 1)
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 2 then
			if player:getStorageValue(Storage.BigfootBurden.MushroomCount) == 3 and player:removeItem(15828, 1) then
				player:setStorageValue(Storage.BigfootBurden.Rank, player:getStorageValue(Storage.BigfootBurden.Rank) + 5)
				player:addItem(16128, 1)
				player:addItem(15698, 1)
				player:setStorageValue(Storage.BigfootBurden.MissionMushroomDigger, 0)
				player:setStorageValue(Storage.BigfootBurden.MushroomCount, -1)
				player:setStorageValue(Storage.BigfootBurden.MushroomDiggerTimeout, os.time() + 72000)
				player:addExperience(20000, true) -- 20k expa
				--player:addAchievement('The Picky Pig')
				--player:checkGnomeRank()
				npcHandler:say("You did well. That will help us a lot. Take your token and this gnomish supply package as a reward. ", npc, creature)
				--npcHandler:setTopic(playerId, 0)
			end
		end
	elseif MsgContains(message, "report") then
		if player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 14 and player:getStorageValue(Storage.BigfootBurden.QuestLine) < 15 then
			npcHandler:say("Which mission do you want to report: {crystal keeper}, {spark hunting}?", npc, creature)
			npcHandler:setTopic(playerId, 1)
		elseif player:getStorageValue(Storage.BigfootBurden.QuestLine) >= 15 then
			npcHandler:say("Which mission do you want to report: {crystal keeper}, {spark hunting}, {extermination} or {mushroom digging}?", npc, creature)
			npcHandler:setTopic(playerId, 2)
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello recruit.")
--npcHandler:setMessage(MESSAGE_GREET_ENG, 'Hello recruit.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
