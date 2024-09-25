local playerLogin = CreatureEvent("PlayerLogin")

function playerLogin.onLogin(player)
	local afterLoginStr = ""
	--[[
	if player:getLastLoginSaved() <= 0 then
		afterLoginStr = "Please choose your outfit."
		player:sendOutfitWindow()
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Premade action bars for every vocation are available in options.")
		player:setStorageValue(Storage.EmoteSpells, 1) -- emote on first login
		player:setStorageValue(Storage.TrudnePoczatki.Rozeznanie, 1) -- initial quest
	else
		local welcomeStr = player:Localizer(LOCALIZER_UNIVERSAL):Get("WELCOME_TO_SERVER")
		player:sendTextMessage(MESSAGE_LOGIN, welcomeStr)
		afterLoginStr = player:Localizer(LOCALIZER_UNIVERSAL):Get("YOUR_LAST_VISIT")
	end

	local commandStr = player:Localizer(LOCALIZER_UNIVERSAL):Get("LIST_AVAILABLE_COMMANDS")
	local bugStr = player:Localizer(LOCALIZER_UNIVERSAL):Get("You can report ingame bugs using ctrl+z.")
	player:sendTextMessage(MESSAGE_LOGIN, afterLoginStr)
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, commandStr)
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, bugStr)
	]]

	if isPremium(player) then
		player:setStorageValue(Storage.PremiumAccount, 1)
	end

	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local hasPromotion = player:kv():get("promoted")
		if not player:isPromoted() and hasPromotion then
			player:setVocation(promotion)
		end
	elseif player:isPromoted() then
		player:setVocation(vocation:getDemotion())
	end

	-- Boosted
	local booostedCreatures = Game.getBoostedCreatures()
	local names = ""
	for _, name in pairs(booostedCreatures) do
		names = names .. name .. ", "
	end
	names = names:sub(1, -3)
	player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, T("Today's boosted creatures: :names:.\nBoosted creatures yield more experience points, carry more loot than usual, and respawn at a faster rate.", { names = names }))
	player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, string.format("Today's boosted boss: %s.\nBoosted bosses contain more loot and count more kills for your Bosstiary.", Game.getBoostedBoss()))

	-- Rate events:
	if SCHEDULE_EXP_RATE ~= 100 then
		sendBoostMessage(player, "Exp Rate", SCHEDULE_EXP_RATE > 100)
	end

	if SCHEDULE_SPAWN_RATE ~= 100 then
		sendBoostMessage(player, "Spawn Rate", SCHEDULE_SPAWN_RATE > 100)
	end

	if SCHEDULE_LOOT_RATE ~= 100 then
		sendBoostMessage(player, "Loot Rate", SCHEDULE_LOOT_RATE > 100)
	end

	if SCHEDULE_BOSS_LOOT_RATE ~= 100 then
		sendBoostMessage(player, "Boss Loot Rate", SCHEDULE_BOSS_LOOT_RATE > 100)
	end

	if SCHEDULE_SKILL_RATE ~= 100 then
		sendBoostMessage(player, "Skill Rate", SCHEDULE_SKILL_RATE > 100)
	end

	-- Send Recruiter Outfit
	local resultId = db.storeQuery("SELECT `recruiter` FROM `accounts` WHERE `id`= " .. getAccountNumberByPlayerName(getPlayerName(player)))
	if resultId then
		local recruiterStatus = Result.getNumber(resultId, "recruiter")
		local sex = player:getSex()
		local outfitId = (sex == 1) and 746 or 745
		for outfitAddOn = 0, 2 do
			if recruiterStatus >= outfitAddOn * 3 + 1 then
				if not player:hasOutfit(outfitId, outfitAddOn) then
					if outfitAddOn == 0 then
						player:addOutfit(outfitId)
					else
						player:addOutfitAddon(outfitId, outfitAddOn)
					end
				end
			end
		end
	end

	-- Send Client Exp Display
	if configManager.getBoolean(configKeys.XP_DISPLAY_MODE) then
		local baseRate = player:getFinalBaseRateExperience() * 100
		if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
			local vipBonusExp = configManager.getNumber(configKeys.VIP_BONUS_EXP)
			if vipBonusExp > 0 and player:isVip() then
				vipBonusExp = (vipBonusExp > 100 and 100) or vipBonusExp
				baseRate = baseRate * (1 + (vipBonusExp / 100))
				player:sendTextMessage(MESSAGE_BOOSTED_CREATURE, "Normal base xp is: " .. baseRate .. "%, because you are VIP, bonus of " .. vipBonusExp .. "%")
			end
		end

		player:setBaseXpGain(baseRate)
	end

	player:setStaminaXpBoost(player:getFinalBonusStamina() * 100)
	player:getFinalLowLevelBonus()

	-- Updates the player's VIP status and executes corresponding actions if applicable.
	if configManager.getBoolean(configKeys.VIP_SYSTEM_ENABLED) then
		local isVipNow = player:isVip()
		local wasVip = player:kv():scoped("account"):get("vip-system") or false

		if wasVip ~= isVipNow then
			if wasVip then
				player:onRemoveVip()
			else
				player:onAddVip(player:getVipDays())
			end
		end

		if isVipNow then
			CheckPremiumAndPrint(player, MESSAGE_LOGIN)
		end
	end

	-- Set Ghost Mode
	if player:getGroup():getId() >= GROUP_TYPE_GAMEMASTER then
		player:setGhostMode(true)
	end

	-- Resets
	if _G.OnExerciseTraining[player:getId()] then
		stopEvent(_G.OnExerciseTraining[player:getId()].event)
		_G.OnExerciseTraining[player:getId()] = nil
		player:setTraining(false)
	end

	local playerId = player:getId()
	_G.NextUseStaminaTime[playerId] = 1
	_G.NextUseXpStamina[playerId] = 1
	_G.NextUseConcoctionTime[playerId] = 1
	DailyReward.init(playerId)

	local stats = player:inBossFight()
	if stats then
		stats.playerId = player:getId()
	end

	-- Remove Boss Time
	if GetDailyRewardLastServerSave() >= player:getLastLoginSaved() then
		player:setRemoveBossTime(1)
	end

	-- Remove combat protection
	local isProtected = player:kv():get("combat-protection") or 0
	if isProtected < 1 then
		player:kv():set("combat-protection", 1)
	end

	-- Change support outfit to a normal outfit to open customize character without crashes
	local playerOutfit = player:getOutfit()
	if table.contains({ 75, 266, 302 }, playerOutfit.lookType) then
		playerOutfit.lookType = 136
		playerOutfit.lookAddons = 0
		player:setOutfit(playerOutfit)
	end

	player:initializeLoyaltySystem()
	player:registerEvent("PlayerDeath")
	player:registerEvent("DropLoot")
	player:registerEvent("BossParticipation")
	player:registerEvent("UpdatePlayerOnAdvancedLevel")

	-- Vaigu custom
	player:openChannel(3) -- General
	player:openChannel(5) -- Trade
	player:openChannel(7) -- Help
	player:openChannel(4) -- English

	if player:getStorageValue(Storage.hasteLock) >= 1 then
		player:setStorageValue(Storage.hasteLock, 0)
	end
	if player:getStorageValue(Storage.healLock) == 1 then
		player:setStorageValue(Storage.healLock, 0)
	end

	player:TryResetDailyTaskCounter()
	-- Legacy
	--player:loadSpecialStorage()

	--[[ Obnoxious
	if player:getGroup():getId() >= GROUP_TYPE_GAMEMASTER then
		player:setGhostMode(true)
	end
	]]

	return true
end
playerLogin:register()
