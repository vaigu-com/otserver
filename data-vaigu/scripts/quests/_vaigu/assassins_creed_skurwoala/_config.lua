BANJO_KROLA_SZCZUROW:Constant(function()
ASSASSINS_CREED_SKURWOALA_SPECIAL_ACTIONS = {
	despawnGmTomek = function(context)
		local pos = Position(5564, 1575, 8)
		local tile = Tile(pos)
		local monster = tile:getTopCreature()

		local vortex = nil
		if monster then
			vortex = Game.createItem(7804, 1, pos)
		end
		addEvent(function()
			if monster then
				monster:remove()
				pos:sendMagicEffect(CONST_ME_WATERSPLASH)
			end
		end, 1500)
		addEvent(function()
			if vortex then
				vortex:remove()
			end
		end, 3000)
	end,
	spawnGmTomek = function(context)
		local pos = Position(5564, 1575, 8)
		local tile = Tile(pos)
		local monster = tile:getTopCreature()
		if not monster then
			Game.createNpc("gm tomek", pos, false, false)
		end
	end,
	addCarpetMount = function(context)
		local player = context.player
		player:addMount(66)
	end,
	aunorTeleportOut = function(context)
		local player = context.player
		if player then
			player:teleportTo(Position(5811, 805, 0))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	end,
	transformNpcToCryptKingLook = function(context)
		local npc = context.npc
		npc:setOutfit({
			lookType = 12,
			lookHead = 1,
			lookBody = 95,
			lookLegs = 90,
			lookFeet = 90,
			lookAddons = 3,
			lookMount = 0,
		})
		npc:setName("King of The Crypt")
	end,
}

ASSASSINS_CREED_SKURWOALA_KEY_ITEMS = {
	palette = {
		aid = Storage.AssassinsCreedSquurvaali.KeyItems.Palette,
		id = 14684,
		desc = "Assortment of paints. Can be used to paint any surface",
	},
	silicon = {
		aid = Storage.AssassinsCreedSquurvaali.KeyItems.Silicon,
		id = 2469,
		desc = "Box of sillicon wafers. Jannah'ma might be interested in it",
	},
	flare = {
		aid = Storage.AssassinsCreedSquurvaali.KeyItems.Flare,
		id = 30209,
		desc = "Flare from Aunor. Use it before Ghasstly Princess's cave entrance",
	},
}
end)
