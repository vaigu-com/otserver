function onCreateWildGrowth(creature, tile)
	local wildGrowth
	if Game.getWorldType() == WORLD_TYPE_NO_PVP then
		wildGrowth = ITEM_WILDGROWTH_SAFE
	else
		wildGrowth = ITEM_WILDGROWTH
	end
	local item = Game.createItem(wildGrowth, 1, tile)
	item:setDuration(38, 45)
end

local combat = Combat()
combat:setParameter(COMBAT_PARAM_DISTANCEEFFECT, CONST_ANI_ENERGY)
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onCreateWildGrowth")

local spell = Spell("rune")
function spell.onCastSpell(creature, variant, isHotkey)
	if creature:getStorageValue(Storage.mwLock) == 1 then
		creature:sendCancelMessage("Wild growth rune is disabled on this event.")
		return false
	else
		return combat:execute(creature, variant)
	end
end

spell:id(94)
spell:name("Wild Growth Rune")
spell:group("attack")
spell:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
spell:impactSound(SOUND_EFFECT_TYPE_SPELL_WILD_GROWTH_RUNE)
spell:cooldown(2 * 1000)
spell:groupCooldown(2 * 1000)
spell:level(27)
spell:magicLevel(8)
spell:runeId(3156)
spell:charges(2)
spell:isBlocking(true, true)
spell:allowFarUse(true)
spell:vocation("druid;true", "elder druid;true")
spell:register()
