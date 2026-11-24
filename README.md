<p align="center">
  <img src="assets/logo.png" alt="接单副驾" width="96" />
</p>

<h1 align="center">接单副驾 Skill</h1>

<p align="center">
  把接单副驾接到 WorkBuddy、Cursor、Claude Code、Codex。<br />
  查积分、AI 生图、看作品，都走已经开通的 MCP。
</p>

<p align="center">
  <a href="https://aurapilot.cn">接单副驾</a>
  ·
  <a href="skills/jiedanfuji/SKILL.md">SKILL.md</a>
  ·
  <a href="skills/jiedanfuji/references/mcp.md">MCP 配置</a>
</p>

Skill 只告诉 Agent 何时调用、按什么顺序调用。密钥留在各客户端的 MCP 配置里，不要写进本仓库。

## 现在能做的

| 工具 | 作用 | 积分 |
| --- | --- | --- |
| `get_credit_balance` | 查当前密钥所属账号的积分 | 不扣 |
| `generate_image` | 提交一张生图任务，马上返回任务号 | 成功后扣除，与电脑端同一套计价 |
| `get_task_status` | 查询任务，完成后拿到图片地址 | 不扣 |
| `list_assets` | 列出这个账号最近的生图作品 | 不扣 |

生图经常要一两分钟。Agent 应拿到任务号后继续查询，不要中途换一个新的请求号再画一张。

## 安装

先在接单副驾电脑端「开放平台」创建 API Key，并按 [MCP 配置](skills/jiedanfuji/references/mcp.md) 连上 `jiedanfuji`。Skill 不另发一把密钥。

WorkBuddy：

```bash
npx skills add yant95123-create/jiedanfuji-skill -g -a workbuddy -y
```

也可以手动放到技能目录：

```bash
git clone https://github.com/yant95123-create/jiedanfuji-skill.git
mkdir -p ~/.workbuddy/skills
cp -R jiedanfuji-skill/skills/jiedanfuji ~/.workbuddy/skills/jiedanfuji
```

其他客户端把同一个 `skills/jiedanfuji` 目录拷到对应位置，然后新开一轮对话：

| 客户端 | 目录 |
| --- | --- |
| Cursor | `~/.cursor/skills/jiedanfuji` |
| Claude Code | `~/.claude/skills/jiedanfuji` |
| Codex | `~/.codex/skills/jiedanfuji` |

装好后可以这样试：

> 用接单副驾查一下我的积分余额

> 用接单副驾画一张 1:1 的图片，画面是一张干净的白色桌面，桌上有一杯咖啡。画完把图片地址给我。

## 确认服务

```bash
bash skills/jiedanfuji/scripts/check-connection.sh
```

不带密钥时，脚本只确认 `https://mcp.aurapilot.cn/mcp` 在线。要连同密钥一起测，先在当前终端设置 `JIEDANFUJI_API_KEY`，不要把密钥写进文件。

## 目录

```text
skills/jiedanfuji/
├── SKILL.md
├── references/
│   ├── mcp.md
│   ├── image-generation.md
│   ├── authentication.md
│   └── billing.md
└── scripts/
    └── check-connection.sh
```

更细的说明：

- [怎么连 MCP](skills/jiedanfuji/references/mcp.md)
- [生图怎么调用](skills/jiedanfuji/references/image-generation.md)
- [密钥和权限](skills/jiedanfuji/references/authentication.md)
- [积分怎么扣](skills/jiedanfuji/references/billing.md)
