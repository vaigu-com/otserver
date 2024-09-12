local config = nil
local langToConfig = {
	["PL"] = {
		[-1] = "Bez specjalnego lomu nic tu nie zdzialam.",
		[1] = "Wieko trumny ani drgnie.",
		[2] = "Uzywajac zdwojonej sily udalo Ci sie lekko poruszyc wiekiem trumny.",
		[3] = "Zapierajac pobliski lom o szczeline podpierasz wieko, ale kawalek drewna, ktory podwazales, odlamal sie.",
		[4] = "Ustawiles lom w innym miejscu, i uzywajac calej swojej sily, udalo Ci sie podwazyc i zsunac wieko.",
	},
	["EN"] = {
		[-1] = "It wont move without special crowbar.",
		[1] = "The lid of this coffin won't move at all.",
		[2] = "Doubling your efforts, you managed to move the lid a bit.",
		[3] = "Having noticed nearby crobar, you put it in cracks in the wood and try to pry it, but the very fragment of wood was rotten and broke off.",
		[4] = "You relocate crowbar to another crevice nad using all you strength, you broke off the lid.",
	},
}

local updateStorages = { [Storage.SpoczywajacyTutaj.Questline] = 5, [Storage.SpoczywajacyTutaj.Mission01] = 2 }

local coffin = Action()
function coffin.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	config = GetConfigByPlayer(player, langToConfig)

	local storageVal = player:getStorageValue(Storage.SpoczywajacyTutaj.Questline)
	local message = config[storageVal]
	player:say(message, TALKTYPE_MONSTER_SAY)
	if storageVal <= 0 then
		return false
	end

	if storageVal < 4 then
		player:IncrementStorages({ Storage.SpoczywajacyTutaj.Questline }, 1)
	elseif storageVal == 4 then
		if player:RemoveItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.crowbar }) then
			if player:AddItems({ SPOCZYWAJACY_TUTAJ_KEY_ITEMS.lastWill }) then
				player:UpdateStorages(updateStorages)
				return true
			end
		end
	end

	return false
end

coffin:aid(Storage.SpoczywajacyTutaj.Coffin)
coffin:register()
