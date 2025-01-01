Based on https://github.com/opentibiabr/canary

## Contributing

### Requirements

* linux host (other hosts not tested)
* VSCode (other IDEs not tested)
* IDE-specific devcontainers extension
* docker

### Development setup (VSCode)

> [!TIP]
> execute all commands from repository root

* start database and login server:
```
docker compose -f docker/docker-compose.dev.yml up
```
* open vscode in this repository
* open command search (`Ctrl+Shift+P`) and choose `>Dev Containers: Rebuild and Reopen in Container`
* once everything finishes loading (likely a couple of minutes), open new terminal and start the server:
```
./start_dev.sh
```

### Running in production

TODO: Add detailed steps for running the production instance.