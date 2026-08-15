# VNS 2024 Team 14 - Local TaskFlow App

Modernized local ToDo web application running with Docker containers.

## What is this project?

This repository contains a CGI-based web application with:

- Login and registration
- Session handling with Redis
- Task management (create, list, edit, delete)
- MariaDB persistence
- Apache CGI runtime
- Modernized UI for auth and task pages

The app is designed to run locally and fully offline (after images are built).

## Tech stack

- Apache 2 + CGI Bash scripts
- MariaDB
- Redis
- Docker (WSL environment on Windows)
- HTML/CSS/JavaScript frontend

## Architecture

Main runtime services:

- `apache1` (port `8081`) - web frontend + CGI endpoints
- `apache2` (port `8082`) - additional Apache node
- `apache3` (port `8083`) - additional Apache node
- `mariadb` - relational data store (`todo_app`)
- `redis` - session store + list cache

Network:

- Docker bridge network `mynet` (`172.27.0.0/16`)

## Project structure (important parts)

- `docker-final/docker-apache/context/html/index.html` - modern login/registration UI
- `docker-final/docker-apache/context/cgi-bin/vns/todo/` - CGI scripts
- `docker-final/docker-mariadb/context/myinit.sh` - DB initialization
- `docker-final/docker-redis/context/` - Redis config/init
- `docker-final/docker-*/bin/` - build/start/stop scripts per service

## Prerequisites

- Windows with WSL installed
- Docker available inside WSL (`docker --version` works)
- Git

## Quick start (recommended)

Run from WSL:

```bash
cd /mnt/c/Users/User/portfolio_run/vns-2024-team14/docker-final

# optional cleanup from old runs
docker rm -f mariadb redis apache1 apache2 apache3 haproxy work 2>/dev/null || true
docker network rm mynet 2>/dev/null || true

# create network
./general/create-mynet-network.sh

# build and start required services
(cd docker-mariadb && ./bin/build.sh && ./bin/start.sh)
(cd docker-redis && ./bin/build.sh && ./bin/start.sh)
(cd docker-apache && ./bin/build.sh && ./bin/start.sh)
```

Open app:

- `http://localhost:8081/index.html`

## Login and registration

Default seeded account:

- username: `admin`
- password: `admin`

You can also create a new account from the `Registrierung` tab.

## API/CGI endpoints (apache)

Base path: `/cgi-bin/vns/todo/`

- `login.sh` - user login
- `register.sh` - user registration
- `logout.sh` - session logout
- `table3.sh` - task page render
- `addTodo.sh` - create task (requires session)
- `editTodo.sh` - update task (requires session)
- `deleteTodo.sh` - delete task (requires session)

## Stop services

```bash
cd /mnt/c/Users/User/portfolio_run/vns-2024-team14/docker-final

docker rm -f apache1 apache2 apache3 redis mariadb
# optional
docker network rm mynet
```

## Troubleshooting

### 1) Login fails immediately

Check containers:

```bash
docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
```

You should see `apache1`, `redis`, and `mariadb` running.

### 2) Page still shows old UI

Use hard refresh in browser (`Ctrl+F5`) or open with cache-buster:

- `http://localhost:8081/index.html?v=2`

### 3) Port conflict on 8081/8082/8083

Stop conflicting process or change apache start script mappings.

### 4) Docker command not found in PowerShell

Run commands via WSL terminal where Docker CLI is configured.

## Security note

This project is educational. Basic hardening was added (session checks and safer parsing/escaping), but production-grade security (strong password hashing, CSRF protection, full input policy, prepared statements in another runtime) is still recommended for real-world deployment.

## Development notes

If you update CGI scripts or UI files, rebuild Apache image and restart apache containers:

```bash
cd /mnt/c/Users/User/portfolio_run/vns-2024-team14/docker-final/docker-apache
./bin/build.sh
docker rm -f apache1 apache2 apache3
./bin/start.sh
```

That is enough to reflect frontend/CGI changes.
