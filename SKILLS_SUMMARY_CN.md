# Aether.go 技能 V3.0 - 精简总结

**日期**：2026-06-02  
**源**：99 技能（38887 行）  
**目标**：25 技能（10759 行）  
**减少**：75%（99 → 25）

---

## 概览

V3.0 精简将 99 个专业技能合并为 25 个生产级别技能，按 7 个功能分组（A-G）组织。每个合并技能都是其源技能的生产级别替代品，无能力损失。

**备份**：`git tag pre-v3-consolidation`

---

## 合并映射（99 → 25）

### A 组：推导链（6 技能，49→6）

#### A1. requirement-analyzer (L1) — 6→1
| 源技能 | 状态 |
|--------|------|
| business-requirements-collector | 合并 |
| business-value-mapper | 合并 |
| requirement-classifier | 合并 |
| value-decomposer | 合并 |
| metrics-definer | 合并 |
| requirements-to-code-docs | 合并 |

**输出**：L1 功能需求（ISO/IEC 25010:2023 13 类）、NFR、度量

#### A2. architecture-planner (L2) — 6→1
| 源技能 | 状态 |
|--------|------|
| architecture-decision-recorder | 合并 |
| architecture-pattern-selector | 合并 |
| tech-stack-selector | 合并 |
| data-flow-analyzer | 合并 |
| interface-contract-designer | 合并 |
| strangler-pattern-suite | 合并 |

**输出**：L2 架构决策记录、接口契约 (P4)、技术栈

#### A3. spec-engineer (L3) — 8→1
| 源技能 | 状态 |
|--------|------|
| spec-parser (984 行) | 合并 |
| usecase-designer | 合并 |
| bdd-scenario-writer | 合并 |
| atdd-acceptance-test-generator | 合并 |
| spec-to-scenario | 合并 |
| scenario-completeness-checker | 合并 |
| nfr-analyzer | 合并 |
| spec-version-manager | 合并 |

**输出**：L3 用例、GWT 场景、验证 NFR、规范版本

#### A4. test-planner (L4) — 9→1
| 源技能 | 状态 |
|--------|------|
| test-pyramid-deriver (578 行) | 合并 |
| test-pyramid-validator | 合并 |
| e2e-test-generator | 合并 |
| integration-test-generator | 合并 |
| contract-test-generator | 合并 |
| system-test-generator | 合并 |
| unit-test-generator | 合并 |
| sit-scenario-generator | 合并 |
| chaos-test-designer | 合并 |

**输出**：L4 测试金字塔、测试规范、契约测试、非功能测试

#### A5. generation-dispatcher (L4.5) — 4→1
| 源技能 | 状态 |
|--------|------|
| deterministic-evaluator | 合并 |
| code-generator-dispatcher | 合并 |
| contract-consistency-gate | 合并 |
| confidence-based-reviewer | 合并 |

**输出**：L4.5 生成计划、置信度评分、契约违规

#### A6. code-generator (L5) — 4→1
| 源技能 | 状态 |
|--------|------|
| contract-driven-code-generator | 合并 |
| backend-code-generator | 合并 |
| frontend-code-generator | 合并 |
| generic-code-generator | 合并 |

**输出**：L5 实现代码、生成测试

### B 组：项目支撑（3 技能，11→3）

#### B1. go-fullstack-scaffolder — 7→1
| 源技能 | 状态 |
|--------|------|
| go-backend-scaffolder | 合并 |
| go-cli-builder | 合并 |
| vue-quasar-scaffolder | 合并 |
| fullstack-project-setup | 合并 |
| go-vue-fullstack-workflow | 合并 |
| makefile-backend-generator | 合并 |
| readme-license-generator | 合并 |

#### B2. constitution-validator — 3→1
| 源技能 | 状态 |
|--------|------|
| constitution-validator (475 行) | 合并（基础） |
| principle-consistency-checker | 合并 |
| constraint-check-runner | 合并 |

#### B3. context-manager — 独立
原技能保留不变以支撑 P7

### C 组：场景适配（3 技能，12→3）

#### C1. scenario-engine — 9→1
| 源技能 | 状态 |
|--------|------|
| scenario-detector | 合并 |
| scenario-mode-recommender | 合并 |
| mode-selector | 合并 |
| poc-exemption-manager | 合并 |
| dual-track-validator | 合并 |
| ai-native-build-workflow | 合并 |
| standard-mode-workflow | 合并 |
| federal-constitution-manager | 合并 |
| harness-reverse-construction-workflow | 合并 |

#### C2. reverse-engineering-suite — 独立
原技能，深化用于遗留系统场景

#### C3. wartime-hotfix-workflow — 独立
原技能，深化用于应急场景

### D 组：运营（2 技能，6→2）

#### D1. deployment-orchestrator — 4→1
| 源技能 | 状态 |
|--------|------|
| deployment-orchestrator | 合并 |
| rollback-manager | 合并 |
| release-manager | 合并 |
| change-management | 合并 |

#### D2. incident-manager — 2→1
| 源技能 | 状态 |
|--------|------|
| incident-management | 合并 |
| problem-management | 合并 |

### E 组：演进（3 技能，8→3）

#### E1. recursive-optimizer — 独立
原技能（348 行）保留不变

#### E2. skill-manager — 6→1
| 源技能 | 状态 |
|--------|------|
| skill-lifecycle-manager | 合并 |
| skill-optimizer | 合并 |
| skill-recommender | 合并 |
| skill-gap-analyzer | 合并 |
| skill-packaging-tool | 合并 |
| prompt-template-manager | 合并 |

#### E3. metrics-tracker — 2→1
| 源技能 | 状态 |
|--------|------|
| ai-effectiveness-tracker | 合并 |
| system-quality-tracker | 合并 |

### F 组：元能力（2 技能，8→2）

#### F1. architecture-auditor — 4→1
| 源技能 | 状态 |
|--------|------|
| architecture-self-auditor | 合并 |
| derivation-chain-validator | 合并 |
| adjustment-proposer | 合并 |
| adjustment-validator | 合并 |

#### F2. universal-skeptic — 4→1
| 源技能 | 状态 |
|--------|------|
| correctness-checker | 合并 |
| completeness-checker | 合并 |
| consistency-checker | 合并 |
| boundedness-checker | 合并 |

### G 组：独立（6 技能，保留不变）
- intent-hierarchizer
- methodology-fusion-orchestrator
- tdd-cycle-runner
- code-refactor-engine
- meta-skeptic
- semantic-intent-clarifier

---

## 已删除技能（74 个）

**服务台（ITIL 开销）**：service-desk
**非 Go 栈**：rust-cli-builder
**专用非核心技能**（详细列表见英文版 SKILLS_SUMMARY.md）

---

## 验证

**覆盖检查**：
- ✅ 15 条原则（P0-P14）全部覆盖
- ✅ 6 层（L1-L5 + L4.5）全部覆盖
- ✅ 3 种模式（标准、POC、战时）全部支持
- ✅ 10 种场景全部处理
- ✅ Go + Vue + Quasar 全栈支持保留

**无孤儿能力**：每个源技能的主要能力都在目标合并技能中暴露。

**生产级别**：每个合并技能 250+ 行，含完整 I/O 契约和示例。
