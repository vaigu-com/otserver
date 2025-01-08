local personalChestScope = Scope("PersonalChest")
local chestType = {
	oneTime = personalChestScope:Get("OneTime"),
	daily = personalChestScope:Get("Daily"),
	weekly = personalChestScope:Get("Weekly"),
}

local keyToCooldown = {
	[chestType.oneTime] = LOCKOUT_TIME.FOREVER,
	[chestType.daily] = LOCKOUT_TIME.DAILY,
	[chestType.weekly] = LOCKOUT_TIME.WEEKLY,
}
local cooldownNeverExpires = -2
local function calculateCooldownExpiry(chest)
	local cooldown = chest:getKey()

	local cooldownExpiry = 0
	if keyToCooldown[cooldown] then
		cooldown = keyToCooldown[cooldown]
	end

	if cooldown == LOCKOUT_TIME.DAILY then
		cooldownExpiry = NextDayEpochTime()
	elseif cooldown == LOCKOUT_TIME.WEEKLY then
		cooldownExpiry = NextWednesdayEpochTime()
	elseif cooldown == LOCKOUT_TIME.FOREVER then
		return cooldownNeverExpires
	end

	return cooldownExpiry + DAY_RESET_TIME_LOCAL * 3600
end

local function personalChestWasOpened(player, chest)
	local nextCooldownExpiry = calculateCooldownExpiry(chest)
	local key = personalChestScope:Get(chest:getPosition():ToString())
	player:setStorageValueByKey(key, nextCooldownExpiry)
end

local function hasCooldownExpired(player, chest)
	local key = personalChestScope:Get(chest:getPosition():ToString())
	local cooldownExpiry = player:getStorageValueByKey(key)
	if cooldownExpiry == cooldownNeverExpires then
		return false
	end
	return os.time() > cooldownExpiry
end

local personalChest = Action()
function personalChest.onUse(player, chest, fromPosition, target, toPosition, isHotkey)
	if not hasCooldownExpired(player, chest) then
		SendChestIsEmpty(player, chest:getId())
		return true
	end

	local rewards = ExtractChestContent(chest)
	if player:TryAddItems(rewards) then
		personalChestWasOpened(player, chest)
		player:getPosition():sendMagicEffect(CONST_ME_STUN)
	end
	return true
end
for _, key in pairs(chestType) do
	personalChest:key(key)
end
personalChest:register()
