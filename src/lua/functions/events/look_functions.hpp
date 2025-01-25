/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

class LookFunctions {
public:
	static void init(lua_State* L);

private:
	static int luaCreateLook(lua_State* L);
	static int luaLookOnLook(lua_State* L);
	static int luaLookRegister(lua_State* L);
	static int luaLookItemId(lua_State* L);
	static int luaLookActionId(lua_State* L);
	static int luaLookUniqueId(lua_State* L);
	static int luaLookPosition(lua_State* L);
	static int luaLookKey(lua_State* L);
	static int luaLookBlockWalls(lua_State* L);
	static int luaLookCheckFloor(lua_State* L);
};
