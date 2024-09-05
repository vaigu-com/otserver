local positions = {
	Position(5497, 1373, 14),
	Position(5497, 1381, 14),
	Position(5499, 1377, 14),
	Position(5502, 1381, 14),
	Position(5502, 1386, 14),
	Position(5503, 1368, 14),
	Position(5504, 1376, 14),
	Position(5508, 1373, 14),
	Position(5508, 1383, 14),
	Position(5509, 1378, 14),
	Position(5513, 1381, 14),
}

local function createVortex()
	local tile = Tile(positions[math.random(#positions)])
	if tile then
		local ground = tile:getGround()
		if ground then
			ground:transform(22894)
			addEvent(function(positionInAddEvent)
				local tile = Tile(positionInAddEvent)
				if tile then
					local ground = tile:getGround()
					if ground then
						ground:transform(23049)
					end
				end
			end, 10 * 1000, tile:getPosition()) -- 10 seconds
		end
	end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	createVortex()
end

spell:name("charge vortex")
spell:words(NextSpellId())
spell:blockWalls(true)
spell:needLearn(true)
spell:register()
