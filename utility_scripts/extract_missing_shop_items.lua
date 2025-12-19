------------------------------------------------------------
-- shop_splitter.lua
-- Aggregates NPC shop items, merges by clientId, categories via items.xml,
-- splits into category files and writes them to .\utility_scripts\shops\
------------------------------------------------------------

-- CONFIG
local npcNamesFile = "utility_scripts\\creature_product_npc_names.txt"
local baseShopFile = "data-vaigu\\scripts\\quests\\_vaigu\\npc_jobs\\009_job_shop.lua"
local npcPath = ".\\data-vaigu\\npc\\real\\"
local itemsXmlPath = "data\\items\\items.xml"
local outDir = ".\\utility_scripts\\shops\\"

-- equipment categories (go into equipment.lua)
local equipmentCategories = {
	["legs"] = true,
	["helmets"] = true,
	["armors"] = true,
	["boots"] = true,
	["amulets and necklaces"] = true,
	["rings"] = true,
	["sword"] = true,
	["axe"] = true,
	["club"] = true,
	["mace"] = true,
	["shield"] = true,
}

-- standalone categories (each gets its own file name = category with spaces -> _)
local extraCategories = {
	"valuables",
	"creature products",
	"food",
	"plants and herbs",
	"furniture",
	"exercise weapons",
	-- newly requested categories:
	"trophies",
	"attack runes",
	"support runes",
	"tools",
	"dolls and bears",
	"musical instruments",
	"containers",
	"fluid containers",
}

