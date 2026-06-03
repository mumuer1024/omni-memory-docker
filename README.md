# Omni Memory Docker 🚀

English | [中文](README_zh.md)

A Dockerized deployment solution for [Omni Memory](https://github.com/original-author/omni-memory).

## 💡 Why This Project?

Long-term memory for LLMs is essential for building AI assistants or long-form creative work (e.g. visual novels). The original project is powerful but lacks out-of-the-box Docker support. This project aims to:

- **Simplify deployment** — One-command Docker startup, no Python environment headaches.
- **Auto-sync** — GitHub Actions monitors the upstream repo and triggers **daily automated builds** (delay ≤ 1 day), so you always run the latest features.
- **Instance isolation** — Supports multi-instance deployment (e.g. daily assistant vs. creative writing, fully independent).

---

## 🛠️ Deployment Guide

### 1. Create Directory Structure

For data persistence, create the following directories on your host (VPS, NAS, etc.):

```bash
mkdir -p /opt/1panel/docker/compose/omni-memory-docker/main/{config,data}
```

### 2. Configuration Files

You need to manually create two core config files.

#### A. endpoints.json (API Configuration)

Create `endpoints.json` inside the `config` directory with your API info:

```json
[
  {
    "name": "your-provider",
    "url": "https://api.example.com/v1",
    "api_key": "sk-your-key",
    "provider": "openai",
    "models": ["model-name"],
    "enabled": true
  }
]
```

#### B. memory_settings.json (Memory Logic)

Create `memory_settings.json` in the same directory:

```json
{
  "debug_mode": false,
  "memory_mode": "builtin",
  "injection_mode": "rag",
  "summary_interval": 5,
  "rag_max_memories": 10
}
```

### 3. Deploy with Docker Compose

Create a `docker-compose.yml` file:

```yaml
services:
  omni-memory:
    image: ghcr.io/mumuer1024/omni-memory-docker:latest
    container_name: omni-memory-main
    restart: always
    ports:
      - "8080:8080"
    volumes:
      - /your/path/config:/app/config
      - /your/path/data:/app/data
    environment:
      - TZ=America/Los_Angeles # Adjust to your timezone
```

Start the service:

```bash
docker compose up -d
```

---

## 🚀 Advanced: Multi-Instance Deployment

To set up independent memory stores for different scenarios (e.g. creative writing, daily assistant), simply duplicate the directory and change the host port mapping. For example:

- Instance A (Daily): port 8081 → mounted to `/path/to/main`
- Instance B (Creative): port 8082 → mounted to `/path/to/project`

---

## 🔄 Automation & Updates

This project uses GitHub Actions for **automated submodule monitoring**.

- **Auto-update frequency**: Checks upstream changes every 24 hours.
- **Image pull**: To upgrade, simply run `docker compose pull && docker compose up -d` for a seamless update.

---

## ⚖️ License

This project is licensed under the [Apache License 2.0](LICENSE), consistent with the upstream project.

## 🤝 Acknowledgements

Thanks to the original author for their excellent exploration of LLM memory capabilities.
