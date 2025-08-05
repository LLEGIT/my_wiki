# My Wiki

A personal Wiki.js instance powered by PostgreSQL, containerized with Docker.

## Overview

This project sets up a Wiki.js application with PostgreSQL database using Docker Compose. Wiki.js is a modern, lightweight and powerful wiki app built on Node.js.

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Make (optional, for using Makefile commands)

## Project Structure

```
my_wiki/
├── .docker/                  # Custom Docker configurations
│   ├── db/                   # PostgreSQL Dockerfile and configs
│   │   ├── Dockerfile        # Custom PostgreSQL image
│   │   └── init/             # Database initialization scripts
│   └── wiki/                 # Wiki.js Dockerfile and configs
│       ├── Dockerfile        # Custom Wiki.js image
│       ├── config/           # Custom Wiki.js configurations
│       └── scripts/          # Helper scripts (healthcheck, etc.)
├── docker-compose.yaml       # Docker services configuration
├── .env.dist                 # Environment variables template
├── .env                      # Environment variables (create from .env.dist)
├── .gitignore               # Git ignore rules
├── Makefile                 # Convenient commands
└── README.md                # This file
```

## Quick Start

1. **Clone or download this project**

2. **Configure environment variables**

   Copy the environment template and customize it:

   ```bash
   cp .env.dist .env
   ```

   Edit the `.env` file with your configuration:

   ```bash
   # Database Configuration
   DB_NAME=wiki
   DB_USER=wikijs
   DB_PASS=your_secure_password_here  # ⚠️ Change this!
   DB_HOST=db
   DB_PORT=5432

   # Wiki Service Configuration
   HOST_PORT=8080
   ```

   **Important**:

   - Change `DB_PASS` to a secure password
   - The `.env` file is ignored by git for security

3. **Build and start the services**

   Build the custom Docker images:

   ```bash
   make build
   ```

   Start the services:

   ```bash
   make run
   ```

   Or build and run in one step:

   ```bash
   docker-compose up -d --build
   ```

4. **Access your wiki**

   Open your browser and navigate to: `http://localhost:8080`

## Available Commands

The project includes a Makefile with convenient commands:

- `make build` - Build custom Docker images
- `make run` - Start all services in detached mode
- `make stop` - Stop all services
- `make clean` - Stop services and remove volumes (⚠️ **This will delete all data!**)
- `make rebuild` - Clean rebuild (stop, build from scratch, start)

## Services

### Wiki.js

- **Image**: `ghcr.io/requarks/wiki:2`
- **Port**: 8080 (configurable via `HOST_PORT` in .env)
- **Dependencies**: PostgreSQL database

### PostgreSQL Database

- **Image**: `postgres:17-alpine`
- **Port**: 5432 (internal)
- **Data**: Persisted in Docker volume `db-data`

## Configuration

### Environment Variables

All configuration is managed through the `.env` file (created from `.env.dist` template):

| Variable    | Description                   | Default Value               |
| ----------- | ----------------------------- | --------------------------- |
| `DB_NAME`   | PostgreSQL database name      | `wiki`                      |
| `DB_USER`   | PostgreSQL username           | `wikijs`                    |
| `DB_PASS`   | PostgreSQL password           | `your_secure_password_here` |
| `DB_HOST`   | Database host (service name)  | `db`                        |
| `DB_PORT`   | Database port                 | `5432`                      |
| `HOST_PORT` | External port for wiki access | `8080`                      |

**Note**: The `.env` file is git-ignored for security. Always use `.env.dist` as a template.

### Changing the Port

To change the port where Wiki.js is accessible:

1. Update `HOST_PORT` in the `.env` file
2. Restart the services: `make stop && make run`

## Customization

### Custom Docker Images

This project uses custom Dockerfiles instead of the base images directly, allowing for easy customization:

#### Database Customization (`.docker/db/`)

- **Dockerfile**: Based on `postgres:17-alpine` with additional tools
- **init/**: Database initialization scripts that run on first startup
- Add custom PostgreSQL extensions or configurations as needed

#### Wiki.js Customization (`.docker/wiki/`)

- **Dockerfile**: Based on `ghcr.io/requarks/wiki:2` with additional tools
- **config/**: Custom Wiki.js configuration files
- **scripts/**: Helper scripts including healthcheck
- Add custom themes, plugins, or configurations as needed

### Rebuilding Images

After making changes to Dockerfiles or custom configurations:

```bash
make rebuild
```

This will stop services, rebuild images from scratch, and restart everything.

## Data Persistence

The PostgreSQL database data is stored in a Docker volume named `db-data`. This ensures your wiki content persists between container restarts.

⚠️ **Warning**: Running `make clean` will remove this volume and **permanently delete all your wiki data**.

## First Time Setup

1. After starting the services, navigate to `http://localhost:8080`
2. Follow the Wiki.js setup wizard
3. Create your administrator account
4. Configure your wiki settings

## Troubleshooting

### Port Already in Use

If you get a "port already in use" error:

1. Check what's using the port:

   ```bash
   lsof -i :8080
   ```

2. Either stop the conflicting service or change `HOST_PORT` in `.env`

### Database Connection Issues

If Wiki.js can't connect to the database:

1. Ensure both services are running:

   ```bash
   docker-compose ps
   ```

2. Check the logs:
   ```bash
   docker-compose logs wiki
   docker-compose logs db
   ```

### Reset Everything

To start fresh (⚠️ **This deletes all data**):

```bash
make clean
make run
```

## Security Notes

- **Change the default password**: Update `DB_PASS` in `.env` before deploying
- **Firewall**: Ensure only necessary ports are exposed
- **Updates**: Regularly update the Docker images for security patches

## Backup

To backup your wiki data:

```bash
# Backup database
docker-compose exec db pg_dump -U wikijs wiki > wiki_backup.sql

# Backup can be restored with:
# docker-compose exec -T db psql -U wikijs wiki < wiki_backup.sql
```

## License

This project setup is provided as-is. Wiki.js is licensed under the AGPL-3.0 License.

## Support

- [Wiki.js Documentation](https://docs.requarks.io/)
- [Wiki.js GitHub Repository](https://github.com/Requarks/wiki)
- [Docker Documentation](https://docs.docker.com/)