-- UTIL
local function readFile(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local c = f:read("*a")
	f:close()
	return c
end

local function writeFile(path, data)
	local f = io.open(path, "w")
	if not f then
		error("Failed to open for writing: " .. tostring(path))
	end
	f:write(data)
	f:close()
end

local function normalizeName(name)
	return name:lower():gsub("%s+", "_")
end

local function trim(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end

-- READ NPC NAMES
local npcNames = {}
do
	local content = readFile(npcNamesFile)
	if content then
		for line in content:gmatch("[^\r\n]+") do
			line = trim(line)
			if line ~= "" then
				table.insert(npcNames, line)
			end
		end
	end
end

-- DATA STRUCTURES
-- items_by_client[clientId] = { itemName=..., clientId=..., lowestBuy=?, highestSell=?, sourceNames = { ... } }
local items_by_client = {}
-- base flags to skip
local base = { buy = {}, sell = {} }
-- items.xml mappings
local xml_primarytype = {} -- id -> primarytype (string lowercased)
local xml_weapontype = {} -- id -> weaponType (string lowercased)
local xml_name = {} -- id -> canonical name from items.xml

-- PARSE items.xml to populate xml_primarytype, xml_weapontype, xml_name
do
	local xml = readFile(itemsXmlPath)
	if xml then
		-- Grab <item ...> blocks (will also capture <item .../> single-line: handle both)
		for itemTag in xml:gmatch("<item%s+([^>/]-)/?>%s*") do
			-- itemTag contains attributes and possibly inner attributes; we will try to extract id and name
			local id = itemTag:match('id%s*=%s*"(%-?%d+)"')
			local nameAttr = itemTag:match('name%s*=%s*"([^"]+)"')
			if id then
				local iid = tonumber(id)
				if nameAttr then
					xml_name[iid] = nameAttr
				end

				-- try to find primarytype attribute inside the full item block
				-- To capture inner <attribute key="primarytype" value="..."/> we need to extract the whole <item ...>...</item> block
				-- We'll search in the full xml for the actual <item ...>...</item> block by id to find nested attributes
				local pattern = ('<item[^>]-id%s*=%s*"%s*%d+%s*".-</item>'):gsub("%s+", "%%s+")
				-- Simpler: find the <item ...>...</item> block by locating '<item' with id and reading until '</item>'
				local blockPattern = '<item[^>]-id%s*=%s*"' .. id .. '"(.-)</item>'
				local block = xml:match(blockPattern)
				if not block then
					-- maybe it's self-closing <item .../>
					block = ""
				end

				-- find primarytype attribute as nested element <attribute key="primarytype" value="..."/>
				local primary = block:match('key%s*=%s*"primarytype"%s+value%s*=%s*"([^"]+)"')
				if primary then
					xml_primarytype[iid] = trim(primary):lower()
				end

				-- weaponType may appear as '<attribute key="weaponType" value="sword"/>' either nested or as attribute in tag
				local weaponInBlock = block:match('key%s*=%s*"weaponType"%s+value%s*=%s*"([^"]+)"')
				if weaponInBlock then
					xml_weapontype[iid] = trim(weaponInBlock):lower()
				end

				-- sometimes weaponType is an attribute in the <item ...> tag itself:
				local weaponInTag = itemTag:match('weaponType%s*=%s*"([^"]+)"')
				if weaponInTag and not xml_weapontype[iid] then
					xml_weapontype[iid] = trim(weaponInTag):lower()
				end

				-- fallback: some items encode weaponType inside script attributes; try to match 'weaponType' anywhere in the full item block
				if not xml_weapontype[iid] and block ~= "" then
					local wt = block:match('weaponType"%s*%>%s*([^<]+)<') -- unlikely; keep simple
					if wt then
						xml_weapontype[iid] = trim(wt):lower()
					end
				end
			end
		end
	end
end

-- HELPER: ensure we have canonical itemName for clientId (prefer items.xml name)
local function ensure_item_entry(vendorItemName, clientId, buy, sell)
	local e = items_by_client[clientId]
	if not e then
		local canonical = xml_name[clientId] or vendorItemName or ("id_" .. tostring(clientId))
		e = {
			itemName = canonical,
			clientId = clientId,
			lowestBuy = nil,
			highestSell = nil,
			sourceNames = {},
		}
		items_by_client[clientId] = e
	end

	-- record vendor-provided name for reference (not used for uniqueness)
	if vendorItemName then
		table.insert(e.sourceNames, vendorItemName)
	end

	if buy then
		if not e.lowestBuy or buy < e.lowestBuy then
			e.lowestBuy = buy
		end
	end
	if sell then
		if not e.highestSell or sell > e.highestSell then
			e.highestSell = sell
		end
	end
end

-- PARSE shop file content: extract blocks like { itemName = "...", clientId = 1234, buy = 5, sell = 10 }
local function parseShopFile(content, intoBase)
	for block in content:gmatch("{(.-)}") do
		local itemName = block:match('itemName%s*=%s*"([^"]+)"')
		local clientId = block:match("clientId%s*=%s*(%d+)")
		if itemName and clientId then
			clientId = tonumber(clientId)
			local buy = block:match("buy%s*=%s*(%d+)")
			local sell = block:match("sell%s*=%s*(%d+)")
			buy = buy and tonumber(buy)
			sell = sell and tonumber(sell)
			if intoBase then
				if buy then
					base.buy[clientId] = true
				end
				if sell then
					base.sell[clientId] = true
				end
			else
				ensure_item_entry(itemName, clientId, buy, sell)
			end
		end
	end
end

-- LOAD base.lua
do
	local baseContent = readFile(baseShopFile)
	if baseContent then
		parseShopFile(baseContent, true)
	end
end

-- LOAD NPC shop files
for _, npc in ipairs(npcNames) do
	local normalized = normalizeName(npc)
	local path = npcPath .. normalized .. ".lua"
	local content = readFile(path)
	if content then
		parseShopFile(content, false)
	end
end

-- Now determine category for each clientId using xml_primarytype or xml_weapontype fallback
local function detect_category_for_client(clientId)
	local p = xml_primarytype[clientId]
	if p and p ~= "" then
		return p:lower()
	end
	local w = xml_weapontype[clientId]
	if w and w ~= "" then
		-- weaponType often is 'sword', 'club', 'mace', etc.
		return w:lower()
	end
	return nil
end

-- Prepare category files map
local category_files = {}
-- equipment file
category_files["equipment"] = {}
-- standalone & extra categories (ensure keys exist)
for _, c in ipairs(extraCategories) do
	local k = c:gsub(" ", "_")
	category_files[k] = {}
end
-- also include earlier common categories (valuables, creature products etc) in case not listed in extraCategories
local commonCats = { "valuables", "creature products", "food", "plants and herbs", "furniture", "exercise weapons" }
for _, c in ipairs(commonCats) do
	local k = c:gsub(" ", "_")
	category_files[k] = category_files[k] or {}
end
-- misc
category_files["misc"] = {}

-- Collect items grouped by category (we'll also keep a sorted list per category)
local categorized_items = {}
for clientId, e in pairs(items_by_client) do
	local cat = detect_category_for_client(clientId)
	if cat then
		cat = trim(cat):lower()
	end

	local outKey
	if cat and equipmentCategories[cat] then
		outKey = "equipment"
	elseif cat then
		local candidate = cat:gsub("%s+", "_")
		if category_files[candidate] then
			outKey = candidate
		else
			-- not in known categories list, create file for it dynamically
			category_files[candidate] = category_files[candidate] or {}
			outKey = candidate
		end
	else
		outKey = "misc"
	end

	categorized_items[outKey] = categorized_items[outKey] or {}
	table.insert(categorized_items[outKey], e)
end

-- Sorting helper: case-insensitive by itemName (use canonical name)
local function cmp_itemname(a, b)
	local na = (a.itemName or ""):lower()
	local nb = (b.itemName or ""):lower()
	if na == nb then
		return a.clientId < b.clientId
	end
	return na < nb
end

-- For each category, sort items by name, then build output lines (buys first, sells second)
for cat, list in pairs(categorized_items) do
	table.sort(list, cmp_itemname)
	local buy_lines = {}
	local sell_lines = {}
	for _, e in ipairs(list) do
		-- skip entries that base.lua already defines
		if e.lowestBuy and not base.buy[e.clientId] then
			table.insert(buy_lines, string.format('    { itemName = "%s", clientId = %d, buy = %d },', e.itemName, e.clientId, e.lowestBuy))
		end
		if e.highestSell and not base.sell[e.clientId] then
			table.insert(sell_lines, string.format('    { itemName = "%s", clientId = %d, sell = %d },', e.itemName, e.clientId, e.highestSell))
		end
	end

	-- concatenate buys first (alphabetically), then sells (alphabetically)
	local out_lines = {}
	for _, l in ipairs(buy_lines) do
		table.insert(out_lines, l)
	end
	for _, l in ipairs(sell_lines) do
		table.insert(out_lines, l)
	end

	category_files[cat] = out_lines
end

-- Ensure categories with no items still produce an empty file (if desired)
for k, _ in pairs(category_files) do
	category_files[k] = category_files[k] or {}
end

-- WRITE FILES to outDir
-- os.execute("mkdir " .. outDir)
for filename, lines in pairs(category_files) do
	local text = { "return {" }
	for _, l in ipairs(lines) do
		table.insert(text, l)
	end
	table.insert(text, "}")
	local outpath = outDir .. filename .. ".lua"
	writeFile(outpath, table.concat(text, "\n"))
end

print("Done: category files written to " .. outDir)
