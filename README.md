# Aether.go Skills

A set of intelligent AI skills for the Aether.go project, based on spec-driven, value-oriented, and test-first development methodology, implementing the five-layer derivation model and constitutional principles.

---

**Language**: [English](README.md) | [中文](README_CN.md)

---

## Overview

Based on [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) and [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md), this repository contains **99 skills** organized into **D1-D8 derivation domains** and extended domains (D4.5, D7.5) covering the complete five-layer derivation model.

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

L4.5: Generation Dispatch Layer (NEW)
    └── D4.5: Generation Dispatch (5 skills)

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
| **D6** | Scenario Adaptation | 10 | 10 scenario modes for context-sensitive workflow |
| **D7** | Evolution Optimization | 5 | P9-P10: Recursive optimization and skill assetization |
| **D8** | Meta-Capability | 9 | Self-verification, self-adjustment, semantic clarification |

### Extended Domains (NEW)

| Domain | Name | Skills | Description |
|--------|------|--------|-------------|
| **D4.5** | Generation Dispatch | 5 | Deterministic evaluation, code generation dispatch, contract consistency gating |
| **D7.5** | Knowledge Engine | 2 | Code-graph analysis, repo-wiki generation |

**Supporting Skills**: 41 tools (skeptic verification, methodology orchestration, IT service management, fullstack development)

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
├── D4.5-Generation-Dispatch/      # L4→L4.5 (5 skills) ★ NEW
│   ├── deterministic-evaluator/
│   ├── code-generator-dispatcher/
│   ├── contract-consistency-gate/
│   ├── confidence-based-reviewer/
│   └── intent-hierarchizer/
│
├── D5-Implementation-Derivation/ # L4→L5 (6 skills)
│   ├── unit-test-generator/
│   ├── tdd-cycle-runner/
│   ├── contract-driven-code-generator/
│   ├── backend-code-generator/
│   ├── frontend-code-generator/
│   └── code-refactor-engine/
│
├── D6-Scenario-Adaptation/        # 10 Scenario Modes (10 skills)
│   ├── scenario-detector/
│   ├── standard-mode-workflow/
│   ├── reverse-engineering-suite/
│   ├── dual-track-validator/
│   ├── strangler-pattern-suite/
│   ├── poc-exemption-manager/
│   ├── wartime-hotfix-workflow/
│   ├── federal-constitution-manager/
│   ├── harness-reverse-construction-workflow/  # NEW
│   └── ai-native-build-workflow/               # NEW
│
├── D7-Evolution-Optimization/     # P9-P10 (5 skills)
│   ├── convergence-checker/
│   ├── improvement-budget-allocator/
│   ├── tech-debt-quantifier/
│   ├── skill-lifecycle-manager/
│   └── skill-optimizer/
│
├── D7.5-Knowledge-Engine/         # Knowledge Engine (2 skills) ★ NEW
│   ├── code-graph-analyzer/
│   └── repo-wiki-generator/
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
├── AI-Collaboration/             # AI Collaboration (6 skills)
│   ├── context-manager/
│   ├── skill-recommender/
│   ├── recursive-optimizer/
│   ├── prompt-template-manager/
│   ├── ai-effectiveness-tracker/   # NEW
│   └── system-quality-tracker/     # NEW
│
├── Fullstack-Tools/             # Development Tools (9 skills)
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
└── Additional-Tools/            # Additional Tools (7 skills)
    ├── business-value-mapper/
    ├── chaos-test-designer/
    ├── generic-code-generator/
    ├── skill-packaging-tool/
    ├── mode-selector/              # NEW
    ├── non-functional-gate-checker/ # NEW
    └── constraint-check-runner/    # NEW
```

---

## Quick Start

### 1. View Skills List
See [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) for detailed descriptions of all 99 skills.

### 2. Choose the Right Skill

| Development Phase | Skills |
|-----------------|--------|
| **L1 Business Analysis** | `business-requirements-collector`, `value-decomposer`, `metrics-definer` |
| **L2 Architecture** | `architecture-pattern-selector`, `tech-stack-selector`, `interface-contract-designer` |
| **L3 Specification** | `spec-to-scenario`, `usecase-designer`, `nfr-analyzer` |
| **L4 Test Planning** | `test-pyramid-deriver`, `e2e-test-generator`, `integration-test-generator` |
| **L4.5 Generation Dispatch** | `deterministic-evaluator`, `code-generator-dispatcher`, `contract-consistency-gate` |
| **L5 Implementation** | `tdd-cycle-runner`, `unit-test-generator`, `code-refactor-engine` |
| **Scenario Adaptation** | `scenario-detector`, `standard-mode-workflow`, `reverse-engineering-suite`, `ai-native-build-workflow` |
| **Knowledge Engine** | `code-graph-analyzer`, `repo-wiki-generator` |
| **Optimization** | `recursive-optimizer`, `convergence-checker`, `skill-optimizer` |
| **Meta-Capability** | `derivation-chain-validator`, `semantic-intent-clarifier`, `meta-skeptic` |

### 3. Use Skills
Request to use a specific skill directly in conversation:
```
User: "I need to decompose business goals into functional requirements"
AI: Using value-decomposer skill...
```

---

## Recent Updates (2026-04-30)

### New Skills Added (16)

1. **D4.5 Generation Dispatch Domain** (5 skills)
   - `deterministic-evaluator` - Evaluate task determinism for generation strategy selection
   - `code-generator-dispatcher` - Dispatch to traditional code generators
   - `contract-consistency-gate` - GATE-001 protocol implementation
   - `confidence-based-reviewer` - Confidence-based human review routing
   - `intent-hierarchizer` - P11 Intent-Hierarchization Principle implementation

2. **D6 Scenario Adaptation** (2 skills)
   - `harness-reverse-construction-workflow` - Reverse construction from legacy code
   - `ai-native-build-workflow` - AI-native build mode with hybrid pipeline

3. **D7.5 Knowledge Engine Domain** (2 skills)
   - `code-graph-analyzer` - Codebase structure and dependency analysis
   - `repo-wiki-generator` - Repository wiki and documentation generation

4. **AI Collaboration & Optimization** (2 skills)
   - `ai-effectiveness-tracker` - Dual-track AI effectiveness metrics
   - `system-quality-tracker` - Dual-track system quality metrics

5. **Additional Tools** (3 skills)
   - `mode-selector` - Three-mode switching with principle strength adjustment
   - `non-functional-gate-checker` - P14 NFR verification
   - `constraint-check-runner` - P13 constraint mechanization

### Architecture Enhancements

- Added L4.5 Generation Dispatch layer between L4 and L5
- Added D7.5 Knowledge Engine domain for context enrichment
- Implemented dual-track optimization (system quality + AI effectiveness)
- Added three-mode development support (norm-driven, emergent exploration, intent-driven)
- Enhanced constraint mechanization with GATE-001 protocol

---

## Skill Statistics

| Category | Skills | Description |
|---------|--------|-------------|
| **D1-D5 Derivation** | 27 | Five-layer derivation model skills |
| **D4.5 Generation Dispatch** | 5 | Generation strategy dispatch skills |
| **D6 Scenario** | 10 | 10 scenario mode adaptation |
| **D7 Evolution** | 5 | Recursive optimization & assetization |
| **D7.5 Knowledge Engine** | 2 | Code-graph and repo-wiki generation |
| **D8 Meta** | 9 | Self-verification & adjustment |
| **Supporting** | 41 | Tools & verification |
| **Total** | **99** | Complete skill library |
