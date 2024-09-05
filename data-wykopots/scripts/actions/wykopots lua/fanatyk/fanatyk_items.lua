local config = nil
local lang_to_config = {
	["PL"] = {
		text = {
			[0] = "Juz to znalazlem.",
			[1] = "Znalazles splawik!",
			[2] = "Znalazles spinning!",
			[3] = "Znalazles stolek!",
		},
	},
	["EN"] = {
		text = {
			[0] = "I got it already.",
			[1] = "You have found fishing float!",
			[2] = "You have found fishing reel!",
			[3] = "You have found fishing stool!",
		},
	},
}

local fanatykSplawik = Action()
function fanatykSplawik.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	config = GetConfigByPlayer(player, lang_to_config)
	if player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSplawik) <= 0 then
			player:AddCustomItem({ id = 6126, aid = 11088, addToStore = true }) 
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.text[1])
			player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSplawik, 1)
			toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		else
			player:sendTextMessage(MESSAGE_STATUS_SMALL, config.text[0])
		end
	end
end
fanatykSplawik:aid(11087)
fanatykSplawik:register()

local fanatykSpinning = Action()
function fanatykSpinning.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	config = GetConfigByPlayer(player, lang_to_config)
	if player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSpinning) <= 0 then
			player:AddCustomItem({ id = 3224, aid = 11090, addToStore = true }) 
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.text[2])
			player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaSpinning, 1)
			toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		else
			player:sendTextMessage(MESSAGE_STATUS_SMALL, config.text[0])
		end
	end
end
fanatykSpinning:aid(11089)
fanatykSpinning:register()

local fanatykStolek = Action()
function fanatykStolek.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	config = GetConfigByPlayer(player, lang_to_config)
	if player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) == 1 then
		if player:getStorageValue(Storage.UstatkowanyFanatyk.FajtlapaStolek) <= 0 then
			player:AddCustomItem({ id = 3107, aid = 11092, addToStore = true }) 
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, config.text[3])
			player:setStorageValue(Storage.UstatkowanyFanatyk.FajtlapaStolek, 1)
			toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
		else
			player:sendTextMessage(MESSAGE_STATUS_SMALL, config.text[0])
		end
	end
end
fanatykStolek:aid(11091)
fanatykStolek:register()
