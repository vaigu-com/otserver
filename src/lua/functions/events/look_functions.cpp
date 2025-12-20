#include "lua/functions/events/look_functions.hpp"

#include "lua/creature/looks.hpp"
#include "game/game.hpp"
#include "items/item.hpp"
#include "lua/functions/lua_functions_loader.hpp"

void LookFunctions::init(lua_State* L) {
	Lua::registerSharedClass(L, "Look", "", LookFunctions::luaCreateLook);
	Lua::registerMethod(L, "Look", "onLook", LookFunctions::luaLookOnLook);
	Lua::registerMethod(L, "Look", "register", LookFunctions::luaLookRegister);
	Lua::registerMethod(L, "Look", "id", LookFunctions::luaLookItemId);
	Lua::registerMethod(L, "Look", "aid", LookFunctions::luaLookActionId);
	Lua::registerMethod(L, "Look", "uid", LookFunctions::luaLookUniqueId);
	Lua::registerMethod(L, "Look", "position", LookFunctions::luaLookPosition);
	Lua::registerMethod(L, "Look", "key", LookFunctions::luaLookKey);
	Lua::registerMethod(L, "Look", "blockWalls", LookFunctions::luaLookBlockWalls);
	Lua::registerMethod(L, "Look", "checkFloor", LookFunctions::luaLookCheckFloor);
	Lua::registerMethod(L, "Look", "position", LookFunctions::luaLookPosition);
	Lua::registerMethod(L, "Look", "isRegistered", LookFunctions::luaLuaAnyEventIsRegistered);
}

int LookFunctions::luaCreateLook(lua_State* L) {
	// Look()
	auto look = std::make_shared<Look>();
	Lua::pushUserdata<Look>(L, look);
	Lua::setMetatable(L, -1, "Look");
	return 1;
}

int LookFunctions::luaLookOnLook(lua_State* L) {
	// look:onLook(callback)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		if (!look->loadScriptId()) {
			Lua::pushBoolean(L, false);
			return 1;
		}
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookRegister(lua_State* L) {
	// look:register()
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		if (!look->isLoadedScriptId()) {
			Lua::pushBoolean(L, false);
			return 1;
		}
		Lua::pushBoolean(L, g_looks().registerLuaEvent(look));
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookItemId(lua_State* L) {
	// look:id(ids)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				look->setItemIdsVector(Lua::getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			look->setItemIdsVector(Lua::getNumber<uint16_t>(L, 2));
		}
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookActionId(lua_State* L) {
	// look:aid(aids)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				look->setActionIdsVector(Lua::getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			look->setActionIdsVector(Lua::getNumber<uint16_t>(L, 2));
		}
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookUniqueId(lua_State* L) {
	// look:uid(uids)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				look->setUniqueIdsVector(Lua::getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			look->setUniqueIdsVector(Lua::getNumber<uint16_t>(L, 2));
		}
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookPosition(lua_State* L) {
	/** @brief Create look position
	 * @param positions = position or table of positions to set a look script
	 * @param itemId or @param itemName = if item id or string name is set, the item is created on position (if not exists), this variable is nil by default
	 * look:position(positions, itemId or name)
	 */
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (!look) {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
		return 1;
	}

	Position position = Lua::getPosition(L, 2);
	// The parameter "- 1" because self is a parameter aswell, which we want to skip L 1 (UserData)
	// Lua::isNumber(L, 2) is for skip the itemId
	if (int parameters = lua_gettop(L) - 1;
	    parameters > 1 && Lua::isNumber(L, 2)) {
		for (int i = 0; i < parameters; ++i) {
			look->setPositionsVector(Lua::getPosition(L, 2 + i));
		}
	} else {
		look->setPositionsVector(position);
	}

	uint16_t itemId;
	bool createItem = false;
	if (Lua::isNumber(L, 3)) {
		itemId = Lua::getNumber<uint16_t>(L, 3);
		createItem = true;
	} else if (Lua::isString(L, 3)) {
		itemId = Item::items.getItemIdByName(Lua::getString(L, 3));
		if (itemId == 0) {
			Lua::reportErrorFunc("Not found item with name: " + Lua::getString(L, 3));
			Lua::pushBoolean(L, false);
			return 1;
		}

		createItem = true;
	}

	if (createItem) {
		if (!Item::items.hasItemType(itemId)) {
			Lua::reportErrorFunc("Not found item with id: " + itemId);
			Lua::pushBoolean(L, false);
			return 1;
		}

		// If it is an item that can be removed, then it will be set as non-movable.
		ItemType &itemType = Item::items.getItemType(itemId);
		if (itemType.movable == true) {
			itemType.movable = false;
		}

		g_game().setCreateLuaItems(position, itemId);
	}

	Lua::pushBoolean(L, true);
	return 1;
}

int LookFunctions::luaLookKey(lua_State* L) {
	// look:key(keys)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				look->setKeysVector(Lua::getString(L, 2 + i));
			}
		} else {
			look->setKeysVector(Lua::getString(L, 2));
		}
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookBlockWalls(lua_State* L) {
	// look:blockWalls(bool)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		look->setCheckLineOfSight(Lua::getBoolean(L, 2));
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookCheckFloor(lua_State* L) {
	// look:checkFloor(bool)
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		look->setCheckFloor(Lua::getBoolean(L, 2));
		Lua::pushBoolean(L, true);
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLuaAnyEventIsRegistered(lua_State* L) {
	// look:isRegistered()
	const auto &look = Lua::getUserdataShared<Look>(L, 1, "Look");
	if (look) {
		Lua::pushBoolean(L, Looks::getInstance().luaAnyEventIsRegistered(look));
	} else {
		Lua::reportErrorFunc(Lua::getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		Lua::pushBoolean(L, false);
	}
	return 1;
}