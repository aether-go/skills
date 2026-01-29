# Skills 目录迁移说明

---

**语言**: [English](MIGRATION.md) | [中文](MIGRATION_CN.md)

---

## 迁移概述

Skills 目录已从 `.opencode/skill/` 迁移到项目根目录下的 `skills/` 目录，便于工具调用和统一管理。

## 迁移详情

### 原始位置
```
.opencode/skill/<skill-name>/SKILL.md
```

## 使用方式

### 1. Skills 管理脚本

提供了便捷的 `skills.sh` 脚本来管理技能：

```bash
# 列出所有技能
cd skills
./skills.sh list

# 显示技能详细信息
./skills.sh show bdd-scenario-writer

# 搜索技能
./skills.sh search testing

# 查看统计信息
./skills.sh stats

# 验证技能格式
./skills.sh validate

# 安装技能到全局位置
./skills.sh install bdd-scenario-writer
```

### 2. OpenCode 自动发现

OpenCode 会从当前工作目录自动发现 `skills/` 目录下的所有技能。

在项目根目录下：
```bash
cd /path/to/project
# OpenCode 会自动发现 skills/ 目录
```

### 3. 手动技能调用

在对话中，AI 助手会根据任务自动推荐和加载相关技能。

## 验证结果

所有 25 个技能已通过格式验证：
- ✅ 所有技能包含必需的 `name` 字段
- ✅ 所有技能包含必需的 `description` 字段
- ✅ 所有 description 以 "Use when" 开头
- ✅ 所有技能文件位于正确位置

## OpenCode 集成

OpenCode 是一个基于终端的 AI 智能体，支持 Skills 功能。详见 [OpenCode 官方文档](https://opencode.ai/docs/skills/) 和 [GitHub 仓库](https://github.com/anthropics/skills)。

### 项目配置

如果需要在 OpenCode 中使用这些技能，确保：

1. `skills/` 目录位于项目根目录
2. 在项目根目录启动 OpenCode

OpenCode 会自动从当前工作目录向上搜索 `skills/` 目录，并加载其中的所有技能。

### 全局安装

如果需要在所有项目中使用这些技能，有以下几种安装方式：

#### 方式1: 使用 OpenSkills 安装（推荐）

OpenSkills 是一个开源工具，用于管理和安装 skills。详见 [OpenSkills GitHub](https://github.com/numman-ali/openskills)。

```bash
# 安装 OpenSkills（如果尚未安装）
npm install -g @openskills/cli

# 从本地项目安装到全局
openskills install ./skills --global

# 或者从 GitHub 仓库安装
openskills install <your-github-username>/aether-go-skills --global
```

#### 方式2: 手动复制到全局目录

```bash
# 复制整个 skills 目录到全局 Claude skills 目录
cp -r skills/* ~/.claude/skills/

# 或者复制到 OpenCode 的全局 skills 目录
cp -r skills/* ~/.config/opencode/skill/
```

#### 方式3: 使用项目级安装（仅当前项目）

```bash
# 在项目根目录创建 .claude/skills 目录
mkdir -p .claude/skills

# 复制技能到项目级目录
cp -r skills/* .claude/skills/
```

#### 目录路径说明

OpenCode 会在以下路径搜索 SKILL.md 文件：

- **项目级路径**: `./.claude/skills/` - 仅在当前项目中可用
- **全局路径**: `~/.claude/skills/` - 在所有项目中可用
- **OpenCode 配置路径**: `~/.config/opencode/skill/` - OpenCode 专用路径

选择合适的安装方式：
- 如果技能仅用于当前项目，使用项目级安装
- 如果技能需要在多个项目中使用，使用全局安装
- 如果使用 OpenCode，可以复制到 OpenCode 配置路径

## 维护说明

### 添加新技能

1. 在 `skills/` 目录创建新子目录
2. 添加 `SKILL.md` 文件，遵循规范
3. 运行 `./skills.sh validate` 验证格式

### 修改现有技能

1. 编辑对应的 `SKILL.md` 文件
2. 使用 `./skills.sh validate` 验证格式
3. 使用 `./skills.sh show <skill-name>` 预览

### 版本控制

所有技能文件应纳入 Git 版本控制：

```bash
git add skills/
git commit -m "Add/update skills"
```

## 相关文档

- **[README.md](README.md)** - Skills 使用说明
- **[SKILLS_SUMMARY.md](SKILLS_SUMMARY.md)** - 技能详细清单
- **[overall.md](overall.md)** - Aether.go 方法论规划
- **[AGENTS.md](AGENTS.md)** - AI 助手使用指南

### 外部资源

- **[OpenCode 官方文档](https://opencode.ai/docs/skills/)** - OpenCode Skills 功能文档
- **[Anthropic Skills GitHub](https://github.com/anthropics/skills)** - 官方 Skills 仓库
- **[OpenSkills GitHub](https://github.com/numman-ali/openskills)** - OpenSkills 工具仓库

## 问题排查

### 技能未被发现

1. 确认在项目根目录启动 OpenCode
2. 检查 `skills/` 目录是否存在
3. 验证技能文件名是否为 `SKILL.md` (大写)

### 格式验证失败

1. 检查 YAML frontmatter 是否正确
2. 确认 `description` 以 "Use when" 开头
3. 验证文件编码为 UTF-8

### 技能无法加载

1. 检查 OpenCode 版本 (>= 1.0.0)
2. 验证技能文件权限
3. 查看 OpenCode 日志中的错误信息
