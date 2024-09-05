local berserk = Condition(CONDITION_ATTRIBUTES)
berserk:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
berserk:setParameter(CONDITION_PARAM_SUBID, AttrSubId_JeanPierreMelee)
berserk:setParameter(CONDITION_PARAM_SKILL_MELEE, 5)
berserk:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
berserk:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local mastermind = Condition(CONDITION_ATTRIBUTES)
mastermind:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
mastermind:setParameter(CONDITION_PARAM_SUBID, AttrSubId_JeanPierreMagic)
mastermind:setParameter(CONDITION_PARAM_STAT_MAGICPOINTS, 3)
mastermind:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local bullseye = Condition(CONDITION_ATTRIBUTES)
bullseye:setParameter(CONDITION_PARAM_TICKS, 10 * 60 * 1000)
bullseye:setParameter(CONDITION_PARAM_SUBID, AttrSubId_JeanPierreDistance)
bullseye:setParameter(CONDITION_PARAM_SKILL_DISTANCE, 5)
bullseye:setParameter(CONDITION_PARAM_SKILL_SHIELD, -10)
bullseye:setParameter(CONDITION_PARAM_BUFF_SPELL, true)

local antidote = Combat()
antidote:setParameter(COMBAT_PARAM_TYPE, COMBAT_HEALING)
antidote:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_MAGIC_BLUE)
antidote:setParameter(COMBAT_PARAM_DISPEL, CONDITION_POISON)
antidote:setParameter(COMBAT_PARAM_AGGRESSIVE, false)
antidote:setParameter(COMBAT_PARAM_TARGETCASTERORTOPMOST, true)

local exhaust = Condition(CONDITION_EXHAUST_HEAL)
exhaust:setParameter(CONDITION_PARAM_TICKS, (configManager.getNumber(configKeys.EX_ACTIONS_DELAY_INTERVAL) - 1000))
-- 1000 - 100 due to exact condition timing. -100 doesn't hurt us, and players don't have reminding ~50ms exhaustion.

--[[local function magicshield(player)
local condition = Condition(CONDITION_MANASHIELD)
condition:setParameter(CONDITION_PARAM_TICKS, 60000)
condition:setParameter(CONDITION_PARAM_MANASHIELD, math.min(player:getMaxMana(), 300 + 7.6 * player:getLevel() + 7 * player:getMagicLevel()))
player:addCondition(condition)
end]]

local potions = {
	--[[[6558] = {
		transform = {
			id = {236, 237}
		},
		effect = CONST_ME_DRAWBLOOD
	},]]
	[7439] = {
		vocations = {
			VOCATION.BASE_ID.KNIGHT,
		},
		condition = berserk,
		effect = CONST_ME_MAGIC_RED,
		description = "Tylko rycerze moga skorzystac z tej mikstury.",
		text = "You feel stronger.",
	},
	[7440] = {
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID,
		},
		condition = mastermind,
		effect = CONST_ME_MAGIC_BLUE,
		description = "Tylko druidzi i magowie moga skorzystac z tej mikstury.",
		text = "You feel smarter.",
	},
	[7443] = {
		vocations = {
			VOCATION.BASE_ID.PALADIN,
		},
		condition = bullseye,
		effect = CONST_ME_MAGIC_GREEN,
		description = "Tylko paladyni moga skorzystac z tej mikstury.",
		text = "You feel more accurate.",
	},
	--[[[35563] = {
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID
		},
		level = 14,
		func = magicshield,
		effect = CONST_ME_ENERGYAREA,
		description = "Only sorcerers and druids of level 14 or above may drink this potion.",
	},]]
	[236] = {
		health = {
			250,
			350,
		},
		vocations = {
			VOCATION.BASE_ID.PALADIN,
			VOCATION.BASE_ID.KNIGHT,
		},
		level = 50,
		flask = 283,
		description = "Tylko paladyni i rycerze od 50 poziomu moga skorzystac z tej mikstury.",
	},
	[237] = {
		mana = {
			115,
			185,
		},
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID,
			VOCATION.BASE_ID.PALADIN,
		},
		level = 50,
		flask = 283,
		description = "Profesje magiczne i paladyni od 50 poziomu moga skorzystac z tej mikstury.",
	},
	[238] = {
		mana = {
			150,
			250,
		},
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID,
			--VOCATION.BASE_ID.PALADIN
		},
		level = 80,
		flask = 284,
		description = "Tylko druidzi i magowie od 80 poziomu moga skorzystac z tej mikstury.",
	},
	[239] = {
		health = {
			425,
			575,
		},
		vocations = {
			VOCATION.BASE_ID.KNIGHT,
		},
		level = 80,
		flask = 284,
		description = "Tylko rycerze od 80 poziomu moga skorzystac z tej mikstury.",
	},
	[266] = {
		health = {
			125,
			175,
		},
		flask = 285,
	},
	[268] = {
		mana = {
			75,
			125,
		},
		flask = 285,
	},
	[7642] = {
		health = {
			250,
			350,
		},
		mana = {
			100,
			200,
		},
		vocations = {
			VOCATION.BASE_ID.PALADIN,
		},
		level = 80,
		flask = 284,
		description = "Tylko paladyni od 80 poziomu moga skorzystac z tej mikstury.",
	},
	[7643] = {
		health = { 650, 850 },
		vocations = {
			VOCATION.BASE_ID.KNIGHT,
		},
		level = 130,
		flask = 284,
		description = "Tylko rycerze od 130 poziomu moga skorzystac z tej mikstury.",
	},
	[7644] = {
		combat = antidote,
		flask = 285,
	},
	[7876] = {
		health = {
			60,
			90,
		},
		flask = 285,
	},
	[23373] = {
		mana = {
			350,
			450,
		},
		vocations = {
			VOCATION.BASE_ID.SORCERER,
			VOCATION.BASE_ID.DRUID,
		},
		level = 220,
		flask = 284,
		description = "Tylko druidzi i magowie od 220 poziomu moga skorzystac z tej mikstury.",
	},
	[23374] = {
		health = {
			420,
			580,
		},
		mana = {
			150,
			250,
		},
		vocations = {
			VOCATION.BASE_ID.PALADIN,
		},
		level = 220,
		flask = 284,
		description = "Tylko paladyni od 220 poziomu moga skorzystac z tej mikstury.",
	},
	[23375] = {
		health = {
			875,
			1125,
		},
		vocations = {
			VOCATION.BASE_ID.KNIGHT,
		},
		level = 200,
		flask = 284,
		description = "Tylko rycerze od 300 poziomu moga skorzystac z tej mikstury.",
	},
}

