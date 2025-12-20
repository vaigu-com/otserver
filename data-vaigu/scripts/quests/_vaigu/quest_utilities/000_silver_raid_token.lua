local silverTokenLook = Look()
function silverTokenLook.onLook(player, item, fromPosition, target, toPosition)
	local elana = Npc("Elana")
	if not elana then
		return DO_SHOW_ONLOOK
	end

	local playerPos = player:getPosition()
	local elanaPos = elana:getPosition()
	local gpsDirection = playerPos:DirectionTo(elanaPos)

	local message = player:Localizer(LOCALIZERS.Universal):Context({ direction = gpsDirection }):Get("GO_IN_DIRECTION")
	doCreatureSay(player, message, TALKTYPE_ORANGE_1)

	return DO_SHOW_ONLOOK
end
silverTokenLook:id(ItemId.SILVER_RAID_TOKEN)
silverTokenLook:blockWalls()
silverTokenLook:register()
