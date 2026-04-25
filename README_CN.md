# Aether.go Skills

Aether.go 项目的一套智能化 AI 技能，基于规范驱动、价值导向、测试先行的开发方法论，实现五层推导模型和宪法原则。

---

**语言**: [English](README.md) | [中文](README_CN.md)

---

## 概述

基于 [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) 和 [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md)，本仓库包含 **85 个技能**，按 **D1-D8 推导域** 组织，覆盖完整的五层推导模型。

### 五层推导模型

```
L1: 业务价值层
    └── D1: 价值推导 (5 个技能)

L2: 系统行为层
    └── D2: 架构推导 (5 个技能)

L3: 验收标准层
    └── D3: 规范推导 (5 个技能)

L4: 组件契约层
    └── D4: 契约推导 (6 个技能)

L5: 单元实现层
    └── D5: 实现推导 (6 个技能)
```

### 核心技能：D1-D8 域 (49 个技能)

| 域 | 名称 | 技能数 | 描述 |
|--------|------|--------|-------------|
| **D1** | 价值推导 | 5 | L1→L2: 业务目标到功能需求 |
| **D2** | 架构推导 | 5 | L2→L3: 功能需求到架构决策 |
| **D3** | 规范推导 | 5 | L3→L4: 系统规范到 GWT 验收标准 |
| **D4** | 契约推导 | 6 | L4→L5: 验收标准到测试分层 |
| **D5** | 实现推导 | 6 | L4→L5: 契约到单元测试和代码 |
| **D6** | 场景适配 | 8 | 8 种场景模式用于上下文敏感工作流 |
| **D7** | 演进优化 | 5 | P9-P10: 递归优化和技能资产化 |
| **D8** | 元能力 | 9 | 自我验证、自我调整、语义澄清 |

**支持技能**: 36 个工具（质疑验证、方法论编排、IT 服务管理、全栈开发）

---

## 目录结构

```
skills/
├── README.md                       # 本文件（英文）
├── README_CN.md                    # 本文件（中文）
├── SKILLS_SUMMARY.md               # 技能详细清单（英文）
├── SKILLS_SUMMARY_CN.md            # 技能详细清单（中文）
├── MIGRATION.md                   # 迁移说明（英文）
├── MIGRATION_CN.md                # 迁移说明（中文）
├── skill-dependencies.yaml         # 技能依赖关系
├── skills.sh                       # 技能管理脚本
├── LICENSE                         # MIT 许可证
│
├── D1-Value-Derivation/           # L1→L2 (5 个技能)
│   ├── business-requirements-collector/
│   ├── value-decomposer/
│   ├── metrics-definer/
│   ├── value-architecture-tracer/
│   └── requirement-implementation-tracer/
│
├── D2-Architecture-Derivation/    # L2→L3 (5 个技能)
│   ├── architecture-decision-recorder/
│   ├── architecture-pattern-selector/
│   ├── tech-stack-selector/
│   ├── data-flow-analyzer/
│   └── interface-contract-designer/
│
├── D3-Specification-Derivation/  # L3→L4 (5 个技能)
│   ├── usecase-designer/
│   ├── nfr-analyzer/
│   ├── spec-to-scenario/
│   ├── scenario-completeness-checker/
│   └── spec-version-manager/
│
├── D4-Contract-Derivation/        # L3→L4 (6 个技能) ★ 最关键
│   ├── test-pyramid-deriver/
│   ├── e2e-test-generator/
│   ├── integration-test-generator/
│   ├── contract-test-generator/
│   ├── system-test-generator/
│   └── test-pyramid-validator/
│
├── D5-Implementation-Derivation/ # L4→L5 (6 个技能)
│   ├── unit-test-generator/
│   ├── tdd-cycle-runner/
│   ├── contract-driven-code-generator/
│   ├── backend-code-generator/
│   ├── frontend-code-generator/
│   └── code-refactor-engine/
│
├── D6-Scenario-Adaptation/        # 8 种场景模式 (8 个技能)
│   ├── scenario-detector/
│   ├── standard-mode-workflow/
│   ├── reverse-engineering-suite/
│   ├── dual-track-validator/
│   ├── strangler-pattern-suite/
│   ├── poc-exemption-manager/
│   ├── wartime-hotfix-workflow/
│   └── federal-constitution-manager/
│
├── D7-Evolution-Optimization/     # P9-P10 (5 个技能)
│   ├── convergence-checker/
│   ├── improvement-budget-allocator/
│   ├── tech-debt-quantifier/
│   ├── skill-lifecycle-manager/
│   └── skill-optimizer/
│
├── D8-Meta-Capability/           # 自我验证 (9 个技能)
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
├── Skeptic-Verification/          # 验证 (4 个技能)
│   ├── correctness-checker/
│   ├── completeness-checker/
│   ├── consistency-checker/
│   └── boundedness-checker/
│
├── Methodology-Orchestration/     # 编排 (2 个技能)
│   ├── methodology-fusion-orchestrator/
│   └── requirement-classifier/
│
├── IT-Service-Management/        # ITIL & 部署 (7 个技能)
│   ├── deployment-orchestrator/
│   ├── incident-management/
│   ├── problem-management/
│   ├── change-management/
│   ├── service-desk/
│   ├── release-manager/
│   └── rollback-manager/
│
└── Fullstack-Tools/             # 开发工具 (9 个技能)
    ├── go-backend-scaffolder/
    ├── vue-quasar-scaffolder/
    ├── fullstack-project-setup/
    ├── requirements-to-code-docs/
    ├── go-vue-fullstack-workflow/
    ├── makefile-backend-generator/
    ├── go-cli-builder/
    ├── rust-cli-builder/
    └── readme-license-generator/
```

