---
name: principle-consistency-checker
description: Use when checking consistency between constitutional principles (P0-P10) and detecting conflicts or violations that require dynamic weighting resolution
---

# Principle Consistency Checker

## Overview
Check consistency between Aether's constitutional principles (P0-P10) and detect conflicts or violations. Supports ConstitutionGuardian by identifying principle conflicts that require dynamic weighting resolution or constitutional amendments.

## When to Use

```
Principles applied to decision? ─────────┐
                                         │
Need to check consistency? ──────────────┤
                                         ├─► Use principle-consistency-checker
Conflicts detected between principles? ──┤
                                         │
Dynamic weighting needed? ───────────────┘
```

Use when:
- Principles are applied to a decision or action
- Need to check consistency between principles
- Conflicts are suspected between principles
- Dynamic weighting resolution is needed
- Preparing for constitutional amendment

Don't use when:
- Only single principle needs validation
- No principles are involved in decision
- Only code quality needs checking

## Core Pattern

### Principle Consistency Check

```
Decision or Action
    ├── Apply P0: Context-Adaptation
    ├── Apply P1: Purpose-Driven
    ├── Apply P2: Planning-First
    ├── Apply P3: Modularity & Orthogonality
    ├── Apply P4: Interface-First
    ├── Apply P5: Occam's Razor
    ├── Apply P6: Test-First
    ├── Apply P7: Context-First
    ├── Apply P8: Human-AI Boundary
    ├── Apply P9: Recursive Self-Optimization
    └── Apply P10: Skill Library Assetization
         |
         v
    Principle Consistency Checker
         |
         v
Consistency Report
    ├── Compliant Principles
    ├── Conflicting Principles
    └── Recommended Resolution
```

### Conflict Detection

| Conflict Pattern | Conflicting Principles | Severity | Resolution |
|-----------------|----------------------|----------|------------|
| **Emergency Fix** | P6 vs Wartime Mode | High | Dynamic weighting |
| **POC Exploration** | P2 vs P4 vs Rapid Validation | Medium | Dynamic weighting |
| **Technical Debt** | P5 vs Legacy Integration | Medium | Exemption |
| **Over-Optimization** | P9 vs Delivery Pressure | Low | Force stop |
| **Multi-Principle** | P1 + P6 + P9 | High | Dynamic weighting |

### Before (Without Consistency Check)
```yaml
decision: "Skip tests for emergency hotfix"

principles_applied:
  - P6: "Test-First" - VIOLATED
  - P8: "Human-AI Boundary" - COMPLIANT
  
result:
  - Tests skipped without justification
  - No record of violation
  - No plan to catch up
  - Technical debt accumulated
```

### After (With Consistency Check)
```yaml
decision: "Skip tests for emergency hotfix"

principles_applied:
  - P6: "Test-First" - VIOLATED (justified)
  - P8: "Human-AI Boundary" - COMPLIANT
  
consistency_check:
  conflicts:
    - principles: ["P6", "Emergency Mode"]
      severity: "high"
      rationale: "Emergency requires immediate fix, tests can be added post-fix"
      
  resolution:
    type: "dynamic_weighting"
    weights:
      P6: 0.4
      P1: 0.9
      P8: 1.0
      
  amendment:
    id: "AMD-20250424-001"
    effective_period: "2025-04-24T12:00:00Z to 2025-04-25T12:00:00Z"
    conditions:
      - "Fix must be deployed within 2 hours"
      - "Tests must be added within 24 hours"
      - "Post-fix validation required"
      
result:
  - Emergency fix deployed with justification
  - Violation recorded with time-boxing
  - Test catch-up scheduled
  - Technical debt tracked
```

## Quick Reference

### Principle Validation Matrix

| Principle | Validation Focus | Common Violations |
|-----------|-----------------|-------------------|
| **P0** | Scenario mode appropriate | Wrong mode for context |
| **P1** | Business value alignment | Technical decisions without business justification |
| **P2** | Planning before implementation | Code written before architecture |
| **P3** | Module boundaries | God classes, tight coupling |
| **P4** | Interface contracts | Implementation before interface |
| **P5** | Dependency limits | Too many dependencies |
| **P6** | Test coverage | Code without tests |
| **P7** | Context quality | Decisions without sufficient context |
| **P8** | Decision routing | High-risk decisions without human approval |
| **P9** | Optimization bounds | Unbounded optimization |
| **P10** | Skill reusability | One-off solutions |

### Dynamic Weighting Triggers

| Trigger | Action | Example |
|---------|--------|---------|
| **Emergency** | Reduce P6, increase P1 | Production hotfix |
| **POC** | Reduce P2, P4 | Technology validation |
| **Debt** | Reduce P5 | Legacy integration |
| **Pressure** | Reduce P9 | Delivery deadline |
| **Multi-conflict** | Compute all weights | Complex scenario |

## Implementation

### Consistency Engine

