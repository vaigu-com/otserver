local config = {
	[24836] = { storage = Storage.Ferumbras.BossCountPlagirath },
	[24832] = { storage = Storage.Ferumbras.BossCountZamulosh },
	[24833] = { storage = Storage.Ferumbras.BossCountMazoran },
	[24830] = { storage = Storage.Ferumbras.BossCountRazzagorn },
	[24831] = { storage = Storage.Ferumbras.BossCountRagiaz },
	[24834] = { storage = Storage.Ferumbras.BossCountTarbaz },
	[24835] = { storage = Storage.Ferumbras.BossCountShulgrax },
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local uId = config[item.uid]
	if not uId then
		return true
	end

	toPosition.z = toPosition.z + 1
	toPosition.y = toPosition.y + 1

	if uId then
		if player:getStorageValue(uId.storage) < 1 then --jak zabilismy bosa 1 raz
			player:teleportTo(toPosition)
			player:setStorageValue(uId.storage, 1) --nadaje ze go zabilismy
			toPosition:sendMagicEffect(CONST_ME_TELEPORT)
			player:say("Przeteleportowales artefakt.", TALKTYPE_MONSTER_SAY)
		else
			player:teleportTo(toPosition) --jak juz kiedys zabilismy to tylko teleportuje
			toPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end
	end
	return true
end

for i, _ in pairs(config) do
	action:uid(i)
end
action:register()