local flaskPotion = Action()

function flaskPotion.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if not target or type(target) == "userdata" and not target:isPlayer() then
		return false
	end

	if player:getStorageValue(Storage.healLock) == 1 then
		player:sendCancelMessage("Healing is disabled on this event.")
		return true
	end

	-- Delay potion
	if not _G.PlayerDelayPotion[player:getId()] then
		_G.PlayerDelayPotion[player:getId()] = 0
	end
	if _G.PlayerDelayPotion[player:getId()] > systemTime() then
		player:sendTextMessage(MESSAGE_FAILURE, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end

	local potion = potions[item:getId()]
	if potion.level and player:getLevel() < potion.level or potion.vocations and not table.contains(potion.vocations, player:getVocation():getBaseId()) and not (player:getGroup():getId() >= GROUP_TYPE_GAMEMASTER) then
		player:say(potion.description, MESSAGE_POTION)
		return true
	end

	if not potion.condition then
		if potion.level and target:getLevel() < potion.level or potion.vocations and not table.contains(potion.vocations, target:getVocation():getBaseId()) then -- na targecie
			target:say(potion.description, MESSAGE_POTION)
			return true
		end
	end

	if player:getCondition(CONDITION_EXHAUST_HEAL) then
		player:sendTextMessage(MESSAGE_FAILURE, Game.getReturnMessage(RETURNVALUE_YOUAREEXHAUSTED))
		return true
	end

	if potion.health or potion.mana or potion.combat then
		if potion.health then
			doTargetCombatHealth(player, target, COMBAT_HEALING, potion.health[1], potion.health[2], CONST_ME_MAGIC_BLUE)
		end

		if potion.mana then
			doTargetCombatMana(0, target, potion.mana[1], potion.mana[2], CONST_ME_MAGIC_BLUE)
		end

		if potion.combat then
			potion.combat:execute(target, Variant(target:getId()))
		end

		if not potion.effect and target:getPosition() ~= nil then
			target:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
		end

		player:addAchievementProgress(38, 5000)
		target:say("Aaaah...", MESSAGE_POTION)
		if fromPosition.x == CONTAINER_POSITION then
			local targetContainer = Container(item:getParent().uid)
			if targetContainer and targetContainer:addItem(potion.flask, 1) then
			else
				player:addItem(potion.flask, 1)
			end
		else
			player:addItem(potion.flask, 1)
		end
		player:addCondition(exhaust)
		player:setStorageValue(38412, player:getStorageValue(38412) + 1)
	end

	player:getPosition():sendSingleSoundEffect(SOUND_EFFECT_TYPE_ITEM_USE_POTION, player:isInGhostMode() and nil or player)
	-- Delay potion
	_G.PlayerDelayPotion[player:getId()] = systemTime() + 500

	if potion.func then
		potion.func(player)
		player:say("Aaaah...", MESSAGE_POTION)
		player:getPosition():sendMagicEffect(potion.effect)
	end

	if potion.condition then
		player:addCondition(potion.condition)
		player:say(potion.text, MESSAGE_POTION)
		player:getPosition():sendMagicEffect(potion.effect)
	end

	if potion.transform then
		if item:getCount() >= 1 then
			item:remove(1)
			player:addItem(potion.transform.id[math.random(#potion.transform.id)], 1)
			item:getPosition():sendMagicEffect(potion.effect)
			return true
		end
	end

	if not configManager.getBoolean(configKeys.REMOVE_POTION_CHARGES) then
		return true
	end

	-- POTION STARTOWY wielokrotnego uzycia
	if item.itemid == 268 and player:getStorageValue(Storage.StartManapot) < 8 then
		player:setStorageValue(Storage.StartManapot, 1 + player:getStorageValue(Storage.StartManapot))
		player:sendTextMessage(23, "Startowy mana potion zniknie po 10 uzyciach.")
	elseif item.itemid == 266 and player:getStorageValue(Storage.StartHealpot) < 8 then
		player:setStorageValue(Storage.StartHealpot, 1 + player:getStorageValue(Storage.StartHealpot))
		player:sendTextMessage(23, "Startowy health potion zniknie po 10 uzyciach.")
	else
		item:remove(1)
		player:updateSupplyTracker(item)
		return true
	end
	return true
end

for index, value in pairs(potions) do
	flaskPotion:id(index)
end

flaskPotion:register()