```python
class PrincipleConsistencyChecker:
    def __init__(self, principles, decision_context):
        self.principles = principles
        self.context = decision_context
        self.conflicts = []
        
    def check_consistency(self):
        """Check consistency of principles applied to decision."""
        
        # Check each principle
        for principle in self.principles:
            self.check_principle(principle)
        
        # Detect conflicts
        self.detect_conflicts()
        
        # Recommend resolution
        resolution = self.recommend_resolution()
        
        return {
            'consistent': len(self.conflicts) == 0,
            'conflicts': self.conflicts,
            'resolution': resolution,
            'weights': self.calculate_weights()
        }
    
    def check_principle(self, principle):
        """Check if principle is compliant with decision."""
        
        checks = {
            'P0': self.check_context_adaptation,
            'P1': self.check_purpose_driven,
            'P2': self.check_planning_first,
            'P3': self.check_modularity,
            'P4': self.check_interface_first,
            'P5': self.check_occams_razor,
            'P6': self.check_test_first,
            'P7': self.check_context_first,
            'P8': self.check_human_ai_boundary,
            'P9': self.check_recursive_optimization,
            'P10': self.check_skill_assetization
        }
        
        check_func = checks.get(principle.id)
        if check_func:
            result = check_func()
            principle.status = result['status']
            principle.violation = result.get('violation')
    
    def detect_conflicts(self):
        """Detect conflicts between principles."""
        
        # Check for known conflict patterns
        conflict_patterns = [
            {
                'name': 'emergency_fix',
                'principles': ['P6', 'emergency_mode'],
                'condition': self.is_emergency_context
            },
            {
                'name': 'poc_exploration',
                'principles': ['P2', 'P4'],
                'condition': self.is_poc_context
            },
            {
                'name': 'technical_debt',
                'principles': ['P5', 'legacy_integration'],
                'condition': self.is_legacy_context
            },
            {
                'name': 'over_optimization',
                'principles': ['P9', 'delivery_pressure'],
                'condition': self.is_delivery_pressure
            }
        ]
        
        for pattern in conflict_patterns:
            if pattern['condition']():
                self.conflicts.append({
                    'pattern': pattern['name'],
                    'principles': pattern['principles'],
                    'severity': self.calculate_severity(pattern)
                })
    
    def recommend_resolution(self):
        """Recommend resolution for conflicts."""
        
        if not self.conflicts:
            return {'type': 'none', 'action': 'continue'}
        
        # Check if dynamic weighting is needed
        needs_weighting = any(
            c['severity'] in ['high', 'medium'] 
            for c in self.conflicts
        )
        
        if needs_weighting:
            return {
                'type': 'dynamic_weighting',
                'action': 'calculate_weights',
                'rationale': 'Conflicts require dynamic weighting resolution'
            }
        
        return {
            'type': 'exemption',
            'action': 'request_exemption',
            'rationale': 'Low severity conflicts can be exempted'
        }
    
    def calculate_weights(self):
        """Calculate dynamic weights for conflicting principles."""
        
        weights = {}
        
        for principle in self.principles:
            if principle.id == 'P6' and self.is_emergency_context():
                weights['P6'] = 0.4  # Reduce test-first priority
            elif principle.id == 'P2' and self.is_poc_context():
                weights['P2'] = 0.3  # Reduce planning priority
            elif principle.id == 'P5' and self.is_legacy_context():
                weights['P5'] = 0.5  # Reduce dependency limit
            elif principle.id == 'P9' and self.is_delivery_pressure():
                weights['P9'] = 0.2  # Reduce optimization priority
            else:
                weights[principle.id] = 1.0  # Full weight
        
        return weights
```

## Output Format

```yaml
principle_consistency:
  check_id: "pc-20250424-001"
  decision: "Emergency hotfix deployment"
  context: {deadline_pressure: high, risk_level: medium}
  
  principles:
    P0: {status: "compliant", weight: 1.0}
    P1: {status: "compliant", weight: 0.9}
    P2: {status: "compliant", weight: 0.7}
    P3: {status: "compliant", weight: 1.0}
    P4: {status: "compliant", weight: 1.0}
    P5: {status: "compliant", weight: 1.0}
    P6: {status: "violated", weight: 0.4, violation: "Tests skipped for emergency"}
    P7: {status: "compliant", weight: 1.0}
    P8: {status: "compliant", weight: 1.0}
    P9: {status: "compliant", weight: 0.2}
    P10: {status: "compliant", weight: 1.0}
    
  conflicts:
    - pattern: "emergency_fix"
      principles: ["P6", "emergency_mode"]
      severity: "high"
      rationale: "Emergency requires immediate fix"
      
  resolution:
    type: "dynamic_weighting"
    weights: {P6: 0.4, P9: 0.2, P1: 0.9}
    amendment:
      id: "AMD-20250424-001"
      effective_period: "2025-04-24T12:00:00Z to 2025-04-25T12:00:00Z"
      conditions:
        - "Fix deployed within 2 hours"
        - "Tests added within 24 hours"
        - "Post-fix validation required"
        
  recommendations:
    - "Record violation in exemption registry"
    - "Schedule test catch-up within 24 hours"
    - "Monitor for similar emergency patterns"
```

## Integration with Aether.go Methodology

- **Input from**: constitution-guardian (principles applied), context-manager (decision context)
- **Output to**: constitution-guardian (conflict resolution), adjustment-proposer (amendment proposals)
- **Validates with**: meta-skeptic (conflict rationale)
- **Part of**: D8 Meta-Capability Domain (META-003)

## Validation Rules

- All principles MUST be checked
- Conflicts MUST be detected and reported
- Resolution MUST be recommended
- Dynamic weights MUST be calculated for conflicts
- Amendments MUST include time-boxing
- Violations MUST be recorded with justification
