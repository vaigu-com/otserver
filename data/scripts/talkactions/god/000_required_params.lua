local STRING = function(param)
	if type(param) == "string" then
		return param
	end
end
local NUMBER = function(param)
	if type(tonumber(param)) == "number" then
		return tonumber(param)
	end
end
local STRING_NUMBER = function(param)
	return NUMBER(param) or STRING(param)
end
COMMAND_REQUIRED_PARAM = {
	STRING = STRING,
	NUMBER = NUMBER,
	STRING_NUMBER = STRING_NUMBER,
}

---@class RequiredParams
---@field requiredParams RequiredParam
RequiredParams = {}
RequiredParams.__index = RequiredParams
function RequiredParams:New(...)
	local newObj = {
		requiredParams = { ... },
	}
	setmetatable(newObj, RequiredParams)
	return newObj
end
setmetatable(RequiredParams, {
	__call = function(_, ...)
		return RequiredParams:New(...)
	end,
})

---@class RequiredParam
---@field paramParser fun()
---@field description string
---@field fieldName string
RequiredParam = {}
RequiredParam.__index = RequiredParam
function RequiredParam:New(fieldName, description, paramParser)
	local newObj = {
		fieldName = fieldName,
		description = description,
		paramParser = paramParser,
	}
	setmetatable(newObj, RequiredParam)
	return newObj
end
setmetatable(RequiredParam, {
	__call = function(_, ...)
		return RequiredParam:New(...)
	end,
})

local parseStatus = {
	wordsAreNull = "wordsAreNull",
	wordsCannotBeParsed = "wordsCannotBeParsed",
	ok = "ok",
}

local unknownDescription = "unknown"
function RequiredParams:GetUsage(parsedTable, fieldsToPlayerWords)
	parsedTable = parsedTable or {}
	fieldsToPlayerWords = fieldsToPlayerWords or {}
	local usageStr = ""
	for _, requiredParam in pairs(self.requiredParams) do
		local playerWord = fieldsToPlayerWords[requiredParam.fieldName]
		local youSaidStr = "(nothing)"
		if playerWord then
			youSaidStr = playerWord
		end

		local parsedValue = parsedTable[requiredParam.fieldName]
		local parsedStr = "(nothing)"
		if parsedValue then
			parsedStr = tostring(parsedValue)
		end

		usageStr = usageStr .. T("\n:desc: || you said :youSaidStr: || parsed: :parsedStr:", { desc = requiredParam.description or unknownDescription, youSaidStr = youSaidStr, parsedStr = parsedStr })
	end
	return usageStr
end

function RequiredParams:ParsedOrSendErrorMessage(playerString, cid)
	local status, parsedTable, fieldsToPlayerWords = self:Parsed(playerString)
	if status ~= parseStatus.ok then
		Player(cid):sendTextMessage(MESSAGE_DAMAGE_DEALT, T("Could not parse your command. Status: :status:. Usage: :usage:", { status = status, usage = self:GetUsage(parsedTable, fieldsToPlayerWords) }))
		return false, parsedTable
	end
	return true, parsedTable
end

function RequiredParams:Parsed(playerWordsString)
	if not playerWordsString then
		return parseStatus.wordsAreNull
	end
	local playerWordsTable = playerWordsString:split(",")

	local status = parseStatus.ok

	local parsedTable = {}
	local fieldsToPlayerWords = {}
	for index, requiredParam in ipairs(self.requiredParams) do
		local playerWord = playerWordsTable[index]
		local parsedVal = requiredParam.paramParser(playerWord)
		fieldsToPlayerWords[requiredParam.fieldName] = playerWord
		parsedTable[requiredParam.fieldName] = parsedVal

		if not parsedVal then
			status = parseStatus.wordsCannotBeParsed
		end
	end

	if status == parseStatus.ok then
		return status, parsedTable
	else
		return status, parsedTable, fieldsToPlayerWords
	end
end
