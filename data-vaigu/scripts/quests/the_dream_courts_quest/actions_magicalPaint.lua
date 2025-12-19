local sapphireDust = 30004
local sunFruitJuice = 30003
local egg = 30005
local enchantedBottle = 30006
local magicalPaint = 29994
local Count = Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Count

local actions_magicalPaint = Action()

function actions_magicalPaint.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if item.itemid == sapphireDust and target.itemid == sunFruitJuice then
		target:remove(1)
		item:remove(1)
		player:addItem(enchantedBottle)
		return true
	elseif item.itemid == egg and target.itemid == enchantedBottle then
		target:remove(1)
		item:remove(1)
		player:addItem(magicalPaint)
		return true
	elseif item.itemid == magicalPaint and target.actionid == 23109 then
		if player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Painting) < 1 then
			item:remove(1)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Carefully you paint over the picture. As you are doing so the flat paiting deepens. It looks now like a room you can enter.")
			player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Painting, 1)
			player:setStorageValueByKey(Count, player:getStorageValueByKey(Count) + 1)
		end
	end
end

actions_magicalPaint:id(29994, 30003, 30004, 30005, 30006)
actions_magicalPaint:register()

local usePainting = Action()
function usePainting.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Painting) == 2 then
		if item.getPosition() == Position(32104, 31921, 13) or item:getPosition() == Position(32103, 31921, 13) then
			player:teleportTo(Position(32114, 32014, 13))
		else
			player:teleportTo(Position(32103, 31922, 13))
		end

		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	elseif player:getStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Painting) == 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "This isn't a normal paiting anymore. By using magical paint you transformed it into a portal and can easily pass it.")
		player:setStorageValueByKey(Storage.Quest.U12_00.TheDreamCourts.TheSevenKeys.Painting, 2)
	end
end

usePainting:aid(23109)
usePainting:register()
