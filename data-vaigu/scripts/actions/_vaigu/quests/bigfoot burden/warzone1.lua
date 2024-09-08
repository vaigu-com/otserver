local posdotp = { x = 7517, y = 1408, z = 9 }
local salaDeathstrike = { x = 7514, y = 1456, z = 9 }
local posDeathstrike = { x = 7521, y = 1467, z = 9 }

function removerTp(tp)
	local t = getTileItemById(posdotp, 1949) -- bierze id i koordy tpka
	if t then -- jak tam jest
		doRemoveItem(t.uid, 1) -- to go usuwa
		doSendMagicEffect(posdotp, CONST_ME_POFF)
	end
end

function TirarCristal()
	local cristal = getTileItemById(posdotp, 15467) -- krystal na koordach
	if cristal then --jak jest
		doRemoveItem(cristal.uid, 1) --to go usuwa
	end
	return true
end

function onTimer5() --creates wall back
	doCreateItem(15467, 1, posdotp) -- Stone pos
end

function onTimer6()
	local tp = Game.createItem(1949, 1, posdotp) --na koordach
	tp:setActionId(45702) --zmienia aid
end

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if getGlobalStorageValue(GlobalStorage.Warzone1Global) < 1 then
		setGlobalStorageValue(GlobalStorage.Warzone1Global, 1)
		for i = 1, 6 do
			for k = 1, 10 do
				local creatures = {
					"humongous fungus",
					"hideous fungus",
				}
				local pos = { x = math.random(7504, 7514), y = math.random(1399, 1416), z = 9 }
				addEvent(doSummonCreature, i * 20 * 1000, creatures[math.random(1, 2)], pos)
				addEvent(doSendMagicEffect, i * 20 * 1000, pos, CONST_ME_TELEPORT)
			end
		end
		doCreatureSay(cid, "Krysztaly sie laduja!", TALKTYPE_ORANGE_1, false, cid, toPosition)
		addEvent(doSendMagicEffect, 6 * 20 * 1000, posDeathstrike, CONST_ME_TELEPORT)
		addEvent(TirarCristal, 6 * 20 * 1000)
		addEvent(onTimer6, 100 + 6 * 20 * 1000) -- Warzone TP
		addEvent(removerTp, 60000 + 5 * 60 * 1000)
		addEvent(onTimer5, 61000 + 5 * 60 * 1000) --5minutes
		addEvent(setGlobalStorageValue, 6 * 20 * 1000 + 30 * 60 * 1000, GlobalStorage.Warzone1Global, 0)
	else
		doPlayerSendCancel(cid, "Musisz zaczekac 30 minut.")
	end
	return true
end
action:uid(3143)
action:register()
