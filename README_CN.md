# Aether.go Skills

Aether.go 项目的一套智能化 AI 技能，基于规范驱动、价值导向、测试先行的开发方法论。

---

**语言**: [English](README.md) | [中文](README_CN.md)

---

## 目录结构

```
skills/
├── README.md                       # 本文件（英文）
├── README_CN.md                    # 本文件（中文）
├── [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md)               # 技能详细清单（英文）
├── [SKILLS_SUMMARY_CN.md](SKILLS_SUMMARY_CN.md)               # 技能详细清单（中文）
├── [MIGRATION.md](MIGRATION.md)                    # 迁移说明（英文）
├── [MIGRATION_CN.md](MIGRATION_CN.md)                    # 迁移说明（中文）
├── skills.sh                       # 技能管理脚本
├── AGENTS.md                       # AI 助手使用说明
├── LICENSE                         # MIT 许可证
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
│   ├── chaos-test-designer/       # 混沌工程实验设计
│   │   └── SKILL.md
│   └── atdd-acceptance-test-generator/ # ATDD 验收测试生成器
│       └── SKILL.md
│
├── 战略层 Skills (BMAD 驱动)
│   ├── business-requirements-collector/ # 业务需求收集器
│   │   └── SKILL.md
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
│   ├── spec-evolution-tracker/    # 规范演进跟踪器
│   │   └── SKILL.md
│   ├── architecture-pattern-selector/ # 架构模式选择器
│   │   └── SKILL.md
│   ├── generic-code-generator/    # 通用代码生成器
│   │   └── SKILL.md
│   └── contract-test-generator/    # 契约测试生成器
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
├── Go + Vue + Quasar 全栈开发 Skills (生产级模式)
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
├── 工具与集成 Skills
│   ├── skill-packaging-tool/      # 技能打包工具
│   │   └── SKILL.md
│   ├── go-cli-builder/            # Go CLI 应用构建器
│   │   └── SKILL.md
│   └── rust-cli-builder/          # Rust CLI 应用构建器
│       └── SKILL.md
│
└── 方法论融合协调层 Skills
    └── methodology-fusion-orchestrator/ # 方法论融合协调器
        └── SKILL.md
```

## 技能分类

### 快速开始

#### 1. 查看技能清单
查看 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 了解所有 39 个技能的详细说明。

#### 2. 选择合适的技能
根据你的开发阶段选择合适的技能：
- **项目初始化**: `fullstack-project-setup`, `go-backend-scaffolder`, `vue-quasar-scaffolder`
- **需求分析**: `business-requirements-collector`, `business-value-mapper`, `metrics-definer`
- **规范定义**: `spec-parser`, `bdd-scenario-writer`, `atdd-acceptance-test-generator`
- **代码开发**: `tdd-red-green-refactor`, `generic-code-generator`
- **测试验证**: `test-pyramid-analyzer`, `sit-scenario-generator`, `chaos-test-designer`
- **部署运维**: `deployment-orchestrator`, `release-manager`, `incident-management`

#### 3. 使用技能
在对话中直接请求使用特定技能，AI 助手会自动加载并执行。

#### 4. 查看迁移说明
如果从旧版本迁移，请查看 [MIGRATION.md](MIGRATION.md) 了解详细迁移步骤。

---

### 执行层 (6个)
- `bdd-scenario-writer` - 将需求转为 Gherkin BDD 场景
- `tdd-red-green-refactor` - 指导 TDD RED-GREEN-REFACTOR 循环
- `test-pyramid-analyzer` - 分析测试分布和覆盖率
- `sit-scenario-generator` - 生成系统集成测试场景
- `chaos-test-designer` - 设计混沌工程实验
- `atdd-acceptance-test-generator` - 生成 ATDD 验收测试

### 战略层 (5个)
- `business-requirements-collector` - 业务需求收集与分析
- `business-value-mapper` - BMAD 业务价值映射
- `metrics-definer` - 定义业务和技术指标
- `architecture-decision-recorder` - 记录架构决策 (ADR)
- `data-flow-analyzer` - 分析数据流和价值链

