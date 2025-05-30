/**
 * Canary - A free and open-source MMORPG server emulator
 * Copyright (©) 2019-2024 OpenTibiaBR <opentibiabr@outlook.com>
 * Repository: https://github.com/opentibiabr/canary
 * License: https://github.com/opentibiabr/canary/blob/main/LICENSE
 * Contributors: https://github.com/opentibiabr/canary/graphs/contributors
 * Website: https://docs.opentibiabr.com/
 */

#include "canary_server.hpp"
#include "lib/di/container.hpp"

#include <sys/wait.h>

int main() {
	asio::io_context io_context;
	asio::signal_set signals(io_context, SIGCHLD);
	signals.async_wait([&signals](const std::error_code& error, int signal_number) {
		while (waitpid(-1, nullptr, WNOHANG) > 0) {}  // Reap zombies
		// Re-register for next SIGCHLD
		signals.async_wait([&signals](const std::error_code& error, int signal_number) {
			while (waitpid(-1, nullptr, WNOHANG) > 0) {}
		});
	});

	// Run io_context in background
	asio::executor_work_guard<asio::io_context::executor_type> work_guard(io_context.get_executor());
	std::thread io_thread([&io_context]() { io_context.run(); });
	io_thread.detach();  // Let it run independently

	// Continue with your server
	return inject<CanaryServer>().run();
}