# 密钥

在接单副驾电脑端打开「开放平台」，创建一把 API Key。完整密钥只显示一次，只放到客户端的 MCP 请求头里。

请求头格式：

```text
Authorization: Bearer jdfj_你的密钥
```

密钥以 `jdfj_` 开头。停用或删除后，下一次调用立即失效。每把密钥可以选择这些权限：

| 权限 | 对应工具 |
| --- | --- |
| `balance:read` | `get_credit_balance` |
| `image:write` | `generate_image` |
| `task:read` | `get_task_status` |
| `asset:read` | `list_assets` |

没有对应权限时，工具会返回 `forbidden`。不要把密钥写进 Git 仓库、Skill 文件、截图或对话记录。泄露后在开放平台停用，再新建一把。

检查连通时可以临时在终端设置 `JIEDANFUJI_API_KEY`，用完即关掉该终端。脚本不会把密钥打出来。
