local config = {
	-- soil guardian
	[16252] = { female = 514, male = 516, effect = CONST_ME_GREEN_RINGS },
	[16253] = { female = 514, male = 516, addon = 1, effect = CONST_ME_GREEN_RINGS, achievement = "Funghitastic" },
	[16254] = { female = 514, male = 516, addon = 2, effect = CONST_ME_GREEN_RINGS, achievement = "Funghitastic" },
	-- crystal warlord
	[16255] = { female = 513, male = 512, effect = CONST_ME_GIANTICE },
	[16256] = { female = 513, male = 512, addon = 1, effect = CONST_ME_GIANTICE, achievement = "Crystal Clear" },
	[16257] = { female = 513, male = 512, addon = 2, effect = CONST_ME_GIANTICE, achievement = "Crystal Clear" },
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local useItem = config[item.itemid]
	if not useItem then
		return true
	end

	local looktype = player:getSex() == PLAYERSEX_FEMALE and useItem.female or useItem.male

	if useItem.addon then
		if not player:hasOutfit(looktype) or player:hasOutfit(looktype, useItem.addon) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You lack the base outfit or already own this outfit part.")
			return true
		end

		player:addOutfitAddon(useItem.female, useItem.addon)
		player:addOutfitAddon(useItem.male, useItem.addon)
		player:getPosition():sendMagicEffect(useItem.effect)
		if player:hasOutfit(looktype, 3) then
			player:addAchievement(useItem.achievement)
		end
		item:remove()
	else
		if player:hasOutfit(looktype) then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You already own this outfit part.")
			return true
		end

		player:addOutfit(useItem.female)
		player:addOutfit(useItem.male)
		player:getPosition():sendMagicEffect(useItem.effect)
		item:remove()
	end
	return true
end
action:id(16252, 16253, 16254, 16255, 16256, 16257)
action:register()
