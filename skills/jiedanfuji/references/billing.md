# 积分

MCP 生图和接单副驾电脑端使用同一套计价，不另设价目。

- `gpt` 按 0.2 元计价，`studio` 按 0.4 元计价。
- 实际扣除的积分由当时的汇率和消耗系数换算，和电脑端同一张图相同。
- 任务成功后才记下这笔积分。生成失败会退回预扣，任务上的 `pointsCharged` 为 0。
- `get_credit_balance`、`get_task_status`、`list_assets` 不扣积分。

同一把密钥、同一个 `requestId` 再次调用，会返回原来的任务，不会再扣一次。

密钥可以设置单次上限和每日上限，`0` 表示不限制。超过单次上限返回 `call_limit`，超过当日上限返回 `daily_limit`，余额不够返回 `insufficient_points`。遇到这三类结果时停止重试，并把原因告诉用户。
