local areczekEnraged = CreatureEvent("AreczekEnragedDeath")
function areczekEnraged.onDeath(creature)
	if not creature or not creature:isMonster() then
		return true
	end
	local corpse = Game.createItem(4240, 1, creature:getPosition())
	corpse:setActionId(Storage.ProdigalSon.AreczekCorpse)
	return true
end

areczekEnraged:register()

local corpse = Action()
function corpse.onUse(player, corpseItem, fromPosition, target, toPosition, isHotkey)
	if not player:isPlayer() then
		return false
	end

	corpseItem:remove()
	player:AddItems({ { id = SYN_MARNOTRAWNY_NORMAL_ITEMS.toiletSoap } })
	fromPosition:sendMagicEffect(CONST_ME_MAGIC_GREEN)
	return true
end
corpse:aid(Storage.ProdigalSon.AreczekCorpse)
corpse:register()
