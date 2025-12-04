FROM python:3.12-slim

RUN apt-get update && apt-get install -y git curl sed net-tools && rm -rf /var/lib/apt/lists/* && pip --no-cache-dir install uv

WORKDIR /app

# Clone the repository
RUN git clone https://github.com/shoeper/intervals-mcp-server.git .
# 1. Install dependencies
RUN uv sync

# 3. Run using the 'mcp' CLI
CMD ["uv" ,"run", "env", "FASTMCP_HOST=0.0.0.0", "FASTMCP_PORT=8000", "MCP_TRANSPORT=http", "FASTMCP_LOG_LEVEL=INFO", "python", "src/intervals_mcp_server/server.py"]