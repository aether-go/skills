---
name: constitution-validator
description: Use when validating that code and specifications comply with the Aether.go constitutional principles and architectural constraints
---

# Constitution Validator

## Overview
Validate that code, specifications, and architectural decisions comply with the Aether.go constitutional principles and quality standards. Enforces consistency and prevents architectural drift across all 11 constitutional principles.

## When to Use

```
Code review needed? ────────────────────┐
                                        │
New architecture decision? ──────────────┤
                                        ├─► Use constitution-validator
PR ready to merge? ──────────────────────┤
                                        │
Compliance audit required? ──────────────┘
```

Use when:
- Reviewing pull requests
- Validating architectural decisions
- Conducting compliance audits
- Onboarding new developers
- Setting up CI validation gates
- Reviewing specifications
- Validating against Aether.go methodology

Don't use when:
- Writing code (use IDE/Editor)
- Simple style checks (use linters)
- Performance profiling

## Core Pattern

### Aether.go Constitutional Principles (11 Principles)

```markdown
## Project Constitution

### P0: Context-Adaptation Principle (Meta Principle)
**Chinese:** 情境适配原则
**Description:** Constitutional principles should be dynamically adjusted based on project context, not rigidly enforced.

**Exemption Mechanisms:**
- POC Phase: Exempt "Planning-Driven Principle"
- Emergency Fix: Exempt "Test-First Principle" (must complete within 24 hours)
- Legacy System: Exempt "Specification-First Principle" (use reverse engineering)

**Validation:**
- [ ] Project context documented
- [ ] Exemptions justified and time-boxed
- [ ] Review criteria established

---

### P1: Purpose-Driven Principle
**Chinese:** 目的主导原则
**Description:** Any technical decision must start with clear business purpose and end with business value validation.

**Logical Derivation:**
- Premise: Software development's fundamental purpose is to create business value
- Corollary 1: Technical solutions must be traceable to business goals
- Corollary 2: Technical decisions without business purpose are over-engineering
- Corollary 3: Business purpose changes should trigger technical solution re-evaluation

**Validation Standards:**
- [ ] Each ADR contains "Business Purpose" section
- [ ] Each feature linked to at least one business metric
- [ ] Technical debt decisions based on business impact assessment

**Checks:**
- Automated: ADR template validation
- Manual: Code review checklist

---

### P2: Planning-Driven Principle
**Chinese:** 规划驱动原则
**Description:** Before generating implementation code, detailed and verifiable implementation planning must be established.

**Coordination with TDD:**
- Strictly applies in **Specification-Driven Mode**
- In **Emergent Exploration Mode**, planning can be simplified to "hypothesis-validation" framework
- Both modes ultimately require **planning-implementation consistency**

**Planning Completeness Standards:**
- [ ] Scope boundaries: clearly define what to do and what not to do
- [ ] Interface contracts: define system-external interaction contracts
- [ ] Data model: define core domain models
- [ ] Validation criteria: define completion conditions

**Exemption:** POC Phase

---

### P3: Modularity-Orthogonality Principle
**Chinese:** 模块化与正交性原则
**Description:** System should be decomposed into high-cohesion, low-coupling modules with orthogonal separation of concerns.

**Formal Definition:**
- Cohesion: Internal interactions / Total interactions (maximize)
- Coupling: Inter-module interactions / Total interactions (minimize)
- Orthogonality: Concern(module_i) ∩ Concern(module_j) = ∅

**Architecture Pattern Requirements:**
- [ ] Layered architecture: Presentation/Application/Domain/Infrastructure
- [ ] Dependency rule: Inner layers don't depend on outer layers
- [ ] Interface isolation: Depend on abstractions, not concrete implementations

---

### P4: Interface-First Principle
**Chinese:** 接口先行原则
**Description:** Before implementing module internal logic, module interface contracts must be defined and validated first.

**Relationship with TDD:**
- Interface definition is prerequisite for testing
- Contract tests validate interface stability
- Interface changes trigger contract test failures as protection mechanism

**Contract Completeness:**
- [ ] Input: type, format, constraints, boundary values
- [ ] Output: type, format, success/failure semantics
- [ ] Preconditions: state that must be satisfied before call
- [ ] Postconditions: state guaranteed after call
- [ ] Exceptions: error codes, exception types, recovery strategies

**Exemption:** POC Phase

---

### P5: Occams-Razor Principle
**Chinese:** 奥卡姆剃刀原则
**Description:** Choose the simplest design solution that meets requirements, minimizing external dependencies.

**Quantitative Standards:**
- [ ] Dependency count: core dependencies ≤ 5
- [ ] Complexity metrics: cyclomatic complexity, cognitive complexity
- [ ] Decision records: necessity documented for each dependency addition

**Relationship with Recursive Optimization:**
- Simple design reduces optimization space dimensionality
- Fewer dependencies reduce optimization constraints
- Necessary condition for recursive optimization convergence

---

### P6: Test-First Principle
**Chinese:** 测试先行原则
**Description:** Before any feature implementation, failing tests must be written first; before any refactoring, tests must provide protection.

**Red-Green-Refactor Cycle:**
```
State 1 (RED): Test fails
    ↓ Write minimal implementation
