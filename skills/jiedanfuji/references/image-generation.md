# 生图

`generate_image` 提交任务后立刻返回，画面在后台生成。用返回的 `taskId` 调用 `get_task_status`，直到 `done` 或 `failed`。

## 参数

| 字段 | 要求 |
| --- | --- |
| `prompt` | 要画的内容，1 到 2000 字 |
| `requestId` | 8 到 64 位字母、数字、下划线或短横线。同一把密钥下相同请求号不会再次扣费 |
| `aspectRatio` | `1:1`、`3:4`、`4:3`、`2:3`、`3:2`、`9:16`、`16:9`。不填是 `1:1` |
| `model` | `gpt` 或 `studio`。不填是 `gpt` |

`gpt` 走电脑端默认生图。`studio` 走更高一档的模型，积分更高。

## 查询

`status` 可能是 `queued`、`running`、`done`、`failed`。

- `done`：读取 `imageUrl` 交给用户。链接有有效期，过期后用 `list_assets` 或再次查询任务拿新链接。
- `failed`：把 `errorMessage` 告诉用户。只有用户明确要求再画一张时，才换一个新的 `requestId`。
- 仍在 `queued` 或 `running`：隔几秒再查。一张图常常要一两分钟，这不是失败。

查询不扣积分。不要在同一张图还没出结果时并行再提交一次。
