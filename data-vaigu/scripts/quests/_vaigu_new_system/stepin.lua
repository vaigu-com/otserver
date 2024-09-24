local quest = Quest("stepin")
quest:Script(function(storageToRequiredState)
	local noDiagonal = MoveEvent()
	function noDiagonal.onStepIn(creature, item, toPosition, fromPosition)
		local player = creature:getPlayer()
		if not player then
			return false
		end
		if fromPosition.z ~= toPosition.z then
			return true
		end
		if IsMoveDiagonal(fromPosition, toPosition) then
			player:teleportTo(fromPosition)
		end
		return true
	end
	noDiagonal:type("stepin")
	noDiagonal:aid(Storage.SpecialStepins.DontAllowDiagonal)
	noDiagonal:register()
end)