State 2 (GREEN): Test passes
    ↓ Refactor optimization
State 3 (REFACTOR): Test passes, code optimized
    ↓ New feature
State 1 (RED): New test fails
```

**Test-First Levels:**
- [ ] Unit level: TDD red-green-refactor
- [ ] Integration level: Contract tests first
- [ ] Acceptance level: ATDD scenario-driven

**Exemption:** Emergency fixes (must complete within 24 hours)

---

### P7: Context-First Principle
**Chinese:** 上下文第一性原则
**Description:** AI-assisted development effectiveness depends on input context quality; context preparation precedes code generation.

**Context Completeness Check:**
- [ ] Requirements context: user stories, acceptance criteria, business rules
- [ ] Technical context: architecture constraints, interface contracts, data models
- [ ] Quality context: performance requirements, security constraints, compliance requirements

**Special Importance in AI Era:**
- AI-generated code quality ∝ Input context quality
- Skill library is assetized沉淀 of context

---

### P8: Human-AI-Boundary Principle
**Chinese:** 人机责任边界原则
**Description:** Clearly distinguish boundaries between human decisions and AI assistance; critical decisions must be confirmed by humans.

**Responsibility Matrix:**

| Decision Type | Human Responsibility | AI Assistance |
|--------------|---------------------|---------------|
| Business goal setting | Full authority | Provide industry benchmarks |
| Architecture design | Approval decision | Generate alternatives |
| Code implementation | Review confirmation | Auto-generate |
| Test cases | Boundary confirmation | Auto-generate |
| Deployment release | Final decision | Risk assessment |

**Confidence Threshold Mechanism:**
- AI confidence > 90%: Auto-execute
- AI confidence 70-90%: Suggest execution, human confirmation
- AI confidence < 70%: Escalate to human

---

### P9: Recursive-Self-Optimization Principle
**Chinese:** 递归自我优化原则
**Description:** System must have capability to self-improve based on feedback, forming "execute-measure-learn-improve" closed loop.

**Formal Model:**
```
S_{t+1} = S_t + O(F(S_t))
```
Where S_t = system state, O = optimization operation, F = feedback

**Convergence Conditions:**
1. **Boundedness:** ∃M, ∀t, |S_t| < M (optimization magnitude limited)
2. **Monotonicity:** Quality(S_{t+1}) ≥ Quality(S_t) - ε (quality doesn't significantly decrease)
3. **Termination:** |S_{t+1} - S_t| < δ or Quality(S_t) > Threshold

**Prevent Over-optimization:**
- [ ] Reserve validation set
- [ ] Multi-objective balance (business value, code quality, development efficiency)
- [ ] Momentum mechanism to prevent high-frequency oscillation

---

### P10: Skill-Assetization Principle
**Chinese:** 技能库资产化原则
**Description:** Treat verified effective patterns, templates, and prompts as reusable skill assets, forming organizational memory.

**Skill Lifecycle:**
```
Creation → Validation → Assetization → Application → Feedback → Optimization → Retirement
```

**Quality Standards:**
- [ ] Success rate: Proportion achieving expected results > 85%
- [ ] Reusability: Usage count across different projects/scenarios
- [ ] Maintenance cost: Human effort required to update skill

**Retirement Conditions:**
- Technology stack obsolete
- Success rate consistently below threshold
- Replaced by better skills
```

