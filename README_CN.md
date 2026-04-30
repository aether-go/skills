# Aether.go Skills

一套用于 Aether.go 项目的智能 AI 技能，基于规范驱动、价值导向和测试优先的开发方法论，实现五层推导模型和宪法原则。

---

**语言**: [English](README.md) | [中文](README_CN.md)

---

## 概述

基于 [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) 和 [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md)，本仓库包含 **99个技能**，组织在 **D1-D8 推导域** 和扩展域（D4.5、D7.5）中，覆盖完整的五层推导模型。

### 五层推导模型

```
L1: 业务价值层
    └── D1: 价值推导域 (5个技能)

L2: 系统行为层
    └── D2: 架构推导域 (5个技能)

L3: 验收标准层
    └── D3: 规范推导域 (5个技能)

L4: 组件契约层
    └── D4: 契约推导域 (6个技能)

L4.5: 生成调度层 (新增)
    └── D4.5: 生成调度域 (5个技能)

L5: 单元实现层
    └── D5: 实现推导域 (6个技能)
```

### 核心Skills: D1-D8 域 (49个Skills)

| 域 | 名称 | 技能数量 | 说明 |
|--------|------|--------|-------------|
| **D1** | 价值推导域 | 5 | L1→L2: 业务目标到功能需求 |
| **D2** | 架构推导域 | 5 | L2→L3: 功能需求到架构决策 |
| **D3** | 规范推导域 | 5 | L3→L4: 系统规范到GWT验收标准 |
| **D4** | 契约推导域 | 6 | L4→L5: 验收标准到测试分层 |
| **D5** | 实现推导域 | 6 | L4→L5: 契约到单元测试和代码 |
| **D6** | 场景适配域 | 10 | 10种场景模式，支持情境感知工作流 |
| **D7** | 演进优化域 | 5 | P9-P10: 递归优化和技能资产化 |
| **D8** | 元能力域 | 9 | 自验证、自调整、语义澄清 |

### 扩展域 (新增)

| 域 | 名称 | 技能数量 | 说明 |
|--------|------|--------|-------------|
| **D4.5** | 生成调度域 | 5 | 确定性评估、代码生成器调度、契约一致性门控 |
| **D7.5** | 知识引擎域 | 2 | 代码图分析、仓库Wiki生成 |

**辅助Skills**: 41个工具（质疑验证、方法论编排、IT服务管理、全栈开发）

---

## 目录结构

