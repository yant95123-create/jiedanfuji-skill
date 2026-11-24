#!/usr/bin/env bash
# 确认接单副驾 MCP 是否在线。设置 JIEDANFUJI_API_KEY 后会再用这把密钥做一次初始化。
set -euo pipefail

URL="${JIEDANFUJI_MCP_URL:-https://mcp.aurapilot.cn/mcp}"
BODY='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2025-03-26","capabilities":{},"clientInfo":{"name":"jiedanfuji-skill","version":"1.0.0"}}}'

probe() {
  curl -sS --max-time 20 -X POST "$URL" \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    "$@" \
    --data "$BODY"
}

echo "检查 ${URL}"
unauth="$(probe -w $'\n%{http_code}' -o /tmp/jiedanfuji-mcp-body.txt || true)"
code="${unauth##*$'\n'}"
if [[ "$code" == "401" ]]; then
  echo "服务在线。未带密钥时会拒绝访问，这是预期结果。"
else
  echo "没有连上，HTTP ${code:-无响应}。" >&2
  exit 1
fi

if [[ -z "${JIEDANFUJI_API_KEY:-}" ]]; then
  echo "未设置 JIEDANFUJI_API_KEY，跳过密钥检查。"
  exit 0
fi

auth_code="$(probe -H "Authorization: Bearer ${JIEDANFUJI_API_KEY}" -o /tmp/jiedanfuji-mcp-auth.txt -w '%{http_code}')"
if [[ "$auth_code" != "200" ]]; then
  echo "密钥没有通过，HTTP ${auth_code}。请到开放平台确认这把密钥仍可用。" >&2
  exit 1
fi
if ! grep -q '"serverInfo"' /tmp/jiedanfuji-mcp-auth.txt; then
  echo "密钥请求有响应，但不是预期的初始化结果。" >&2
  exit 1
fi
echo "密钥可用，MCP 已完成初始化。"