### Validation Process

```yaml
validation:
  scope:
    - code_review
    - spec_review
    - architecture_decision
    - workflow_validation

  principles_check:
    - name: "P0: Context-Adaptation"
      rule: "Project context documented, exemptions justified"
      severity: "info"
      
    - name: "P1: Purpose-Driven"
      rule: "Technical decisions traceable to business goals"
      severity: "error"
      
    - name: "P2: Planning-Driven"
      rule: "Implementation planning complete before coding"
      severity: "error"
      exemption: "poc_phase"
      
    - name: "P3: Modularity-Orthogonality"
      rule: "High cohesion, low coupling, orthogonal concerns"
      severity: "warning"
      
    - name: "P4: Interface-First"
      rule: "Interface contracts defined before implementation"
      severity: "error"
      exemption: "poc_phase"
      
    - name: "P5: Occams-Razor"
      rule: "Dependencies ≤ 5, minimal complexity"
      severity: "warning"
      
    - name: "P6: Test-First"
      rule: "Tests written before implementation"
      severity: "error"
      exemption: "emergency_fix"
      
    - name: "P7: Context-First"
      rule: "Complete context prepared before code generation"
      severity: "warning"
      
    - name: "P8: Human-AI-Boundary"
      rule: "Critical decisions have human confirmation"
      severity: "error"
      
    - name: "P9: Recursive-Self-Optimization"
      rule: "Feedback loops established and active"
      severity: "info"
      
    - name: "P10: Skill-Assetization"
      rule: "Patterns documented as reusable skills"
      severity: "info"

  report:
    format: "markdown"
    output: ".aether/docs/09-reports/constitution-validation-report.md"
```

## Implementation

### Validation Rules

```python
class ConstitutionValidator:
    """Validate code and specifications against Aether.go constitutional principles."""
    
    PRINCIPLES = {
        'P0': 'context-adaptation-principle',
        'P1': 'purpose-driven-principle',
        'P2': 'planning-driven-principle',
        'P3': 'modularity-orthogonality-principle',
        'P4': 'interface-first-principle',
        'P5': 'occams-razor-principle',
        'P6': 'test-first-principle',
        'P7': 'context-first-principle',
        'P8': 'human-ai-boundary-principle',
        'P9': 'recursive-self-optimization-principle',
        'P10': 'skill-assetization-principle'
    }
    
    EXEMPTIONS = {
        'poc_phase': ['P2', 'P4'],
        'emergency_fix': ['P6'],
        'legacy_system': ['P4']
    }
    
    def validate(self, artifact, context):
        """Validate artifact against all applicable principles."""
        violations = []
        
        # Check which principles apply based on context
        applicable_principles = self._get_applicable_principles(context)
        
        for principle_id in applicable_principles:
            principle_violations = self._validate_principle(
                principle_id, artifact, context
            )
            violations.extend(principle_violations)
        
        return {
            'valid': len(violations) == 0,
            'violations': violations,
            'compliance_score': self._calculate_compliance_score(violations)
        }
    
    def _get_applicable_principles(self, context):
        """Get list of principles applicable to current context."""
        all_principles = list(self.PRINCIPLES.keys())
        
        # Remove exempted principles
        for exemption_type, exempted in self.EXEMPTIONS.items():
            if context.get(exemption_type):
                all_principles = [p for p in all_principles if p not in exempted]
        
        return all_principles
    
    def _validate_principle(self, principle_id, artifact, context):
        """Validate single principle."""
        violations = []
        
        if principle_id == 'P1':  # Purpose-Driven
            if not self._has_business_traceability(artifact):
                violations.append({
                    'principle': 'P1: Purpose-Driven',
                    'rule': 'Technical decisions must be traceable to business goals',
                    'severity': 'error',
                    'suggestion': 'Add business purpose section to ADR'
                })
        
        elif principle_id == 'P6':  # Test-First
            if not self._has_tests_before_code(artifact):
                violations.append({
                    'principle': 'P6: Test-First',
                    'rule': 'Tests must be written before implementation',
                    'severity': 'error',
                    'suggestion': 'Write failing test before implementation'
                })
        
        elif principle_id == 'P8':  # Human-AI-Boundary
            if not self._has_human_confirmation(artifact):
                violations.append({
                    'principle': 'P8: Human-AI-Boundary',
                    'rule': 'Critical decisions must have human confirmation',
                    'severity': 'error',
                    'suggestion': 'Add human review checkpoint'
                })
        
        return violations
    
    def _calculate_compliance_score(self, violations):
        """Calculate overall constitutional compliance score."""
        error_count = sum(1 for v in violations if v['severity'] == 'error')
        warning_count = sum(1 for v in violations if v['severity'] == 'warning')
        
        # Score: 100 - (errors * 10) - (warnings * 2)
        score = 100 - (error_count * 10) - (warning_count * 2)
        return max(0, score)
```

