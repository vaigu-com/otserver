local function splitString(inputStr)
	local result = {}
	for word in string.gmatch(inputStr, "([^ .%-]+)") do
		table.insert(result, word)
	end
	return result
end

---@class Scope
---@field keys table
Scope = {}
Scope.__index = Scope
---@private
function Scope:New(...)
	local newObj = {}
	setmetatable(newObj, self)
	newObj.keys = {}
	for _, key in pairs({ ... }) do
		newObj:Key(tostring(key))
	end
	return newObj
end
setmetatable(Scope, {
	__call = function(class, ...)
		return class:New(...)
	end,
})
function Scope:Key(key)
	local keys = splitString(key)
	for _, value in pairs(keys) do
		table.insert(self.keys, value)
	end
	return self
end

local scopeSeparator = "-"
---@private
function Scope:Build()
	local keyStr = self.keys[1]
	for i = 2, #self.keys do
		local nextKey = self.keys[i]
		keyStr = keyStr .. scopeSeparator .. nextKey
	end
	self.keyStr = keyStr
	return self
end

function Scope:Get(str)
	self:Build()
	if self.keyStr == nil then
		logger.warn(debug.traceback("[Scope::Get] keyStr is null"))
	end

	if str then
		local addedScope = Scope(str)
		return self.keyStr .. scopeSeparator .. addedScope:Get()
	end
	return self.keyStr
end
