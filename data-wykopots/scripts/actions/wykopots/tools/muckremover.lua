local config = {
	{ from = 1, to = 1500, itemId = 16097 }, -- muhomor 15
	{ from = 1501, to = 3000, itemId = 16120, count = 5 }, -- crystal shard 7.5k 15
	{ from = 3001, to = 4500, itemId = 16124, count = 10 }, -- 4k 15
	{ from = 4501, to = 6000, itemId = 16119, count = 10 }, -- 7.5k 15
	{ from = 6001, to = 7000, itemId = 3041 }, --blue gem 10
	{ from = 7001, to = 7500, itemId = 23529 }, -- blue plasma 5
	{ from = 7501, to = 8000, itemId = 23531 }, -- green plasma 5
	{ from = 8001, to = 8500, itemId = 23533 }, -- red plasma 5
	{ from = 8501, to = 8900, itemId = 9301, count = 5 }, -- bonfire 4
	{ from = 8901, to = 9100, itemId = 21217 }, -- green light 2
	{ from = 9101, to = 9600, itemId = 3333 }, -- mace 12k 5
	{ from = 9601, to = 9900, itemId = 8050 }, -- armor 16k 3
	{ from = 9901, to = 9999, itemId = 16160 }, -- sword 0k 1
}

local action = Action()

function action.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if target.itemid ~= 16102 then
		return false
	end

	local chance, randomItem = math.random(9999)
	for i = 1, #config do
		randomItem = config[i]
		if chance >= randomItem.from and chance <= randomItem.to then
			if toPosition.x == CONTAINER_POSITION then
				target:getParent():addItem(randomItem.itemId, randomItem.count or 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
			else
				Game.createItem(randomItem.itemId, randomItem.count or 1, toPosition)
			end

			target:getPosition():sendMagicEffect(CONST_ME_GREEN_RINGS)
			target:remove(1)

			item:remove(1)
			break
		end
	end
	return true
end

action:id(16101)
action:register()
