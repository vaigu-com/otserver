local taint = Action()
function taint.onUse(player, bottle, fromPosition, target, toPosition, isHotkey)
	if not target then
		return false
	end
	if not (target:getActionId() == Storage.SultanPrime.MagicianFountain) then
		return
	end

	if target:getId() == SULTAN_PRIME_KEY_ITEMS["bottle"].id then
		return -- using one player bottle on another
	end

	local storage_val = player:getStorageValue(Storage.SultanPrime.Questline)
	if storage_val ~= 4 then
		return false
	end

	if not player:RemoveItems({ SULTAN_PRIME_KEY_ITEMS["bottle"] }) then
		return
	end

	player:setStorageValue(Storage.SultanPrime.Mission02, 3)
	player:setStorageValue(Storage.SultanPrime.Questline, 5)
	player:setStorageValue(Storage.SultanPrime.DromedaryCount, 0)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	target:getPosition():sendMagicEffect(CONST_ME_PLANTATTACK)
	return true
end

taint:aid(Storage.SultanPrime.MagicianFountain)
taint:register()
