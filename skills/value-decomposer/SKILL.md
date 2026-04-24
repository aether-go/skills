---
name: value-decomposer
description: Use when decomposing high-level business goals into measurable functional requirements, establishing the L1 to L2 derivation bridge in Aether methodology
---

# Value Decomposer

## Overview
Decompose high-level business goals (L1) into measurable, actionable functional requirements (L2) using the BMAD framework. Establishes the critical L1->L2 derivation bridge in the Aether five-layer derivation model, ensuring every functional requirement traces directly to business value.

## When to Use

```
Business goal specified? ────────────────┐
                                         │
Need functional requirements? ───────────┤
                                         ├─► Use value-decomposer
L1 -> L2 derivation needed? ─────────────┤
                                         │
BMAD value mapping required? ────────────┘
```

Use when:
- Starting a new project and need to derive functional requirements from business goals
- Business goals are defined but lack technical decomposition
- Need to establish traceability between business value and functional requirements
- Following Aether.go methodology five-layer derivation model (L1->L2)
- Preparing input for usecase-designer and spec-parser

Don't use when:
- Functional requirements already exist and are validated
- Only technical implementation details are needed
- Business goals are not yet defined (use business-requirements-collector first)

## Core Pattern

### L1 -> L2 Derivation Model

```
L1: Business Goals (Business Layer)
    ├── Goal 1: Increase user base by 30%
    ├── Goal 2: Reduce churn rate to <5%
    └── Goal 3: Improve NPS to >50
         |
         v
    Value Decomposition
         |
         v
L2: Functional Requirements (System Behavior Layer)
    ├── FR-001: User registration with email/phone/social login
    ├── FR-002: Onboarding tutorial flow
    ├── FR-003: User profile management
    ├── FR-004: In-app feedback collection
    ├── FR-005: Retention email campaigns
    └── FR-006: Customer support ticket system
```

### Derivation Rules

```
L1: Business Goal BG
    ├── value-decomposer ──→ Functional Requirements FR[]
    ├── metrics-definer ──→ Success Metrics M[]
    └── business-value-mapper ──→ BMAD Matrix
```

### Before (Without Value Decomposition)
```yaml
business_goal: "Grow user base"

team_interpretation:
  developer_a: "I'll add more signup options"
  developer_b: "I'll improve the landing page"
  developer_c: "I'll add referral program"

result:
  - Scattered effort, unclear priorities
  - No measurement of business value delivery
  - Missing critical features (onboarding, retention)
  - Cannot trace code changes to business goals
```

### After (With Value Decomposition)
```yaml
business_goal: "Grow user base by 30% in Q3"

decomposition:
  bg-001:
    goal: "Grow user base by 30% in Q3"
    current_baseline: "10,000 users"
    target: "13,000 users"
    deadline: "2025-09-30"
    
    functional_requirements:
      fr-001:
        description: "Multi-channel user registration (email, phone, WeChat, Google)"
        business_value: "Reduce signup friction, capture 15% more leads"
        priority: "must"
        acceptance_criteria: ["ac-001", "ac-002", "ac-003"]
        
      fr-002:
        description: "Guided onboarding tutorial flow"
        business_value: "Improve activation rate by 20%"
        priority: "must"
        acceptance_criteria: ["ac-004", "ac-005"]
        
      fr-003:
        description: "Referral program with rewards"
        business_value: "Drive 10% organic growth"
        priority: "should"
        acceptance_criteria: ["ac-006", "ac-007"]
        
      fr-004:
        description: "User re-engagement email campaigns"
        business_value: "Recover 5% dormant users"
        priority: "should"
        acceptance_criteria: ["ac-008"]

    metrics:
      m-001: {name: "monthly_new_users", target: 1000, current: 700}
      m-002: {name: "signup_conversion_rate", target: "25%", current: "18%"}
      m-003: {name: "user_activation_rate", target: "60%", current: "45%"}
```

## Quick Reference

| Business Goal Pattern | Typical Functional Requirements | Metrics |
|----------------------|--------------------------------|---------|
| **Grow user base** | Multi-channel signup, onboarding, referral | New users, conversion rate, activation rate |
| **Increase revenue** | Checkout optimization, pricing, upsell | Conversion rate, AOV, LTV |
| **Reduce costs** | Automation, efficiency tools, resource optimization | Cost per user, automation rate |
| **Improve UX** | Simplified flows, personalization, performance | Task completion rate, NPS, load time |
| **Increase reliability** | Redundancy, monitoring, alerting | Uptime, MTTR, error rate |
| **Accelerate delivery** | CI/CD, templates, automation | Deployment frequency, lead time |

