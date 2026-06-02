# Aether.go 技能库 (V3.0 精简版)

基于规范驱动、价值导向、测试优先开发方法论实现的 AI 技能集合，实现五层推导模型和宪政原则。

---

**语言**: [English](README.md) | [中文](README_CN.md)

---

## 概览

基于 [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) 和 [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md)，本仓库包含 **25 个技能**，按 **A-G 功能分组**组织，覆盖完整五层推导模型和 15 条宪政原则（P0-P14）。

> **V3.0 精简**：从 99 个技能精简至 25 个（减少 75%），同时保持方法论完整覆盖。详见 [SKILLS_SUMMARY_CN.md](SKILLS_SUMMARY_CN.md)。

### 五层推导模型

```
L1: 业务价值层
    └── A1: requirement-analyzer (L1)

L2: 系统行为层
    └── A2: architecture-planner (L2)

L3: 验收标准层
    └── A3: spec-engineer (L3)

L4: 组件契约层
    └── A4: test-planner (L4)

L4.5: 生成调度层 (新增)
    └── A5: generation-dispatcher (L4.5)

L5: 单元实现层
    └── A6: code-generator (L5)
```

### 核心分组：A-G (25 技能)

| 分组 | 名称 | 技能数 | 描述 |
|------|------|--------|------|
| **A** | 推导链 | 6 | L1→L2→L3→L4→L4.5→L5 线性流水线 |
| **B** | 项目支撑 | 3 | 横切关注点（脚手架、宪政、上下文）|
| **C** | 场景适配 | 3 | 场景检测和专用工作流 |
| **D** | 运营 | 2 | 部署、事件、发布管理 |
| **E** | 演进 | 3 | 递归优化、技能管理、度量 |
| **F** | 元能力 | 2 | 架构审计、通用怀疑层 |
| **G** | 独立 | 6 | 独立核心能力（意图、TDD、重构等）|

### 宪政原则覆盖 (P0-P14)

技能库实现了 method-paper.md V3.0 的全部 15 条宪政原则：
- **P0** 上下文适配 · **P1** 宪政优先 · **P2** 架构决策可追溯
- **P3** 规范显式化 · **P4** 接口优先 · **P5** 测试优先
- **P6** 奥卡姆剃刀 · **P7** 上下文优先 · **P8** 渐进式验证
- **P9** 递归优化 · **P10** 知识引擎 · **P11** 质量门禁
- **P12** 人机边界 · **P13** 场景自适应 · **P14** 技能资产化

## 技能目录

### A 组：推导链 (6 技能)

| # | 技能 | 层级 | 合并 (源→目标) | 用途 |
|---|------|------|----------------|------|
| 1 | **requirement-analyzer** | L1 | 6→1 | 业务需求收集、13 类分类、价值分解、度量定义 |
| 2 | **architecture-planner** | L2 | 6→1 | 架构模式+技术栈选型、数据流分析、接口契约 (P4) |
| 3 | **spec-engineer** | L3 | 8→1 | 规范解析、用例设计、BDD/ATDD 场景编写、NFR 分析、版本管理 |
| 4 | **test-planner** | L4 | 9→1 | 测试金字塔推导（单元/集成/契约/系统/E2E/非功能）|
| 5 | **generation-dispatcher** | L4.5 | 4→1 | 确定性评估、调度决策、契约一致性门禁 |
| 6 | **code-generator** | L5 | 4→1 | 从接口契约生成代码（前端+后端+语言无关）|

### B 组：项目支撑 (3 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 7 | **go-fullstack-scaffolder** | 生成 Go + Vue + Quasar 全栈项目（脚手架、Makefile、README、LICENSE）|
| 8 | **constitution-validator** | 验证 P0-P14 原则合规性；解决原则冲突 |
| 9 | **context-manager** | 项目上下文、对话历史、推导矩阵 (P7) |

### C 组：场景适配 (3 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 10 | **scenario-engine** | 检测场景（10 种模式）、推荐模式、支持联邦/双轨工作流 |
| 11 | **reverse-engineering-suite** | 从遗留系统提取规范（静态+动态分析）|
| 12 | **wartime-hotfix-workflow** | 战时双阶段应急响应（即时+24h 规范化）|

### D 组：运营 (2 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 13 | **deployment-orchestrator** | 蓝绿/金丝雀/滚动部署+回滚+发布+变更管理 |
| 14 | **incident-manager** | 完整 ITIL 事件+问题管理生命周期 |

