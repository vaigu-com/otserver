kv = kv
function kv:increment(key, addend)
	self:set(self:get(key) + (addend or 1))
end
