# Skills 目录迁移说明

## 迁移概述

Skills 目录已从 `.opencode/skill/` 迁移到项目根目录下的 `skills/` 目录，便于工具调用和统一管理。

## 迁移详情

### 原始位置
```
.opencode/skill/<skill-name>/SKILL.md
```

### 新位置
```
skills/<skill-name>/SKILL.md
```

## 新目录结构

```
skills/
├── README.md                       # Skills 总体说明
├── SKILLS_SUMMARY.md               # 技能详细清单
├── MIGRATION.md                    # 迁移说明
├── skills.sh                       # Skills 管理脚本
│
├── 执行层 Skills
│   ├── bdd-scenario-writer/       # BDD 场景编写器
│   ├── tdd-red-green-refactor/    # TDD 循环指导
│   ├── test-pyramid-analyzer/     # 测试金字塔分析
│   ├── sit-scenario-generator/    # SIT 场景生成器
│   └── chaos-test-designer/       # 混沌工程实验设计
│
├── 战略层 Skills
│   ├── business-value-mapper/     # 业务价值映射器
│   ├── metrics-definer/           # 指标定义器
│   ├── architecture-decision-recorder/ # 架构决策记录器
│   └── data-flow-analyzer/        # 数据流分析器
│
├── 战术层 Skills
│   ├── spec-parser/               # 规范解析器
│   ├── constitution-validator/    # 宪法验证器
│   ├── spec-to-code-tracer/       # 规范代码追溯器
│   └── spec-evolution-tracker/    # 规范演进跟踪器
│
├── AI 协作层 Skills
│   ├── context-manager/           # 上下文管理器
│   ├── skill-recommender/         # 技能推荐器
│   ├── recursive-optimizer/       # 递归优化器
│   └── prompt-template-manager/   # 提示词模板管理器
│
├── Go + Vue + Quasar 全栈开发 Skills
│   ├── go-backend-scaffolder/     # Go 后端脚手架
│   ├── vue-quasar-scaffolder/     # Vue + Quasar 前端脚手架
│   ├── fullstack-project-setup/   # 全栈项目初始化
│   ├── requirements-to-code-docs/ # 需求到代码文档生成
│   ├── go-vue-fullstack-workflow/ # Go + Vue 全栈工作流
│   └── makefile-backend-generator/ # Makefile 生成器
│
└── 工具与集成 Skills
    ├── skill-packaging-tool/      # 技能打包工具
    └── go-cli-builder/            # Go CLI 应用构建器
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

## 技能统计

- **总技能数**: 25
- **执行层**: 5 (BDD, TDD, 测试分析, SIT, Chaos)
- **战略层**: 4 (BMAD, 指标, ADR, 数据流)
- **战术层**: 4 (解析, 宪法, 追溯, 演进)
- **AI协作层**: 4 (上下文, 推荐, 优化, 模板)
- **Go + Vue + Quasar 全栈开发层**: 6 (后端脚手架, 前端脚手架, 项目初始化, 文档生成, 工作流协调, Makefile生成)
- **工具与集成层**: 2 (技能打包, CLI构建器)

## 验证结果

所有 25 个技能已通过格式验证：
- ✅ 所有技能包含必需的 `name` 字段
- ✅ 所有技能包含必需的 `description` 字段
- ✅ 所有 description 以 "Use when" 开头
- ✅ 所有技能文件位于正确位置

## OpenCode 集成

### 项目配置

如果需要在 OpenCode 中使用这些技能，确保：

1. `skills/` 目录位于项目根目录
2. 在项目根目录启动 OpenCode

```bash
cd /home/bison/workspace/aether-go/skills
opencode
```

### 全局安装

如果需要在所有项目中使用这些技能：

```bash
# 安装单个技能到全局位置
./skills/skills.sh install bdd-scenario-writer

# 或复制整个目录
cp -r skills/* ~/.config/opencode/skill/
```

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

- `skills/README.md` - Skills 使用说明
- `skills/SKILLS_SUMMARY.md` - 技能详细清单
- `overall.md` - Aether.go 方法论规划
- `AGENTS.md` - AI 助手使用指南

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

## 迁移日期

- 执行日期：2024-01-16
- 执行人：AI Assistant
- 状态：✅ 完成

## 回滚方案

如果需要回滚到旧位置：

```bash
# 恢复到 .opencode/skill
mkdir -p .opencode/skill
mv skills/* .opencode/skill/

# 但建议继续使用新的 skills/ 目录
```

---

**注意**: 推荐使用新的 `skills/` 目录结构，便于工具调用和管理。