```
skills/
├── README.md                       # 本文件（英文）
├── README_CN.md                    # 本文件（中文）
├── SKILLS_SUMMARY.md               # 详细技能列表（英文）
├── SKILLS_SUMMARY_CN.md          # 详细技能列表（中文）
├── MIGRATION.md                   # 迁移指南（英文）
├── MIGRATION_CN.md                # 迁移指南（中文）
├── skill-dependencies.yaml         # 技能依赖关系
├── skills.sh                       # 技能管理脚本
├── LICENSE                         # MIT许可证
│
├── D1-Value-Derivation/           # L1→L2 (5个技能)
│   ├── business-requirements-collector/
│   ├── value-decomposer/
│   ├── metrics-definer/
│   ├── value-architecture-tracer/
│   └── requirement-implementation-tracer/
│
├── D2-Architecture-Derivation/    # L2→L3 (5个技能)
│   ├── architecture-decision-recorder/
│   ├── architecture-pattern-selector/
│   ├── tech-stack-selector/
│   ├── data-flow-analyzer/
│   └── interface-contract-designer/
│
├── D3-Specification-Derivation/  # L3→L4 (5个技能)
│   ├── usecase-designer/
│   ├── nfr-analyzer/
│   ├── spec-to-scenario/
│   ├── scenario-completeness-checker/
│   └── spec-version-manager/
│
├── D4-Contract-Derivation/        # L3→L4 (6个技能) ★ 最关键
│   ├── test-pyramid-deriver/
│   ├── e2e-test-generator/
│   ├── integration-test-generator/
│   ├── contract-test-generator/
│   ├── system-test-generator/
│   └── test-pyramid-validator/
│
├── D4.5-Generation-Dispatch/      # L4→L4.5 (5个技能) ★ 新增
│   ├── deterministic-evaluator/
│   ├── code-generator-dispatcher/
│   ├── contract-consistency-gate/
│   ├── confidence-based-reviewer/
│   └── intent-hierarchizer/
│
├── D5-Implementation-Derivation/ # L4→L5 (6个技能)
│   ├── unit-test-generator/
│   ├── tdd-cycle-runner/
│   ├── contract-driven-code-generator/
│   ├── backend-code-generator/
│   ├── frontend-code-generator/
│   └── code-refactor-engine/
│
├── D6-Scenario-Adaptation/        # 10种场景模式 (10个技能)
│   ├── scenario-detector/
│   ├── standard-mode-workflow/
│   ├── reverse-engineering-suite/
│   ├── dual-track-validator/
│   ├── strangler-pattern-suite/
│   ├── poc-exemption-manager/
│   ├── wartime-hotfix-workflow/
│   ├── federal-constitution-manager/
│   ├── harness-reverse-construction-workflow/  # 新增
│   └── ai-native-build-workflow/               # 新增
│
├── D7-Evolution-Optimization/     # P9-P10 (5个技能)
│   ├── convergence-checker/
│   ├── improvement-budget-allocator/
│   ├── tech-debt-quantifier/
│   ├── skill-lifecycle-manager/
│   └── skill-optimizer/
│
├── D7.5-Knowledge-Engine/         # 知识引擎 (2个技能) ★ 新增
│   ├── code-graph-analyzer/
│   └── repo-wiki-generator/
│
├── D8-Meta-Capability/           # 自验证 (9个技能)
│   ├── derivation-chain-validator/
│   ├── principle-consistency-checker/
│   ├── scenario-mode-recommender/
│   ├── meta-skeptic/
│   ├── architecture-self-auditor/
│   ├── skill-gap-analyzer/
│   ├── adjustment-proposer/
│   ├── adjustment-validator/
│   └── semantic-intent-clarifier/
│
├── Skeptic-Verification/          # 验证 (4个技能)
│   ├── correctness-checker/
│   ├── completeness-checker/
│   ├── consistency-checker/
│   └── boundedness-checker/
│
├── Methodology-Orchestration/     # 编排 (2个技能)
│   ├── methodology-fusion-orchestrator/
│   └── requirement-classifier/
│
├── IT-Service-Management/        # ITIL与部署 (7个技能)
│   ├── deployment-orchestrator/
│   ├── incident-management/
│   ├── problem-management/
│   ├── change-management/
│   ├── service-desk/
│   ├── release-manager/
│   └── rollback-manager/
│
├── AI-Collaboration/             # AI协作 (6个技能)
│   ├── context-manager/
│   ├── skill-recommender/
│   ├── recursive-optimizer/
│   ├── prompt-template-manager/
│   ├── ai-effectiveness-tracker/   # 新增
│   └── system-quality-tracker/     # 新增
│
├── Fullstack-Tools/             # 开发工具 (9个技能)
│   ├── go-backend-scaffolder/
│   ├── vue-quasar-scaffolder/
│   ├── fullstack-project-setup/
│   ├── requirements-to-code-docs/
│   ├── go-vue-fullstack-workflow/
│   ├── makefile-backend-generator/
│   ├── go-cli-builder/
│   ├── rust-cli-builder/
│   └── readme-license-generator/
│
└── Additional-Tools/            # 附加工具 (7个技能)
    ├── business-value-mapper/
    ├── chaos-test-designer/
    ├── generic-code-generator/
    ├── skill-packaging-tool/
    ├── mode-selector/              # 新增
    ├── non-functional-gate-checker/ # 新增
    └── constraint-check-runner/    # 新增
```

