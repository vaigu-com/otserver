table.append = table.insert
table.empty = function(t)
	return next(t) == nil
end

table.find = function(table, value)
	for i, v in pairs(table) do
		if v == value then
			return i
		end
	end

	return nil
end

table.contains = function(array, value)
	for _, targetColumn in pairs(array) do
		if targetColumn == value then
			return true
		end
	end
	return false
end

table.count = function(table, item)
	local count = 0
	for i, n in pairs(table) do
		if item == n then
			count = count + 1
		end
	end

	return count
end
table.countElements = table.count

table.getCombinations = function(table, num)
	local a, number, select, newlist = {}, #table, num, {}
	for i = 1, select do
		a[#a + 1] = i
	end

	local newthing = {}
	while true do
		local newrow = {}
		for i = 1, select do
			newrow[#newrow + 1] = table[a[i]]
		end

		newlist[#newlist + 1] = newrow
		local i = select
		while a[i] == (number - select + i) do
			i = i - 1
		end

		if i < 1 then
			break
		end

		a[i] = a[i] + 1
		for j = i, select do
			a[j] = a[i] + j - i
		end
	end

	return newlist
end

function table.serialize(x, recur)
	local t = type(x)
	recur = recur or {}

	if t == nil then
		return "nil"
	elseif t == "string" then
		return string.format("%q", x)
	elseif t == "number" then
		return tostring(x)
	elseif t == "boolean" then
		return t and "true" or "false"
	elseif getmetatable(x) then
		error("Can not serialize a table that has a metatable associated with it.")
	elseif t == "table" then
		if table.find(recur, x) then
			error("Can not serialize recursive tables.")
		end
		table.append(recur, x)

		local s = "{"
		for k, v in pairs(x) do
			s = s .. "[" .. table.serialize(k, recur) .. "]"
			s = s .. " = " .. table.serialize(v, recur) .. ","
		end
		s = s .. "}"
		return s
	else
		error("Can not serialize value of type '" .. t .. "'.")
	end
end

function table.unserialize(str)
	return loadstring("return " .. str)()
end

function table.shallowCopy(oldTable)
	local newTable = {}
	for k, v in pairs(oldTable) do
		newTable[k] = v
	end
	return newTable
end

function pairsByKeys(t, f)
	local a = {}
	for n in pairs(t) do
		table.insert(a, n)
	end
	table.sort(a, f)
	local i = 0 -- iterator variable
	local iter = function() -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

-- Each next table key-values will override previous table key-values in case of conflicts
---@param ... any
function MergedTable(...)
	local result = {}
	for _, maybeTable in pairs({ ... }) do
		if type(maybeTable) == "table" then
			result = table.merged(result, maybeTable)
		end
	end
	return result
end

function table.merged(table1, table2)
	local result = {}

	for key, value in pairs(table1) do
		result[key] = value
	end
	for key, value in pairs(table2) do
		if type(value) == "table" and result[key] then
			result[key] = table.merged(result[key], value)
		else
			result[key] = value
		end
	end
	return result
end
