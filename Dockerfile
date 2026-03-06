FROM python:3.10-slim

# 设置工作目录
WORKDIR /app

# 设置环境变量，确保 Python 输出直接打印到日志
ENV PYTHONUNBUFFERED=1

# 复制子模块中的源码到容器
# 注意：我们之前把源码关联到了 src 文件夹
COPY src/ .

# 安装依赖
RUN pip install --no-cache-dir -r requirements.txt

# 暴露 Omni Memory 默认的 8080 端口
EXPOSE 8080

# 启动程序
CMD ["python", "main.py"]
