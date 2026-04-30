# Aether.go Skills Summary

---

**Language**: [English](SKILLS_SUMMARY.md) | [中文](SKILLS_SUMMARY_CN.md)

---

Based on Aether.go methodology fusion framework V2.1 and OpenCode skills specifications, **99 skills** have been created covering complete eight derivation domains (D1-D8) per the five-layer derivation model.

## Architecture Update (2026-04-30)

Based on [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) and [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md), the following architectural improvements have been implemented:

### Core Skills: D1-D8 Derivation Domains (49 Skills)

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

### Extended Domains (D4.5, D7.5)

| Domain | Name | Skills | Description |
|--------|------|--------|-------------|
| **D4.5** | Generation Dispatch | 5 | Deterministic evaluation, code generation dispatch, contract consistency gating |
| **D7.5** | Knowledge Engine | 2 | Code-graph analysis, repo-wiki generation |

### Five-Layer Derivation Model

```
L1: Business Value Layer
    └── business-requirements-collector → value-decomposer → metrics-definer
L2: System Behavior Layer
    └── architecture-pattern-selector → tech-stack-selector → data-flow-analyzer → interface-contract-designer
L3: Acceptance Standard Layer
    └── spec-parser → spec-to-scenario → scenario-completeness-checker → usecase-designer → nfr-analyzer
L4: Component Contract Layer
    └── test-pyramid-deriver → e2e-test-generator → integration-test-generator → contract-test-generator → system-test-generator → test-pyramid-validator
L4.5: Generation Dispatch Layer
    └── deterministic-evaluator → code-generator-dispatcher → contract-consistency-gate → confidence-based-reviewer
L5: Unit Implementation Layer
    └── unit-test-generator → tdd-cycle-runner → contract-driven-code-generator → backend-code-generator → frontend-code-generator → code-refactor-engine
```

### Protocol Support (ARGUE-001 to ARGUE-005, META-001 to META-005)

- **ARGUE-001**: UniversalSkeptic → WorkflowOrchestrator (质疑结果)
- **ARGUE-002**: ConstitutionGuardian → ChangeAndTaskAgent (原则违规)
- **ARGUE-003**: RecursiveOptimizer → WorkflowOrchestrator (优化建议)
- **ARGUE-004**: ContextManager → 任意Agent (上下文质量)
- **ARGUE-005**: HumanAIBoundaryGuard → 用户 (语义确认)

### Dynamic Principle Weighting

ConstitutionGuardian supports real-time dynamic weighting for principle conflict resolution:
- Emergency mode: P6 (Test-First) reduced to 0.4
- POC mode: P2, P4 exempted
- Delivery pressure: P9 (Recursive Optimization) reduced

---

## Skills List by Domain

### D1: Value Derivation Domain (5 Skills) — L1→L2

1. **business-requirements-collector**
   - Description: Collect, analyze, and prioritize business requirements from stakeholders
   - Location: `skills/business-requirements-collector/SKILL.md`

2. **value-decomposer** ⭐
   - Description: Decompose business goals into measurable functional requirements
   - Location: `skills/value-decomposer/SKILL.md`

3. **metrics-definer**
   - Description: Define business and technical metrics with monitoring configuration
   - Location: `skills/metrics-definer/SKILL.md`

4. **value-architecture-tracer** ⭐
   - Description: Verify bidirectional mapping between functional requirements and architecture decisions
   - Location: `skills/value-architecture-tracer/SKILL.md`

5. **requirement-implementation-tracer**
   - Description: Establish three-layer bidirectional traceability between requirements, use cases, and implementation
   - Location: `skills/requirement-implementation-tracer/SKILL.md`

### D2: Architecture Derivation Domain (5 Skills) — L2→L3

6. **architecture-decision-recorder**
   - Description: Record architecture decisions with business rationale and alternative analysis
   - Location: `skills/architecture-decision-recorder/SKILL.md`

7. **architecture-pattern-selector**
   - Description: Select architecture patterns based on requirements, constraints, and team capabilities
   - Location: `skills/architecture-pattern-selector/SKILL.md`

8. **tech-stack-selector**
   - Description: Interactive technology stack selection for application type, languages, frameworks, databases
   - Location: `skills/tech-stack-selector/SKILL.md`

9. **data-flow-analyzer**
   - Description: Analyze data flow and value chain to identify bottlenecks
   - Location: `skills/data-flow-analyzer/SKILL.md`

10. **interface-contract-designer** ⭐
    - Description: Design interface contracts with complete input/output/precondition/postcondition definitions
    - Location: `skills/interface-contract-designer/SKILL.md`

