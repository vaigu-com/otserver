/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#pragma once

#include "lua/scripts/luascript.hpp"

class LookFunctions final : LuaScriptInterface {
public:
	static void init(lua_State* L) {
		registerSharedClass(L, "Look", "", LookFunctions::luaCreateLook);
		registerMethod(L, "Look", "onLook", LookFunctions::luaLookOnLook);
		registerMethod(L, "Look", "register", LookFunctions::luaLookRegister);
		registerMethod(L, "Look", "id", LookFunctions::luaLookItemId);
		registerMethod(L, "Look", "aid", LookFunctions::luaLookActionId);
		registerMethod(L, "Look", "uid", LookFunctions::luaLookUniqueId);
		registerMethod(L, "Look", "position", LookFunctions::luaLookPosition);
		registerMethod(L, "Look", "blockWalls", LookFunctions::luaLookBlockWalls);
		registerMethod(L, "Look", "checkFloor", LookFunctions::luaLookCheckFloor);
		registerMethod(L, "Look", "position", LookFunctions::luaLookPosition);
	}

private:
	static int luaCreateLook(lua_State* L);
	static int luaLookOnLook(lua_State* L);
	static int luaLookRegister(lua_State* L);
	static int luaLookItemId(lua_State* L);
	static int luaLookActionId(lua_State* L);
	static int luaLookUniqueId(lua_State* L);
	static int luaLookPosition(lua_State* L);
	static int luaLookBlockWalls(lua_State* L);
	static int luaLookCheckFloor(lua_State* L);
};
