Storage.Namelock = {}

function Player:isNameLocked()
	local state  = self:getStorageValueByKey(Storage.Namelock)
	if state == NOT_NAME_LOCKED then
		return false
	else
		return true
	end
end

function Player:reasonIfNamelocked()
	local state  = self:getStorageValueByKey(Storage.Namelock)
	if state == NOT_NAME_LOCKED then
		return nil
	else
		return state
	end
end

function CheckNamelock(player)
	local namelockedReason = player:reasonIfNamelocked()
	if not namelockedReason then
		return true
	end

	player:setMoveLocked(true)
	player:teleportTo(player:getTown():getTemplePosition())
	player:sendTextMessage(MESSAGE_ADMINISTRATOR, "Your name has been locked for the following reason: " .. namelockedReason .. ".")
	player:openStore("extras")
	addPlayerEvent(sendRequestPurchaseData, 50, player, 65002, GameStore.ClientOfferTypes.CLIENT_STORE_OFFER_NAMECHANGE)
	addPlayerEvent(CheckNamelock, 30000, player)
end

local playerLogin = CreatureEvent("NamelockLogin")

function playerLogin.onLogin(player)
	addPlayerEvent(CheckNamelock, 1000, player)
	return true
end

playerLogin:register()
