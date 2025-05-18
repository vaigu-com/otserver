local pseudoQuest = Quest(LOCALIZERS.NONE)

pseudoQuest
	:NoQuestlog()
	:Script(function()
		local berserk = Condition(CONDITION_ATTRIBUTES)
		berserk:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
		berserk:setParameter(CONDITION_PARAM_SUBID, JeanPierreMelee)
		berserk:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
		berserk:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
		berserk:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

		local mastermind = Condition(CONDITION_ATTRIBUTES)
		mastermind:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
		mastermind:setParameter(CONDITION_PARAM_SUBID, JeanPierreMagicLevel)
		mastermind:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
		mastermind:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

		local bullseye = Condition(CONDITION_ATTRIBUTES)
		bullseye:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
		bullseye:setParameter(CONDITION_PARAM_SUBID, JeanPierreDistance)
		bullseye:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
		bullseye:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
		bullseye:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

		local antidote = Combat()
		antidote:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
		antidote:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
		antidote:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)
		antidote:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
		antidote:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

		local function magicshield(player)
			local condition = Condition(CONDITION_MANASHIELD)
			condition:setParameter(CONDITION_PARAM_TICKS, 60000)
			condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), 300 + 7.6 * player:getLevel() + 7 * player:getMagicLevel()))
			player:addCondition(condition)
		end

		local vocIdToName = {
			[VOCATION.BASE_ID.SORCERER] = "sorcerers",
			[VOCATION.BASE_ID.DRUID] = "druids",
			[VOCATION.BASE_ID.PALADIN] = "paladins",
			[VOCATION.BASE_ID.KNIGHT] = "knights",
		}
		local moreThan1 = 2
		local vocSizeToMessageCallback = {
			[0] = function()
				return "players"
			end,
			[1] = function(vocations)
				return T(":firstVoc:", { firstVoc = vocIdToName[vocations[1]] })
			end,
			[moreThan1] = function(vocations)
				local vocString = ""
				for i = 1, #vocations - 1 do
					local vocationName = vocIdToName[vocations[i]]
					vocString = vocString .. vocationName .. ", "
				end
				vocString = string.sub(vocString, 1, -3) .. " and " .. vocIdToName[vocations[#vocations]]
				return vocString
			end,
		}

		local function parseVocationsCountIdentifier(vocationsCount)
			if vocationsCount > 1 then
				vocationsCount = moreThan1
			end
			return vocationsCount
		end
		local function parseLevelMessage(requiredLevel)
			if not requiredLevel then
				return ""
			end
			return T("of :requiredLevel:", { requiredLevel = requiredLevel })
		end
		local function generateVocationLevelError(potion)
			local vocations = vocSizeToMessageCallback[parseVocationsCountIdentifier(#potion.vocations)](potion.vocations)
			local accessStr = ""
			if #potion.accessVocations > 0 then
				local accessVocations = vocSizeToMessageCallback[parseVocationsCountIdentifier(#potion.accessVocations)](potion.accessVocations)
				accessStr = " " .. FirstCharToUpper(accessVocations) .. " of level 200 will require training in order to drink this fluid."
			end
			local levelMessage = parseLevelMessage(potion.requiredLevel)
			return T("Only :vocations: :levelMessage: may drink this fluid.:accessStr:", { vocations = vocations, levelMessage = levelMessage, accessStr = accessStr })
		end

		local edEkRpMs = {
			VOCATION.BASE_ID.DRUID,
			VOCATION.BASE_ID.KNIGHT,
			VOCATION.BASE_ID.PALADIN,
			VOCATION.BASE_ID.SORCERER,
		}
		--Vaigu custom
		local potions = {
			--Health
			[7876] = { health = { 60, 90 }, vocations = edEkRpMs, flask = 285 },
			[266] = { health = { 125, 175 }, vocations = edEkRpMs, flask = 285 },
			[236] = { health = { 250, 350 }, vocations = { VOCATION.BASE_ID.PALADIN, VOCATION.BASE_ID.KNIGHT }, requiredLevel = 50, flask = 283 },
			[239] = { health = { 425, 575 }, vocations = { VOCATION.BASE_ID.KNIGHT }, requiredLevel = 80, flask = 284 },
			[7643] = { health = { 650, 850 }, vocations = { VOCATION.BASE_ID.KNIGHT }, requiredLevel = 130, flask = 284 },
			[23375] = { health = { 875, 1125 }, vocations = { VOCATION.BASE_ID.KNIGHT }, requiredLevel = 200, flask = 284 },

			--Mana
			[268] = { mana = { 75, 125 }, vocations = edEkRpMs, flask = 285 },
			[237] = { mana = { 115, 185 }, vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID, VOCATION.BASE_ID.PALADIN }, requiredLevel = 50, flask = 283, access = Storage.EnterTheDrunkTank.MediumManaPotion, accessVocations = { VOCATION.BASE_ID.KNIGHT } },
			[238] = { mana = { 150, 250 }, vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID }, requiredLevel = 80, flask = 284, access = Storage.EnterTheDrunkTank.GreatManaPotion, accessVocations = { VOCATION.BASE_ID.PALADIN } },
			[23373] = { mana = { 425, 575 }, vocations = {}, requiredLevel = 180, flask = 284, access = Storage.EnterTheDrunkTank.UltimateManaPotion, accessVocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID } },

			--Spirit
			[7642] = { health = { 250, 350 }, mana = { 100, 200 }, vocations = { VOCATION.BASE_ID.PALADIN }, requiredLevel = 80, flask = 284 },
			[23374] = { health = { 420, 580 }, mana = { 150, 250 }, vocations = { VOCATION.BASE_ID.PALADIN }, requiredLevel = 130, flask = 284 },

			--Buffs
			[7439] = { vocations = { VOCATION.BASE_ID.KNIGHT }, condition = berserk, effect = CONST_ME_MAGIC_RED, text = "You feel stronger.", achievement = "Berserker" },
			[7440] = { vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID }, condition = mastermind, effect = CONST_ME_MAGIC_BLUE, text = "You feel smarter.", achievement = "Mastermind" },
			[7443] = { vocations = { VOCATION.BASE_ID.PALADIN }, condition = bullseye, effect = CONST_ME_MAGIC_GREEN, text = "You feel more accurate.", achievement = "Sharpshooter" },
			[7644] = { vocations = edEkRpMs, combat = antidote, flask = 285 },

			--Mana shield
			-- [35563] = { vocations = { VOCATION.BASE_ID.SORCERER, VOCATION.BASE_ID.DRUID }, requiredLevel = 14, func = magicshield, effect = CONST_ME_ENERGYAREA },
		}
		local function gernerateAuxillaryFields()
			for _, potion in pairs(potions) do
				potion.vocations = potion.vocations or {}
				potion.accessVocations = potion.accessVocations or {}
				potion.noLevelVocationError = generateVocationLevelError(potion)
			end
		end
		gernerateAuxillaryFields()

		local function tryCreateEmptyFlask(player, usedPotionEx, potionData, fromPosition)
			local deactivatedFlasks = player:kv():get("talkaction.potions.flask") or false
			if deactivatedFlasks then
				return
			end

			local container = Container(usedPotionEx:getParent().uid)
			if not container then
				Game.createItem(potionData.flask, 1, fromPosition)
				return
			end

			local storeInbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
			local parent = usedPotionEx:getParent()
			if parent == storeInbox then
				Game.createItem(potionData.flask, 1, fromPosition)
				return
			end

			local emptyFlaskEx = { id = potionData.flask, count = 1, dontAnnounce = true }
			if player:CanAddItems({ emptyFlaskEx }) then
				if container:getEmptySlots() ~= 0 or container:getItemCountById(potionData.flask) > 0 then
					player:AddCustomItem(emptyFlaskEx, parent)
				else
					player:AddItems({ emptyFlaskEx })
				end
			else
				Game.createItem(potionData.flask, 1, fromPosition)
			end
		end

		local noError = nil
		local function errorMessageIfCannotUse(player, potion)
			local hasLevel = false
			local hasProfession = false
			local hasAccess = false
			local isOfAccessVocation = false

			if player:getLevel() >= (potion.requiredLevel or 0) then
				hasLevel = true
			end
			if table.contains(potion.vocations or {}, player:getVocation():getBaseId()) then
				hasProfession = true
			end
			if potion.access and player:getStorageValueByKey(potion.access) == ACCESS_GRANTED then
				hasAccess = true
			end
			if potion.accessVocations and table.contains(potion.accessVocations, player:getVocation():getBaseId()) then
				isOfAccessVocation = true
			end

			if hasLevel and hasProfession then
				return noError
			end
			if hasLevel and hasAccess and isOfAccessVocation then
				return noError
			end

			if not hasLevel then
				return potion.noLevelVocationError
			end
			if isOfAccessVocation and not hasAccess then
				return "Your stomach cant withstand this fluid... yet."
			end
			if not hasProfession then
				return potion.noLevelVocationError
			end

			return noError
		end

		local flaskPotion = Action()
		function flaskPotion.onUse(player, usedPotionEx, fromPosition, target, toPosition, isHotkey)
			if not target or not player then
				return false
			end
			if not target:isPlayer() or not player:isPlayer() then
				return
			end

			local potionData = potions[usedPotionEx:getId()]
			if not potionData then
				return false
			end

			local errorMessage = errorMessageIfCannotUse(player, potionData)
			if errorMessage then
				player:say(errorMessage, MESSAGE_POTION)
				return false
			end

			if potionData.health or potionData.mana or potionData.combat then
				if potionData.health then
					doTargetCombatHealth(player, target, COMBAT_HEALING, potionData.health[1], potionData.health[2], CONST_ME_MAGIC_BLUE)
				end

				if potionData.mana then
					doTargetCombatMana(0, target, potionData.mana[1], potionData.mana[2], CONST_ME_MAGIC_BLUE)
				end

				if potionData.combat then
					potionData.combat:execute(target, Variant(target:getId()))
				end

				if not potionData.effect and target:getPosition() ~= nil then
					target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				end

				player:addAchievementProgress("Potion Addict", 100000)
				target:say("Aaaah...", MESSAGE_POTION)

				tryCreateEmptyFlask(player, usedPotionEx, potionData, fromPosition)
			end

			player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ITEM_USE_POTION, player:isInGhostMode() and nil or player)

			if potionData.func then
				potionData.func(player)
				player:say("Aaaah...", MESSAGE_POTION)
				player:getPosition():sendMagicEffect(potionData.effect)

				if potionData.achievement then
					player:addAchievementProgress(potionData.achievement, 100)
				end
			end

			if potionData.condition then
				player:addCondition(potionData.condition)
				player:say(potionData.text, MESSAGE_POTION)
				player:getPosition():sendMagicEffect(potionData.effect)
			end

			if not configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
				return true
			end

			player:updateSupplyTracker(usedPotionEx)
			usedPotionEx:remove(1)
			return true
		end

		for index, value in pairs(potions) do
			flaskPotion:id(index)
		end

		flaskPotion:register()
	end)
	:Register()