### 战术层 (7个)
- `spec-parser` - 解析自然语言需求为结构化规范
- `constitution-validator` - 验证宪法原则合规性
- `spec-to-code-tracer` - 建立规范与代码双向追溯
- `spec-evolution-tracker` - 跟踪规范变更历史
- `architecture-pattern-selector` - 基于需求选择架构模式
- `generic-code-generator` - 根据规范、模板或TDD模式跨语言生成代码
- `contract-test-generator` - 生成消费者驱动的契约测试，确保微服务API兼容性

### AI 协作层 (4个)
- `context-manager` - 管理项目上下文
- `skill-recommender` - 智能推荐相关技能
- `recursive-optimizer` - 基于反馈优化技能
- `prompt-template-manager` - 管理提示词模板

### Go + Vue + Quasar 全栈开发层 (6个)
- `go-backend-scaffolder` - 基于生产级模式生成 Go 后端代码
- `vue-quasar-scaffolder` - 基于生产级模式生成 Vue 3 + Quasar 前端组件
- `fullstack-project-setup` - 初始化完整的 Go + Vue + Quasar 全栈项目
- `requirements-to-code-docs` - 从需求到用例到实现生成结构化文档
- `go-vue-fullstack-workflow` - 协调 Go + Vue + Quasar 全栈开发工作流
- `makefile-backend-generator` - 为 Go 后端项目创建生产级 Makefile

### 工具与集成层 (3个)
- `skill-packaging-tool` - 打包技能为可分发包
- `go-cli-builder` - 构建企业级 Go CLI 应用，基于 cobra+viper 最佳实践
- `rust-cli-builder` - 构建企业级 Rust CLI 应用，基于 clap+serde+config 最佳实践

### 方法论融合协调层 (1个)
- `methodology-fusion-orchestrator` - 协调端到端方法论融合工作流

---

**总计**: 39 个技能，覆盖完整的软件开发生命周期

## 使用方式

### 通过 OpenCode 自动发现

OpenCode 会从当前工作目录向上搜索，自动发现 `skills/` 目录下的所有技能。

```bash
# 在用户目录下
git clone https://github.com/aether-go/skills.git
cp -Rv skills/* .opencode/skill/

# OpenCode 会自动发现 skills/ 目录下的所有技能
```

### Skills 管理脚本

项目提供了便捷的 `skills.sh` 脚本来管理技能（详见 [MIGRATION.md](MIGRATION.md)）：

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

### 手动调用技能

在对话中，AI 助手会根据任务自动推荐和加载相关技能：

```
用户: "我需要为用户登录功能编写 BDD 测试场景"

AI助手: 使用 bdd-scenario-writer 技能来转换需求为 Gherkin 场景...
```

### 方法论融合协调器使用示例

`methodology-fusion-orchestrator` 是最强大的技能，它协调所有其他技能执行完整的八阶段工作流。以下是实际使用示例：

#### 示例1：电商用户认证系统（基础版）

```
我需要开发一个电商用户认证系统。

业务目标：
- 主要：提升用户注册转化率30%
- 次要：降低认证相关客服咨询50%

成功指标：
- 注册成功率 > 95%
- 平均注册时间 < 60秒
- 第三方登录使用率 > 40%
- 认证API P99延迟 < 200ms

技术栈：
- 后端：Go + Gin + PostgreSQL + Redis
- 前端：Vue 3 + Quasar + Pinia

请使用methodology-fusion-orchestrator执行完整的八阶段工作流，确保宪法合规，启用递归优化和资产化。
```

#### 示例2：微服务订单管理系统（标准版）

```
项目类型：微服务架构
技术栈：Go后端 + Vue前端

BMAD框架：
Business：
  - 主要目标：提升订单处理效率50%
  - 次要目标：降低订单错误率到0.1%以下

Metrics：
  业务：
    - 订单处理时间 < 2秒
    - 订单准确率 > 99.9%
  技术：
    - API P99延迟 < 100ms
    - 系统可用性 > 99.95%

Architecture：
  - 架构风格：DDD + 事件驱动
  - 关键约束：支持10万并发订单

Data：
  - 数据类型：订单数据、用户数据、支付数据
  - 数据流向：订单创建 → 支付处理 → 库存更新 → 物流通知

请使用methodology-fusion-orchestrator执行完整工作流，启用所有优化和资产化功能。
```