---

## 快速开始

### 1. 查看技能清单
参见 [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) 了解所有 85 个技能的详细描述。

### 2. 选择合适的技能

| 开发阶段 | 技能 |
|-----------------|--------|
| **L1 业务分析** | `business-requirements-collector`, `value-decomposer`, `metrics-definer` |
| **L2 架构** | `architecture-pattern-selector`, `tech-stack-selector`, `interface-contract-designer` |
| **L3 规范** | `spec-to-scenario`, `usecase-designer`, `nfr-analyzer` |
| **L4 测试规划** | `test-pyramid-deriver`, `e2e-test-generator`, `integration-test-generator` |
| **L5 实现** | `tdd-cycle-runner`, `unit-test-generator`, `code-refactor-engine` |
| **场景适配** | `scenario-detector`, `standard-mode-workflow`, `reverse-engineering-suite` |
| **优化** | `recursive-optimizer`, `convergence-checker`, `skill-optimizer` |
| **元能力** | `derivation-chain-validator`, `semantic-intent-clarifier`, `meta-skeptic` |

### 3. 使用技能
在对话中直接请求使用特定技能：
```
用户: "我需要将业务目标分解为功能需求"
AI: 使用 value-decomposer 技能...
```

---

## 技能统计

| 类别 | 技能数 | 描述 |
|---------|--------|-------------|
| **D1-D5 推导** | 27 | 五层推导模型技能 |
| **D6 场景** | 8 | 8 种场景模式适配 |
| **D7 演进** | 5 | 递归优化与资产化 |
| **D8 元** | 9 | 自我验证与调整 |
| **支持** | 36 | 工具与验证 |
| **总计** | **85** | 完整技能库 |

---

## 协议支持

### ARGUE 协议（Agent 交互）
- **ARGUE-001**: UniversalSkeptic → WorkflowOrchestrator
- **ARGUE-002**: ConstitutionGuardian → ChangeAndTaskAgent
- **ARGUE-003**: RecursiveOptimizer → WorkflowOrchestrator
- **ARGUE-004**: ContextManager → 任意Agent
- **ARGUE-005**: HumanAIBoundaryGuard → 用户

### META 协议（元论证）
- **META-001**: architecture-self-auditor 架构自审
- **META-002**: derivation-chain-validator 推导链验证
- **META-003**: principle-consistency-checker 原则一致性
- **META-004**: adjustment-proposer 调整方案提出
- **META-005**: meta-skeptic 边界合理性质疑

---

## 关键特性

### 五层推导链
```
业务目标 → 功能需求 → 架构决策 → 验收标准 → 测试分层 → 单元测试 → 代码
```

### 宪法原则 (P0-P10)
- P0: Context-Adaptation (情境适配)
- P1: Purpose-Driven (目的主导)
- P2: Planning-Driven (规划驱动)
- P3: Modularity-Orthogonality (模块化与正交性)
- P4: Interface-First (接口先行)
- P5: Occam's Razor (奥卡姆剃刀)
- P6: Test-First (测试先行)
- P7: Context-First (上下文第一性)
- P8: Human-AI Boundary (人机责任边界)
- P9: Recursive Self-Optimization (递归自我优化)
- P10: Skill Assetization (技能资产化)

### 8 种场景模式
1. **Standard**: 绿地项目，完整方法论
2. **Reverse Engineering**: 遗留系统理解
3. **Language Migration**: 技术栈迁移
4. **Refactoring**: 增量架构升级
5. **POC**: 概念验证，快速验证
6. **Emergency**: 生产热修复
7. **Federal**: 多团队分布式开发
8. **Continuous Improvement**: 长期演进

---

## 使用方式

### 通过 OpenCode 自动发现

OpenCode 自动发现 `skills/` 目录下的技能。

### 技能管理脚本

```bash
# 列出所有技能
./skills.sh list

# 显示技能详细信息
./skills.sh show test-pyramid-deriver

# 搜索技能
./skills.sh search "test"

# 查看统计信息
./skills.sh stats

# 验证技能格式
./skills.sh validate
```

---

## 贡献

1. 在相应的 D 域目录下创建新技能目录
2. 添加遵循 OpenCode 规范的 `SKILL.md` 文件
3. 更新 `SKILLS_SUMMARY.md` 和 `skill-dependencies.yaml`
4. 运行 `./skills.sh validate` 验证格式

---

## 参考文档

- [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) - Aether 方法论融合框架
- [ai-agent-architecture-proposal.md](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md) - AI Agent 智能体架构方案 V2.1

---

**创建日期**: 2026-01-16
**最后更新**: 2026-04-25
**维护者**: Aether.go Team

## 最近重构 (2026-04-25)

- 将 `test-pyramid-analyzer` 合并到 `test-pyramid-validator`
- 将 `continuous-improvement-suite` 合并到 `improvement-budget-allocator`
- 将 `spec-evolution-tracker` 合并到 `spec-version-manager`
- 移除已废弃技能: `scenario-mode-selector`, `tdd-red-green-refactor`