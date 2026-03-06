
# Omni Memory Docker 🚀

这是一个为 [Omni Memory](https://github.com/original-author/omni-memory) (原作者项目) 打造的 Docker 化部署方案。

## 💡 项目初衷
LLM 的长期记忆是构建 AI 助手或进行长篇创作（如视觉小说）的核心。原项目功能强大，但缺乏开箱即用的 Docker 支持。本项目旨在：
- **简化部署**：通过 Docker 一键启动，无需理会复杂的 Python 环境配置。
- **自动同步**：通过 GitHub Actions 监控原作者代码，保持 **每日自动同步构建**（延迟 ≤ 1天），确保你永远使用的是最新功能。
- **物理隔离**：支持多实例部署（如日常助手与专业创作互不干扰）。

---

## 🛠️ 部署指南 (小白保姆级)

### 1. 准备目录结构
为了确保数据持久化，请先在宿主机（如 VPS 或 NAS）创建以下目录。建议路径：

```bash
mkdir -p /opt/1panel/docker/compose/omni-memory-docker/main/{config,data}

```

### 2. 获取配置文件模板

你需要手动创建两个核心配置文件。

#### A. endpoints.json (配置你的 API)

在 `config` 目录下创建 `endpoints.json`，填入你的 API 信息：

```json
[
  {
    "name": "your-provider",
    "url": "[https://api.example.com/v1](https://api.example.com/v1)",
    "api_key": "sk-your-key",
    "provider": "openai",
    "models": ["model-name"],
    "enabled": true
  }
]

```

#### B. memory_settings.json (配置记忆逻辑)

在同一目录下创建 `memory_settings.json`：

```json
{
  "debug_mode": false,
  "memory_mode": "builtin",
  "injection_mode": "rag",
  "summary_interval": 5,
  "rag_max_memories": 10
}

```

### 3. 使用 Docker Compose 部署

创建 `docker-compose.yml` 文件：

```yaml
services:
  omni-memory:
    image: ghcr.io/mumuer1024/omni-memory-docker:latest
    container_name: omni-memory-main
    restart: always
    ports:
      - "8080:8080"
    volumes:
      - /你的路径/config:/app/config
      - /你的路径/data:/app/data
    environment:
      - TZ=America/Los_Angeles # 请根据你的位置修改时区

```

运行启动命令：

```bash
docker compose up -d

```

---

## 🚀 进阶：多实例部署

如果你需要为不同场景（如 Claude 创作、日常助手）设置独立的记忆库，只需复制上述目录并更改宿主机端口映射即可。例如：

* 实例 A (日常): 端口 8081 -> 挂载到 `/path/to/main`
* 实例 B (创作): 端口 8082 -> 挂载到 `/path/to/project`

---

## 🔄 自动化与更新

本项目通过 GitHub Actions 实现 **子模块自动监测**。

* **自动更新频率**：每 24 小时检查一次原仓库变动。
* **镜像拉取**：当你需要升级时，只需在本地运行 `docker compose pull && docker compose up -d` 即可无损升级。

---

## ⚖️ 开源协议

本项目采用 [Apache License 2.0](https://www.google.com/search?q=LICENSE) 协议，与原项目保持一致。

## 🤝 致谢

感谢原作者对 LLM 记忆能力的卓越探索。
