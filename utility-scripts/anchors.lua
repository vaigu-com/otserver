HFPX_ANCHOR = {5158, 866, 11}


function T(template, variables)
	local result = template
	for key, value in ipairs(variables) do
		result = result:gsub(":" .. key .. ":", value)
	end
	return result
end

local anchor = HFPX_ANCHOR

local toCalculate = {
	5052,988,13
}

local id = 0
local actionid = "Storage.DesertQuestTwo.Teleports.FromIdenticalRoom"

for i = 1, #toCalculate, 3 do
	local x = toCalculate[i + 0] - anchor[1]
	local y = toCalculate[i + 1] - anchor[2]
	local z = toCalculate[i + 2] - anchor[3]
	local xyz = x .. "," .. y .. "," .. z
	local str = T("{ position = { x = :x:, y = :y:, z = :z: }, id = :id:, actionid = :actionid: },", { x = x, y = y, z = z, id = id, actionid = actionid })
	local newPos = T("corner:i: = HFPX_ANCHOR:Moved(:x:, :y:, :z:),", { x = x, y = y, z = z, i = math.floor(i / 3) + 1 })
	--print(str)
	print(xyz)
end
