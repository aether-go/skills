# Aether.go Skills

A set of intelligent AI skills for the Aether.go project, based on spec-driven, value-oriented, and test-first development methodology, implementing the five-layer derivation model and constitutional principles.

---

**Language**: [English](README.md) | [中文](README_CN.md)

---

## Overview

Based on [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) and [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md), this repository contains **85 skills** organized into **D1-D8 derivation domains** covering the complete five-layer derivation model.

### Five-Layer Derivation Model

```
L1: Business Value Layer
    └── D1: Value Derivation (5 skills)

L2: System Behavior Layer
    └── D2: Architecture Derivation (5 skills)

L3: Acceptance Standard Layer
    └── D3: Specification Derivation (5 skills)

L4: Component Contract Layer
    └── D4: Contract Derivation (6 skills)

L5: Unit Implementation Layer
    └── D5: Implementation Derivation (6 skills)
```

### Core Skills: D1-D8 Domains (49 Skills)

| Domain | Name | Skills | Description |
|--------|------|--------|-------------|
| **D1** | Value Derivation | 5 | L1→L2: Business goals to functional requirements |
| **D2** | Architecture Derivation | 5 | L2→L3: Functional requirements to architecture decisions |
| **D3** | Specification Derivation | 5 | L3→L4: System specs to GWT acceptance criteria |
| **D4** | Contract Derivation | 6 | L4→L5: Acceptance criteria to test stratification |
| **D5** | Implementation Derivation | 6 | L4→L5: Contracts to unit tests and code |
| **D6** | Scenario Adaptation | 8 | 8 scenario modes for context-sensitive workflow |
| **D7** | Evolution Optimization | 5 | P9-P10: Recursive optimization and skill assetization |
| **D8** | Meta-Capability | 9 | Self-verification, self-adjustment, semantic clarification |

**Supporting Skills**: 36 tools (skeptic verification, methodology orchestration, IT service management, fullstack development)

---

## Directory Structure

