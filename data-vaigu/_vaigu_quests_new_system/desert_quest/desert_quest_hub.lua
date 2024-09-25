local quest = Quest("desert_quest_one")
quest
	:Constant(function()
		-- None
	end)
	:Storage(function()
		Storage.DesertQuestHub = Storage.DesertQuestHub or {}
		Storage.DesertQuestHub.ToHub = NextStorage()
	end)
	:Questlog(function()
		--None
	end)
	:Script(function(storageToRequiredState)
		local teleportId = 775

		local teleportToQuests = {
			{ pos = { -2, 0, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToDesertQuestOne },
			{ pos = { 2, 0, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToDesertQuestTwo },
			{ pos = { 0, -2, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToSultanPrime },
			-- {position = {x = 0, y= 2, z= 0}, id = teleportId, aid = Storage.DesertQuestHub}, -- unused
		}
		local teleportFromDesertQuestOne =
			{ { pos = { 66, 64, -2 }, id = teleportId, aid = Storage.DesertQuestHub.ToHub } }

		local teleportFromDesertQuestTwo = {
			{ pos = { 5, 20, 0 }, id = teleportId, aid = Storage.DesertQuestHub.ToHub },
		}
		local teleportFromSultanPrime =
			{ { pos = { 8, 4, 2 }, id = teleportId, actionid = Storage.DesertQuestHub.ToHub } }
		local desertQuestInit = GlobalEvent("desertQuestHubInit")
		function desertQuestInit.onStartup()
			LoadStartupItems(teleportToQuests, DESERT_QUEST_HUB_ANCHOR)
			LoadStartupItems(teleportFromDesertQuestOne, DESERT_QUEST_ONE_ANCHOR)
			LoadStartupItems(teleportFromDesertQuestTwo, DESERT_QUEST_TWO_ANCHOR)
			LoadStartupItems(teleportFromSultanPrime, RETRO_MIRKO_ANCHOR)
		end

		desertQuestInit:register()
	end)
	:Script(function(storageToRequiredState)
		local aidToRequiredStorages = {
			[Storage.DesertQuestHub.ToDesertQuestOne] = nil,
			[Storage.DesertQuestHub.ToDesertQuestTwo] = nil,
			[Storage.DesertQuestHub.ToSultanPrime] = { [Storage.SultanPrime.Mission01] = 1 },
			[Storage.DesertQuestHub.ToHub] = nil,
		}

		local aidToDestination = {
			[Storage.DesertQuestHub.ToDesertQuestOne] = DESERT_QUEST_ONE_ANCHOR:Moved(71, 64, -2),
			[Storage.DesertQuestHub.ToDesertQuestTwo] = DESERT_QUEST_TWO_ANCHOR:Moved(3, 20, 0),
			[Storage.DesertQuestHub.ToSultanPrime] = RETRO_MIRKO_ANCHOR:Moved(11, 4, 2),
			[Storage.DesertQuestHub.ToHub] = DESERT_QUEST_HUB_ANCHOR,
		}

		local function onCannotEnter(player, fromPosition)
			player:sendTextMessage(MESSAGE_FAILURE, "You cannot use this portal.")
			player:teleportTo(fromPosition, true)
			fromPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end

		local fromHubToQuestPortal = MoveEvent()
		function fromHubToQuestPortal.onStepIn(creature, item, position, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end

			local aid = item:getActionId()
			local checkStorages = aidToRequiredStorages[aid]
			local destination = aidToDestination[aid]
			if checkStorages and (not player:HasCorrectStorageValues(checkStorages)) then
				onCannotEnter(player, fromPosition)
				return
			end
			if not destination then
				onCannotEnter(player, fromPosition)
				return
			end

			player:teleportTo(destination)
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			SPECIAL_ACTIONS_UNIVERSAL.clearConditions({ player = player })
			return true
		end

		fromHubToQuestPortal:aid(Storage.DesertQuestHub.ToDesertQuestOne)
		fromHubToQuestPortal:aid(Storage.DesertQuestHub.ToDesertQuestTwo)
		fromHubToQuestPortal:aid(Storage.DesertQuestHub.ToSultanPrime)
		fromHubToQuestPortal:aid(Storage.DesertQuestHub.ToHub)
		fromHubToQuestPortal:type("stepin")
		fromHubToQuestPortal:register()
	end)
	:MonsterEvent(function() end)
	:Monster(function() end)
	:Npc("Sultan of Phantasms", {
		outfit = { lookType = 360, lookHead = 0, lookBody = 0, lookLegs = 0, lookFeet = 0, lookAddons = 0 },
	})
	:Mission(Storage.DesertQuestOne)
	:Script(function(storageToRequiredState)
		local neckUpdateStorages = {
			[Storage.SultanPrime.Mission01] = 1,
		}
		local questStorage = Storage.SultanPrime.Mission01

		local corpse = Action()
		function corpse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if player:getStorageValue(questStorage) ~= QUEST_NOT_STARTED then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "It is empty.")
				return
			end

			player:AddItems({ SULTAN_PRIME_KEY_ITEMS.amulet })
			player:UpdateStorages(neckUpdateStorages)
			return true
		end
		corpse:aid(Storage.SultanPrime.RewardsScripted.Necklace)
		corpse:register()
	end)
	:Register()
