local internalNpcName = "Elana"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 140,
	lookHead = 2,
	lookBody = 112,
	lookLegs = 76,
	lookFeet = 130,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = false }

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

local items = {
	[1] = { name = "Abacus", id = 19151 },
	[2] = { name = "Assassin Doll", id = 28897 },
	[3] = { name = "Bag of Oriental Spices", id = 10817 },
	[4] = { name = "Bookworm Doll", id = 18343 },
	[5] = { name = "Cateroides Doll", id = 22151 },
	[6] = { name = "Doll of Durin the Almighty", id = 14764 },
	[7] = { name = "Dragon Eye", id = 22027 },
	[8] = { name = "Dragon Goblet", id = 31265 },
	[9] = { name = "Draken Doll", id = 12043 },
	[10] = { name = "Encyclopedia", id = 8149 },
	[11] = { name = "Friendship Amulet", id = 19153 },
	[12] = { name = "Frozen Heart", id = 19156 },
	[13] = { name = "Golden Falcon", id = 28896 },
	[14] = { name = "Golden Newspaper", id = 8153 },
	[15] = { name = "Hand Puppets", id = 9189 },
	[16] = { name = "Imortus", id = 12811 },
	[17] = { name = "Jade Amulet", id = 31268 },
	[18] = { name = "Key of Numerous Locks", id = 19152 },
	[19] = { name = "Loremaster Doll", id = 31267 },
	[20] = { name = "Mathmaster Shield", id = 14760 },
	[21] = { name = "Medusa Skull", id = 14762 },
	[22] = { name = "Music Box", id = 12045 },
	[23] = { name = "Noble Sword", id = 16276 },
	[24] = { name = "Norsemal Doll", id = 19150 },
	[25] = { name = "Old Radio", id = 12813 },
	[26] = { name = "Orcs Jaw Shredder", id = 19155 },
	[27] = { name = "Pigeon Trophy", id = 31266 },
	[28] = { name = "Phoenix Statue", id = 22026 },
	[29] = { name = "The Mexcalibur", id = 19154 },
	[30] = { name = "Goromaphone", id = 34210 },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if MsgContains(message, "token") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Moge wymienic twoje {silver} oraz {golden} raid tokeny na rozmaite {artefakty}. Mozesz takze zdobyc {stroj} oraz {wierzchowca} za odpowiednia ilosc." or "I can exchange your {silver} and {golden} raid tokens for various {artifacts}. You can also get {outfit} and {mount} for the appropriate amount.", npc, creature)
	elseif MsgContains(message, "silver") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Dosc latwo je zdobyc, wypadaja z rozamitych kreatur podczas najazdow. Dziesiec sztuk moge {wymienic} na golden raid token." or "They are pretty common, you can drop them from various raid creatures. I can {exchange} ten of them for single golden raid token.", npc, creature)
	elseif MsgContains(message, "golden") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Sa zdecydowanie rzadsze, wypadaja glownie z bossow podczas najazdow." or "They are definitely uncommon, you can drop them mostly from bosses during raids.", npc, creature)
	elseif MsgContains(message, "art") then
		npcHandler:say(
			getPlayerLanguage(player) == "PL"
					and "20 silver raid tokenow moge wymienic na nastepujace artefakty: {Abacus}, {Assassin Doll}, {Bag of Oriental Spices}, {Bookworm Doll}, {Cateroides Doll}, {Doll of Durin the Almighty}, {Dragon Eye}, {Dragon Goblet}, {Draken Doll}, {Encyclopedia}, {Friendship Amulet}, {Frozen Heart}, {Golden Falcon}, {Golden Newspaper}, {Hand Puppets}, {Imortus}, {Jade Amulet}, {Key of Numerous Locks}, {Loremaster Doll}, {Mathmaster Shield}, {Medusa Skull}, {Music Box}, {Noble Sword}, {Norsemal Doll}, {Old Radio}, {Orcs Jaw Shredder}, {Pigeon Trophy}, {Phoenix Statue}, {The Mexcalibur}, {Goromaphone}."
				or "I can exchange 20 silver raid tokens for following artifacts: {Abacus}, {Assassin Doll}, {Bag of Oriental Spices}, {Bookworm Doll}, {Cateroides Doll}, {Doll of Durin the Almighty}, {Dragon Eye}, {Dragon Goblet}, {Draken Doll}, {Encyclopedia}, {Friendship Amulet}, {Frozen Heart}, {Golden Falcon}, {Golden Newspaper}, {Hand Puppets}, {Imortus}, {Jade Amulet}, {Key of Numerous Locks}, {Loremaster Doll}, {Mathmaster Shield}, {Medusa Skull}, {Music Box}, {Noble Sword}, {Norsemal Doll}, {Old Radio}, {Orcs Jaw Shredder}, {Pigeon Trophy}, {Phoenix Statue}, {The Mexcalibur}, {Goromaphone}.",
			npc,
			creature
		)
	elseif table.contains({ "wymienic", "exchange" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz wymienic 10 silver raid tokenow na 1 golden raid token?" or "You want to exchange 10 silver raid tokens for one golden raid token?", npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 1 then
		if getPlayerItemCount(creature, 21400) >= 10 then
			doPlayerRemoveItem(creature, 21400, 10)
			doPlayerAddItem(creature, 21399, 1)
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 10 silver raid tokenow." or "You need 10 silver raid tokens.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 2 then -- stroj
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 3 then -- jousting eagle
		if getPlayerItemCount(creature, 21399) >= 20 then
			if not player:hasMount(145) then
				doPlayerRemoveItem(creature, 21399, 20)
				player:addMount(145)
				player:getPosition():sendMagicEffect(CONST_ME_BLUE_FIREWORKS)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz masz tego wierzchowca." or "You already have this mount.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 20 golden raid tokenow." or "You need 20 golden raid tokens.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 4 then -- cerberus champion
		if getPlayerItemCount(creature, 21399) >= 20 then
			if not player:hasMount(146) then
				doPlayerRemoveItem(creature, 21399, 20)
				player:addMount(146)
				player:getPosition():sendMagicEffect(CONST_ME_BLUE_FIREWORKS)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo." or "Here you are.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz masz tego wierzchowca." or "You already have this mount.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 20 golden raid tokenow." or "You need 20 golden raid tokens.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 5 then -- Makeshift Warrior
		if getPlayerItemCount(creature, 21399) >= 20 then
			if not player:hasOutfit(1043) then
				doPlayerRemoveItem(creature, 21399, 20)
				player:addOutfit(1042)
				player:addOutfit(1043)
				player:getPosition():sendMagicEffect(CONST_ME_BLUE_FIREWORKS)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo. Po addony do Piroga." or "Here you are. For addons visit Michael Dumpling.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz posiadasz ten stroj." or "You already have this outfit.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 20 golden raid tokenow." or "You need 20 golden raid tokens.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "yes", "tak" }, message) and npcHandler:getTopic(playerId) == 6 then -- Battle Mage
		if getPlayerItemCount(creature, 21399) >= 20 then
			if not player:hasOutfit(1070) then
				doPlayerRemoveItem(creature, 21399, 20)
				player:addOutfit(1069)
				player:addOutfit(1070)
				player:getPosition():sendMagicEffect(CONST_ME_BLUE_FIREWORKS)
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Prosze bardzo. Po addony do Piroga." or "Here you are. For addons visit Michael Dumpling.", npc, creature)
			else
				npcHandler:say(getPlayerLanguage(player) == "PL" and "Juz posiadasz ten stroj." or "You already have this outfit.", npc, creature)
			end
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Potrzebujesz 20 golden raid tokenow." or "You need 20 golden raid tokens.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "stroj", "outfit" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Za 20 golden raid tokenow otrzymac mozesz stroj {Makeshift Warrior} lub {Battle Mage}." or "You can get {Makeshift Warrior} or {Battle Mage} mount for 20 golden raid tokens.", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "mount", "wierzchowca", "wierzchowiec" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Za 20 golden raid tokenow otrzymac mozesz wierzchowca {Jousting Eagle} lub {Cerberus Champion}." or "You can get {Jousting Eagle} or {Cerberus Champion} mount for 20 golden raid tokens.", npc, creature)
	elseif MsgContains(message, "jousting eagle") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz otrzymac wierzchowca Jousting Eagle za 20 golden raid tokenow?" or "You want to get Jousting Eagle mount for 20 golden raid tokens?", npc, creature)
		npcHandler:setTopic(playerId, 3)
	elseif MsgContains(message, "cerberus champion") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz otrzymac wierzchowca Cerberus Champion za 20 golden raid tokenow?" or "You want to get Cerberus Champion mount for 20 golden raid tokens?", npc, creature)
		npcHandler:setTopic(playerId, 4)
	elseif MsgContains(message, "makeshift warrior") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz otrzymac stroj Makeshift Warrior za 20 golden raid tokenow?" or "You want to get Jousting Eagle outfit for 20 golden raid tokens?", npc, creature)
		npcHandler:setTopic(playerId, 5)
	elseif MsgContains(message, "battle mage") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz otrzymac stroj Battle Mage za 20 golden raid tokenow?" or "You want to get Battle Mage outfit for 20 golden raid tokens?", npc, creature)
		npcHandler:setTopic(playerId, 6)
	end
	if message then
		for i = 1, #items do
			if MsgContains(message, items[i].name) then
				if getPlayerItemCount(creature, 19083) >= 20 then
					doPlayerRemoveItem(creature, 19083, 20)
					doPlayerAddItem(creature, items[i].id, 1)
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Oto twoj " .. getItemName(items[i].name) .. "." or "You just swapped 20 silver raid tokens for 1 " .. getItemName(items[i].name) .. ".", npc, creature)
				else
					npcHandler:say(getPlayerLanguage(player) == "PL" and "Na to potrzebujesz 20 silver raid tokenow." or "You need 20 silver raid tokens.", npc, creature)
				end
			end
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hej |PLAYERNAME|. Poza obsluga biblioteki posiadam kolekcje replik roznych {artefaktow}. Mozesz zdobyc niektore z nich wzamian za {raid tokeny}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Do zobaczenia!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcType:register(npcConfig)
