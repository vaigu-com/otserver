/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "lua/scripts/scripts.hpp"

#include "lib/di/container.hpp"
#include "config/configmanager.hpp"
#include "creatures/combat/spells.hpp"
#include "creatures/monsters/monsters.hpp"
#include "items/weapons/weapons.hpp"
#include "lua/callbacks/events_callbacks.hpp"
#include "lua/creature/creatureevent.hpp"
#include "lua/creature/movement.hpp"
#include "lua/creature/talkaction.hpp"
#include "lua/global/globalevent.hpp"

Scripts::Scripts() :
	scriptInterface("Scripts Interface") {
	scriptInterface.initState();
}

Scripts &Scripts::getInstance() {
	static Scripts instance;
	return instance;
}

void Scripts::clearAllScripts() const {
	g_actions().clear();
	g_creatureEvents().clear();
	g_talkActions().clear();
	g_globalEvents().clear();
	g_spells().clear();
	g_moveEvents().clear();
	g_weapons().clear();
	g_callbacks().clear();
	g_monsters().clear();
}

bool Scripts::loadEventSchedulerScripts(const std::string &fileName) {
	auto coreFolder = g_configManager().getString(CORE_DIRECTORY);
	const auto dir = std::filesystem::current_path() / coreFolder / "events" / "scripts" / "scheduler";
	if (!std::filesystem::exists(dir) || !std::filesystem::is_directory(dir)) {
		g_logger().warn("{} - Can not load folder 'scheduler' on {}/events/scripts'", __FUNCTION__, coreFolder);
		return false;
	}

	const std::filesystem::recursive_directory_iterator endit;
	for (std::filesystem::recursive_directory_iterator it(dir); it != endit; ++it) {
		if (std::filesystem::is_regular_file(*it) && it->path().extension() == ".lua") {
			if (it->path().filename().string() == fileName) {
				if (scriptInterface.loadFile(it->path().string(), it->path().filename().string()) == -1) {
					g_logger().error(it->path().string());
					g_logger().error(scriptInterface.getLastLuaError());
					continue;
				}
				return true;
			}
		}
	}

	return false;
}

// Function to validate the directory path
bool validateDirectory(const std::filesystem::path &dir, const std::string_view loadPath) {
	if (!std::filesystem::exists(dir) || !std::filesystem::is_directory(dir)) {
		g_logger().error("Cannot load folder {}", loadPath);
		return false;
	}
	return true;
}

// Function to collect Lua files in a directory
std::vector<std::filesystem::path> collectLuaFiles(const std::filesystem::path &dir) {
	std::vector<std::filesystem::path> luaFiles;
	for (const auto &entry : std::filesystem::recursive_directory_iterator(dir)) {
		const auto &path = entry.path();
		if (std::filesystem::is_regular_file(path) && path.extension() == ".lua") {
			luaFiles.push_back(path);
		}
	}
	return luaFiles;
}

// Function to process files and return a vector of successfully loadable files
std::vector<std::filesystem::path> processFiles(
	const std::vector<std::filesystem::path> &files,
	bool isLib,
	bool isReload,
	LuaScriptInterface &scriptInterface
) {
	std::vector<std::filesystem::path> successfullyLoadedFiles;
	std::string lastDirectory;

	for (const auto &file : files) {
		const auto realPath = file;
		std::string fileFolder = realPath.parent_path().filename().string();
		std::string scriptFolder = realPath.parent_path().string();

		// Skip files starting with "#"
		if (file.filename().string().front() == '#') {
			if (g_configManager().getBoolean(SCRIPTS_CONSOLE_LOGS)) {
				g_logger().info("[script]: {} [disabled]", realPath.filename().string());
			}
			continue;
		}

		// Log folder and attempt to load file
		if (isLib || (fileFolder != "lib" && fileFolder != "events")) {
			if (g_configManager().getBoolean(SCRIPTS_CONSOLE_LOGS)) {
				if (lastDirectory.empty() || lastDirectory != scriptFolder) {
					lastDirectory = scriptFolder;
					g_logger().info("Loading folder: [{}]", realPath.parent_path().filename().string());
				}
			}

			// Add successfully loaded file to the list
			successfullyLoadedFiles.push_back(realPath);
		}
	}

	return successfullyLoadedFiles;
}

// Function to sort files alphabetically
void sortFilesAlphabetically(std::vector<std::filesystem::path> &files) {
	std::sort(files.begin(), files.end(), [](const std::filesystem::path &a, const std::filesystem::path &b) {
		return a.filename().string() < b.filename().string();
	});
}

// Function to run all loadable files
void runFiles(const std::vector<std::filesystem::path> &files, bool isReload, LuaScriptInterface &scriptInterface) {
	for (const auto &file : files) {
		const auto realPath = file;
		// Try to load file
		if (scriptInterface.loadFile(realPath.string(), realPath.filename().string()) == -1) {
			g_logger().error(realPath.string());
			g_logger().error(scriptInterface.getLastLuaError());
			continue;
		}

		// Log successful load or reload
		if (g_configManager().getBoolean(SCRIPTS_CONSOLE_LOGS)) {
			g_logger().info("[script {}]: {}", isReload ? "reloaded" : "loaded", realPath.filename().string());
		}
	}
}

// Vaigu custom
// Main function
bool Scripts::loadScripts(std::string_view loadPath, bool isLib, bool isReload) {
	const auto dir = std::filesystem::current_path() / loadPath;

	// Validate directory
	if (!validateDirectory(dir, loadPath)) {
		return false;
	}

	// Step 1: Collect Lua files
	auto luaFiles = collectLuaFiles(dir);

	// Step 2: Process files to determine which are loadable
	auto successfullyLoadedFiles = processFiles(luaFiles, isLib, isReload, scriptInterface);

	// Step 3: Sort successfully loaded files alphabetically
	sortFilesAlphabetically(successfullyLoadedFiles);

	// Step 4: Run sorted files
	runFiles(successfullyLoadedFiles, isReload, scriptInterface);

	return true;
}
