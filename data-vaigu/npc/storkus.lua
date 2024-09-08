local internalNpcName = "Storkus"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 69,
	lookHead = 57,
	lookBody = 59,
	lookLegs = 118,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

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

	if table.contains({ "mission", "misja", "misje" }, message) then
		if player:getStorageValue(Storage.TheInquisition.Questline) == 6 then
			if player:getStorageValue(Storage.TheInquisition.StorkusVampiredust) < 0 then
				player:setStorageValue(Storage.TheInquisition.StorkusVampiredust, 0)
			end
			if player:getStorageValue(Storage.TheInquisition.StorkusVampiredust) < 20 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Masz przy sobie " .. player:getItemCount(5905) .. " z 20 {vampire dusts}. Chcesz mi je oddac?" or "So far ye've brought me " .. player:getItemCount(5905) .. " of 20 {vampire dusts}. Do ye' have any more with ye'?", npc, creature)
				npcHandler:setTopic(playerId, 1)
			elseif player:getStorageValue(Storage.TheInquisition.StorkusVampiredust) == 20 then
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Swietnie! Powinnismy znow porozmiawiac o misji." or "Fine, you're done! Ye' should talk to me about your {mission} again now.", npc, creature)
				npcHandler:setTopic(playerId, 2)
				player:setStorageValue(Storage.TheInquisition.Questline, 7)
				player:setStorageValue(Storage.TheInquisition.Mission03, 2) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			end
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 7 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Moge przekazac ci istotna informacje o jednym z wampirzych wladcow. ...",
				"Jeden z nich ukrywa sie na zapomnianym cmentarzu w okolicy obozowiska mysliwych. Wierze, ze znajdziesz go i zabijesz. ...",
				"Jednak uwazaj: Bez odpowiedniego przygotowania mozesz miec spory problem. Mam nadzieje ze zastaniesz go podczas snu. ...",
				"Nim otworzysz trumne i pozwolisz mu sie wydostac, rozloz kilka czosnkowych amuletow na oltarzykach wokol jego trumny. To znacznie go oslabi. ...",
				"Przynies mi jego amulet jako trofeum. Dobra, sprobuj to zalatwic jak najpredzej.",
			} or {
				"While ye' were keeping the lower ranks busy, I could get valuable information about some vampire lords. ...",
				"One of them is hiding somewhere beneath cemetery south of pouchers village. I expect ye' to find him and kill him. ...",
				"But be warned: Without good preparation, ye' might get into trouble. I hope for ye' he will be sleeping in his coffin when ye' arrive. ...",
				"Before ye' open his coffin and drag that beast out to destroy it, I advise ye' to place some garlic necklaces on the stone slabs next to his coffin. That will weaken him considerably. ...",
				"Bring me his ring as proof for his death. And now hurry and good hunt to ye'.",
			}, npc, creature)
			player:setStorageValue(Storage.TheInquisition.Questline, 8)
			player:setStorageValue(Storage.TheInquisition.Mission03, 3) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			npcHandler:setTopic(playerId, 0)
		elseif player:getStorageValue(Storage.TheInquisition.Questline) == 8 or player:getStorageValue(Storage.TheInquisition.Questline) == 9 then
			if player:removeItem(7924, 1) then
				npcHandler:say(getPlayerLanguage(player) == "PL" and {
					"I jak pokonales go? Mysle, ze mozesz wrocic do Henryka i potwierdzic wykonanie zadania. Zapewne ma dla ciebie bardziej wymagajace wyzwania. ...",
					"Jescze jedno: Wspomnialem o wampirzych wladcach. ...",
					"Dosc ciezko je napotkac. Jak znajdziesz jakiegos i poskromisz, na pewno zostwi po sobie wapirzy zeton. Jesli mozesz przynies go do mnie. ...",
					"Jesli pokonasz ich odpowiednio duzo, to postaram ci sie cos zalatwic.",
				} or {
					"Ding, dong, the vampire is dead, eh? So I guess ye' can return to Henricus and tell him that ye' finished your job here. I'm quite sure he has some more challenging task up his sleeve. ...",
					"One more thing before ye' leave: I already mentioned the master vampires. ...",
					"They are quite hard to find. If ye' stumble across one of them and manage to kill him, he will surely drop some token that proves his death. Bring me these tokens. ...",
					"If ye' kill enough of them, I might have a little surprise for ye'.",
				}, npc, creature)
				player:setStorageValue(Storage.TheInquisition.Questline, 10)
				player:setStorageValue(Storage.TheInquisition.Mission03, 5) -- The Inquisition Questlog- "Mission 3: Vampire Hunt"
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Pokonales wampirzego wladce? Nie posiadasz dowodu." or "Have ye' killed the vampire lord? Because ye' have no his ring.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		end
	elseif MsgContains(message, "vampire lord token") and player:getStorageValue(Storage.TheInquisition.Questline) == 10 then
		if player:getStorageValue(Storage.VampireHunter.Rank) < 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 3)
		elseif player:getStorageValue(Storage.VampireHunter.Rank) == 1 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 4)
		elseif player:getStorageValue(Storage.VampireHunter.Rank) == 2 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 5)
		elseif player:getStorageValue(Storage.VampireHunter.Rank) == 3 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 6)
		elseif player:getStorageValue(Storage.VampireHunter.Rank) == 4 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 7)
		elseif player:getStorageValue(Storage.VampireHunter.Rank) == 5 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz mi przekazac wampirzy zeton?" or "Would ye' like to give me vampire tokens?", npc, creature)
			npcHandler:setTopic(playerId, 8)
		end
	elseif MsgContains(message, "yes") or MsgContains(message, "tak") then
		if npcHandler:getTopic(playerId) == 1 then
			local count = player:getItemCount(5905)
			requiredCount = 20 - player:getStorageValue(Storage.TheInquisition.StorkusVampiredust)
			if count > requiredCount then
				count = requiredCount
			end
			player:setStorageValue(Storage.TheInquisition.StorkusVampiredust, player:getStorageValue(Storage.TheInquisition.StorkusVampiredust) + count)
			player:removeItem(5905, count)
			if player:getStorageValue(Storage.TheInquisition.StorkusVampiredust) < 20 then
				npcHandler:say(
					getPlayerLanguage(player) == "PL"
							and "Przyniosles mi " .. count .. " vampire dustow. " .. (20 - player:getStorageValue(Storage.TheInquisition.StorkusVampiredust)) == 0
							and "Spytaj o {misje} aby kontynuowac."
						or ("Musisz przyniesc mi jeszcze " .. (20 - player:getStorageValue(Storage.TheInquisition.StorkusVampiredust)) .. ".")
						or "Ye've brought me " .. count .. " vampire dusts. " .. (20 - player:getStorageValue(Storage.TheInquisition.StorkusVampiredust)) == 0 and "Ask me for a {mission} to continue your quest."
						or ("Ye' need to bring " .. (20 - player:getStorageValue(Storage.TheInquisition.StorkusVampiredust)) .. " more."),
					npc,
					creature
				)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Przyniosles mi " .. count .. " vampire dustow. Spytaj o {misje} aby kontynuowac." or "Ye've brought me " .. count .. " vampire dusts. Ask for {mission} to continue.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 3 then
			if player:removeItem(8192, 1) then
				npcHandler:say("Ye' brought the token needed to advance to the first vampire hunter rank. I consider that a fluke, but still, congrats! Let me share some of my experience with ye'.", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 1)
				player:addExperience(1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 4 then
			if player:removeItem(8192, 4) then
				npcHandler:say("Ye' brought the four tokens needed to advance to the second vampire hunter rank. Pretty lucky ye' are! Let me share some of my experience with ye'.", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 2)
				player:addExperience(5 * 1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 5 then
			if player:removeItem(8192, 5) then
				npcHandler:say("Ye' brought the five tokens needed to advance to the third vampire hunter rank. Wow, you're pretty determined! Let me share some of my experience with ye'.", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 3)
				player:addExperience(10 * 1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 6 then
			if player:removeItem(8192, 10) then
				npcHandler:say("Ye' brought the ten tokens needed to advance to the fourth vampire hunter rank. You're absolutely painstaking! Let me share some of my experience with ye'.", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 4)
				player:addExperience(20 * 1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 7 then
			if player:removeItem(8192, 30) then
				npcHandler:say("Ye' brought the thirty tokens needed to advance to the fifth vampire hunter rank. You're completely obliterative, kid! Let me share some of my experience with ye'.", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 5)
				player:addExperience(50 * 1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		elseif npcHandler:getTopic(playerId) == 8 then
			if player:removeItem(8192, 50) then
				npcHandler:say("Ye' brought the fifty tokens needed to advance to the last vampire hunter rank. Now that's something. You're razing-amazing! Let me share some of my experience and a little something with ye'!", npc, creature)
				player:setStorageValue(Storage.VampireHunter.Rank, 6)
				player:addItem(8191, 1)
				player:addExperience(100 * 1000, true)
			else
				npcHandler:say("Ye' don't have enought tokens.", npc, creature)
			end
			npcHandler:setTopic(playerId, 0)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