#### 示例3：企业级全栈应用（高级版）

```yaml
# Aether.go 方法论融合编排请求

## 项目概览
project:
  name: "企业资源规划系统"
  type: "fullstack-web"
  version: "1.0.0"
  business_criticality: "high"
  compliance_requirements: ["SOC2", "GDPR"]

## BMAD 业务价值框架
business:
  primary_goals:
    - id: "BG-001"
      description: "优化库存管理"
      priority: "high"
      success_criteria: "库存处理时间减少40%"
    - id: "BG-002"
      description: "改进订单履行"
      priority: "medium"
      success_criteria: "订单准确率达到99.5%"

metrics:
  business:
    - name: "库存周转率"
      target: "12次/年"
      measurement: "从库存日志计算"
      frequency: "monthly"
      owner: "运营经理"
  
  technical:
    - name: "API响应时间"
      target: "P99 < 150ms"
      measurement: "APM监控"
      frequency: "continuous"
      owner: "DevOps团队"

architecture:
  style: "Clean Architecture + DDD"
  patterns: ["CQRS", "Event Sourcing"]
  constraints:
    - type: "performance"
      requirement: "支持1万并发用户"
    - type: "security"
      requirement: "符合OWASP Top 10"

data:
  entities:
    - name: "客户数据"
      sensitivity: "confidential"
      retention: "7年"
      compliance: "GDPR"
  flows:
    - from: "订单服务"
      to: "库存服务"
      transformation: "扣减库存"
      validation: "库存可用性检查"

## 宪法与合规配置
constitution:
  file: "./constitution.yaml"
  strict_mode: true
  auto_evolve: true
  evolution_threshold: 0.85

## 优化与资产化配置
optimization:
  enabled: true
  frequency: "after_each_stage"
  scope: ["skills", "constitution", "workflow"]

skill_effectiveness:
  tracking:
    - success_rate
    - execution_time
    - output_quality
    - constitution_compliance
  reporting:
    frequency: "daily"
    dashboard: true
    alerts:
      - condition: "success_rate < 0.7"
        action: "notify_team"

## 执行要求

请使用methodology-fusion-orchestrator执行完整的八阶段工作流，并提供：
1. 每个阶段的详细执行报告
2. 宪法合规检查结果
3. 度量指标汇总
4. 优化建议和资产化结果
5. 可视化仪表板链接

## 预期成果
- 宪法合规得分 ≥ 95%
- 需求可追溯性 = 100%
- 测试覆盖率 ≥ 90%
- 业务价值对齐度 ≥ 90%
- 优化效率提升 ≥ 15%
- 资产化成功模式数量 ≥ 2
```

### Prompt优化建议

1. **明确业务价值**：始终从BMAD框架开始，明确业务目标、度量、架构和数据
2. **指定技术栈**：明确后端、前端、数据库等技术选型
3. **配置宪法选项**：根据项目需求调整宪法严格程度和进化阈值
4. **启用优化功能**：明确要求启用递归优化、资产化和自动化
5. **指定输出格式**：要求提供详细的执行报告、可视化仪表板和优化建议
6. **设置质量门禁**：明确宪法合规、测试覆盖率、代码质量的最低要求
7. **配置协作流程**：指定需要审批的阶段和审批人
8. **启用可视化**：要求生成实时更新的仪表板和多种导出格式

### 技能统计

根据 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 的详细清单：

