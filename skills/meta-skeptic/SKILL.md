---
name: meta-skeptic
description: Use when challenging boundary rationality of test-pyramid-deriver outputs with META-005 protocol, requiring explicitized argumentation before accepting derivation results
---

# Meta-Skeptic

## Overview
Challenge boundary rationality of test-pyramid-deriver outputs using META-005 protocol. Requires explicitized argumentation before accepting derivation results, preventing irrational test stratification plans from proceeding.

## When to Use

```
test-pyramid-deriver output received? ───┐
                                         │
Need boundary rationality challenge? ────┤
                                         ├─► Use meta-skeptic
META-005 triggered? ─────────────────────┤
                                         │
Key derivation output needs validation? ─┘
```

Use when:
- test-pyramid-deriver has generated test stratification plan
- META-005 protocol is triggered by UniversalSkeptic
- Key derivation output needs boundary rationality validation
- Need to challenge test layer assignments
- Preventing irrational test distribution

Don't use when:
- Only code correctness needs checking
- Only single test layer needs validation
- test-pyramid-deriver has not yet run

## Core Pattern

### META-005 Protocol Flow

```
test-pyramid-deriver outputs test stratification plan
    |
    v
UniversalSkeptic detects key derivation output
    |
    v
Invoke meta-skeptic with META-005
    |
    v
meta-skeptic challenges boundary rationality
    |
    v
test-pyramid-deriver explicitizes boundary rationale
    |
    v
meta-skeptic evaluates explicitized argumentation
    |
    v
If boundary rational: PASS
If boundary irrational: FAIL, trigger adjustment-proposer
```

### Boundary Challenge Dimensions

| Dimension | Challenge Focus | Acceptance Criteria |
|-----------|----------------|---------------------|
| **User-System Boundary** | E2E test scope | Only critical user journeys |
| **System-External Service Boundary** | Contract test coverage | All external dependencies |
| **System Internal Component Boundary** | Integration test scope | Cross-component flows |
| **Global Attribute Boundary** | System test scope | All NFR requirements |
| **Internal Logic Boundary** | Unit test coverage | All business logic branches |

### Challenge Questions

| Boundary | Challenge Question |
|----------|-------------------|
| **User-System** | "Why are N E2E tests assigned to feature X when only M user-visible behaviors exist?" |
| **System-External** | "Do contract tests cover all external service dependencies?" |
| **System-Internal** | "Are integration tests targeting correct component collaborations?" |
| **Global Attribute** | "Do system tests cover all NFR requirements from architecture decisions?" |
| **Internal Logic** | "Do unit tests cover all business logic branches and edge cases?" |

### Before (Without META-005)
```yaml
test_stratification:
  e2e_tests:
    - "e2e-user-login"
    - "e2e-user-signup"
    - "e2e-user-profile"
    - "e2e-user-settings"
    - "e2e-admin-dashboard"
    - "e2e-admin-users"
    - "e2e-admin-settings"
    
  unit_tests:
    - "unit-email-validation"
    - "unit-password-validation"

issues:
  - 7 E2E tests for user features (too many)
  - Admin operations in E2E (should be integration)
  - Only 2 unit tests (insufficient)
  - No contract tests (missing external boundaries)
  - No system tests (NFRs not validated)
```

### After (With META-005)
```yaml
test_stratification:
  e2e_tests:
    - "e2e-user-login"
    - "e2e-user-signup"
    - "e2e-checkout-flow"
    
  integration_tests:
    - "it-auth-session"
    - "it-user-profile"
    - "it-admin-operations"
    
  contract_tests:
    - "ct-payment-gateway"
    - "ct-email-service"
    - "ct-sms-provider"
    - "ct-analytics"
    
  system_tests:
    - "st-load-test"
    - "st-security-scan"
    
  unit_tests:
    - "unit-email-validation"
    - "unit-password-validation"
    - "unit-user-service"
    - "unit-auth-service"
    - "unit-payment-service"
    - "unit-notification-service"

meta_005_validation:
  user_system_boundary: "PASS - Only 3 critical user journeys"
  system_external_boundary: "PASS - All 4 external services covered"
  system_internal_boundary: "PASS - Cross-component flows validated"
  global_attribute_boundary: "PASS - NFRs covered"
  internal_logic_boundary: "PASS - All services have unit tests"
```

## Quick Reference

### META-005 Challenge Flow

```
Receive test stratification plan
    |
    v
Identify boundary assignments
    |
    v
Challenge each boundary:
    ├── User-System: Count user-visible behaviors vs E2E tests
    ├── System-External: List external dependencies vs contract tests
    ├── System-Internal: Identify component flows vs integration tests
    ├── Global Attribute: List NFRs vs system tests
    └── Internal Logic: Count logic branches vs unit tests
    |
    v
Request explicitized rationale
    |
    v
Evaluate rationale
    |
    v
Verdict: BOUNDARY_RATIONAL or BOUNDARY_IRRATIONAL
```

### Boundary Rationality Criteria

| Boundary | Rational Criteria | Irrational Criteria |
|----------|-------------------|---------------------|
| **User-System** | E2E tests <= user-visible behaviors | E2E tests > user-visible behaviors |
| **System-External** | Contract tests >= external dependencies | Missing contract tests for dependencies |
| **System-Internal** | Integration tests cover cross-component flows | Integration tests only test single components |
| **Global Attribute** | System tests cover all NFRs | NFRs not tested |
| **Internal Logic** | Unit tests cover all branches | Branches not tested |

