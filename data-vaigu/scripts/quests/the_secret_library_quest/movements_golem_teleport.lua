local golemTeleport = MoveEvent()

function golemTeleport.onStepIn(creature, item, toPosition, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return true
	end

	if player:getStorageValueByKey(Storage.TheSecretLibrary.Mota) == 10 then
		player:setStorageValueByKey(Storage.TheSecretLibrary.Mota, 11)
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end
	return true
end

golemTeleport:aid(26688)
golemTeleport:register()