- **总技能数**: 38
- **执行层**: 6 (BDD, TDD, 测试分析, SIT, Chaos, ATDD)
- **战略层**: 5 (BMAD, 指标, ADR, 数据流, 需求收集)
- **战术层**: 7 (解析, 宪法, 追溯, 演进, 架构选择, 代码生成, 契约测试)
- **AI协作层**: 4 (上下文, 推荐, 优化, 模板)
- **Go + Vue + Quasar 全栈开发层**: 6 (后端脚手架, 前端脚手架, 项目初始化, 文档生成, 工作流协调, Makefile生成)
- **工具与集成层**: 2 (技能打包, CLI构建器)
- **方法论融合协调层**: 1 (方法论融合协调器)

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

这些技能与 Aether.go 核心方法论深度集成，覆盖完整的软件开发生命周期：

### 七阶段方法论融合工作流

详见 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 中的完整工作流图示：

1. **阶段1: 业务分析 (Business Analysis)**
   - `business-requirements-collector` - 收集和分析业务需求
   - `business-value-mapper` - 将业务目标映射到技术指标
   - `metrics-definer` - 定义可衡量的业务和技术指标

2. **阶段2: 规范定义 (Specification Definition)**
   - `spec-parser` - 解析自然语言需求为结构化规范
   - `bdd-scenario-writer` - 转换需求为 Gherkin BDD 场景
   - `atdd-acceptance-test-generator` - 生成可执行验收测试

3. **阶段3: 宪法审查 (Constitutional Review)**
   - `constitution-validator` - 验证代码和规范符合架构原则

4. **阶段4: 实现计划 (Implementation Planning)**
   - `architecture-decision-recorder` - 记录架构决策 (ADR)
   - `data-flow-analyzer` - 分析数据流和价值链
   - `architecture-pattern-selector` - 选择合适的架构模式

5. **阶段5: 代码生成 (Code Generation)**
   - `tdd-red-green-refactor` - 使用 TDD 方法实现功能
   - `go-backend-scaffolder` - 生成 Go 后端代码
   - `vue-quasar-scaffolder` - 生成 Vue 前端组件
   - `generic-code-generator` - 跨语言生成代码

6. **阶段6: 集成验证 (Integration Validation)**
   - `sit-scenario-generator` - 生成系统集成测试场景
   - `chaos-test-designer` - 设计混沌工程实验
   - `test-pyramid-analyzer` - 分析测试覆盖率和分布
   - `contract-test-generator` - 生成契约测试

7. **阶段7: 部署与运维 (Deployment & Operations)**
   - `deployment-orchestrator` - 高级部署策略编排
   - `release-manager` - 发布规划和版本管理
   - `incident-management` - ITIL 对齐的事件处理
   - `problem-management` - 根本原因分析
   - `change-management` - 受控变更流程
   - `service-desk` - 用户请求和问题管理
   - `rollback-manager` - 失败部署的自动回滚

8. **阶段8: 递归优化 (Recursive Optimization)**
   - `methodology-fusion-orchestrator` - 协调端到端方法论融合工作流
   - `recursive-optimizer` - 基于反馈优化技能
   - `skill-recommender` - 智能推荐相关技能
   - `prompt-template-manager` - 管理提示词模板

### 核心方法论

- **BMAD** (Business-Driven Metrics) - 业务驱动指标
  - `business-requirements-collector` - 业务需求收集与分析
  - `business-value-mapper` - BMAD 业务价值映射
  - `metrics-definer` - 定义业务和技术指标

- **SDD** (Spec-Driven Development) - 规范驱动开发
  - `spec-parser` - 解析自然语言需求为结构化规范
  - `spec-to-code-tracer` - 建立规范与代码双向追溯
  - `spec-evolution-tracker` - 跟踪规范变更历史

- **Constitution** - 宪法约束原则
  - `constitution-validator` - 验证宪法原则合规性
  - `architecture-decision-recorder` - 记录架构决策 (ADR)

- **Testing** - 测试驱动开发
  - `bdd-scenario-writer` - 将需求转为 Gherkin BDD 场景
  - `tdd-red-green-refactor` - 指导 TDD RED-GREEN-REFACTOR 循环
  - `test-pyramid-analyzer` - 分析测试分布和覆盖率
  - `atdd-acceptance-test-generator` - 生成 ATDD 验收测试

