local rune = Spell("rune")

local nonDisintegratableIds = { 4240, 4241, 4242, 4243, 4246, 4247, 4248 }
local removalLimit = 500

local function isDisintegratable(item)
	if not item:getType():isMovable() then
		return false
	end
	if item:getUniqueId() <= 65535 then
		return false
	end
	if item:getActionId() ~= 0 then
		return false
	end
	if table.contains(nonDisintegratableIds, item:getId()) then
		return false
	end
	if item:hasAttribute(ITEM_ATTRIBUTE_KEY) then
		return false
	end
	return true
end

function rune.onCastSpell(creature, variant, isHotkey)
	local position = variant:getPosition()
	position:sendMagicEffect(CONST_ME_POFF)

	local tile = Tile(position)
	if not tile then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	local items = tile:getItems()
	if not items then
		creature:sendCancelMessage(RETURNVALUE_NOTPOSSIBLE)
		return true
	end

	for i, item in ipairs(items) do
		if isDisintegratable(item) then
			item:remove()
		end

		if i == removalLimit then
			break
		end
	end

	return true
end

rune:group("support")
rune:name("desintegrate rune")
rune:castSound(SOUND_EFFECT_TYPE_SPELL_OR_RUNE)
rune:impactSound(SOUND_EFFECT_TYPE_SPELL_DISINTEGRATE_RUNE)
rune:runeId(3197)
rune:allowFarUse(false)
rune:charges(3)
rune:level(21)
rune:magicLevel(4)
rune:cooldown(2 * 1000)
rune:groupCooldown(2 * 1000)
rune:range(1)
rune:register()