---

## 快速开始

### 1. 查看技能列表
参见 [SKILLS_SUMMARY_CN.md](SKILLS_SUMMARY_CN.md) 获取所有99个技能的详细说明。

### 2. 选择合适的技能

| 开发阶段 | 技能 |
|-----------------|--------|
| **L1 业务分析** | `business-requirements-collector`, `value-decomposer`, `metrics-definer` |
| **L2 架构设计** | `architecture-pattern-selector`, `tech-stack-selector`, `interface-contract-designer` |
| **L3 规范定义** | `spec-to-scenario`, `usecase-designer`, `nfr-analyzer` |
| **L4 测试规划** | `test-pyramid-deriver`, `e2e-test-generator`, `integration-test-generator` |
| **L4.5 生成调度** | `deterministic-evaluator`, `code-generator-dispatcher`, `contract-consistency-gate` |
| **L5 实现** | `tdd-cycle-runner`, `unit-test-generator`, `code-refactor-engine` |
| **场景适配** | `scenario-detector`, `standard-mode-workflow`, `reverse-engineering-suite`, `ai-native-build-workflow` |
| **知识引擎** | `code-graph-analyzer`, `repo-wiki-generator` |
| **优化** | `recursive-optimizer`, `convergence-checker`, `skill-optimizer` |
| **元能力** | `derivation-chain-validator`, `semantic-intent-clarifier`, `meta-skeptic` |

### 3. 使用技能
在对话中直接请求使用特定技能：
```
用户："我需要将业务目标分解为功能需求"
AI：正在使用 value-decomposer 技能...
```

---

## 最近更新 (2026-04-30)

### 新增技能 (16个)

1. **D4.5 生成调度域** (5个技能)
   - `deterministic-evaluator` - 评估任务确定性以选择生成策略
   - `code-generator-dispatcher` - 分派到传统代码生成器
   - `contract-consistency-gate` - GATE-001协议实现
   - `confidence-based-reviewer` - 基于置信度的人工审查路由
   - `intent-hierarchizer` - P11意图分层原则实现

2. **D6 场景适配域** (2个技能)
   - `harness-reverse-construction-workflow` - 从遗留代码逆向构建
   - `ai-native-build-workflow` - 具有混合管道的AI原生构建模式

3. **D7.5 知识引擎域** (2个技能)
   - `code-graph-analyzer` - 代码库结构和依赖分析
   - `repo-wiki-generator` - 仓库Wiki和文档生成

4. **AI协作与优化** (2个技能)
   - `ai-effectiveness-tracker` - 双轨AI效果指标
   - `system-quality-tracker` - 双轨系统质量指标

5. **附加工具** (3个技能)
   - `mode-selector` - 三种模式切换及原则强度调整
   - `non-functional-gate-checker` - P14 NFR验证
   - `constraint-check-runner` - P13约束机制化

### 架构增强

- 在L4和L5之间添加L4.5生成调度层
- 添加D7.5知识引擎域用于上下文增强
- 实现双轨优化（系统质量 + AI效果）
- 添加三种开发模式支持（规范驱动、涌现探索、意图驱动）
- 使用GATE-001协议增强约束机制化

---

## 技能统计

| 类别 | 技能数量 | 说明 |
|---------|--------|-------------|
| **D1-D5 推导域** | 27 | 五层推导模型技能 |
| **D4.5 生成调度域** | 5 | 生成策略调度技能 |
| **D6 场景域** | 10 | 10种场景模式适配 |
| **D7 演进域** | 5 | 递归优化与资产化 |
| **D7.5 知识引擎域** | 2 | 代码图和仓库Wiki生成 |
| **D8 元能力域** | 9 | 自验证与调整 |
| **辅助工具** | 41 | 工具与验证 |
| **总计** | **99** | 完整技能库 |