### E 组：演进 (3 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 15 | **recursive-optimizer** | 技能、提示、工作流的递归自优化 |
| 16 | **skill-manager** | 技能库生命周期（创建/验证/优化/退役）|
| 17 | **metrics-tracker** | AI 效果+系统质量度量 |

### F 组：元能力 (2 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 18 | **architecture-auditor** | 审计整体架构+推导链完整性 (L1-L5) |
| 19 | **universal-skeptic** | 跨域验证：正确性、完整性、一致性、有界性 |

### G 组：独立 (6 技能)

| # | 技能 | 用途 |
|---|-------|------|
| 20 | **intent-hierarchizer** | 层次化用户意图：目标→子目标→任务→子任务 |
| 21 | **methodology-fusion-orchestrator** | 端到端 Aether 方法论融合编排（8 阶段）|
| 22 | **tdd-cycle-runner** | 原子化红绿重构 TDD 循环，桥接 L4 测试到 L5 实现 |
| 23 | **code-refactor-engine** | 保持测试覆盖率的前提下重构代码（支撑 P9）|
| 24 | **meta-skeptic** | 挑战测试金字塔推导输出的边界理性（META-005）|
| 25 | **semantic-intent-clarifier** | 在关键需求语义节点生成反向澄清问题 |

## 标准推导流水线

```
意图 → 场景 → L1 → L2 → L3 → L4 → L4.5 → L5 → 验证 → 部署 → 运营 → 演进
```

| 步骤 | 阶段 | 技能 |
|------|------|------|
| 0 | 推导前 | intent-hierarchizer, semantic-intent-clarifier, context-manager |
| 1 | 场景检测 | scenario-engine |
| 2 | L1 需求 | requirement-analyzer |
| 3 | L2 架构 | architecture-planner, go-fullstack-scaffolder |
| 4 | L3 规范 | spec-engineer |
| 5 | L4 测试 | test-planner |
| 6 | L4.5 调度 | generation-dispatcher |
| 7 | L5 代码 | code-generator, tdd-cycle-runner, code-refactor-engine |
| 8 | 验证 | constitution-validator, architecture-auditor, universal-skeptic, meta-skeptic |
| 9 | 部署 | deployment-orchestrator |
| 10 | 运营 | incident-manager, wartime-hotfix-workflow |
| 11 | 演进 | metrics-tracker, recursive-optimizer, skill-manager |

## 目录结构

```
skills/
├── README.md (本文件)
├── SKILLS_SUMMARY_CN.md
├── skill-dependencies.yaml
├── LICENSE
│
├── A. 推导链 (6)
│   ├── requirement-analyzer/
│   ├── architecture-planner/
│   ├── spec-engineer/
│   ├── test-planner/
│   ├── generation-dispatcher/
│   └── code-generator/
│
├── B. 项目支撑 (3)
│   ├── go-fullstack-scaffolder/
│   ├── constitution-validator/
│   └── context-manager/
│
├── C. 场景适配 (3)
│   ├── scenario-engine/
│   ├── reverse-engineering-suite/
│   └── wartime-hotfix-workflow/
│
├── D. 运营 (2)
│   ├── deployment-orchestrator/
│   └── incident-manager/
│
├── E. 演进 (3)
│   ├── recursive-optimizer/
│   ├── skill-manager/
│   └── metrics-tracker/
│
├── F. 元能力 (2)
│   ├── architecture-auditor/
│   └── universal-skeptic/
│
└── G. 独立 (6)
    ├── intent-hierarchizer/
    ├── methodology-fusion-orchestrator/
    ├── tdd-cycle-runner/
    ├── code-refactor-engine/
    ├── meta-skeptic/
    └── semantic-intent-clarifier/
```

## 从 V2.x (99 技能) 迁移

V3.0 将 99 技能精简至 25。完整映射表见 [SKILLS_SUMMARY_CN.md](SKILLS_SUMMARY_CN.md)。

**备份标签**：`pre-v3-consolidation`

**关键精简原则**：
1. **合并规则**：概念重叠 >50% 且同层/同场景的技能合并
2. **无孤儿能力**：所有源能力在目标技能中暴露
3. **KISS**：在不丢失功能的前提下最小化技能数
4. **生产级别**：每个合并技能 250+ 行，含完整 I/O 契约

## 许可证

MIT 许可证 - 见 [LICENSE](LICENSE)