### D3: Specification Derivation Domain (5 Skills) — L3→L4

11. **usecase-designer**
    - Description: Design use cases with bidirectional traceability to requirements
    - Location: `skills/usecase-designer/SKILL.md`

12. **nfr-analyzer**
    - Description: Analyze non-functional requirements with measurable metrics and validation criteria
    - Location: `skills/nfr-analyzer/SKILL.md`

13. **spec-to-scenario** ⭐
    - Description: Convert structured specifications to GWT (Given-When-Then) acceptance scenarios
    - Location: `skills/spec-to-scenario/SKILL.md`

14. **scenario-completeness-checker** ⭐
    - Description: Validate GWT scenario coverage completeness including positive/negative paths and boundaries
    - Location: `skills/scenario-completeness-checker/SKILL.md`

15. **spec-version-manager** ⭐
    - Description: Manage specification versions with evolution tracking and impact analysis (merged with spec-evolution-tracker)
    - Location: `skills/spec-version-manager/SKILL.md`

### D4: Contract Derivation Domain (6 Skills) — L3→L4 (Most Critical)

16. **test-pyramid-deriver** ⭐
    - Description: Derive test stratification plans from GWT acceptance criteria with META-005 validation
    - Location: `skills/test-pyramid-deriver/SKILL.md`

17. **integration-test-generator** ⭐
    - Description: Generate integration tests for component collaboration across internal boundaries
    - Location: `skills/integration-test-generator/SKILL.md`

18. **contract-test-generator**
    - Description: Generate consumer-driven contract tests for microservice API compatibility
    - Location: `skills/contract-test-generator/SKILL.md`

19. **e2e-test-generator** ⭐
    - Description: Generate end-to-end tests for complete user journeys across system boundaries
    - Location: `skills/e2e-test-generator/SKILL.md`

20. **system-test-generator** ⭐
    - Description: Generate non-functional system tests for performance, security, reliability, scalability
    - Location: `skills/system-test-generator/SKILL.md`

21. **test-pyramid-validator** ⭐
    - Description: Validate test proportions and analyze coverage/distribution (merged with test-pyramid-analyzer)
    - Location: `skills/test-pyramid-validator/SKILL.md`

### D4.5: Generation Dispatch Domain (5 Skills) — L4→L4.5 (NEW)

22. **deterministic-evaluator** ⭐
    - Description: Evaluate determinism score of component contracts to decide generation strategy (traditional vs AI)
    - Location: `skills/deterministic-evaluator/SKILL.md`

23. **code-generator-dispatcher** ⭐
    - Description: Dispatch deterministic tasks to appropriate traditional code generators based on pattern matching
    - Location: `skills/code-generator-dispatcher/SKILL.md`

24. **contract-consistency-gate** ⭐
    - Description: Verify generated code conforms to component contracts before entering L5 (GATE-001)
    - Location: `skills/contract-consistency-gate/SKILL.md`

25. **confidence-based-reviewer** ⭐
    - Description: Grade AI-generated code confidence and route to appropriate human review level
    - Location: `skills/confidence-based-reviewer/SKILL.md`

26. **intent-hierarchizer** ⭐
    - Description: Layer business intent into three levels (business, functional, implementation) for intent-driven development (P11)
    - Location: `skills/intent-hierarchizer/SKILL.md`

### D5: Implementation Derivation Domain (6 Skills) — L4→L5

27. **unit-test-generator** ⭐
    - Description: Generate unit tests from interface contracts with boundary value analysis
    - Location: `skills/unit-test-generator/SKILL.md`

28. **tdd-cycle-runner** ⭐
    - Description: Execute complete TDD red-green-refactor cycle as atomic skill
    - Location: `skills/tdd-cycle-runner/SKILL.md`

29. **contract-driven-code-generator** ⭐
    - Description: Generate skeleton code from interface contracts
    - Location: `skills/contract-driven-code-generator/SKILL.md`

30. **backend-code-generator** ⭐
    - Description: Generate backend implementation from contracts and business logic
    - Location: `skills/backend-code-generator/SKILL.md`

31. **frontend-code-generator** ⭐
    - Description: Generate frontend implementation from contracts and UI specifications
    - Location: `skills/frontend-code-generator/SKILL.md`

32. **code-refactor-engine** ⭐
    - Description: Automated refactoring while preserving behavior
    - Location: `skills/code-refactor-engine/SKILL.md`

### D6: Scenario Adaptation Domain (10 Skills) — 8+2 Scenario Modes

33. **scenario-detector** ⭐
    - Description: Detect appropriate development scenario mode with derivation parameters
    - Location: `skills/scenario-detector/SKILL.md`