- **Resilience** - 弹性和可靠性
  - `sit-scenario-generator` - 生成系统集成测试场景
  - `chaos-test-designer` - 设计混沌工程实验
  - `contract-test-generator` - 生成契约测试确保微服务兼容性

- **Methodology Fusion** - 方法论融合协调
  - `methodology-fusion-orchestrator` - 协调端到端方法论融合工作流
  - `context-manager` - 管理项目上下文
  - `recursive-optimizer` - 基于反馈优化技能

## 开发与维护

### 添加新技能

1. 在 `skills/` 目录下创建新子目录
2. 添加 `SKILL.md` 文件
3. 遵循 writing-skills 规范和 TDD 原则
4. 运行 `./skills.sh validate` 验证格式
5. 更新 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 添加新技能说明

### 修改现有技能

1. 阅读 `SKILL.md` 文件
2. 使用 TDD 方法修改（先写测试）
3. 使用 recursive-optimizer 持续改进
4. 运行 `./skills.sh validate` 验证格式
5. 更新 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 中的技能描述

### 测试技能

使用 subagent 驱动开发进行技能验证：

```bash
# 测试技能有效性
python scripts/test-skill.py <skill-name>

# 或使用 skills.sh 验证
./skills.sh validate <skill-name>
```

### 技能版本管理

所有技能文件应纳入 Git 版本控制：

```bash
# 添加新技能或修改
git add skills/<skill-name>/SKILL.md
git add SKILLS_SUMMARY.md
git add README.md

# 提交更改
git commit -m "feat: add/update <skill-name> skill"
```

## 相关文档

- **[SKILLS_SUMMARY.md](SKILLS_SUMMARY.md)** - 所有技能的详细清单和说明
  - 包含 39 个技能的完整描述
  - 每个技能的功能、位置和特点
  - 技能集成与工作流说明
  - 七阶段方法论融合工作流图示
  - 宪法贯穿执行和智能技能调度机制
  
- **[MIGRATION.md](MIGRATION.md)** - Skills 目录迁移说明
  - 从 `.opencode/skill/` 到 `skills/` 的迁移详情
  - 新目录结构说明
  - Skills 管理脚本使用方法
  - 技能统计和验证结果
  - OpenCode 集成配置
  - 问题排查指南
  
- **[overall.md](overall.md)** - Aether.go 方法论融合框架规划
  - 方法论融合框架的完整规划
  - 七个阶段的详细说明
  - 技能与各阶段的对应关系
  
- **[AGENTS.md](AGENTS.md)** - AI 助手使用说明
  - AI 助手的配置和使用方法
  - 如何与技能系统集成

## 贡献

欢迎贡献新技能和改进！

### 贡献流程

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/my-skill`)
3. 遵循 writing-skills 规范
4. 运行 `./skills.sh validate` 验证格式
5. 更新 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 添加新技能说明
6. 更新 [README.md](README.md) 中的相关文档链接
7. 提交 Pull Request

### 技能规范

每个技能必须遵循以下规范：

1. **文件命名**: `skills/<skill-name>/SKILL.md` (SKILL.md 必须大写)
2. **YAML Frontmatter**: 必须包含 `name` 和 `description` 字段
3. **Description 格式**: 必须以 "Use when" 开头
4. **命名规范**: 技能名称使用小写字母、数字和连字符
5. **内容结构**: 包含 Overview, When to Use, Core Pattern, Quick Reference, Implementation, Common Mistakes, Real-World Impact

### 代码审查清单

- [ ] 技能文件位于正确目录
- [ ] 文件名为 `SKILL.md` (大写)
- [ ] 包含必需的 YAML frontmatter
- [ ] description 以 "Use when" 开头
- [ ] 遵循 OpenCode 规范
- [ ] 已更新 SKILLS_SUMMARY.md
- [ ] 已运行 `./skills.sh validate`
- [ ] 已添加必要的测试

## 许可证

本项目采用 MIT License - 详见 [LICENSE](LICENSE) 文件
