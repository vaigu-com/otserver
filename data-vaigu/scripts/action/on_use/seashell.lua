local function revertCask(position)
	local caskItem = Tile(position):getItemById(21799)
	if caskItem then
		caskItem:transform(21798)
		position:sendMagicEffect(CONST_ME_POFF)
	end
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getLevel() >= 1 then
		if player:getStorageValueByKey(Storage.Seashell) >= os.time() then
			return player:say("Dzis juz ja sprawdzilem..", TALKTYPE_MONSTER_SAY)
		end
		local szansa = math.random(100)
		if szansa <= 19 then
			player:AddCustomItem({ id = 3027, count = 2 }) --black pearl
		elseif szansa >= 20 and szansa <= 29 then
			player:AddCustomItem({ id = 24391, count = 1 }) --coral brooch
		elseif szansa >= 30 and szansa <= 39 then
			player:AddCustomItem({ id = 24392, count = 1 }) --gemmed figurine
		elseif szansa >= 40 and szansa <= 49 then
			player:AddCustomItem({ id = 281, count = 1 }) --shimmering blue
		elseif szansa >= 50 and szansa <= 59 then
			player:AddCustomItem({ id = 282, count = 1 }) --shimmering brown
		elseif szansa >= 60 and szansa <= 69 then
			player:AddCustomItem({ id = 9303, count = 5 }) --leviathan 5 charges
		elseif szansa >= 70 and szansa <= 79 then
			player:AddCustomItem({ id = 13990, count = 50 }) --necklace of the deep 50 charges
		elseif szansa >= 80 and szansa <= 89 then
			player:AddCustomItem({ id = 3581, count = 16 }) --shrimp
		elseif szansa >= 90 then
			player:AddCustomItem({ id = 3026, count = 3 }) --white pearl
		end
		fromPosition:sendMagicEffect(CONST_ME_POFF)
		item:transform(21799)
		addEvent(revertCask, 1 * 60 * 1000, toPosition)
		player:setStorageValueByKey(Storage.Seashell, os.time() + 20 * 3600)
		return true
	else
		player:sendCancelMessage("Musisz posiadac 30 poziom, by uzyc muszli.")
		return true
	end
end

action:id(21798)
action:register()
