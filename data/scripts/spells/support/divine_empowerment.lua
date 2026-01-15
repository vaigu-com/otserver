local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	if not creature or not creature:isPlayer() then
		return false
	end

	local grade = creature:revelationStageWOD("Divine Empowerment")
	if grade == 0 then
		creature:sendCancelMessage("You cannot cast this spell")
		creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end

	local empowermentItemPositions = {}
	local ownerId = creature:getId()
	local position = creature:getPosition()
	IterateBetweenPositions(position:Moved(-1, -1, 0), position:Moved(1, 1, 0), function(context)
		local pos = context.pos
		local item = Game.createItem(ITEM_DIVINE_EMPOWERMENT, 1, pos)
		item:setAttribute(ITEM_ATTRIBUTE_OWNER, ownerId)
		table.insert(empowermentItemPositions, item:getPosition())
	end)

	addEvent(function()
		local empowermentItems = {}
		for _, position in pairs(empowermentItemPositions) do
			local empowermentItem = position:GetItemById(ITEM_DIVINE_EMPOWERMENT)
			if empowermentItem then
				table.insert(empowermentItems, empowermentItem)
			end
		end
		for _, empowermentItem in pairs(empowermentItems) do
			empowermentItem:remove()
		end
	end, 5000)

	creature:onThinkWheelOfDestiny(true)
	return true
end

spell:group("support")
spell:name("Divine Empowerment")
spell:words("utevo grav san")
spell:level(50)
spell:mana(500)
spell:isPremium(true)
spell:range(7)
spell:isSelfTarget(true)
spell:isAggressive(false)
spell:cooldown(32 * 1000)
spell:groupCooldown(2 * 1000)
spell:needLearn(true)
spell:vocation("paladin;true", "royal paladin;true")
spell:register()
