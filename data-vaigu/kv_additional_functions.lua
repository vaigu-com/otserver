KV = KV
function KV:incrementOrSet(key, addend)
	local currentVal = self:get(key)
	self:set((currentVal or 0) + (addend or 1))
end

function KV:increment(key, addend)
	self:set(self:get(key) + (addend or 1))
end