## Implementation

### META-005 Engine

```python
class MetaSkeptic:
    def __init__(self, test_stratification_plan):
        self.plan = test_stratification_plan
        self.challenges = []
        
    def challenge_boundary_rationality(self):
        """Challenge boundary rationality of test stratification plan."""
        
        # Challenge user-system boundary
        self.challenge_user_system_boundary()
        
        # Challenge system-external boundary
        self.challenge_system_external_boundary()
        
        # Challenge system-internal boundary
        self.challenge_system_internal_boundary()
        
        # Challenge global attribute boundary
        self.challenge_global_attribute_boundary()
        
        # Challenge internal logic boundary
        self.challenge_internal_logic_boundary()
        
        return {
            'verdict': self.determine_verdict(),
            'challenges': self.challenges,
            'rationale_required': len(self.challenges) > 0
        }
    
    def challenge_user_system_boundary(self):
        """Challenge user-system boundary rationality."""
        
        e2e_tests = self.plan.get_e2e_tests()
        user_visible_behaviors = self.plan.get_user_visible_behaviors()
        
        if len(e2e_tests) > len(user_visible_behaviors):
            self.challenges.append({
                'boundary': 'user_system',
                'status': 'challenged',
                'question': f"Why are {len(e2e_tests)} E2E tests assigned when only {len(user_visible_behaviors)} user-visible behaviors exist?",
                'severity': 'high'
            })
        
    def challenge_system_external_boundary(self):
        """Challenge system-external boundary rationality."""
        
        contract_tests = self.plan.get_contract_tests()
        external_dependencies = self.plan.get_external_dependencies()
        
        uncovered_dependencies = [
            dep for dep in external_dependencies
            if not any(dep in test for test in contract_tests)
        ]
        
        if uncovered_dependencies:
            self.challenges.append({
                'boundary': 'system_external',
                'status': 'challenged',
                'question': f"Contract tests missing for dependencies: {uncovered_dependencies}",
                'severity': 'high'
            })
    
    def determine_verdict(self):
        """Determine final verdict based on challenges."""
        
        if not self.challenges:
            return 'BOUNDARY_RATIONAL'
        
        high_severity_challenges = [
            c for c in self.challenges 
            if c['severity'] == 'high'
        ]
        
        if high_severity_challenges:
            return 'BOUNDARY_IRRATIONAL'
        
        return 'BOUNDARY_RATIONAL_WITH_WARNINGS'
    
    def evaluate_explicitized_rationale(self, rationale):
        """Evaluate explicitized boundary rationale."""
        
        evaluations = []
        
        for challenge in self.challenges:
            response = rationale.get(challenge['boundary'])
            
            if response:
                evaluation = {
                    'boundary': challenge['boundary'],
                    'response': response,
                    'accepted': self.evaluate_response(challenge, response)
                }
                evaluations.append(evaluation)
        
        return {
            'verdict': 'BOUNDARY_RATIONAL' if all(e['accepted'] for e in evaluations) else 'BOUNDARY_IRRATIONAL',
            'evaluations': evaluations
        }
    
    def evaluate_response(self, challenge, response):
        """Evaluate if response adequately addresses challenge."""
        
        # Check if response provides clear justification
        if not response.get('rationale'):
            return False
        
        # Check if response addresses the specific question
        if challenge['question'] not in response.get('addresses', []):
            return False
        
        # Check if response includes evidence
        if not response.get('evidence'):
            return False
        
        return True
```

## Output Format

```yaml
meta_005_report:
  challenge_id: "META005-20250424-001"
  target_skill: "test-pyramid-deriver"
  
  boundary_challenges:
    - boundary: "user_system"
      status: "challenged"
      question: "Why are 7 E2E tests assigned to user features when only 3 user-visible behaviors exist?"
      severity: "high"
      
    - boundary: "system_external"
      status: "passed"
      rationale: "Contract tests align with 4 external dependencies"
      
    - boundary: "system_internal"
      status: "challenged"
      question: "Are integration tests targeting correct component collaborations?"
      severity: "medium"
      
  explicitized_rationale:
    - boundary: "user_system"
      response: "Reduced to 3 E2E tests: login, signup, checkout. Admin operations moved to integration tests."
      accepted: true
      
    - boundary: "system_internal"
      response: "Integration tests cover auth-session, user-profile, and payment-inventory flows."
      accepted: true
      
  verdict: "BOUNDARY_RATIONAL"
  
  recommendations:
    - "Monitor E2E test count as features grow"
    - "Add contract tests for new external dependencies"
```

## Integration with Aether.go Methodology

- **Input from**: test-pyramid-deriver (stratification plan), universal-skeptic (META-005 trigger)
- **Output to**: adjustment-proposer (if boundary irrational), test-pyramid-deriver (for rationale)
- **Validates with**: correctness-checker (challenge validity)
- **Part of**: D8 Meta-Capability Domain (META-005)

## Validation Rules

- Each boundary MUST be challenged
- Challenges MUST include specific questions
- Rationale MUST be explicitized with evidence
- Verdict MUST be BOUNDARY_RATIONAL or BOUNDARY_IRRATIONAL
- If BOUNDARY_IRRATIONAL, adjustment-proposer MUST be triggered
- High severity challenges MUST be resolved before proceeding
