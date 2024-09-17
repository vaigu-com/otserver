local fajtlapaItems = {
	[Storage.UstatkowanyFanatyk.FajtlapaFloat] = { id = 6126, aid = 11088, addToStore = true },
	[Storage.UstatkowanyFanatyk.FajtlapaReel] = { id = 3224, aid = 11090, addToStore = true },
	[Storage.UstatkowanyFanatyk.FajtlapaStool] = { id = 3107, aid = 11092, addToStore = true },
}

local fajtlapaDescriptions = {
	[Storage.UstatkowanyFanatyk.FajtlapaFloat] = "You have found fishing float!",
	[Storage.UstatkowanyFanatyk.FajtlapaReel] = "You have found fishing reel!",
	[Storage.UstatkowanyFanatyk.FajtlapaStool] = "You have found fishing stool!",
}

local fajtlapaContainers = Action()
function fajtlapaContainers.onUse(player, item, _, _, toPosition, _)
	if player:getStorageValue(Storage.UstatkowanyFanatyk.Fajtlapa) ~= 1 then
		return
	end

	local itemAid = item:getActionId()
	if player:getStorageValue(itemAid) ~= QUEST_NOT_STARTED then
		local translatedMessage = player:Localizer():Get("I got it already.")
		player:sendTextMessage(MESSAGE_STATUS_SMALL, translatedMessage)
	end

	local itemData = fajtlapaItems[itemAid]
	if player:TryAddItems({ itemData }) then
		local translatedMessage = player:Localizer():Get(fajtlapaDescriptions[itemAid])
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, translatedMessage)
		player:setStorageValue(itemAid, 1)
		toPosition:sendMagicEffect(CONST_ME_BLOCKHIT)
	end
end

fajtlapaContainers:aid(
	Storage.UstatkowanyFanatyk.FajtlapaFloat,
	Storage.UstatkowanyFanatyk.FajtlapaReel,
	Storage.UstatkowanyFanatyk.FajtlapaStool
)
fajtlapaContainers:register()
