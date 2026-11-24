# MCP 接入

- 地址：`https://mcp.aurapilot.cn/mcp`
- 协议：Streamable HTTP
- 认证：请求头 `Authorization: Bearer jdfj_...`
- 注册登录：https://jdfj.aurapilot.cn/todo
- 密钥在登录后的「开放平台 → MCP 与密钥」创建，完整内容只显示一次。

地址不要加结尾斜杠。`Bearer` 和密钥之间有一个空格。请求头的名字是 `Authorization`，不要把密钥本身当成字段名。

## WorkBuddy

在「连接器 → 自定义连接器 → 配置 MCP」里加入：

```json
{
  "mcpServers": {
    "jiedanfuji": {
      "type": "streamableHttp",
      "url": "https://mcp.aurapilot.cn/mcp",
      "headers": {
        "Authorization": "Bearer jdfj_你的密钥"
      },
      "timeout": 60000
    }
  }
}
```

保存后点刷新。第一次连接如果提示信任，点信任。连上后应能看到 4 个工具。

## Cursor

```json
{
  "mcpServers": {
    "jiedanfuji": {
      "url": "https://mcp.aurapilot.cn/mcp",
      "headers": {
        "Authorization": "Bearer jdfj_你的密钥"
      }
    }
  }
}
```

## Claude Code

```bash
claude mcp add --transport http jiedanfuji https://mcp.aurapilot.cn/mcp \
  --header "Authorization: Bearer jdfj_你的密钥"
```

生图和电脑端使用同一套积分。查询余额、任务和作品不扣积分。