## Implementation

### Decomposition Process

#### Step 1: Clarify Business Goal
```python
def clarify_business_goal(raw_goal):
    """Engage with stakeholders to clarify vague goals."""
    
    questions = [
        "What does success look like? Quantify it.",
        "What is the current baseline?",
        "What is the target timeframe?",
        "How will we know when we've succeeded?",
        "What is the business impact of not achieving this?",
        "What constraints exist (budget, timeline, resources)?"
    ]
    
    clarified_goal = engage_stakeholder(raw_goal, questions)
    return clarified_goal
```

#### Step 2: Identify Value Streams
```python
def identify_value_streams(business_goal):
    """Break down business goal into value streams."""
    
    value_stream_templates = {
        'user_acquisition': ['signup', 'onboarding', 'activation'],
        'user_retention': ['engagement', 're-engagement', 'support'],
        'monetization': ['checkout', 'pricing', 'upsell'],
        'efficiency': ['automation', 'optimization', 'scaling']
    }
    
    # Match goal keywords to value streams
    relevant_streams = []
    for stream, activities in value_stream_templates.items():
        if any(keyword in business_goal.lower() for keyword in stream):
            relevant_streams.extend(activities)
    
    return relevant_streams
```

#### Step 3: Derive Functional Requirements
```python
def derive_functional_requirements(value_streams):
    """Derive functional requirements from value streams."""
    
    requirement_catalog = {
        'signup': [
            {'id': 'fr-auth-001', 'desc': 'Email registration', 'value': 'Primary signup channel'},
            {'id': 'fr-auth-002', 'desc': 'Social login integration', 'value': 'Reduce friction'}
        ],
        'onboarding': [
            {'id': 'fr-onb-001', 'desc': 'Tutorial flow', 'value': 'Improve activation'},
            {'id': 'fr-onb-002', 'desc': 'Progress tracking', 'value': 'Motivate completion'}
        ],
        'engagement': [
            {'id': 'fr-eng-001', 'desc': 'Push notifications', 'value': 'Re-engage users'},
            {'id': 'fr-eng-002', 'desc': 'Personalized content', 'value': 'Increase stickiness'}
        ]
    }
    
    requirements = []
    for stream in value_streams:
        if stream in requirement_catalog:
            requirements.extend(requirement_catalog[stream])
    
    return requirements
```

### Output Format

```yaml
value_decomposition:
  business_goal:
    id: "bg-001"
    statement: "Grow user base by 30% in Q3"
    baseline: 10000
    target: 13000
    deadline: "2025-09-30"
    
  functional_requirements:
    - id: "fr-001"
      description: "Multi-channel user registration"
      business_value: "Reduce signup friction, capture 15% more leads"
      priority: "must"
      derived_from: "bg-001"
      acceptance_criteria: ["ac-001", "ac-002", "ac-003"]
      
    - id: "fr-002"
      description: "Guided onboarding tutorial"
      business_value: "Improve activation rate by 20%"
      priority: "must"
      derived_from: "bg-001"
      acceptance_criteria: ["ac-004", "ac-005"]
      
  metrics:
    - id: "m-001"
      name: "monthly_new_users"
      target: 1000
      current: 700
      unit: "users"
      
  traceability:
    bg-001: [fr-001, fr-002, fr-003]
    fr-001: [ac-001, ac-002, ac-003]
```

## Integration with Aether.go Methodology

- **Input from**: business-requirements-collector (stakeholder requirements)
- **Output to**: usecase-designer (functional requirements -> use cases)
- **Used by**: metrics-definer (define success metrics)
- **Validates with**: correctness-checker (requirement accuracy), completeness-checker (coverage)
- **Part of**: D1 Value Derivation Domain (L1 -> L2)

## Validation Rules

- Each functional requirement MUST trace to at least one business goal
- Each business goal MUST have at least one measurable metric
- Priority MUST be one of: must, should, could, won't
- Acceptance criteria MUST be defined for "must" priority requirements
