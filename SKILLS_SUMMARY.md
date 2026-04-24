# Aether.go Skills Summary

---

**Language**: [English](SKILLS_SUMMARY.md) | [中文](SKILLS_SUMMARY_CN.md)

---

Based on Aether.go methodology fusion framework V2.1 and OpenCode skills specifications, **87 skills** have been created covering complete eight derivation domains (D1-D8) per the five-layer derivation model.

## Architecture Update (2026-04-24)

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

### Five-Layer Derivation Model

```
L1: Business Value Layer
    └── business-requirements-collector → value-decomposer → metrics-definer
L2: System Behavior Layer
    └── architecture-pattern-selector → tech-stack-selector → data-flow-analyzer → interface-contract-designer
L3: Acceptance Standard Layer
    └── spec-parser → spec-to-scenario → scenario-completeness-checker → usecase-designer → nfr-analyzer
L4: Component Contract Layer
    └── test-pyramid-deriver → e2e-test-generator → integration-test-generator → contract-test-generator → system-test-generator → test-pyramid-analyzer
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

15. **spec-evolution-tracker**
    - Description: Track specification change history and impact analysis
    - Location: `skills/spec-evolution-tracker/SKILL.md`

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

21. **test-pyramid-analyzer**
    - Description: Analyze test coverage, distribution, and test strategy gaps
    - Location: `skills/test-pyramid-analyzer/SKILL.md`

### D5: Implementation Derivation Domain (6 Skills) — L4→L5

22. **unit-test-generator** ⭐
    - Description: Generate unit tests from interface contracts with boundary value analysis
    - Location: `skills/unit-test-generator/SKILL.md`

23. **tdd-cycle-runner** ⭐
    - Description: Execute complete TDD red-green-refactor cycle as atomic skill
    - Location: `skills/tdd-cycle-runner/SKILL.md`

24. **contract-driven-code-generator** ⭐
    - Description: Generate skeleton code from interface contracts
    - Location: `skills/contract-driven-code-generator/SKILL.md`

25. **backend-code-generator** ⭐
    - Description: Generate backend implementation from contracts and business logic
    - Location: `skills/backend-code-generator/SKILL.md`

26. **frontend-code-generator** ⭐
    - Description: Generate frontend implementation from contracts and UI specifications
    - Location: `skills/frontend-code-generator/SKILL.md`

27. **code-refactor-engine** ⭐
    - Description: Automated refactoring while preserving behavior
    - Location: `skills/code-refactor-engine/SKILL.md`

### D6: Scenario Adaptation Domain (8 Skills) — 8 Scenario Modes

28. **scenario-detector** ⭐
    - Description: Detect appropriate development scenario mode with derivation parameters
    - Location: `skills/scenario-detector/SKILL.md`

29. **standard-mode-workflow** ⭐
    - Description: Standard workflow for greenfield projects with complete five-layer derivation
    - Location: `skills/standard-mode-workflow/SKILL.md`

30. **reverse-engineering-suite** ⭐
    - Description: Extract specifications from legacy systems with static/dynamic analysis
    - Location: `skills/reverse-engineering-suite/SKILL.md`

31. **dual-track-validator** ⭐
    - Description: Parallel verification for technology stack migration with behavioral equivalence
    - Location: `skills/dual-track-validator/SKILL.md`

32. **strangler-pattern-suite** ⭐
    - Description: Incremental component replacement with anti-corruption layer
    - Location: `skills/strangler-pattern-suite/SKILL.md`

33. **poc-exemption-manager** ⭐
    - Description: Manage constitution principle exemptions for proof-of-concept projects
    - Location: `skills/poc-exemption-manager/SKILL.md`

34. **wartime-hotfix-workflow** ⭐
    - Description: Emergency production fix with two-phase process (immediate + post-incident normalization)
    - Location: `skills/wartime-hotfix-workflow/SKILL.md`

35. **federal-constitution-manager** ⭐
    - Description: Multi-team development with global + local constitutions and CDC contracts
    - Location: `skills/federal-constitution-manager/SKILL.md`

### D7: Evolution Optimization Domain (5 Skills) — P9-P10

36. **convergence-checker** ⭐
    - Description: Check convergence conditions for recursive optimization (boundedness, monotonicity, termination)
    - Location: `skills/convergence-checker/SKILL.md`

37. **improvement-budget-allocator** ⭐
    - Description: Allocate improvement budget following 70/20/10 rule (delivery/debt/experimental)
    - Location: `skills/improvement-budget-allocator/SKILL.md`

38. **tech-debt-quantifier** ⭐
    - Description: Quantify and catalog technical debt with impact analysis
    - Location: `skills/tech-debt-quantifier/SKILL.md`

39. **skill-lifecycle-manager** ⭐
    - Description: Manage skill asset lifecycle from creation through validation to retirement
    - Location: `skills/skill-lifecycle-manager/SKILL.md`

40. **skill-optimizer** ⭐
    - Description: Optimize skill parameters based on execution history and success rate analysis
    - Location: `skills/skill-optimizer/SKILL.md`

### D8: Meta-Capability Domain (9 Skills) — Self-Verification & Semantic Clarification

41. **derivation-chain-validator** ⭐
    - Description: Validate five-layer derivation chain completeness
    - Location: `skills/derivation-chain-validator/SKILL.md`

42. **principle-consistency-checker** ⭐
    - Description: Check principle consistency with dynamic weighting support
    - Location: `skills/principle-consistency-checker/SKILL.md`

43. **scenario-mode-recommender** ⭐
    - Description: Recommend scenario mode with confidence scoring and derivation parameters
    - Location: `skills/scenario-mode-recommender/SKILL.md`

44. **meta-skeptic** ⭐
    - Description: Challenge agent/skill configurations and key derivation outputs
    - Location: `skills/meta-skeptic/SKILL.md`

45. **architecture-self-auditor** ⭐
    - Description: Architecture self-audit across coverage, redundancy, bottleneck,均衡度, evolution
    - Location: `skills/architecture-self-auditor/SKILL.md`

46. **skill-gap-analyzer** ⭐
    - Description: Analyze skill coverage gaps against methodology requirements
    - Location: `skills/skill-gap-analyzer/SKILL.md`

47. **adjustment-proposer** ⭐
    - Description: Propose architecture adjustments in response to audit findings
    - Location: `skills/adjustment-proposer/SKILL.md`

48. **adjustment-validator** ⭐
    - Description: Validate proposed adjustments for correctness and safety
    - Location: `skills/adjustment-validator/SKILL.md`

49. **semantic-intent-clarifier** ⭐
    - Description: Generate structured reverse clarification questions at critical requirement nodes
    - Location: `skills/semantic-intent-clarifier/SKILL.md`

---

## Supporting Skills (38 Tools)

### Skeptic Verification Skills (4)

50. **correctness-checker**
    - Description: Verify factual accuracy and logical consistency

51. **completeness-checker**
    - Description: Verify content completeness and coverage

52. **consistency-checker**
    - Description: Verify cross-layer and cross-domain consistency

53. **boundedness-checker**
    - Description: Verify boundedness constraints for optimization

### Methodology Orchestration (2)

54. **methodology-fusion-orchestrator**
    - Description: Coordinate end-to-end Aether.go methodology fusion workflow

55. **requirement-classifier**
    - Description: Classify requirements into 7 categories with cross-category relationships

### Specification & Testing (4)

56. **spec-parser**
    - Description: Parse natural language requirements into structured specifications

57. **bdd-scenario-writer**
    - Description: Convert user stories to Gherkin BDD scenario files

58. **atdd-acceptance-test-generator**
    - Description: Generate executable acceptance tests from requirements

59. **sit-scenario-generator**
    - Description: Create system integration test scenarios across services

### Constitution & Traceability (2)

60. **constitution-validator**
    - Description: Validate code and specs comply with constitutional principles

61. **spec-to-code-tracer**
    - Description: Establish bidirectional traceability between specs and code

### AI Collaboration & Optimization (4)

62. **context-manager**
    - Description: Manage project context, conversation history, and information retrieval

63. **skill-recommender**
    - Description: Recommend relevant skills based on current task and context

64. **recursive-optimizer**
    - Description: Optimize skills, prompts, and workflows based on feedback

65. **prompt-template-manager**
    - Description: Manage, version, and optimize AI prompt templates

### IT Service Management & Deployment (7)

66. **deployment-orchestrator**
    - Description: Advanced deployment strategy orchestration (canary, blue-green, rolling)

67. **incident-management**
    - Description: ITIL-aligned incident handling processes

68. **problem-management**
    - Description: Root cause analysis and permanent fix management

69. **change-management**
    - Description: Controlled change processes and CAB approval

70. **service-desk**
    - Description: Single point of contact management

71. **release-manager**
    - Description: Release planning and stakeholder coordination

72. **rollback-manager**
    - Description: Automated rollback procedures

### Fullstack Development Tools (9)

73. **go-backend-scaffolder**
    - Description: Generate clean architecture Go backend code

74. **vue-quasar-scaffolder**
    - Description: Generate Vue 3 + Quasar + TypeScript components

75. **fullstack-project-setup**
    - Description: Initialize complete Go + Vue + Quasar fullstack project

76. **requirements-to-code-docs**
    - Description: Generate structured documentation workflow

77. **go-vue-fullstack-workflow**
    - Description: Coordinate Go + Vue fullstack development

78. **makefile-backend-generator**
    - Description: Create production-ready Makefiles for Go projects

79. **go-cli-builder**
    - Description: Build enterprise-grade Go CLI applications

80. **rust-cli-builder**
    - Description: Build enterprise-grade Rust CLI applications

81. **readme-license-generator**
    - Description: Generate bilingual README and LICENSE files

### Additional Tools (6)

82. **business-value-mapper**
    - Description: Transform business objectives into measurable metrics using BMAD

83. **chaos-test-designer**
    - Description: Design chaos engineering experiments

84. **generic-code-generator**
    - Description: Generate production code across multiple languages

85. **skill-packaging-tool**
    - Description: Package skills into distributable packages

86. **tdd-red-green-refactor**
    - Description: Implement features using TDD methodology

87. **scenario-mode-selector**
    - Description: Select appropriate scenario mode (legacy, use scenario-detector)

---

## Skill Structure

Each skill follows OpenCode specifications:
- YAML frontmatter (name and description)
- Description starts with "Use when..."
- Names use lowercase letters, numbers, and hyphens
- File path: `skills/<name>/SKILL.md`

---

**Created**: 2026-01-16
**Last Updated**: 2026-04-24
**Reference Documents**: `method-paper.md`, `ai-agent-architecture-proposal.md V2.1`
