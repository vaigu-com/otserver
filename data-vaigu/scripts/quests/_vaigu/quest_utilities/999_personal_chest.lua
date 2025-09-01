PersonalChestScope = Scope("PersonalChest")
PersonalChest = {
	OneTime = PersonalChestScope:Get("OneTime"),
	Daily = PersonalChestScope:Get("Daily"),
	Weekly = PersonalChestScope:Get("Weekly"),
}
do
	for _, key in pairs(PersonalChest) do
		ImmovableKeys:Add(key)
	end
end

local keyToExpiryType = {
	[PersonalChest.OneTime] = LOCKOUT_EXPIRY_TIME.FOREVER,
	[PersonalChest.Daily] = LOCKOUT_EXPIRY_TIME.DAILY,
	[PersonalChest.Weekly] = LOCKOUT_EXPIRY_TIME.WEEKLY,
}

local function getChestStorage(chest)
	local storage = PersonalChestScope:Get(chest:getPosition():ToString())
	return storage
end

local function setLockout(player, chest)
	local lockoutExpiryTime = keyToExpiryType[chest:getKey()]
	local storage = getChestStorage(chest)
	player:setLockoutExpiry(storage, lockoutExpiryTime)
end

local personalChestUse = Action()
function personalChestUse.onUse(player, chest, fromPosition, target, toPosition, isHotkey)
	if not IsLockoutExpired(player, getChestStorage(chest)) then
		SendChestIsEmpty(player, chest:getId())
		return true
	end

	local rewards = ExtractChestContent(chest)
	if player:TryAddItems(rewards) then
		setLockout(player, chest)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end
for _, key in pairs(PersonalChest) do
	personalChestUse:key(key)
end
personalChestUse:register()