```
skills/
├── README.md                       # This file (English)
├── README_CN.md                    # This file (Chinese)
├── SKILLS_SUMMARY.md               # Detailed skills list (English)
├── SKILLS_SUMMARY_CN.md          # Detailed skills list (Chinese)
├── MIGRATION.md                   # Migration guide (English)
├── MIGRATION_CN.md                # Migration guide (Chinese)
├── skill-dependencies.yaml         # Skill dependencies
├── skills.sh                       # Skills management script
├── LICENSE                         # MIT License
│
├── D1-Value-Derivation/           # L1→L2 (5 skills)
│   ├── business-requirements-collector/
│   ├── value-decomposer/
│   ├── metrics-definer/
│   ├── value-architecture-tracer/
│   └── requirement-implementation-tracer/
│
├── D2-Architecture-Derivation/    # L2→L3 (5 skills)
│   ├── architecture-decision-recorder/
│   ├── architecture-pattern-selector/
│   ├── tech-stack-selector/
│   ├── data-flow-analyzer/
│   └── interface-contract-designer/
│
├── D3-Specification-Derivation/  # L3→L4 (5 skills)
│   ├── usecase-designer/
│   ├── nfr-analyzer/
│   ├── spec-to-scenario/
│   ├── scenario-completeness-checker/
│   └── spec-version-manager/
│
├── D4-Contract-Derivation/        # L3→L4 (6 skills) ★ Most Critical
│   ├── test-pyramid-deriver/
│   ├── e2e-test-generator/
│   ├── integration-test-generator/
│   ├── contract-test-generator/
│   ├── system-test-generator/
│   └── test-pyramid-validator/
│
├── D5-Implementation-Derivation/ # L4→L5 (6 skills)
│   ├── unit-test-generator/
│   ├── tdd-cycle-runner/
│   ├── contract-driven-code-generator/
│   ├── backend-code-generator/
│   ├── frontend-code-generator/
│   └── code-refactor-engine/
│
├── D6-Scenario-Adaptation/        # 8 Scenario Modes (8 skills)
│   ├── scenario-detector/
│   ├── standard-mode-workflow/
│   ├── reverse-engineering-suite/
│   ├── dual-track-validator/
│   ├── strangler-pattern-suite/
│   ├── poc-exemption-manager/
│   ├── wartime-hotfix-workflow/
│   └── federal-constitution-manager/
│
├── D7-Evolution-Optimization/     # P9-P10 (5 skills)
│   ├── convergence-checker/
│   ├── improvement-budget-allocator/
│   ├── tech-debt-quantifier/
│   ├── skill-lifecycle-manager/
│   └── skill-optimizer/
│
├── D8-Meta-Capability/           # Self-verification (9 skills)
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
├── Skeptic-Verification/          # Verification (4 skills)
│   ├── correctness-checker/
│   ├── completeness-checker/
│   ├── consistency-checker/
│   └── boundedness-checker/
│
├── Methodology-Orchestration/     # Orchestration (2 skills)
│   ├── methodology-fusion-orchestrator/
│   └── requirement-classifier/
│
├── IT-Service-Management/        # ITIL & Deployment (7 skills)
│   ├── deployment-orchestrator/
│   ├── incident-management/
│   ├── problem-management/
│   ├── change-management/
│   ├── service-desk/
│   ├── release-manager/
│   └── rollback-manager/
│
└── Fullstack-Tools/             # Development Tools (9 skills)
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

## Quick Start

### 1. View Skills List
See [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) for detailed descriptions of all 87 skills.

### 2. Choose the Right Skill

| Development Phase | Skills |
|-----------------|--------|
| **L1 Business Analysis** | `business-requirements-collector`, `value-decomposer`, `metrics-definer` |
| **L2 Architecture** | `architecture-pattern-selector`, `tech-stack-selector`, `interface-contract-designer` |
| **L3 Specification** | `spec-to-scenario`, `usecase-designer`, `nfr-analyzer` |
| **L4 Test Planning** | `test-pyramid-deriver`, `e2e-test-generator`, `integration-test-generator` |
| **L5 Implementation** | `tdd-cycle-runner`, `unit-test-generator`, `code-refactor-engine` |
| **Scenario Adaptation** | `scenario-detector`, `standard-mode-workflow`, `reverse-engineering-suite` |
| **Optimization** | `recursive-optimizer`, `convergence-checker`, `skill-optimizer` |
| **Meta-Capability** | `derivation-chain-validator`, `semantic-intent-clarifier`, `meta-skeptic` |

### 3. Use Skills
Request to use a specific skill directly in conversation:
```
User: "I need to decompose business goals into functional requirements"
AI: Using value-decomposer skill...
```

---

## Skill Statistics

| Category | Skills | Description |
|---------|--------|-------------|
| **D1-D5 Derivation** | 27 | Five-layer derivation model skills |
| **D6 Scenario** | 8 | 8 scenario mode adaptation |
| **D7 Evolution** | 5 | Recursive optimization & assetization |
| **D8 Meta** | 9 | Self-verification & adjustment |
| **Supporting** | 36 | Tools & verification |
| **Total** | **85** | Complete skill library |

---

## Protocol Support

### ARGUE Protocols (Agent Interaction)
- **ARGUE-001**: UniversalSkeptic → WorkflowOrchestrator
- **ARGUE-002**: ConstitutionGuardian → ChangeAndTaskAgent
- **ARGUE-003**: RecursiveOptimizer → WorkflowOrchestrator
- **ARGUE-004**: ContextManager → 任意Agent
- **ARGUE-005**: HumanAIBoundaryGuard → 用户

### META Protocols (Meta-Argumentation)
- **META-001**: architecture-self-auditor 架构自审
- **META-002**: derivation-chain-validator 推导链验证
- **META-003**: principle-consistency-checker 原则一致性
- **META-004**: adjustment-proposer 调整方案提出
- **META-005**: meta-skeptic 边界合理性质疑

---

## Key Features

### Five-Layer Derivation Chain
```
Business Goals → Functional Requirements → Architecture Decisions → Acceptance Criteria → Test Stratification → Unit Tests → Code
```

### Constitutional Principles (P0-P10)
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

### 8 Scenario Modes
1. **Standard**: Greenfield projects, full methodology
2. **Reverse Engineering**: Legacy system understanding
3. **Language Migration**: Technology stack migration
4. **Refactoring**: Incremental architecture upgrade
5. **POC**: Proof of concept, rapid validation
6. **Emergency**: Production hotfix
7. **Federal**: Multi-team distributed development
8. **Continuous Improvement**: Long-term evolution

---

## Usage

### Auto-discovery via OpenCode

OpenCode automatically discovers skills in the `skills/` directory.

### Skills Management Script

```bash
# List all skills
./skills.sh list

# Show skill details
./skills.sh show test-pyramid-deriver

# Search skills
./skills.sh search "test"

# View statistics
./skills.sh stats

# Validate skill format
./skills.sh validate
```

---

## Contributing

1. Create a new skill directory in the appropriate D-domain
2. Add a `SKILL.md` file following OpenCode specification
3. Update `SKILLS_SUMMARY.md` and `skill-dependencies.yaml`
4. Run `./skills.sh validate` to verify format

---

## Reference Documents

- [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) - Aether方法论融合框架
- [ai-agent-architecture-proposal.md](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md) - AI Agent智能体架构方案 V2.1

---

**Created**: 2026-01-16
**Last Updated**: 2026-04-25
**Maintainer**: Aether.go Team

## Recent Refactoring (2026-04-25)

- Merged `test-pyramid-analyzer` into `test-pyramid-validator`
- Merged `continuous-improvement-suite` into `improvement-budget-allocator`
- Merged `spec-evolution-tracker` into `spec-version-manager`
- Removed deprecated skills: `scenario-mode-selector`, `tdd-red-green-refactor`
