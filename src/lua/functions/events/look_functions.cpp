#include "pch.hpp"

#include "lua/creature/looks.hpp"
#include "lua/functions/events/look_functions.hpp"
#include "game/game.hpp"
#include "items/item.hpp"

int LookFunctions::luaCreateLook(lua_State* L) {
	// Look()
	auto look = std::make_shared<Look>(getScriptEnv()->getScriptInterface());
	pushUserdata<Look>(L, look);
	setMetatable(L, -1, "Look");
	return 1;
}

int LookFunctions::luaLookOnLook(lua_State* L) {
	// look:onLook(callback)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		if (!action->loadCallback()) {
			pushBoolean(L, false);
			return 1;
		}
		action->setLoadedCallback(true);
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookRegister(lua_State* L) {
	// look:register()
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		if (!action->isLoadedCallback()) {
			pushBoolean(L, false);
			return 1;
		}
		pushBoolean(L, g_looks().registerLuaEvent(action));
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookItemId(lua_State* L) {
	// look:id(ids)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				action->setItemIdsVector(getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			action->setItemIdsVector(getNumber<uint16_t>(L, 2));
		}
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookActionId(lua_State* L) {
	// look:aid(aids)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				action->setActionIdsVector(getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			action->setActionIdsVector(getNumber<uint16_t>(L, 2));
		}
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookUniqueId(lua_State* L) {
	// look:uid(uids)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		int parameters = lua_gettop(L) - 1; // - 1 because self is a parameter aswell, which we want to skip ofc
		if (parameters > 1) {
			for (int i = 0; i < parameters; ++i) {
				action->setUniqueIdsVector(getNumber<uint16_t>(L, 2 + i));
			}
		} else {
			action->setUniqueIdsVector(getNumber<uint16_t>(L, 2));
		}
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookPosition(lua_State* L) {
	/** @brief Create action position
	 * @param positions = position or table of positions to set a action script
	 * @param itemId or @param itemName = if item id or string name is set, the item is created on position (if not exists), this variable is nil by default
	 * action:position(positions, itemId or name)
	 */
	const auto action = getUserdataShared<Look>(L, 1);
	if (!action) {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
		return 1;
	}

	Position position = getPosition(L, 2);
	// The parameter "- 1" because self is a parameter aswell, which we want to skip L 1 (UserData)
	// isNumber(L, 2) is for skip the itemId
	if (int parameters = lua_gettop(L) - 1;
	    parameters > 1 && isNumber(L, 2)) {
		for (int i = 0; i < parameters; ++i) {
			action->setPositionsVector(getPosition(L, 2 + i));
		}
	} else {
		action->setPositionsVector(position);
	}

	uint16_t itemId;
	bool createItem = false;
	if (isNumber(L, 3)) {
		itemId = getNumber<uint16_t>(L, 3);
		createItem = true;
	} else if (isString(L, 3)) {
		itemId = Item::items.getItemIdByName(getString(L, 3));
		if (itemId == 0) {
			reportErrorFunc("Not found item with name: " + getString(L, 3));
			pushBoolean(L, false);
			return 1;
		}

		createItem = true;
	}

	if (createItem) {
		if (!Item::items.hasItemType(itemId)) {
			reportErrorFunc("Not found item with id: " + itemId);
			pushBoolean(L, false);
			return 1;
		}

		// If it is an item that can be removed, then it will be set as non-movable.
		ItemType &itemType = Item::items.getItemType(itemId);
		if (itemType.movable == true) {
			itemType.movable = false;
		}

		g_game().setCreateLuaItems(position, itemId);
	}

	pushBoolean(L, true);
	return 1;
}

int LookFunctions::luaLookBlockWalls(lua_State* L) {
	// look:blockWalls(bool)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		action->setCheckLineOfSight(getBoolean(L, 2));
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}

int LookFunctions::luaLookCheckFloor(lua_State* L) {
	// look:checkFloor(bool)
	const auto action = getUserdataShared<Look>(L, 1);
	if (action) {
		action->setCheckFloor(getBoolean(L, 2));
		pushBoolean(L, true);
	} else {
		reportErrorFunc(getErrorDesc(LUA_ERROR_ACTION_NOT_FOUND));
		pushBoolean(L, false);
	}
	return 1;
}
