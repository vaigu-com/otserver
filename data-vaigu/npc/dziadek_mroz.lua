local internalNpcName = "Old Man Frost"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 153,
	lookHead = 0,
	lookBody = 114,
	lookLegs = 79,
	lookFeet = 0,
	lookAddons = 3,
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
	-- ============= Do questa na pick Axe =================
	if table.contains({ "misja", "pomoc", "mission" }, message) and player:getStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy) < 1 then
		npcHandler:say(getPlayerLanguage(player) == "PL" and {
			"Ciagle panosza sie tu barbarzyncy. Jeszcze pare lat temu byl tutaj spokoj, jednak teraz ciezko sie z nimi zyje. ...",
			"Sprobuj sie nimi zajac. Wiem, ze trudno bedzie wykurzyc wszystkich, ale nawet kilku mniej bedzie sukcesem. ...",
			"Na dowod pokonania kilku z nich przynies mi Brutetamers Staff oraz Fur Boots, to ich podstawowy ekwupunek. ...",
			"To co piszesz sie na to?",
		} or {
			"There are still barbarians here. Few years ago it was peaceful, but now it is difficult to live with them. ...",
			"Try to take care of them. I know it's going to be hard to get everyone out, but even a few less will be a success. ...",
			"For proof of defeating a few of them, bring me Brutetamers Staff and Fur Boots, this is their basic equipment. ...",
			"So, you're down for that?",
		}, npc, creature)
		npcHandler:setTopic(playerId, 1)
	elseif table.contains({ "tak", "yes", "ok", "pewnie" }, message) and npcHandler:getTopic(playerId) == 1 and player:getStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy) < 1 then
		player:setStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy, 1) -- zaczynamy questa
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Swietnie, w nagrode dostaniesz ode mnie specjalny kilof. Podpowiem ci pozniej, do czego mozna go wykorzystac." or "Great, I'll give you a special pickaxe as a reward. I'll tell you what to use it for later.", npc, creature)
		npcHandler:setTopic(playerId, 0)
	elseif table.contains({ "misja", "pomoc", "mission", "help" }, message) and player:getStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy) == 1 then
		if player:getItemCount(7379) > 0 and player:getItemCount(7457) > 0 then
			npcHandler:say(getPlayerLanguage(player) == "PL" and {
				"Bardzo dobrze, niech gina. Laska mi sie przyda, ale buty mozesz sobie zatrzymac. Trzymaj nagrode, tak jak sie umowilismy. ...",
				"A wlasnie, ten kilof. Mozesz nim na przyklad rozbijac {sople}, lub niektore z krysztalow na wyspie. Czasem udaje sie pozyskac ich czastki.",
			} or {
				"Very well, let them die. I could use the cane, but you can keep the shoes. Keep the prize, just like we agreed. ...",
				"Oh, yeah, the pickaxe. You can use it to smash icicles, for example, or some of the crystals on the island. Sometimes you can get pieces of them.",
			}, npc, creature)
			player:setStorageValue(Storage.NieproszeniGoscie.ZasraniBarbarzyncy, 2) -- koniec questa
			player:removeItem(7379, 1) -- zabieramy staff
			player:addItem(4872, 1) -- dostaje ice pickaxe
			-- Q5.1
			player:addExperience(100000, true) -- 100k expa
			player:getPosition():sendMagicEffect(CONST_ME_STUN)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Jeszcze nie zdobyles laski ani buciorow?" or "You still didn't get brutetamer staff and fur boots?", npc, creature)
			-- Q5.1
		end
	elseif table.contains({ "sopel", "sople", "icicle" }, message) then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Chcesz oddac mi sopel? Dam ci maly upominek wzamian." or "You want to give me an icicle? I'll give you a little gift in exchange.", npc, creature)
		npcHandler:setTopic(playerId, 2)
	elseif table.contains({ "tak", "yes" }, message) and npcHandler:getTopic(playerId) == 2 then
		if player:getItemCount(4837) > 0 then
			player:removeItem(4837, 1) -- zabieramy sopel
			player:addItem(30058, 3) -- dostaje kwiatek
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Dzieki!" or "Thanks!", npc, creature)
		else
			npcHandler:say(getPlayerLanguage(player) == "PL" and "Chyba nic dla mnie nie masz." or "I dont think you got anything for me.", npc, creature)
		end
		npcHandler:setTopic(playerId, 0)
	end
	return true
end

local function greetCallback(npc, player, type, message)
	npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|. Feel free to look at and pat my mammooth.")
	npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, newcomer!")
	npcHandler:setMessage(MESSAGE_WALKAWAY, "Be aware of bandits!")
	if getPlayerLanguage(player) == "PL" then
		npcHandler:setMessage(MESSAGE_GREET, "Witaj |PLAYERNAME|. Nie boj sie mojego mamuta. Mozesz na niego popatrzec a nawet go poglaskac.")
		npcHandler:setMessage(MESSAGE_FAREWELL, "Zegnaj przybyszu!")
		npcHandler:setMessage(MESSAGE_WALKAWAY, "Uwazaj na bandytow!")
	end
	return true
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