34. **standard-mode-workflow** ⭐
    - Description: Standard workflow for greenfield projects with complete five-layer derivation
    - Location: `skills/standard-mode-workflow/SKILL.md`

35. **reverse-engineering-suite** ⭐
    - Description: Extract specifications from legacy systems with static/dynamic analysis
    - Location: `skills/reverse-engineering-suite/SKILL.md`

36. **dual-track-validator** ⭐
    - Description: Parallel verification for technology stack migration with behavioral equivalence
    - Location: `skills/dual-track-validator/SKILL.md`

37. **strangler-pattern-suite** ⭐
    - Description: Incremental component replacement with anti-corruption layer
    - Location: `skills/strangler-pattern-suite/SKILL.md`

38. **poc-exemption-manager** ⭐
    - Description: Manage constitution principle exemptions for proof-of-concept projects
    - Location: `skills/poc-exemption-manager/SKILL.md`

39. **wartime-hotfix-workflow** ⭐
    - Description: Emergency production fix with two-phase process (immediate + post-incident normalization)
    - Location: `skills/wartime-hotfix-workflow/SKILL.md`

40. **federal-constitution-manager** ⭐
    - Description: Multi-team development with global + local constitutions and CDC contracts
    - Location: `skills/federal-constitution-manager/SKILL.md`

41. **harness-reverse-construction-workflow** ⭐ (NEW)
    - Description: Reverse-engineer constraints and architecture from existing codebase through knowledge engine
    - Location: `skills/harness-reverse-construction-workflow/SKILL.md`

42. **ai-native-build-workflow** ⭐ (NEW)
    - Description: Execute AI-native build mode combining intent-driven development with hybrid generation pipeline
    - Location: `skills/ai-native-build-workflow/SKILL.md`

### D7: Evolution Optimization Domain (5 Skills) — P9-P10

43. **convergence-checker** ⭐
    - Description: Check convergence conditions for recursive optimization (boundedness, monotonicity, termination)
    - Location: `skills/convergence-checker/SKILL.md`

44. **improvement-budget-allocator** ⭐
    - Description: Allocate improvement budget with continuous improvement workflow (merged with continuous-improvement-suite)
    - Location: `skills/improvement-budget-allocator/SKILL.md`

45. **tech-debt-quantifier** ⭐
    - Description: Quantify and catalog technical debt with impact analysis
    - Location: `skills/tech-debt-quantifier/SKILL.md`

46. **skill-lifecycle-manager** ⭐
    - Description: Manage skill asset lifecycle from creation through validation to retirement
    - Location: `skills/skill-lifecycle-manager/SKILL.md`

47. **skill-optimizer** ⭐
    - Description: Optimize skill parameters based on execution history and success rate analysis
    - Location: `skills/skill-optimizer/SKILL.md`

### D7.5: Knowledge Engine Domain (2 Skills) — (NEW)

48. **code-graph-analyzer** ⭐
    - Description: Analyze codebase structure, dependencies, and relationships to build code-graph knowledge engine
    - Location: `skills/code-graph-analyzer/SKILL.md`

49. **repo-wiki-generator** ⭐
    - Description: Generate repository wiki with architecture encyclopedia, design decisions, and onboarding guides
    - Location: `skills/repo-wiki-generator/SKILL.md`

### D8: Meta-Capability Domain (9 Skills) — Self-Verification & Semantic Clarification

50. **derivation-chain-validator** ⭐
    - Description: Validate five-layer derivation chain completeness
    - Location: `skills/derivation-chain-validator/SKILL.md`

51. **principle-consistency-checker** ⭐
    - Description: Check principle consistency with dynamic weighting support
    - Location: `skills/principle-consistency-checker/SKILL.md`

52. **scenario-mode-recommender** ⭐
    - Description: Recommend scenario mode with confidence scoring and derivation parameters
    - Location: `skills/scenario-mode-recommender/SKILL.md`

53. **meta-skeptic** ⭐
    - Description: Challenge agent/skill configurations and key derivation outputs
    - Location: `skills/meta-skeptic/SKILL.md`

54. **architecture-self-auditor** ⭐
    - Description: Architecture self-audit across coverage, redundancy, bottleneck, balance, evolution
    - Location: `skills/architecture-self-auditor/SKILL.md`

55. **skill-gap-analyzer** ⭐
    - Description: Analyze skill coverage gaps against methodology requirements
    - Location: `skills/skill-gap-analyzer/SKILL.md`

