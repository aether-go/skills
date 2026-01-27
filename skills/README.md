# Aether.go Skills

Aether.go 项目的一套智能化 AI 技能，基于规范驱动、价值导向、测试先行的开发方法论。

## 目录结构

```
skills/
├── README.md                       # 本文件
├── SKILLS_SUMMARY.md               # 技能详细清单
├── MIGRATION.md                    # 迁移说明
├── skills.sh                       # 技能管理脚本
├── AGENTS.md                       # AI 助手使用说明
├── .gitignore                      # Git 忽略配置
│
├── 执行层 Skills (ATDD/BDD/TDD/SIT/Chaos)
│   ├── bdd-scenario-writer/       # BDD 场景编写器
│   │   └── SKILL.md
│   ├── tdd-red-green-refactor/    # TDD 循环指导
│   │   └── SKILL.md
│   ├── test-pyramid-analyzer/     # 测试金字塔分析
│   │   └── SKILL.md
│   ├── sit-scenario-generator/    # SIT 场景生成器
│   │   └── SKILL.md
│   └── chaos-test-designer/       # 混沌工程实验设计
│       └── SKILL.md
│
├── 战略层 Skills (BMAD 驱动)
│   ├── business-value-mapper/     # 业务价值映射器
│   │   └── SKILL.md
│   ├── metrics-definer/           # 指标定义器
│   │   └── SKILL.md
│   ├── architecture-decision-recorder/ # 架构决策记录器
│   │   └── SKILL.md
│   └── data-flow-analyzer/        # 数据流分析器
│       └── SKILL.md
│
├── 战术层 Skills (SDD + 宪法约束)
│   ├── spec-parser/               # 规范解析器
│   │   └── SKILL.md
│   ├── constitution-validator/    # 宪法验证器
│   │   └── SKILL.md
│   ├── spec-to-code-tracer/       # 规范代码追溯器
│   │   └── SKILL.md
│   └── spec-evolution-tracker/    # 规范演进跟踪器
│       └── SKILL.md
│
├── AI 协作与优化 Skills
│   ├── context-manager/           # 上下文管理器
│   │   └── SKILL.md
│   ├── skill-recommender/         # 技能推荐器
│   │   └── SKILL.md
│   ├── recursive-optimizer/       # 递归优化器
│   │   └── SKILL.md
│   └── prompt-template-manager/   # 提示词模板管理器
│       └── SKILL.md
│
├── Go + Vue + Quasar 全栈开发 Skills (基于 bitcms 模式)
│   ├── go-backend-scaffolder/     # Go 后端脚手架
│   │   └── SKILL.md
│   ├── vue-quasar-scaffolder/     # Vue + Quasar 前端脚手架
│   │   └── SKILL.md
│   ├── fullstack-project-setup/   # 全栈项目初始化
│   │   └── SKILL.md
│   ├── requirements-to-code-docs/ # 需求到代码文档生成
│   │   └── SKILL.md
│   ├── go-vue-fullstack-workflow/ # Go + Vue 全栈工作流
│   │   └── SKILL.md
│   └── makefile-backend-generator/ # Makefile 生成器
│       └── SKILL.md
│
└── 工具与集成 Skills
    ├── skill-packaging-tool/      # 技能打包工具
    │   └── SKILL.md
    └── go-cli-builder/            # Go CLI 应用构建器
        └── SKILL.md
```

## 技能分类

### 执行层 (5个)
- `bdd-scenario-writer` - 将需求转为 Gherkin BDD 场景
- `tdd-red-green-refactor` - 指导 TDD RED-GREEN-REFACTOR 循环
- `test-pyramid-analyzer` - 分析测试分布和覆盖率
- `sit-scenario-generator` - 生成系统集成测试场景
- `chaos-test-designer` - 设计混沌工程实验

### 战略层 (4个)
- `business-value-mapper` - BMAD 业务价值映射
- `metrics-definer` - 定义业务和技术指标
- `architecture-decision-recorder` - 记录架构决策 (ADR)
- `data-flow-analyzer` - 分析数据流和价值链

