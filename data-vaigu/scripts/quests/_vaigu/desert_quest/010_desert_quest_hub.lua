local quest = Quest(LOCALIZERS.DesertQuestHub)

quest
	:Storage(function()
		Storage.DesertQuestHub = {
			ToHub = NextStorage(),
			ToDesertQuestOne = NextStorage(),
			ToDesertQuestTwo = NextStorage(),
			ToSultanPrime = NextStorage(),
		}
	end)
	:Questlog(function()
		--38f
	end)
	:Mission("NONE")
	:State(
		{ min = MISSION_NOT_STARTED, max = DEFAULT_MAX_STATE },
		QuestFactory.StartupItems({
			{ pos = { -2, 0, 0 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestOne },
			{ pos = { 2, 0, 0 }, id = 1949, aid = Storage.DesertQuestHub.ToDesertQuestTwo },
			{ pos = { 0, -2, 0 }, id = 1949, aid = Storage.DesertQuestHub.ToSultanPrime },
			-- {position = {x = 0, y= 2, z= 0}, id = 1949, aid = Storage.DesertQuestHub}, -- unused
		}, DESERT_QUEST_HUB_ANCHOR),
		QuestFactory.StartupItems({
			{ { pos = { 66, 64, -2 }, id = 1949, aid = Storage.DesertQuestHub.ToHub } },
		}, DESERT_QUEST_ONE_ANCHOR),
		QuestFactory.StartupItems({
			{ pos = { 5, 20, 0 }, id = 1949, aid = Storage.DesertQuestHub.ToHub },
		}, DESERT_QUEST_TWO_ANCHOR),
		QuestFactory.StartupItems({
			{ { pos = { 8, 4, 2 }, id = 1949, actionid = Storage.DesertQuestHub.ToHub } },
		}, RETRO_MIRKO_ANCHOR),
		QuestFactory.Script(function(missionState)
			local aidToRequiredStorages = {
				[Storage.DesertQuestHub.ToDesertQuestOne] = nil,
				[Storage.DesertQuestHub.ToDesertQuestTwo] = nil,
				[Storage.DesertQuestHub.ToSultanPrime] = { [Storage.SultanPrime.PuzzlesDoneStateBinary] = 1 },
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
				if checkStorages and (not player:HasExactMissionState(checkStorages)) then
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
	)
	:Register()