56. **adjustment-proposer** ⭐
    - Description: Propose architecture adjustments in response to audit findings
    - Location: `skills/adjustment-proposer/SKILL.md`

57. **adjustment-validator** ⭐
    - Description: Validate proposed adjustments for correctness and safety
    - Location: `skills/adjustment-validator/SKILL.md`

58. **semantic-intent-clarifier** ⭐
    - Description: Generate structured reverse clarification questions at critical requirement nodes
    - Location: `skills/semantic-intent-clarifier/SKILL.md`

---

## Supporting Skills (41 Tools)

### Skeptic Verification Skills (4)

59. **correctness-checker**
    - Description: Verify factual accuracy and logical consistency

60. **completeness-checker**
    - Description: Verify content completeness and coverage

61. **consistency-checker**
    - Description: Verify cross-layer and cross-domain consistency

62. **boundedness-checker**
    - Description: Verify boundedness constraints for optimization

### Methodology Orchestration (2)

63. **methodology-fusion-orchestrator**
    - Description: Coordinate end-to-end Aether.go methodology fusion workflow

64. **requirement-classifier**
    - Description: Classify requirements into 7 categories with cross-category relationships

### Specification & Testing (4)

65. **spec-parser**
    - Description: Parse natural language requirements into structured specifications

66. **bdd-scenario-writer**
    - Description: Convert user stories to Gherkin BDD scenario files

67. **atdd-acceptance-test-generator**
    - Description: Generate executable acceptance tests from requirements

68. **sit-scenario-generator**
    - Description: Create system integration test scenarios across services

### Constitution & Traceability (2)

69. **constitution-validator**
    - Description: Validate code and specs comply with constitutional principles

70. **spec-to-code-tracer**
    - Description: Establish bidirectional traceability between specs and code

### AI Collaboration & Optimization (6)

71. **context-manager**
    - Description: Manage project context, conversation history, and information retrieval

72. **skill-recommender**
    - Description: Recommend relevant skills based on current task and context

73. **recursive-optimizer**
    - Description: Optimize skills, prompts, and workflows based on feedback

74. **prompt-template-manager**
    - Description: Manage, version, and optimize AI prompt templates

75. **ai-effectiveness-tracker** (NEW)
    - Description: Track AI collaboration effectiveness metrics (token savings, generation quality, review reduction)

76. **system-quality-tracker** (NEW)
    - Description: Track system quality metrics (completeness, coverage, correctness, satisfaction)

### IT Service Management & Deployment (7)

77. **deployment-orchestrator**
    - Description: Advanced deployment strategy orchestration (canary, blue-green, rolling)

78. **incident-management**
    - Description: ITIL-aligned incident handling processes

79. **problem-management**
    - Description: Root cause analysis and permanent fix management

80. **change-management**
    - Description: Controlled change processes and CAB approval

81. **service-desk**
    - Description: Single point of contact management

82. **release-manager**
    - Description: Release planning and stakeholder coordination

83. **rollback-manager**
    - Description: Automated rollback procedures

### Fullstack Development Tools (9)

84. **go-backend-scaffolder**
    - Description: Generate clean architecture Go backend code

85. **vue-quasar-scaffolder**
    - Description: Generate Vue 3 + Quasar + TypeScript components

86. **fullstack-project-setup**
    - Description: Initialize complete Go + Vue + Quasar fullstack project

87. **requirements-to-code-docs**
    - Description: Generate structured documentation workflow

88. **go-vue-fullstack-workflow**
    - Description: Coordinate Go + Vue fullstack development

89. **makefile-backend-generator**
    - Description: Create production-ready Makefiles for Go projects

90. **go-cli-builder**
    - Description: Build enterprise-grade Go CLI applications

91. **rust-cli-builder**
    - Description: Build enterprise-grade Rust CLI applications

92. **readme-license-generator**
    - Description: Generate bilingual README and LICENSE files

### Additional Tools (7)

93. **business-value-mapper**
    - Description: Transform business objectives into measurable metrics using BMAD

94. **chaos-test-designer**
    - Description: Design chaos engineering experiments

95. **generic-code-generator**
    - Description: Generate production code across multiple languages

96. **skill-packaging-tool**
    - Description: Package skills into distributable packages

97. **mode-selector** (NEW)
    - Description: Manage three-mode switching (norm-driven, emergent exploration, intent-driven) with principle strength adjustment

98. **non-functional-gate-checker** (NEW)
    - Description: Verify non-functional requirements including performance budgets, security scans, compliance checks (P14)

99. **constraint-check-runner** (NEW)
    - Description: Execute constraint checks loaded from constraints/*.yml files (P13, GATE-001)

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