### Automated CI Gate

```yaml
# .github/workflows/constitution-check.yaml
name: Aether.go Constitution Validation

on: [pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Aether Validator
        run: |
          pip install aether-constitution-validator

      - name: Validate Against Constitution
        run: |
          aether-validate \
            --principles P1,P2,P3,P4,P5,P6,P7,P8,P9,P10 \
            --exemptions ${{ github.event.label }} \
            --output validation-report.json

      - name: Check Compliance Score
        run: |
          score=$(jq '.compliance_score' validation-report.json)
          if (( $(echo "$score < 80" | bc -l) )); then
            echo "❌ Constitutional compliance $score% below 80% threshold"
            exit 1
          fi
          echo "✅ Constitutional compliance: $score%"

      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: constitution-validation-report
          path: validation-report.json
```

### Validation Report Template

```markdown
# Aether.go Constitution Validation Report

**Date:** {{date}}
**Scope:** {{scope}}
**Context:** {{context}}

## Compliance Summary

| Metric | Value |
|--------|-------|
| Overall Score | {{compliance_score}}% |
| Principles Checked | {{principles_checked}} |
| Errors | {{error_count}} |
| Warnings | {{warning_count}} |
| Status | {{status}} |

## Principle-by-Principle Results

### P0: Context-Adaptation Principle
**Status:** {{P0.status}}
{{#if P0.exemptions}}
**Active Exemptions:**
{{#each P0.exemptions}}
- {{this}}
{{/each}}
{{/if}}

### P1: Purpose-Driven Principle
**Status:** {{P1.status}}
{{#if P1.violations}}
**Violations:**
{{#each P1.violations}}
- {{this.rule}}
  - Severity: {{this.severity}}
  - Suggestion: {{this.suggestion}}
{{/each}}
{{/if}}

### P2: Planning-Driven Principle
**Status:** {{P2.status}}
...

### P3-P10
[Similar sections for each principle]

## Conclusion

{{#if all_passed}}
✅ **All constitutional principles satisfied.** Ready for merge.
{{else}}
❌ **Constitutional violations detected.** Please address before merge.
{{/if}}

## Next Steps

{{#each action_items}}
{{@index}}. [{{this.priority}}] {{this.action}}
{{/each}}
```

### Constitution Configuration

