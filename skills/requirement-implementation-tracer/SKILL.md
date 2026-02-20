---
name: requirement-implementation-tracer
description: Use when establishing three-layer bidirectional traceability between requirements, use cases, and implementation
---

# Requirement Implementation Tracer

## Overview
Establish and maintain three-layer bidirectional traceability between requirements, use cases, and code implementation. Ensures complete coverage from business requirements to deployed code, enables impact analysis, and provides gap detection across the entire development lifecycle.

## When to Use

```
Need end-to-end traceability? ───────────┐
                                          │
Implementation complete? ──────────────────┤
                                          ├─► Use requirement-implementation-tracer
Gap analysis needed? ──────────────────────┤
                                          │
Impact analysis required? ─────────────────┘
```

Use when:
- After [usecase-designer](file:///d:/repos/aether-go/skills/skills/usecase-designer/SKILL.md) creates use cases
- During and after implementation
- Need to verify requirement coverage
- Performing impact analysis for changes
- Conducting compliance audits
- Generating traceability reports

Don't use when:
- Requirements not yet classified
- Use cases not designed
- Only need single-layer traceability

## Core Pattern

### Three-Layer Traceability Model

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           REQUIREMENT LAYER                                  │
│  REQ-BUS-001    REQ-ARCH-001    REQ-FUNC-001    REQ-NFR-001    REQ-SEC-001  │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ implements / implemented_by
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              USE CASE LAYER                                  │
│     UC-BUS-001        UC-FUNC-001        UC-FUNC-002        UC-SEC-001      │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ realizes / realized_by
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          IMPLEMENTATION LAYER                                │
│    AuthService      UserController      LoginAPI      SecurityMiddleware    │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Before (No Traceability)
```yaml
requirements:
  - id: "REQ-FUNC-001"
    statement: "Users can login"
    
implementation:
  files:
    - "src/auth/login.ts"
    - "src/controllers/user.ts"
    
# No connection between requirements and code
```

### After (Three-Layer Traceability)
```yaml
traceability_matrix:
  requirement_layer:
    REQ-FUNC-001:
      name: "User Login"
      category: "03_functional"
      status: "implemented"
      
      usecase_links:
        - UC-FUNC-001: "implements"
          coverage: "100%"
          
      implementation_links:
        - file: "src/auth/login.ts"
          relation: "implements"
          lines: "15-45"
          
        - file: "src/controllers/user.ts"
          relation: "supports"
          lines: "20-35"
          
      test_links:
        - file: "tests/auth.test.ts"
          relation: "validates"
          coverage: "95%"
          
  usecase_layer:
    UC-FUNC-001:
      name: "User Login with Email"
      status: "implemented"
      
      requirement_links:
        - REQ-FUNC-001: "derived_from"
          
      implementation_links:
        - file: "src/auth/login.ts"
          relation: "realizes"
          
  implementation_layer:
    src/auth/login.ts:
      requirement_links:
        - REQ-FUNC-001: "implements"
        - REQ-SEC-001: "satisfies"
          
      usecase_links:
        - UC-FUNC-001: "realizes"
          
      test_links:
        - tests/auth.test.ts: "tested_by"
```

## Quick Reference

### Traceability Relations

| From Layer | To Layer | Relation Type | Description |
|------------|----------|---------------|-------------|
| Requirement | Use Case | implements | Requirement implemented by use case |
| Use Case | Requirement | derived_from | Use case derived from requirement |
| Use Case | Implementation | realizes | Use case realized by code |
| Implementation | Use Case | fulfills | Code fulfills use case |
| Requirement | Implementation | satisfied_by | Requirement satisfied by code |
| Implementation | Requirement | implements | Code implements requirement |
| Implementation | Test | tested_by | Code tested by test file |
| Test | Requirement | validates | Test validates requirement |

### Coverage Status

| Status | Description | Action Required |
|--------|-------------|-----------------|
| **covered** | Fully traced through all layers | None |
| **partial** | Traced but incomplete | Complete traceability |
| **orphan_requirement** | No use case or implementation | Create use case/implementation |
| **orphan_usecase** | No implementation | Implement use case |
| **orphan_code** | No requirement traceability | Add requirement annotation |

### Gap Types

| Gap Type | Description | Detection Method | Resolution |
|----------|-------------|------------------|------------|
| **Missing Use Case** | Requirement has no use case | Requirement-only detection | Design use case |
| **Missing Implementation** | Use case has no code | Use case-only detection | Implement code |
| **Missing Test** | Implementation has no test | Code-only detection | Write tests |
| **Orphan Code** | Code without requirement | Code annotation check | Add requirement link |
| **Incomplete Coverage** | Partial traceability | Coverage analysis | Complete traceability |

## Implementation

### Traceability Matrix Structure

```yaml
traceability_matrix:
  version: "1.0"
  generated_at: "2026-01-20T10:00:00Z"
  
  summary:
    total_requirements: 50
    total_usecases: 35
    total_implementations: 120
    
    coverage:
      requirement_to_usecase: 95%
      usecase_to_implementation: 90%
      requirement_to_implementation: 85%
      
    gaps:
      missing_usecases: 3
      missing_implementations: 5
      orphan_code: 8
      
  layers:
    requirement_layer:
      requirements:
        - id: "REQ-{CATEGORY}-{NUMBER}"
          name: "Requirement name"
          category: "01_business | 02_architecture | 03_functional | 
                     04_non_functional | 05_compliance | 06_security | 07_scalability"
          status: "covered | partial | orphan"
          
          links:
            usecases:
              - id: "UC-{CATEGORY}-{NUMBER}"
                relation: "implements"
                coverage: "percentage"
                
            implementations:
              - file: "path/to/file"
                relation: "satisfied_by"
                lines: "line_range"
                
            tests:
              - file: "path/to/test"
                relation: "validated_by"
                coverage: "percentage"
                
    usecase_layer:
      usecases:
        - id: "UC-{CATEGORY}-{NUMBER}"
          name: "Use case name"
          status: "covered | partial | orphan"
          
          links:
            requirements:
              - id: "REQ-{CATEGORY}-{NUMBER}"
                relation: "derived_from"
                
            implementations:
              - file: "path/to/file"
                relation: "realizes"
                
    implementation_layer:
      files:
        - path: "path/to/file"
          type: "source | test | config"
          status: "covered | orphan"
          
          links:
            requirements:
              - id: "REQ-{CATEGORY}-{NUMBER}"
                relation: "implements"
                annotation: "// @requirement REQ-FUNC-001"
                
            usecases:
              - id: "UC-{CATEGORY}-{NUMBER}"
                relation: "fulfills"
```

### Annotation Format

```yaml
code_annotations:
  requirement_annotation:
    format: "// @requirement REQ-{CATEGORY}-{NUMBER}"
    example: "// @requirement REQ-FUNC-001"
    description: "Links code to requirement"
    
  usecase_annotation:
    format: "// @usecase UC-{CATEGORY}-{NUMBER}"
    example: "// @usecase UC-FUNC-001"
    description: "Links code to use case"
    
  acceptance_criteria_annotation:
    format: "// @acceptance AC-{NUMBER}"
    example: "// @acceptance AC-FUNC-001-1"
    description: "Links code to acceptance criteria"
    
  combined_annotation:
    format: |
      // @requirement REQ-FUNC-001
      // @usecase UC-FUNC-001
      // @acceptance AC-FUNC-001-1
    description: "Multiple annotations for complete traceability"
```

### Coverage Analysis

```yaml
coverage_analysis:
  requirement_coverage:
    method: "trace_chain_analysis"
    
    metrics:
      - name: "requirement_to_usecase"
        formula: "requirements_with_usecases / total_requirements"
        target: "100%"
        
      - name: "usecase_to_implementation"
        formula: "usecases_with_code / total_usecases"
        target: "100%"
        
      - name: "requirement_to_implementation"
        formula: "requirements_with_code / total_requirements"
        target: "100%"
        
      - name: "test_coverage"
        formula: "code_with_tests / total_code"
        target: "80%"
        
  category_coverage:
    01_business:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "90%"
      
    02_architecture:
      requirement_to_usecase: "95%"
      usecase_to_implementation: "85%"
      
    03_functional:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "95%"
      
    04_non_functional:
      requirement_to_usecase: "80%"
      usecase_to_implementation: "70%"
      
    05_compliance:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "100%"
      
    06_security:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "95%"
      
    07_scalability:
      requirement_to_usecase: "75%"
      usecase_to_implementation: "60%"
```

### Gap Detection

```yaml
gap_detection:
  orphan_requirements:
    detection: "requirements without usecase links"
    severity: "high"
    resolution: "design use cases for requirements"
    
  orphan_usecases:
    detection: "usecases without implementation links"
    severity: "high"
    resolution: "implement use cases"
    
  orphan_code:
    detection: "code files without requirement annotations"
    severity: "medium"
    resolution: "add requirement annotations"
    
  missing_tests:
    detection: "implementation without test links"
    severity: "medium"
    resolution: "write tests for implementation"
    
  incomplete_chains:
    detection: "broken traceability chains"
    severity: "high"
    resolution: "complete traceability chain"
```

### Impact Analysis

```yaml
impact_analysis:
  requirement_change:
    method: "downstream_propagation"
    
    steps:
      - identify_usecases: "Find all use cases implementing requirement"
      - identify_implementations: "Find all code implementing use cases"
      - identify_tests: "Find all tests validating code"
      - calculate_effort: "Estimate change effort"
      
    output:
      affected_usecases: ["UC-FUNC-001", "UC-FUNC-002"]
      affected_files: ["src/auth/login.ts", "src/controllers/user.ts"]
      affected_tests: ["tests/auth.test.ts"]
      estimated_effort: "4 hours"
      risk_level: "medium"
      
  code_change:
    method: "upstream_propagation"
    
    steps:
      - identify_requirements: "Find requirements implemented by code"
      - identify_usecases: "Find use cases realized by code"
      - identify_dependencies: "Find dependent requirements"
      - assess_impact: "Assess impact on requirements"
      
    output:
      affected_requirements: ["REQ-FUNC-001", "REQ-SEC-001"]
      affected_usecases: ["UC-FUNC-001"]
      validation_required: true
      stakeholder_notification: ["Product Owner", "Security Officer"]
```

### Traceability Report

```yaml
traceability_report:
  metadata:
    generated_at: "2026-01-20T10:00:00Z"
    project: "Project Name"
    version: "1.0"
    
  executive_summary:
    overall_coverage: "87%"
    total_requirements: 50
    total_usecases: 35
    total_implementations: 120
    
    coverage_by_layer:
      requirement_to_usecase: "95%"
      usecase_to_implementation: "90%"
      requirement_to_implementation: "85%"
      test_coverage: "78%"
      
    gaps_summary:
      critical: 3
      high: 5
      medium: 8
      low: 4
      
  category_breakdown:
    01_business:
      requirements: 8
      usecases: 6
      implementations: 15
      coverage: "92%"
      
    02_architecture:
      requirements: 5
      usecases: 4
      implementations: 10
      coverage: "88%"
      
    03_functional:
      requirements: 15
      usecases: 12
      implementations: 45
      coverage: "95%"
      
    04_non_functional:
      requirements: 8
      usecases: 5
      implementations: 20
      coverage: "75%"
      
    05_compliance:
      requirements: 4
      usecases: 4
      implementations: 10
      coverage: "100%"
      
    06_security:
      requirements: 5
      usecases: 4
      implementations: 12
      coverage: "90%"
      
    07_scalability:
      requirements: 5
      usecases: 3
      implementations: 8
      coverage: "65%"
      
  gap_details:
    - id: "GAP-001"
      type: "missing_usecase"
      requirement: "REQ-SCAL-002"
      severity: "high"
      description: "Requirement has no use case"
      recommendation: "Design use case for scalability requirement"
      
    - id: "GAP-002"
      type: "missing_implementation"
      usecase: "UC-NFR-003"
      severity: "high"
      description: "Use case has no implementation"
      recommendation: "Implement performance monitoring use case"
      
    - id: "GAP-003"
      type: "orphan_code"
      file: "src/utils/helper.ts"
      severity: "medium"
      description: "Code has no requirement annotation"
      recommendation: "Add requirement annotation or verify as infrastructure code"
      
  recommendations:
    - priority: "critical"
      action: "Address 3 critical gaps in scalability requirements"
      effort: "2 days"
      
    - priority: "high"
      action: "Complete traceability for 5 high-severity gaps"
      effort: "3 days"
      
    - priority: "medium"
      action: "Add annotations to 8 orphan code files"
      effort: "1 day"
```

## Integration with Other Skills

### Input from [usecase-designer](file:///d:/repos/aether-go/skills/skills/usecase-designer/SKILL.md)

```yaml
input:
  use_cases:
    - id: "UC-{CATEGORY}-{NUMBER}"
      traceability:
        derived_from_requirements: ["REQ-{CATEGORY}-{NUMBER}"]
```

### Input from [spec-to-code-tracer](file:///d:/repos/aether-go/skills/skills/spec-to-code-tracer/SKILL.md)

```yaml
input:
  code_annotations:
    - file: "path/to/file"
      requirements: ["REQ-{CATEGORY}-{NUMBER}"]
```

### Output to [constitution-validator](file:///d:/repos/aether-go/skills/skills/constitution-validator/SKILL.md)

```yaml
output:
  traceability_compliance:
    coverage_percentage: 87
    gaps: [...]
    recommendations: [...]
```

## Best Practices

### Traceability Guidelines

1. **Complete Chain**: Ensure every requirement has complete traceability chain
2. **Bidirectional**: Maintain bidirectional links at every layer
3. **Annotations**: Use consistent code annotations
4. **Regular Updates**: Update traceability with every change
5. **Gap Resolution**: Resolve gaps promptly

### Coverage Guidelines

1. **100% Target**: Aim for 100% requirement coverage
2. **Category Focus**: Pay special attention to compliance and security categories
3. **Test Coverage**: Ensure tests link to requirements
4. **Orphan Detection**: Regularly detect and resolve orphan code
5. **Impact Analysis**: Use traceability for impact analysis

### Reporting Guidelines

1. **Regular Reports**: Generate traceability reports regularly
2. **Gap Prioritization**: Prioritize gap resolution by severity
3. **Trend Analysis**: Track coverage trends over time
4. **Stakeholder Communication**: Share reports with stakeholders
5. **Continuous Improvement**: Use reports to improve processes

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| One-way traceability | Cannot trace backwards | Maintain bidirectional links |
| Missing annotations | Orphan code detection fails | Add consistent annotations |
| Ignoring gaps | Accumulates technical debt | Resolve gaps promptly |
| No test linkage | Missing validation traceability | Link tests to requirements |
| Irregular updates | Outdated traceability | Update with every change |

## Real-World Impact

**Before (No Traceability):**
- Requirements implemented without verification
- Unknown code purpose
- Difficult impact analysis
- Compliance audit failures
- Change risk assessment impossible

**After (Three-Layer Traceability):**
- Complete requirement-to-code coverage
- Clear code purpose and origin
- Accurate impact analysis
- Compliance audit ready
- Informed change decisions

**Result:** 95% requirement coverage, 80% faster impact analysis, zero compliance audit failures.
