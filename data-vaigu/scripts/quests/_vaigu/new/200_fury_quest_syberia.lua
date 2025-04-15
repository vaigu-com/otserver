local quest = Quest(LOCALIZERS.NONE)

quest
	:Storage(function()
		Storage.FuryQuestSyberia = {
			StatueEast = {},
			StatueWest = {},
			Lever = {},
		}
	end)
	:NoQuestlog()
	:Script(function()
		local westGatePos = Position(6521, 1755, 12)
		local westGateId = 2184
		local statueWest = Action()
		function statueWest.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local gate = westGatePos:GetItemById(westGateId)
			if gate then
				gate:remove()
				fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
			end
			return true
		end
		statueWest:key(Storage.FuryQuestSyberia.StatueWest)
		statueWest:register()

		local eastGatePos = Position(6522, 1755, 12)
		local eastGateId = 2184
        local statueEast = Action()
		function statueEast.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local gate = eastGatePos:GetItemById(eastGateId)
			if gate then
				gate:remove()
				fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
			end
			return true
		end
		statueEast:key(Storage.FuryQuestSyberia.StatueEast)
		statueEast:register()

        local stoneId = 1791
        local stonePos = Position(6490, 1750, 9)
        local lever = Action()
		function lever.onUse(player, item, fromPosition, target, toPosition, isHotkey)
			local stone = stonePos:GetItemById(stoneId)
			if stone then
				stone:remove()
				fromPosition:sendMagicEffect(CONST_ME_MAGIC_RED)
			end
			return true
		end
		lever:key(Storage.FuryQuestSyberia.Lever)
		lever:register()
	end)
	:Register()