```yaml
# .aether/constitution.yaml
constitution:
  version: "2.0"
  methodology: "aether-go"
  
  principles:
    P0:
      name: "context-adaptation-principle"
      chinese: "情境适配原则"
      enabled: true
      
    P1:
      name: "purpose-driven-principle"
      chinese: "目的主导原则"
      enabled: true
      enforcement: strict
      
    P2:
      name: "planning-driven-principle"
      chinese: "规划驱动原则"
      enabled: true
      enforcement: strict
      exemptions:
        - poc_phase
        
    P3:
      name: "modularity-orthogonality-principle"
      chinese: "模块化与正交性原则"
      enabled: true
      enforcement: warning
      
    P4:
      name: "interface-first-principle"
      chinese: "接口先行原则"
      enabled: true
      enforcement: strict
      exemptions:
        - poc_phase
        
    P5:
      name: "occams-razor-principle"
      chinese: "奥卡姆剃刀原则"
      enabled: true
      enforcement: warning
      max_dependencies: 5
      
    P6:
      name: "test-first-principle"
      chinese: "测试先行原则"
      enabled: true
      enforcement: strict
      exemptions:
        - emergency_fix
      
    P7:
      name: "context-first-principle"
      chinese: "上下文第一性原则"
      enabled: true
      enforcement: warning
      
    P8:
      name: "human-ai-boundary-principle"
      chinese: "人机责任边界原则"
      enabled: true
      enforcement: strict
      confidence_thresholds:
        auto_execute: 0.90
        suggest_confirm: 0.70
        escalate_human: 0.00
        
    P9:
      name: "recursive-self-optimization-principle"
      chinese: "递归自我优化原则"
      enabled: true
      enforcement: info
      convergence:
        bounded: true
        monotonic: true
        termination_delta: 0.01
        
    P10:
      name: "skill-assetization-principle"
      chinese: "技能库资产化原则"
      enabled: true
      enforcement: info
      quality_thresholds:
        success_rate: 0.85
        reusability: 3

  exemptions:
    poc_phase:
      description: "Proof of concept phase"
      exempt_principles: ["P2", "P4"]
      max_duration: "4 weeks"
      
    emergency_fix:
      description: "Emergency production fix"
      exempt_principles: ["P6"]
      completion_deadline: "24 hours"
      
    legacy_system:
      description: "Legacy system maintenance"
      exempt_principles: ["P4"]
      approach: "reverse-engineering"
```

## Quick Reference

### Principle Severity Levels

| Level | Description | Action Required |
|-------|-------------|-----------------|
| **error** | Principle violated | Must fix before merge |
| **warning** | Principle not fully satisfied | Should address, can proceed with justification |
| **info** | Principle satisfied or not applicable | No action required |

### Exemption Types

| Exemption | Exempted Principles | Conditions |
|-----------|---------------------|------------|
| `poc_phase` | P2, P4 | POC duration ≤ 4 weeks |
| `emergency_fix` | P6 | Fix within 24 hours |
| `legacy_system` | P4 | Using reverse engineering |

### Compliance Score Calculation

```
Score = 100 - (errors × 10) - (warnings × 2)

Pass: Score ≥ 80
Conditional Pass: 60 ≤ Score < 80
Fail: Score < 60
```

## Integration with Aether.go Methodology

### Stage Gates

```yaml
stage_validation:
  stage_1_business_analysis:
    required_principles: [P0, P1]
    
  stage_2_specification:
    required_principles: [P0, P1, P7]
    
  stage_3_constitutional_review:
    required_principles: [P0, P1, P2, P3, P4, P5, P6, P7, P8, P9, P10]
    gate: true  # Must pass to proceed
    
  stage_4_implementation_planning:
    required_principles: [P2, P3, P4, P5]
    
  stage_5_code_generation:
    required_principles: [P6, P7, P8]
    
  stage_6_integration_validation:
    required_principles: [P6, P9]
    
  stage_7_deployment:
    required_principles: [P8]
    
  stage_8_recursive_optimization:
    required_principles: [P9, P10]
```

### Metrics Collection

```yaml
metrics:
  constitutional_compliance:
    collection_points:
      - stage_start
      - principle_validation
      - stage_completion
    aggregation: realtime
    
  principle_effectiveness:
    tracking:
      - violation_frequency
      - exemption_usage
      - compliance_trends
    reporting:
      frequency: weekly
      dashboard: true
```
