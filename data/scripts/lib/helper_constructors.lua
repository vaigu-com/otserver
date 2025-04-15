-- HelperConstructors
local classes = {
	Action = Action,
	CreatureEvent = CreatureEvent,
	Spell = Spell,
	TalkAction = TalkAction,
	MoveEvent = MoveEvent,
	GlobalEvent = GlobalEvent,
	Weapon = Weapon,
}

-- Vaigu custom
local checkClasses = {
	Action = true,
	CreatureEvent = true,
	Spell = nil,
	TalkAction = true,
	MoveEvent = true,
	GlobalEvent = true,
}
local nameToPresence = {}
local function validateDuplicates(className, name)
	if not name then
		return
	end
	if not checkClasses[className] then
		return
	end
	if nameToPresence[name] then
		logger.warn(T("[CreatureEvent::New] Already registered :className: with :name: ", { className = className, name = name }))
	end
	nameToPresence[name] = true
end

for className, class in pairs(classes) do
	local MT = getmetatable(class)
	local DefaultConstructor = MT.__call

	MT.__call = function(self, def, ...)
		validateDuplicates(className, def)
		-- Backwards compatibility for default obj() constructor
		if type(def) ~= "table" then
			return DefaultConstructor(self, def, ...)
		end

		local obj = nil
		if def.init then
			obj = DefaultConstructor(self, unpack(def.init))
		else
			obj = DefaultConstructor(self)
		end

		-- Call each method from definition table with the value as params
		local hasCallback = false

		for methodName, value in pairs(def) do
			-- Strictly check if a correct callback is passed
			if methodName:sub(1, 2) == "on" and type(value) == "function" and rawget(class, methodName) then
				hasCallback = true
			end

			if methodName ~= "register" then
				local method = rawget(self, methodName)
				if method then
					if type(value) == "table" then
						method(obj, unpack(value))
					else
						method(obj, value)
					end
				end
			end
		end

		-- Only register if callback has already been defined, otherwise defining afterwards will not work
		if def.register then
			if not hasCallback then
				logger.warn("[HelperConstructors] - Event not registered due to there being no callback")
			else
				obj:register()
			end
		end

		return obj
	end
end
