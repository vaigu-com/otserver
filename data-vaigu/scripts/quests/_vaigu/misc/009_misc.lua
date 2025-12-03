local quest = Quest(LOCALIZERS.NONE)
quest
	:Storage(function()
		Storage.SpecialStepins = {
			DontAllowDiagonal = {},
		}
		Storage.FishingHotspot = {
			Syberia = {},
			Steppes = {},
			Orshaawa = {},
			OrnuldCamp = {},
			Mirkotown = {},
			MirkotownSlums = {},
			Maioorka = {},
			Kongo = {},
			Knurowo = {},
			Hurghada = {},
			HugoBossVilla = {},
			Bydgoshch = {},
		}
	end)
	:Constant(function()
		TELEPORT_TO_OTHER_SIDE_VERTICAL = "TELEPORT_TO_OTHER_SIDE_VERTICAL"
	end)
	:NoQuestlog()
	:Script(function()
		local teleportToOtherSide = Action()
		function teleportToOtherSide.onUse(player, usedItem, fromPosition, target, toPosition, isHotkey)
			if isPlayerPzLocked(player) then
				SendPlayerIsPzLocked(player)
				return false
			end

			local playerPosition = player:getPosition()
			local usedItemPosition = usedItem:getPosition()
			local directionVector = playerPosition:VectorTo(usedItemPosition)
			if not directionVector:IsFacingVerticalPartially() then
				return false
			end

			local destination = playerPosition:Moved(directionVector:Scaled(2))
			player:teleportTo(destination)
			return true
		end
		teleportToOtherSide:key(TELEPORT_TO_OTHER_SIDE_VERTICAL)
		teleportToOtherSide:register()
	end)
	:Script(function(missionState)
		local noDiagonal = MoveEvent()
		function noDiagonal.onStepIn(creature, item, toPosition, fromPosition)
			local player = creature:getPlayer()
			if not player then
				return false
			end
			if fromPosition.z ~= toPosition.z then
				return true
			end
			if IsMoveDiagonal(fromPosition, toPosition) then
				player:teleportTo(fromPosition)
			end
			return true
		end
		noDiagonal:type("stepin")
		noDiagonal:key(Storage.SpecialStepins.DontAllowDiagonal)
		noDiagonal:register()

		local dontAllowUse = Action()
		function dontAllowUse.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			return false
		end
		dontAllowUse:key(UNUSABLE_KEY)
		dontAllowUse:register()
	end)
	:Script(function()
		local cookieUse = Action()
		function cookieUse.onUse(player, cookie, fromPosition, target, toPosition, isHotkey)
			AddExperienceWithAnnouncement(player, tonumber(cookie:getKey()))
			cookie:remove(1)
			return true
		end
		cookieUse:id(ItemId.EXP_COOKIE)
		cookieUse:register()

		local cookieLook = Look()
		function cookieLook.onLook(player)
			local exp = tonumber(cookie:getKey())
			player:sendTextMessage(MESSAGE_LOOK, T("Usage: eat me. (:exp: experience)", { exp = exp }))
			return DONT_SHOW_ONLOOK
		end
		cookieLook:id(ItemId.EXP_COOKIE)
		cookieLook:register()
	end)
	:Script(function()
		---@class FishingHotspot
		---@field zone Zone
		---@field active boolean
		---@field expiry integer
		FishingHotspot = {}
		FishingHotspot.__index = FishingHotspot
		---@param zone Zone
		---@return FishingHotspot newObj
		function FishingHotspot.New(zone)
			local newObj = {
				zone = zone,
				expiry = os.time(),
				active = false,
			}
			setmetatable(newObj, FishingHotspot)
			return newObj
		end
		setmetatable(FishingHotspot, {
			__call = function(_, ...)
				return FishingHotspot.New(...)
			end,
		})

		local maxHotspots = 3
		local hotspotDuration = 60 * 15
		local tryRerollEachSeconds = 60 * 5
		local rerollChancePercent = 0.40

		--< do not modify
		local base = 100
		local rerollChanceNormalized = rerollChancePercent * base
		--  do not modify >

		---@class FishingHotspotRegistry
		---@field registry FishingHotspot[]
		FishingHotspotRegistry = {}
		FishingHotspotRegistry.__index = FishingHotspotRegistry
		FishingHotspotRegistry.registry = {}

		function FishingHotspotRegistry:CountActive()
			local activeCount = 0
			for _, fishingHotspot in pairs(self.registry) do
				if fishingHotspot.active then
					activeCount = activeCount + 1
				end
			end
			return activeCount
		end

		function FishingHotspotRegistry:TryActivateRandom()
			if self:CountActive() >= maxHotspots then
				return
			end
			if math.random(1, base) > rerollChanceNormalized then
				return
			end
			local randomHotspot = table.random(self.registry)
			if not randomHotspot.active then
				randomHotspot.active = true
				randomHotspot.expiry = os.time() + hotspotDuration
			end
		end

		local zoneNameToHotspot = {}
		function FishingHotspotRegistry:IsActiveByZone(zone)
			if not zone then
				return
			end
			local hotspot = zoneNameToHotspot[zone:getName()]
			if not hotspot then
				return
			end
			return hotspot.active
		end

		---@param fishingHotspot FishingHotspot
		function FishingHotspotRegistry:Add(fishingHotspot)
			table.insert(self.registry, fishingHotspot)
			zoneNameToHotspot[fishingHotspot.zone:getName()] = fishingHotspot
		end

		function FishingHotspotRegistry:ExpireAll()
			for _, fishingHotspot in pairs(self.registry) do
				if fishingHotspot.active and os.time() > fishingHotspot.expiry then
					fishingHotspot.active = false
					fishingHotspot.zone:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The fishing hotspot in this area has just expired.")
				end
			end
		end
		function FishingHotspotRegistry:Initialize()
			for _, key in pairs(Storage.FishingHotspot) do
				local zone = Zone(key)
				local zoneEvent = ZoneEvent(zone)
				function zoneEvent.beforeEnter(zone, creature)
					local player = creature:getPlayer()
					if not player then
						return true
					end

					if FishingHotspotRegistry:IsActiveByZone(zone) then
						player:sendTextMessage(MESSAGE_FAILURE, "You've entered a fishing hotspot! Catch fish here to earn greater rewards.")
					end

					return true
				end
				zoneEvent:register()
				self:Add(FishingHotspot(zone))
			end
		end
		FishingHotspotRegistry:Initialize()

		---@param player Player
		---@return Position|nil closestActivePosition
		function FishingHotspotRegistry:ClosestActivePosition(player)
			local playerPos = player:getPosition()

			local closestActiveDistance = 99999
			local closestActivePosition = nil
			for _, fishingHotspot in pairs(self.registry) do
				local zonePos = fishingHotspot.zone:firstPosition()
				local distance = zonePos:EuclideanDistance(playerPos)
				if fishingHotspot.active and distance < closestActiveDistance then
					closestActiveDistance = distance
					closestActivePosition = zonePos
				end
			end
			return closestActivePosition
		end

		local rerollHotspots = GlobalEvent("FishingHotspotReroll")
		function rerollHotspots.onTime(interval)
			FishingHotspotRegistry:TryActivateRandom()
			FishingHotspotRegistry:ExpireAll() --expire after rolling to avoid 24/7 hotspot possibility
			return true
		end
		rerollHotspots:interval(tryRerollEachSeconds * 1000)
		rerollHotspots:register()

		local dowserUse = Action()
		function dowserUse.onUse(player, dowser, fromPosition, target, toPosition, isHotkey)
			dowser:remove(1)

			local closestActivePosition = FishingHotspotRegistry:ClosestActivePosition(player)
			if not closestActivePosition then
				local noActiveMessage = player:Localizer(LOCALIZERS.Universal):Get("You intensify you efforts, but cannot find any hotspots.")
				player:sendTextMessage(MESSAGE_FAILURE, noActiveMessage)
				return
			end
			local direction = player:getPosition():DirectionTo(closestActivePosition)
			local directionMessage = player:Localizer(LOCALIZERS.Universal):Context({ direction = direction }):Get("GO_IN_DIRECTION")
			player:sendTextMessage(MESSAGE_FAILURE, directionMessage)
			return true
		end
		dowserUse:id(ItemId.DOWSER)
		dowserUse:register()
	end)
	:Script(function()
		local waterIds = { 622, 4597, 4598, 4599, 4600, 12561, 12563, 4601, 4602, 4609, 4610, 4611, 4612, 4613, 4614, 629, 630, 631, 632, 633, 634, 7236, 9582, 13988, 13989, 12560, 21414 }
		local lootTrash = { 3119, 3123, 3264, 3409, 3578 }
		local lootCommon = { 3035, 3051, 3052, 3580, 236, 237 }
		local lootRare = { 3026, 3029, 3032, 7158, 7159 }
		local lootVeryRare = { 281, 282, 9303 }
		local lootVeryRare1 = { 281, 12557 }
		local lootRare1 = { 3026, 12557 }
		local lootCommon1 = { 3035, 237, 12557 }

		local elementals = {
			chances = {
				{ from = 0, to = 500, itemId = 3026 }, -- white pearl
				{ from = 501, to = 801, itemId = 3029 }, -- small sapphire
				{ from = 802, to = 1002, itemId = 3032 }, -- small emerald
				{ from = 1003, to = 1053, itemId = 281 }, -- giant shimmering pearl (green)
				{ from = 1054, to = 1104, itemId = 282 }, -- giant shimmering pearl (brown)
				{ from = 1105, to = 1115, itemId = 9303 }, -- leviathan's amulet
			},
		}
		local idToSpecialAction = {
			[9582] = function(player, toPosition, target)
				local owner = target:getAttribute(ITEM_ATTRIBUTE_CORPSEOWNER)
				if owner ~= 0 and owner ~= player.uid then
					player:sendTextMessage(MESSAGE_FAILURE, "You are not the owner.")
					return true
				end

				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				target:transform(target.itemid + 1)

				local chance = math.random(10000)
				for i = 1, #elementals.chances do
					local randomItem = elementals.chances[i]
					if chance >= randomItem.from and chance <= randomItem.to then
						player:addItem(randomItem.itemId, 1)
					end
					if chance > 1115 then
						player:say("There was just rubbish in it.", TALKTYPE_MONSTER_SAY)
						return true
					end
				end
			end,
			[12560] = function(player, toPosition)
				toPosition:sendMagicEffect(CONST_ME_WATERSPLASH)
				local rareChance = math.random(100)
				if rareChance == 1 then
					player:addItem(lootVeryRare1[math.random(#lootVeryRare1)], 1)
				elseif rareChance <= 3 then
					player:addItem(lootRare1[math.random(#lootRare1)], 1)
				elseif rareChance <= 10 then
					player:addItem(lootCommon1[math.random(#lootCommon1)], 1)
				else
					player:addItem(lootTrash[math.random(#lootTrash)], 1)
				end
				return true
			end,
			[622] = function()
				toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
			end,
			[13989] = function()
				toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
			end,
		}

		local useWorms = true

		local function refreeIceHole(position)
			local iceHole = Tile(position):getItemById(7237)
			if iceHole then
				iceHole:transform(7200)
			end
		end

		local minChance = 10
		local maxChance = 50
		local requiredRollBase = 100
		local function isFishingSuccesful(player, usedWorm, isInHotspot)
			local requiredRollMultiplier = 1
			if not usedWorm then
				requiredRollMultiplier = requiredRollMultiplier * 3
			end
			if isInHotspot then
				requiredRollMultiplier = requiredRollMultiplier * 0.5
			end
			local finalChance = math.clamp((player:getEffectiveSkillLevel(SKILL_FISHING) - minChance) * 0.597, minChance, maxChance)
			return math.random(requiredRollBase * requiredRollMultiplier) <= finalChance
		end

		local wormId = 3492
		local function tryRemoveWormIfRequired(player)
			if not useWorms then
				return false
			end
			return player:TryRemoveItems({ { id = wormId } })
		end

		local hotspotLootbox = LootboxData({
			lootboxId = NO_LOOTBOX_ID, -- belonging of a deceased
			rewards = {
				LootboxReward({ rewardItemId = 3578, weight = 2000, count = 1 }),

				LootboxReward({ rewardItemId = 7158, weight = 1000, count = 1 }),
				LootboxReward({ rewardItemId = 7159, weight = 1000, count = 1 }),
				LootboxReward({ rewardItemId = 3580, weight = 1000, count = 1 }),

				LootboxReward({ rewardItemId = 5809, weight = 1, count = 1 }),

				LootboxReward({ rewardItemId = 25361, weight = 10, count = 1 }),
				LootboxReward({ rewardItemId = 25360, weight = 10, count = 1 }),
			},
			effect = CONST_ME_POFF,
		})

		local function isInActiveFishingHotspot(player)
			local zones = player:getZones()
			for _, zone in pairs(zones) do
				if FishingHotspotRegistry:IsActiveByZone(zone) then
					return true
				end
			end
			return false
		end

		local fishing = Action()
		function fishing.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			if not table.contains(waterIds, target.itemid) then
				return false
			end

			local targetId = target:getId()
			local specialAction = idToSpecialAction[targetId]
			if specialAction then
				specialAction(player, toPosition, target)
				return
			end

			if targetId ~= 7236 then
				toPosition:sendMagicEffect(CONST_ME_LOSEENERGY)
			end

			if player:getItemCount(3492) > 0 then
				player:addSkillTries(SKILL_FISHING, 1, true)
			end

			local usedWorm = false
			if tryRemoveWormIfRequired(player) then
				usedWorm = true
			end

			local isInHotspot = isInActiveFishingHotspot(player)

			if isFishingSuccesful(player, usedWorm, isInHotspot) then
				if targetId == 13988 then
					target:transform(targetId + 1)
					target:decay()

					if math.random(100) >= 97 then
						player:addItem(13992, 1)
						return true
					end
				elseif targetId == 9 then
					target:transform(7237)
					local position = target:getPosition()
					addEvent(refreeIceHole, 1000 * 60 * 15, position)
					local rareChance = math.random(100)
					if rareChance == 1 then
						player:addItem(7158, 1)
						player:addAchievementProgress("Exquisite Taste", 250)
						return true
					elseif rareChance <= 4 then
						player:addItem(3580, 1)
						player:addAchievementProgress("Exquisite Taste", 250)
						return true
					elseif rareChance <= 10 then
						player:addItem(7159, 1)
						player:addAchievementProgress("Exquisite Taste", 250)
						return true
					end
				else
					player:addItem(3578, 1)
					player:addAchievementProgress("Here, Fishy Fishy!", 250)
				end
				if isInHotspot then
					local randomReward = hotspotLootbox:GetRandomReward()
					player:AddCustomItem({ id = randomReward.rewardItemId, count = randomReward.count })
				end
			end
			return true
		end

		fishing:id(3483)
		fishing:allowFarUse(true)
		fishing:register()
	end)
	:Register()
