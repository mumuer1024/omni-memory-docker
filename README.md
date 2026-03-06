# Omni Memory Docker

这是一个为 [Omni Memory](原作者仓库链接) 项目封装的 Docker 镜像，旨在简化部署流程。

## 特性
- **一键部署**：支持多实例物理隔离（如日常助手与专业创作分开）。
- **思维链支持**：自动识别并保留 `reasoning_content`，完美适配 Pro 级别模型。
- **配置持久化**：通过挂载外部目录，确保记忆数据不丢失。

## 快速开始

### 1. 配置
在宿主机创建配置目录，并参考原项目配置 `endpoints.json`。

### 2. 部署 (示例)
```bash
docker run -d \
  --name omni-memory \
  -p 8080:8080 \
  -v /你的路径/config:/app/config \
  -v /你的路径/data:/app/data \
  ghcr.io/mumuer1024/omni-memory:latest
