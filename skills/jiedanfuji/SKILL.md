---
name: jiedanfuji
description: 使用接单副驾的积分、AI 生图、任务状态和作品列表。用户要求用接单副驾出图、查积分或取回生成结果时使用。
---

# 接单副驾

通过已经配置好的 MCP 服务 `jiedanfuji` 调用。地址是 `https://mcp.aurapilot.cn/mcp`。认证用用户自己的 Bearer API Key。不要在仓库、提示词或日志里写下完整密钥。

如果这个 MCP 还没连上，先按 `references/mcp.md` 配置，不要改用别的画图工具冒充接单副驾。

## 工具

- `get_credit_balance`：查询当前密钥所属账号的积分和即将过期积分。不扣积分。
- `generate_image`：创建生图任务。必须带 `prompt` 和 `requestId`。马上返回 `taskId`，这时图片还没画完。
- `get_task_status`：用 `taskId` 查询。`status` 为 `done` 时读取 `imageUrl`。`failed` 时把 `errorMessage` 告诉用户，不要自动换请求号重画。
- `list_assets`：列出这个账号最近的生图作品。地址是短期链接。

## 生图顺序

1. 先确认用户要接单副驾来画，而不是本地画图工具。
2. 调用 `generate_image`。`requestId` 用新的 8 到 64 位字母、数字、下划线或短横线。同一张图重试不要换请求号。
3. 用 `get_task_status` 查询，直到 `done` 或 `failed`。生成常常要一两分钟，间隔几秒再查，查询本身不扣积分。
4. 把完成后的图片地址交给用户，并说明本次扣除的积分。积分不足、密钥停用或超过限额时，停止重试并说明原因。

比例可选 `1:1`、`3:4`、`4:3`、`2:3`、`3:2`、`9:16`、`16:9`。模型用 `gpt` 或 `studio`，不填就是 `gpt`。细节见 `references/image-generation.md` 和 `references/billing.md`。
