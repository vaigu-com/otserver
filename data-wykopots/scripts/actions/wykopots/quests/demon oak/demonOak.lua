local config = {
	demonOakIds = { 914, 915, 916, 917 },
	sounds = {
		"MOJE KORZENIE SA OSTRE JAK POEZJA BYWA BRZECHWY ! CZUJESZ TO !?",
		"PRZEKLINAM CIE!",
		"POWSTANCIE MOJE MINIONY, POWSTANCIE Z ZASWIATOW!!!!",
		"AHHHH! TWOJA KREW TYLKO MNIE WZMACNIA!",
		"BIERZ ICH, BIERZ ICH SZARIK!!",
		"NIE UCIEKAJ, I TAK CIE DOPADNE!!!",
		"CZEKA CIE NIEWYOBRAZALNE CIERPIENIE !!",
		"MASZ ZAMIAR PLACIC ZA TEN BOL ?! CZEKA CIE WYSOKI RACHUNEK",
		"ARGG! NIE ZABIJAJCIE !!, NIECH ZDYCHA W MECZARNIACH !!",
	},
	bonebeastChance = 90,
	bonebeastCount = 4,
	waves = 10,
	questArea = {
		fromPosition = { x = 6091, y = 1066, z = 7 },
		toPosition = { x = 6110, y = 1078, z = 7 },
	},
	summonPositions = {
		{ x = 6099, y = 1069, z = 7 },
		{ x = 6097, y = 1070, z = 7 },
		{ x = 6096, y = 1072, z = 7 },
		{ x = 6098, y = 1075, z = 7 },
		{ x = 6101, y = 1075, z = 7 },
		{ x = 6104, y = 1075, z = 7 },
		{ x = 6106, y = 1072, z = 7 },
		{ x = 6104, y = 1069, z = 7 },
	},
	summons = {
		[914] = {
			[5] = { "Braindeath", "Braindeath", "Braindeath", "Bonebeast" },
			[10] = { "Betrayed Wraith", "Betrayed Wraith" },
		},
		[915] = {
			[5] = { "Lich", "Lich", "Lich" },
			[10] = { "Dark Torturer", "Blightwalker" },
		},
		[916] = {
			[5] = { "Banshee", "Banshee", "Banshee" },
			[10] = { "Grim Reaper" },
		},
		[917] = {
			[5] = { "Giant Spider", "Giant Spider", "Lich" },
			[10] = { "Undead Dragon", "Hand of Cursed Fate" },
		},
	},
	storages = {
		[914] = Storage.DemonOak.AxeBlowsBird,
		[915] = Storage.DemonOak.AxeBlowsLeft,
		[916] = Storage.DemonOak.AxeBlowsRight,
		[917] = Storage.DemonOak.AxeBlowsFace,
	},
}

local function getRandomSummonPosition()
	return config.summonPositions[math.random(#config.summonPositions)]
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not isInArray(config.demonOakIds, target.itemid) then
		return true
	end

	local totalProgress = 0
	for k, v in pairs(config.storages) do
		totalProgress = totalProgress + math.max(0, player:getStorageValue(v))
	end

	local spectators, hasMonsters = Game.getSpectators(DEMON_OAK_POSITION, false, false, 9, 9, 6, 6), false
	for i = 1, #spectators do
		if spectators[i]:isMonster() then
			hasMonsters = true
			break
		end
	end

	local isDefeated = totalProgress == (#config.demonOakIds * (config.waves + 1))
	if (config.killAllBeforeCut or isDefeated) and hasMonsters then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Najpierw pokonaj wszystkie potwory.")
		return true
	end

	if isDefeated then
		player:teleportTo(DEMON_OAK_KICK_POSITION)
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Powiedz Oldrakowi o swoim wielkim zwyciestwie przeciw Debowi.")
		player:setStorageValue(Storage.DemonOak.Done, 1)
		player:setStorageValue(Storage.DemonOak.Progress, 3)
		return true
	end

	local cStorage = config.storages[target.itemid]
	local progress = math.max(player:getStorageValue(cStorage), 1)
	if progress >= config.waves + 1 then
		toPosition:sendMagicEffect(CONST_ME_POFF)
		return true
	end

	local isLastCut = totalProgress == (#config.demonOakIds * (config.waves + 1) - 1)
	local summons = config.summons[target.itemid]
	if summons and summons[progress] then
		-- Summon a single demon on the last hit
		if isLastCut then
			Game.createMonster("Demon", getRandomSummonPosition(), false, true)

		-- Summon normal monsters otherwise
		else
			for i = 1, #summons[progress] do
				Game.createMonster(summons[progress][i], getRandomSummonPosition(), false, true)
			end
		end

	-- if it is not the 5th or 10th there is only a chance to summon bonebeasts
	elseif math.random(100) >= config.bonebeastChance then
		for i = 1, config.bonebeastCount do
			Game.createMonster("Bonebeast", getRandomSummonPosition(), false, true)
		end
	end

	player:say(isLastCut and "JAK TO MOZLIWE?!? MOJ PAN CIE ZNISZCZY!! AHRRGGG!" or config.sounds[math.random(#config.sounds)], TALKTYPE_MONSTER_YELL, false, player, DEMON_OAK_POSITION)
	toPosition:sendMagicEffect(CONST_ME_DRAWBLOOD)
	player:setStorageValue(cStorage, progress + 1)
	player:say("-krrrrak-", TALKTYPE_MONSTER_YELL, false, player, toPosition)
	doTargetCombatHealth(0, player, COMBAT_EARTHDAMAGE, -170, -210, CONST_ME_BIGPLANTS)
	return true
end

action:id(8293)
action:register()