### 战术层 (4个)
- `spec-parser` - 解析自然语言需求为结构化规范
- `constitution-validator` - 验证宪法原则合规性
- `spec-to-code-tracer` - 建立规范与代码双向追溯
- `spec-evolution-tracker` - 跟踪规范变更历史

### AI 协作层 (4个)
- `context-manager` - 管理项目上下文
- `skill-recommender` - 智能推荐相关技能
- `recursive-optimizer` - 基于反馈优化技能
- `prompt-template-manager` - 管理提示词模板

### Go + Vue + Quasar 全栈开发层 (6个)
- `go-backend-scaffolder` - 基于 bitcms 模式生成 Go 后端代码
- `vue-quasar-scaffolder` - 基于 bitcms 模式生成 Vue 3 + Quasar 前端组件
- `fullstack-project-setup` - 初始化完整的 Go + Vue + Quasar 全栈项目
- `requirements-to-code-docs` - 从需求到用例到实现生成结构化文档
- `go-vue-fullstack-workflow` - 协调 Go + Vue + Quasar 全栈开发工作流
- `makefile-backend-generator` - 为 Go 后端项目创建生产级 Makefile

### 工具与集成层 (2个)
- `skill-packaging-tool` - 打包技能为可分发包
- `go-cli-builder` - 构建企业级 Go CLI 应用，基于 cobra+viper 最佳实践

## 使用方式

### 通过 OpenCode 自动发现

OpenCode 会从当前工作目录向上搜索，自动发现 `skills/` 目录下的所有技能。

```bash
# 在项目根目录下
cd /home/bison/workspace/aether-go/skills

# OpenCode 会自动发现 skills/ 目录下的所有技能
```

### 手动调用技能

在对话中，AI 助手会根据任务自动推荐和加载相关技能：

```
用户: "我需要为用户登录功能编写 BDD 测试场景"

AI助手: 使用 bdd-scenario-writer 技能来转换需求为 Gherkin 场景...
```

### 技能文件格式

每个技能遵循 OpenCode 规范：

```markdown
---
name: skill-name
description: Use when [specific triggering conditions]
---

# Skill Title

## Overview
[What this skill does in 1-2 sentences]

## When to Use
[When to apply this skill]

## Core Pattern
[Before/After comparison]

## Quick Reference
[Table of common operations]

## Implementation
[Code examples and patterns]

## Common Mistakes
[What goes wrong and how to fix it]

## Real-World Impact
[Concrete results and benefits]
```

## Aether.go 方法论集成

这些技能与 Aether.go 核心方法论深度集成：

- **BMAD** (Business-Driven Metrics) - business-value-mapper, metrics-definer
- **SDD** (Spec-Driven Development) - spec-parser, spec-to-code-tracer
- **Constitution** - constitution-validator, architecture-decision-recorder
- **Testing** - bdd-scenario-writer, tdd-red-green-refactor, test-pyramid-analyzer
- **Resilience** - sit-scenario-generator, chaos-test-designer

## 开发与维护

### 添加新技能

1. 在 `skills/` 目录下创建新子目录
2. 添加 `SKILL.md` 文件
3. 遵循 writing-skills 规范和 TDD 原则

### 修改现有技能

1. 阅读 `SKILL.md` 文件
2. 使用 TDD 方法修改（先写测试）
3. 使用 recursive-optimizer 持续改进

### 测试技能

使用 subagent 驱动开发进行技能验证：

```bash
# 测试技能有效性
python scripts/test-skill.py <skill-name>
```

## 相关文档

- `SKILLS_SUMMARY.md` - 所有技能的详细清单和说明
- `overall.md` - Aether.go 方法论融合框架规划
- `AGENTS.md` - AI 助手使用说明

## 贡献

欢迎贡献新技能和改进！

1. Fork 项目
2. 创建特性分支
3. 遵循 writing-skills 规范
4. 提交 Pull Request

## 许可证

MIT License

---

创建日期：2024-01-16
维护者：Aether.go Team
