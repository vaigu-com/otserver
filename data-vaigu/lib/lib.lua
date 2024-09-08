-- Core API functions implemented in Lua
-- Load storages first
dofile(DATA_DIRECTORY .. "/lib/core/load.lua")

-- Compatibility library for our old Lua API
dofile(DATA_DIRECTORY .. "/lib/compat/compat.lua")

-- Tables library
dofile(DATA_DIRECTORY .. "/lib/tables/load.lua")

-- Others library
dofile(DATA_DIRECTORY .. "/lib/others/load.lua")

-- Quests library
dofile(DATA_DIRECTORY .. "/lib/quests/quest.lua")
dofile(DATA_DIRECTORY .. "/lib/quests/the_primal_ordeal.lua")

-- Vip System library
dofile(DATA_DIRECTORY .. "/lib/vip/vip_system.lua")

-- Npc generator library
dofile(DATA_DIRECTORY .. "/lib/npc/load.lua")
