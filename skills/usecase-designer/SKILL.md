---
name: usecase-designer
description: Use when designing use cases from classified requirements with bidirectional traceability
---

# Use Case Designer

## Overview
Design comprehensive use cases from classified requirements across all 7 categories, establishing bidirectional traceability between requirements and use cases. Generates use case documents with actors, flows, pre/post conditions, and complexity assessment.

## When to Use

```
Requirements classified? ───────────────┐
                                        │
Need use case design? ───────────────────┤
                                        ├─► Use usecase-designer
Establish traceability? ─────────────────┤
                                        │
Validate requirements? ──────────────────┘
```

Use when:
- After [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md) classifies requirements
- Before [bdd-scenario-writer](file:///d:/repos/aether-go/skills/skills/bdd-scenario-writer/SKILL.md) generates scenarios
- Need to validate requirements through use cases
- Need bidirectional traceability (requirement ↔ use case)
- Preparing for [atdd-acceptance-test-generator](file:///d:/repos/aether-go/skills/skills/atdd-acceptance-test-generator/SKILL.md)

Don't use when:
- Requirements not yet classified
- Only need simple user stories
- Use cases already designed

## Core Pattern

### Use Case Design Workflow

```
Classified Requirements → Actor Identification → Use Case Discovery → Flow Design
         ↓                        ↓                    ↓                ↓
   7-Category Req          Actor Map          Use Case List      Use Case Docs
         ↓                        ↓                    ↓                ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│                    Traceability Establishment                          │
└─────────────────────────────────────────────────────────────────────────────┘
         ↓
   Bidirectional Traceability Matrix
         ↓
   Input to BDD Scenario Writer
```

### Before (Requirements Only)
```yaml
requirements:
  - id: "REQ-FUNC-001"
    category: "03_functional"
    statement: "Users can login with email"
```

### After (Use Cases with Traceability)
```yaml
use_cases:
  - id: "UC-FUNC-001"
    name: "User Login with Email"
    category: "03_functional"
    
    traceability:
      derived_from_requirements:
        - id: "REQ-FUNC-001"
          relation: "implements"
          coverage: "100%"
          
      implements_requirements:
        - id: "REQ-FUNC-001"
          acceptance_criteria_covered: ["AC-FUNC-001-1", "AC-FUNC-001-2"]
    
    actors:
      primary: ["Registered User"]
      secondary: ["Authentication Service", "User Database"]
      
    flows:
      basic_flow:
        - step: 1
          actor: "Registered User"
          action: "Enters email and password"
          system_response: "Validates credentials"
          
        - step: 2
          actor: "System"
          action: "Authenticates user"
          system_response: "Generates session token"
          
      alternative_flows:
        - id: "AF-001"
          name: "Invalid credentials"
          trigger: "User enters wrong password"
          steps: [...]
          
      exception_flows:
        - id: "EF-001"
          name: "Account locked"
          trigger: "Too many failed attempts"
          steps: [...]
    
    preconditions:
      - "User has registered account"
      - "Account is active"
      - "System is operational"
      
    postconditions:
      - "User is authenticated"
      - "Session token generated"
      - "Login event logged"
      
    complexity:
      score: 3
      level: "moderate"
      factors: ["3 steps", "2 alternative flows", "1 exception flow"]
```

## Quick Reference

### Use Case to Requirement Mapping

| Requirement Category | Use Case Focus | Example Use Cases | Traceability Pattern |
|-------------------|----------------|------------------|---------------------|
| **01-Business Requirements** | Business processes | Customer onboarding, Order processing | Business process flows |
| **02-Architecture Requirements** | System interactions | Service communication, Data flow | Architecture interaction flows |
| **03-Functional Requirements** | User features | User login, Data export | Feature-specific flows |
| **04-Non-Functional Requirements** | Quality attributes | Performance monitoring, Error handling | Quality attribute validation |
| **05-Compliance Requirements** | Compliance processes | Data consent, Audit logging | Compliance verification flows |
| **06-Security Requirements** | Security operations | Authentication, Authorization | Security control flows |
| **07-Scalability Requirements** | Scaling operations | Load balancing, Resource allocation | Scaling behavior flows |

### Actor Types

| Actor Type | Description | Examples | Involvement Level |
|------------|-------------|-----------|-------------------|
| **Primary** | Initiates use case | User, Customer | High |
| **Secondary** | Provides support | Database, External Service | Medium |
| **Tertiary** | Receives notifications | Admin, Auditor | Low |

### Flow Types

| Flow Type | Purpose | Trigger | Complexity |
|-----------|---------|---------|-------------|
| **Basic Flow** | Main success scenario | Normal operation | Low-Medium |
| **Alternative Flow** | Valid alternative paths | User choice, system option | Medium |
| **Exception Flow** | Error handling | Error condition, validation failure | Medium-High |

### Complexity Assessment

| Complexity Score | Level | Characteristics | Recommended Action |
|----------------|--------|----------------|-------------------|
| 1-2 | Low | <5 steps, 0-1 alternative flows | Direct implementation |
| 3-5 | Moderate | 5-10 steps, 2-3 alternative flows | Consider decomposition |
| 6-8 | High | 10-15 steps, 3-5 alternative flows | Decompose required |
| 9+ | Very High | >15 steps, >5 alternative flows | Decompose mandatory |

## Implementation

### Actor Identification

```yaml
actor_identification:
  method: "stakeholder_analysis"
  
  sources:
    - requirement_analysis: "Extract actors from requirements"
    - stakeholder_map: "Use stakeholder map from collector"
    - system_context: "Identify system boundaries"
    
  actor_attributes:
    - id: "ACT-{NUMBER}"
    - name: "Actor name"
    - type: "primary | secondary | tertiary"
    - role: "Specific role or responsibility"
    - goals: ["Actor goals in system"]
    - capabilities: ["Actor capabilities"]
    - constraints: ["Actor limitations"]
```

### Use Case Discovery

```yaml
use_case_discovery:
  method: "requirement_analysis"
  
  discovery_strategies:
    - functional_decomposition: "Break down functional requirements"
    - user_goal_analysis: "Identify user goals"
    - business_process_mapping: "Map business processes"
    - system_interaction_analysis: "Analyze system interactions"
    
  use_case_template:
    id: "UC-{CATEGORY}-{NUMBER}"
    name: "Descriptive use case name"
    category: "01_business | 02_architecture | 03_functional | 
               04_non_functional | 05_compliance | 06_security | 07_scalability"
    
    priority: "critical | high | medium | low"
    frequency: "high | medium | low"
    complexity: "low | moderate | high | very_high"
```

### Flow Design

```yaml
flow_design:
  basic_flow:
    structure:
      - step: 1
        actor: "Actor name"
        action: "Action description"
        system_response: "System response description"
        data_flow: "Data exchanged"
        
      - step: 2
        actor: "Actor name"
        action: "Action description"
        system_response: "System response description"
        data_flow: "Data exchanged"
        
  alternative_flows:
    - id: "AF-{NUMBER}"
      name: "Alternative flow name"
      trigger: "Condition triggering alternative"
      return_point: "Step where basic flow resumes"
      steps: [...]
      
  exception_flows:
    - id: "EF-{NUMBER}"
      name: "Exception flow name"
      trigger: "Error condition"
      error_handling: "How error is handled"
      recovery: "Recovery procedure"
      steps: [...]
```

### Traceability Establishment

```yaml
traceability:
  requirement_to_usecase:
    - requirement_id: "REQ-FUNC-001"
      usecase_id: "UC-FUNC-001"
      relation_type: "implemented_by"
      coverage_percentage: 100
      acceptance_criteria_mapped:
        - "AC-FUNC-001-1": "Covered in step 2"
        - "AC-FUNC-001-2": "Covered in step 3"
        
  usecase_to_requirement:
    - usecase_id: "UC-FUNC-001"
      requirement_id: "REQ-FUNC-001"
      relation_type: "implements"
      validation_method: "flow_coverage"
      gaps: []
      
  cross_category_traceability:
    - usecase_id: "UC-FUNC-001"
      primary_requirement: "REQ-FUNC-001"
      related_requirements:
        - id: "REQ-SEC-001"
          relation: "depends_on"
          impact: "Authentication flow"
        - id: "REQ-NFR-001"
          relation: "constrained_by"
          impact: "Response time requirement"
```

### Complexity Assessment

```yaml
complexity_assessment:
  factors:
    basic_flow_steps:
      weight: 1.0
      calculation: "count(basic_flow.steps) * 1.0"
      
    alternative_flows:
      weight: 1.5
      calculation: "count(alternative_flows) * 1.5"
      
    exception_flows:
      weight: 2.0
      calculation: "count(exception_flows) * 2.0"
      
    actor_count:
      weight: 0.5
      calculation: "count(actors) * 0.5"
      
    data_complexity:
      weight: 1.0
      calculation: "data_fields_count * 0.1"
      
  total_score:
    formula: "sum(all_factors)"
    
  complexity_levels:
    low:
      range: "1-2"
      recommendation: "Direct implementation"
      
    moderate:
      range: "3-5"
      recommendation: "Consider decomposition if >4"
      
    high:
      range: "6-8"
      recommendation: "Decompose recommended"
      
    very_high:
      range: "9+"
      recommendation: "Decompose mandatory"
```

### Use Case Document Template

```yaml
use_case_document:
  metadata:
    id: "UC-{CATEGORY}-{NUMBER}"
    name: "Use case name"
    version: "1.0"
    status: "draft | reviewed | approved"
    created_date: "2026-01-20"
    last_modified: "2026-01-20"
    
  overview:
    description: "Brief description of use case"
    business_value: "Business value provided"
    category: "Requirement category"
    priority: "critical | high | medium | low"
    frequency: "high | medium | low"
    
  traceability:
    derived_from_requirements:
      - id: "REQ-{CATEGORY}-{NUMBER}"
        relation: "implements | validates | supports"
        coverage: "percentage"
        
    implements_requirements:
      - id: "REQ-{CATEGORY}-{NUMBER}"
        acceptance_criteria_covered: ["AC-IDs"]
        
    cross_category_relations:
      - related_requirement: "REQ-{CATEGORY}-{NUMBER}"
        relation_type: "depends_on | constrained_by | enabled_by"
        impact: "Impact description"
        
  actors:
    primary:
      - id: "ACT-{NUMBER}"
        name: "Actor name"
        role: "Actor role"
        goals: ["Actor goals"]
        
    secondary:
      - id: "ACT-{NUMBER}"
        name: "Actor name"
        role: "Actor role"
        interaction_type: "provides_service | receives_notification"
        
  flows:
    basic_flow:
      steps:
        - step: 1
          actor: "Actor name"
          action: "Action description"
          system_response: "System response"
          data_flow: "Data exchanged"
          validation: "Validation performed"
          
    alternative_flows:
      - id: "AF-{NUMBER}"
        name: "Alternative flow name"
        trigger: "Trigger condition"
        steps: [...]
        return_point: "Return to step X"
        
    exception_flows:
      - id: "EF-{NUMBER}"
        name: "Exception flow name"
        trigger: "Error condition"
        error_type: "error_type"
        error_handling: "How error handled"
        recovery: "Recovery procedure"
        steps: [...]
        
  preconditions:
    - "Precondition 1"
    - "Precondition 2"
    
  postconditions:
    - "Postcondition 1"
    - "Postcondition 2"
    
  business_rules:
    - id: "BR-{NUMBER}"
      description: "Business rule description"
      enforcement: "How rule enforced"
      
  data_requirements:
    - id: "DR-{NUMBER}"
      name: "Data element"
      type: "data_type"
      validation: "Validation rules"
      
  non_functional_requirements:
    - id: "NFR-{NUMBER}"
      type: "performance | security | usability"
      requirement: "NFR description"
      measurement: "How measured"
      
  complexity_assessment:
    score: 3
    level: "moderate"
    factors:
      basic_flow_steps: 5
      alternative_flows: 2
      exception_flows: 1
      actor_count: 2
      data_complexity: 3
    recommendation: "Consider decomposition if additional flows added"
    
  test_scenarios:
    - id: "TS-{NUMBER}"
      name: "Test scenario name"
      type: "happy_path | alternative | exception"
      coverage: "Requirements covered"
```

## Integration with Other Skills

### Input from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)

```yaml
input:
  classified_requirements:
    01_business: ["REQ-BUS-*"]
    02_architecture: ["REQ-ARCH-*"]
    03_functional: ["REQ-FUNC-*"]
    04_non_functional: ["REQ-NFR-*"]
    05_compliance: ["REQ-COMP-*"]
    06_security: ["REQ-SEC-*"]
    07_scalability: ["REQ-SCAL-*"]
    
  cross_category_relationships: [...]
  conflicts: [...]
```

### Output to [bdd-scenario-writer](file:///d:/repos/aether-go/skills/skills/bdd-scenario-writer/SKILL.md)

```yaml
output:
  use_cases:
    - id: "UC-{CATEGORY}-{NUMBER}"
      name: "Use case name"
      flows:
        basic_flow: [...]
        alternative_flows: [...]
        exception_flows: [...]
      traceability:
        requirement_id: "REQ-{CATEGORY}-{NUMBER}"
```

### Output to [requirement-implementation-tracer](file:///d:/repos/aether-go/skills/skills/requirement-implementation-tracer/SKILL.md)

```yaml
output:
  traceability_matrix:
    requirement_to_usecase: [...]
    usecase_to_requirement: [...]
    cross_category_traceability: [...]
```

## Best Practices

### Use Case Design Guidelines

1. **Actor Clarity**: Clearly define all actors and their roles
2. **Flow Completeness**: Cover all possible paths (basic, alternative, exception)
3. **Traceability**: Maintain bidirectional traceability with requirements
4. **Complexity Management**: Decompose complex use cases
5. **Validation**: Validate use cases with stakeholders

### Traceability Guidelines

1. **Bidirectional**: Map requirements ↔ use cases in both directions
2. **Coverage**: Ensure 100% requirement coverage
3. **Gap Analysis**: Identify gaps in use case coverage
4. **Cross-Category**: Map cross-category relationships
5. **Validation**: Validate traceability with stakeholders

### Complexity Management Guidelines

1. **Assessment**: Assess complexity before implementation
2. **Decomposition**: Decompose high-complexity use cases
3. **Simplification**: Simplify flows where possible
4. **Reuse**: Reuse common flow patterns
5. **Documentation**: Document complexity rationale

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Missing alternative flows | Incomplete coverage | Identify all valid alternatives |
| No exception handling | Unhandled errors | Add exception flows for all error conditions |
| Poor traceability | Lost requirement connection | Maintain bidirectional traceability |
| Ignoring complexity | Difficult implementation | Assess and decompose complex use cases |
| Vague actor definitions | Unclear responsibilities | Define clear actor roles and goals |

## Real-World Impact

**Before (Manual Use Case Design):**
- Inconsistent use case structure
- Missing traceability
- Uncovered requirements
- Time-consuming process
- Complexity not assessed

**After (Automated Use Case Design):**
- Consistent use case structure
- Complete bidirectional traceability
- 100% requirement coverage
- 70% reduction in design time
- Proactive complexity management

**Result:** Better requirement validation, clearer implementation guidance, faster delivery.
