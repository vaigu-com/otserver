local internalNpcName = "Michael Dumpling"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2500
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 154,
	lookHead = 114,
	lookBody = 91,
	lookLegs = 91,
	lookFeet = 114,
	lookAddons = 0,
}

npcConfig.flags = { floorchange = 0 }

local config = {
	[1] = {
		female = 136,
		male = 128,
		nazwa = "Citizen",
		male_jeden = { { 5878, 100 } },
		male_dwa = { { 2480, 1 }, { 5902, 50 }, { 5890, 100 } },
		female_jeden = { { 5878, 100 } },
		female_dwa = { { 2480, 1 }, { 5902, 50 }, { 5890, 100 } },
	},

	[2] = {
		female = 137,
		male = 129,
		nazwa = "Hunter",
		male_jeden = {
			{ 5876, 100 },
			{ 5948, 100 },
			{ 5891, 5 },
			{ 5887, 1 },
			{ 5889, 1 },
			{ 5888, 1 },
		},
		male_dwa = { { 5875, 1 } },
		female_jeden = { { 5875, 1 } },
		female_dwa = {
			{ 5876, 100 },
			{ 5948, 100 },
			{ 5891, 5 },
			{ 5887, 1 },
			{ 5889, 1 },
			{ 5888, 1 },
		},
	},

	[3] = {
		female = 138,
		male = 130,
		nazwa = "Mage",
		male_jeden = {
			{ 2182, 1 },
			{ 2186, 1 },
			{ 2185, 1 },
			{ 2181, 1 },
			{ 2183, 1 },
			{ 2190, 1 },
			{ 2191, 1 },
			{ 2188, 1 },
			{ 2189, 1 },
			{ 2187, 1 },
			{ 2193, 20 },
			{ 5809, 1 },
			{ 5904, 10 },
		},
		male_dwa = { { 5903, 1 } },
		female_jeden = { { 5958, 1 } },
		female_dwa = {
			{ 5894, 70 },
			{ 5911, 20 },
			{ 5883, 40 },
			{ 5922, 35 },
			{ 5881, 60 },
			{ 5882, 40 },
			{ 5905, 30 },
			{ 5904, 15 },
			{ 5886, 10 },
		},
	},
	--
	[4] = {
		female = 139,
		male = 131,
		nazwa = "Knight",
		male_jeden = { { 5880, 100 }, { 5892, 1 } },
		male_dwa = { { 5893, 100 }, { 5887, 1 }, { 11422, 1 }, { 5885, 1 } },
		female_jeden = { { 5880, 100 }, { 5892, 1 } },
		female_dwa = { { 5893, 100 }, { 5887, 1 }, { 11422, 1 }, { 5885, 1 } },
	},

	[5] = {
		female = 140,
		male = 132,
		nazwa = "Noblewoman",
		male_jeden = { { 2160, 15 } },
		male_dwa = { { 2160, 15 } },
		female_jeden = { { 2160, 15 } },
		female_dwa = { { 2160, 15 } },
	},

	[6] = {
		female = 141,
		male = 133,
		nazwa = "Summoner",
		male_jeden = { { 5958, 1 } },
		male_dwa = {
			{ 5894, 70 },
			{ 5911, 20 },
			{ 5883, 40 },
			{ 5922, 35 },
			{ 5881, 60 },
			{ 5882, 40 },
			{ 5905, 30 },
			{ 5904, 15 },
			{ 5886, 10 },
		},
		female_jeden = {
			{ 2182, 1 },
			{ 2186, 1 },
			{ 2185, 1 },
			{ 2181, 1 },
			{ 2183, 1 },
			{ 2190, 1 },
			{ 2191, 1 },
			{ 2188, 1 },
			{ 2189, 1 },
			{ 2187, 1 },
			{ 2193, 20 },
			{ 5809, 1 },
			{ 5904, 10 },
		},
		female_dwa = { { 5903, 1 } },
	},

	[7] = {
		female = 142,
		male = 134,
		nazwa = "Warrior",
		male_jeden = { { 5925, 100 }, { 5899, 100 }, { 5919, 1 }, { 5884, 1 } },
		male_dwa = { { 5880, 100 }, { 5887, 1 } },
		female_jeden = { { 5925, 100 }, { 5899, 100 }, { 5919, 1 }, { 5884, 1 } },
		female_dwa = { { 5880, 100 }, { 5887, 1 } },
	},

	[8] = {
		female = 147,
		male = 143,
		nazwa = "Barbarian",
		male_jeden = { { 5884, 1 }, { 5885, 1 }, { 5911, 50 }, { 5910, 50 }, { 5886, 10 } },
		male_dwa = { { 5880, 100 }, { 5876, 50 }, { 5893, 50 }, { 5892, 1 } },
		female_jeden = {
			{ 5884, 1 },
			{ 5885, 1 },
			{ 5911, 50 },
			{ 5910, 50 },
			{ 5886, 10 },
		},
		female_dwa = { { 5880, 100 }, { 5876, 50 }, { 5893, 50 }, { 5892, 1 } },
	},

	[9] = {
		female = 148,
		male = 144,
		nazwa = "Druid",
		male_jeden = { { 5896, 50 }, { 5897, 50 } },
		male_dwa = { { 5906, 100 }, { 5940, 1 }, { 5937, 1 }, { 5938, 1 } },
		female_jeden = { { 5896, 50 }, { 5897, 50 } },
		female_dwa = { { 5906, 100 }, { 5940, 1 }, { 5937, 1 }, { 5938, 1 } },
	},

	[10] = {
		female = 149,
		male = 145,
		nazwa = "Wizard",
		male_jeden = { { 5922, 50 } },
		male_dwa = { { 2536, 1 }, { 2492, 1 }, { 2488, 1 }, { 2123, 1 } },
		female_jeden = { { 5922, 50 } },
		female_dwa = { { 2536, 1 }, { 2492, 1 }, { 2488, 1 }, { 2123, 1 } },
	},

	[11] = {
		female = 150,
		male = 146,
		nazwa = "Oriental",
		male_jeden = { { 5945, 1 } },
		male_dwa = { { 5883, 100 }, { 5895, 100 }, { 5912, 100 }, { 5891, 2 } },
		female_jeden = { { 5945, 1 } },
		female_dwa = { { 5883, 100 }, { 5895, 100 }, { 5912, 100 }, { 5891, 2 } },
	},

	[12] = {
		female = 156,
		male = 152,
		nazwa = "Assassin",
		male_jeden = {
			{ 5910, 50 },
			{ 5912, 50 },
			{ 5886, 10 },
			{ 5909, 50 },
			{ 5913, 50 },
			{ 5914, 50 },
			{ 5911, 50 },
		},
		male_dwa = { { 5930, 1 }, { 5804, 1 } },
		female_jeden = {
			{ 5910, 50 },
			{ 5912, 50 },
			{ 5886, 10 },
			{ 5909, 50 },
			{ 5913, 50 },
			{ 5914, 50 },
			{ 5911, 50 },
		},
		female_dwa = { { 5930, 1 }, { 5804, 1 } },
	},

	[13] = {
		female = 155,
		male = 151,
		nazwa = "Pirate",
		male_jeden = { { 6098, 100 }, { 6126, 100 }, { 6097, 100 } },
		male_dwa = { { 6101, 1 }, { 6102, 1 }, { 6100, 1 }, { 6099, 1 } },
		female_jeden = { { 6098, 100 }, { 6126, 100 }, { 6097, 100 } },
		female_dwa = { { 6101, 1 }, { 6102, 1 }, { 6100, 1 }, { 6099, 1 } },
	},

	[14] = {
		female = 157,
		male = 153,
		nazwa = "Beggar",
		male_jeden = { { 5913, 20 }, { 5878, 50 }, { 5894, 10 }, { 5921, 30 } },
		male_dwa = { { 5883, 100 } },
		female_jeden = { { 5913, 20 }, { 5878, 50 }, { 5894, 10 }, { 5921, 30 } },
		female_dwa = { { 5883, 100 } },
	},

	[15] = {
		female = 158,
		male = 154,
		nazwa = "Shaman",
		male_jeden = { { 3966, 5 }, { 3967, 5 } },
		male_dwa = { { 5810, 5 }, { 3955, 5 }, { 5015, 1 } },
		female_jeden = { { 3966, 5 }, { 3967, 5 } },
		female_dwa = { { 5810, 5 }, { 3955, 5 }, { 5015, 1 } },
	},

	[16] = {
		female = 1042,
		male = 1043,
		nazwa = "Makeshift Warrior",
		male_jeden = { { 21399, 5 } },
		male_dwa = { { 21399, 5 } },
		female_jeden = { { 21399, 5 } },
		female_dwa = { { 21399, 5 } },
	},

	[17] = {
		female = 1069,
		male = 1070,
		nazwa = "Battle Mage",
		male_jeden = { { 21399, 5 } },
		male_dwa = { { 21399, 5 } },
		female_jeden = { { 21399, 5 } },
		female_dwa = { { 21399, 5 } },
	},
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

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{
		text = "...iii nie ma Piroga w Tap Madl.. Gratuluje, zabieraja mnie na bagiety...",
	},
	{
		text = "Szybciej sie przebieraj w te outfity bo zaraz na Fashion Week spadam gosciu...",
	},
	{
		text = "Naturalna skora? Dumny ty jestes z siebie, masz ty rozum i godnosc czlowieka? Przez Ciebie gina zwierzatka... ",
	},
	{ text = "Ladnie dzis wygladasz w tych addonach, no homo heheh... oh wait" },
}

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()

	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	if table.contains({ "outfit", "addon", "addons", "dodatki", "dodatek" }, message) then
		local plec = player:getSex()
		local looktype = 100
		if getPlayerLanguage(player) == "PL" then
			local modal = ModalWindow(100, "Addon", "Wybierz interesujacy cie addon: ")
			for i = 1, #config do
				if plec == PLAYERSEX_FEMALE then
					looktype = config[i].female
				elseif plec == PLAYERSEX_MALE then
					looktype = config[i].male
				end

				if player:hasOutfit(looktype, 3) then
					modal:addChoice(i, config[i].nazwa .. " -- (Kompletny)")
				elseif player:hasOutfit(looktype, 1) or player:hasOutfit(looktype, 2) then
					modal:addChoice(i, config[i].nazwa .. " -- (Niekompletny)")
				else
					modal:addChoice(i, config[i].nazwa .. " -- (Brak)")
				end
			end

			-- modal:addButton(1, "Testuj")
			modal:addButton(2, "Wybierz")
			modal:addButton(3, "Pomoc")
			modal:addButton(4, "Anuluj")
			modal:setDefaultEnterButton(3)
			modal:setDefaultEscapeButton(4)
			modal:sendToPlayer(player)
		else -- eng
			local modal = ModalWindow(100, "Addon", "Select outfit to choose addon: ")
			for i = 1, #config do
				if plec == PLAYERSEX_FEMALE then
					looktype = config[i].female
				elseif plec == PLAYERSEX_MALE then
					looktype = config[i].male
				end

				if player:hasOutfit(looktype, 3) then
					modal:addChoice(i, config[i].nazwa .. " -- (Complete)")
				elseif player:hasOutfit(looktype, 1) or player:hasOutfit(looktype, 2) then
					modal:addChoice(i, config[i].nazwa .. " -- (Incomplete)")
				else
					modal:addChoice(i, config[i].nazwa .. " -- (None)")
				end
			end

			-- modal:addButton(1, "Testuj")
			modal:addButton(2, "Select")
			modal:addButton(3, "Help")
			modal:addButton(4, "Cancel")
			modal:setDefaultEnterButton(3)
			modal:setDefaultEscapeButton(4)
			modal:sendToPlayer(player)
		end
	elseif MsgContains(message, "ticket") then
		npcHandler:say(getPlayerLanguage(player) == "PL" and "Los moze zostac wymioniony na butelki przy pasie. Dokladnie jest to pierwszy dodatek do meskiego summonera lub zenskiego mage." or "I can exchange your winning lottery ticket for fluid belt addon. I mean first male summoner addon, or first female mage addon.", npc, creature)
	elseif table.contains({ "zadanie", "misja", "quest", "mission" }, message) then
		npcHandler:say("Moj kolega nie wspominal, ze przyjdziesz. Porozmawiaj najpierw z nim.", npc, creature)
		return true
	end
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)
npcType:register(npcConfig)
