---
name: requirement-implementation-tracer
description: Use when establishing three-layer bidirectional traceability between requirements, use cases, and implementation with ISO/IEC 25010:2023 quality model mapping
---

# Requirement Implementation Tracer

## Overview
Establish and maintain three-layer bidirectional traceability between requirements, use cases, and code implementation. Ensures complete coverage from business requirements to deployed code, enables impact analysis, and provides gap detection across the entire development lifecycle. Supports the 13-category requirement classification system based on ISO/IEC 25010:2023 with quality model mapping.

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
- Mapping requirements to ISO/IEC 25010:2023 quality model

Don't use when:
- Requirements not yet classified
- Use cases not designed
- Only need single-layer traceability

## Core Pattern

### Three-Layer Traceability Model (ISO/IEC 25010:2023 Based)

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           REQUIREMENT LAYER                                  │
│  REQ-BUS-001  REQ-COMP-001  REQ-FUNC-001  REQ-PERF-001  REQ-SEC-001  ...    │
│  ─────────────────────────────────────────────────────────────────────────  │
│  ISO 25010 Mapping: Functional Suitability, Performance Efficiency, ...      │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ implements / implemented_by
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                              USE CASE LAYER                                  │
│     UC-BUS-001        UC-FUNC-001        UC-PERF-001        UC-SEC-001      │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    │ realizes / realized_by
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          IMPLEMENTATION LAYER                                │
│    AuthService      UserController      CacheService      SecurityMiddleware│
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
# No ISO 25010 quality model mapping
```

### After (Three-Layer Traceability with ISO 25010)
```yaml
traceability_matrix:
  requirement_layer:
    REQ-FUNC-001:
      name: "User Login"
      category: "04_functional"
      iso_25010:
        characteristic: "Functional Suitability"
        subcharacteristic: "Functional Completeness"
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

### Thirteen-Category Traceability (ISO/IEC 25010:2023 Based)

| Category | ID Prefix | ISO 25010 Reference | Traceability Focus |
|----------|-----------|---------------------|-------------------|
| **01-Business Requirements** | REQ-BUS | - | Business goals to features |
| **02-Compliance Requirements** | REQ-COMP | - | Compliance to controls |
| **03-Constraint Requirements** | REQ-CONS | - | Constraints to architecture |
| **04-Functional Requirements** | REQ-FUNC | Functional Suitability | Features to implementation |
| **05-Performance Requirements** | REQ-PERF | Performance Efficiency | Performance to optimization |
| **06-Compatibility Requirements** | REQ-COMPAT | Compatibility | Integration to interfaces |
| **07-Usability Requirements** | REQ-USE | Usability | UX to UI implementation |
| **08-Reliability Requirements** | REQ-REL | Reliability | Availability to failover |
| **09-Security Requirements** | REQ-SEC | Security | Security to controls |
| **10-Maintainability Requirements** | REQ-MAIN | Maintainability | Code quality to standards |
| **11-Portability Requirements** | REQ-PORT | Portability | Platform to deployment |
| **12-Architecture Requirements** | REQ-ARCH | - | Architecture to structure |
| **13-Data Requirements** | REQ-DATA | - | Data model to schema |

### ISO/IEC 25010:2023 Quality Characteristics Mapping

| ISO Characteristic | Subcharacteristics | Requirement Category |
|-------------------|---------------------|---------------------|
| **Functional Suitability** | Functional completeness, correctness, appropriateness | 04-Functional |
| **Performance Efficiency** | Time behavior, Resource utilization, Capacity | 05-Performance |
| **Compatibility** | Coexistence, Interoperability | 06-Compatibility |
| **Usability** | Appropriateness recognizability, Learnability, Operability, User error protection, Accessibility | 07-Usability |
| **Reliability** | Maturity, Availability, Fault tolerance, Recoverability | 08-Reliability |
| **Security** | Confidentiality, Integrity, Non-repudiation, Authenticity | 09-Security |
| **Maintainability** | Modularity, Reusability, Analysability, Modifiability, Testability | 10-Maintainability |
| **Portability** | Adaptability, Installability, Replaceability | 11-Portability |

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
| **Missing ISO Mapping** | No ISO 25010 reference | ISO mapping check | Add quality model reference |

## Implementation

### Traceability Matrix Structure

```yaml
traceability_matrix:
  version: "1.0"
  generated_at: "2026-01-20T10:00:00Z"
  iso_standard: "ISO/IEC 25010:2023"
  
  summary:
    total_requirements: 50
    total_usecases: 35
    total_implementations: 120
    
    coverage:
      requirement_to_usecase: 95%
      usecase_to_implementation: 90%
      requirement_to_implementation: 85%
      iso_25010_mapping: 80%
      
    gaps:
      missing_usecases: 3
      missing_implementations: 5
      orphan_code: 8
      missing_iso_mapping: 10
      
  layers:
    requirement_layer:
      requirements:
        - id: "REQ-{CATEGORY}-{NUMBER}"
          name: "Requirement name"
          category: "01_business | 02_compliance | 03_constraint | 04_functional | 
                     05_performance | 06_compatibility | 07_usability | 08_reliability | 
                     09_security | 10_maintainability | 11_portability | 12_architecture | 13_data"
          iso_25010:
            characteristic: "ISO 25010 characteristic"
            subcharacteristic: "ISO 25010 subcharacteristic"
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
    
  iso_25010_annotation:
    format: "// @iso25010 {characteristic}:{subcharacteristic}"
    example: "// @iso25010 Security:Confidentiality"
    description: "Links code to ISO 25010 quality characteristic"
    
  combined_annotation:
    format: |
      // @requirement REQ-FUNC-001
      // @usecase UC-FUNC-001
      // @acceptance AC-FUNC-001-1
      // @iso25010 Functional Suitability:Functional Completeness
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
        
      - name: "iso_25010_mapping"
        formula: "requirements_with_iso_mapping / total_requirements"
        target: "100%"
        
  category_coverage:
    01_business:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "90%"
      iso_mapping: "N/A"
      
    02_compliance:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "100%"
      iso_mapping: "N/A"
      
    03_constraint:
      requirement_to_usecase: "95%"
      usecase_to_implementation: "85%"
      iso_mapping: "N/A"
      
    04_functional:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "95%"
      iso_mapping: "100%"
      
    05_performance:
      requirement_to_usecase: "90%"
      usecase_to_implementation: "85%"
      iso_mapping: "100%"
      
    06_compatibility:
      requirement_to_usecase: "85%"
      usecase_to_implementation: "80%"
      iso_mapping: "100%"
      
    07_usability:
      requirement_to_usecase: "80%"
      usecase_to_implementation: "75%"
      iso_mapping: "100%"
      
    08_reliability:
      requirement_to_usecase: "95%"
      usecase_to_implementation: "90%"
      iso_mapping: "100%"
      
    09_security:
      requirement_to_usecase: "100%"
      usecase_to_implementation: "95%"
      iso_mapping: "100%"
      
    10_maintainability:
      requirement_to_usecase: "85%"
      usecase_to_implementation: "80%"
      iso_mapping: "100%"
      
    11_portability:
      requirement_to_usecase: "75%"
      usecase_to_implementation: "70%"
      iso_mapping: "100%"
      
    12_architecture:
      requirement_to_usecase: "95%"
      usecase_to_implementation: "90%"
      iso_mapping: "N/A"
      
    13_data:
      requirement_to_usecase: "90%"
      usecase_to_implementation: "85%"
      iso_mapping: "N/A"
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
    
  missing_iso_mapping:
    detection: "requirements without ISO 25010 reference"
    severity: "medium"
    resolution: "add ISO 25010 quality model mapping"
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
      - identify_iso_impact: "Assess impact on ISO 25010 quality characteristics"
      - calculate_effort: "Estimate change effort"
      
    output:
      affected_usecases: ["UC-FUNC-001", "UC-FUNC-002"]
      affected_files: ["src/auth/login.ts", "src/controllers/user.ts"]
      affected_tests: ["tests/auth.test.ts"]
      iso_characteristics_affected: ["Functional Suitability", "Security"]
      estimated_effort: "4 hours"
      risk_level: "medium"
      
  code_change:
    method: "upstream_propagation"
    
    steps:
      - identify_requirements: "Find requirements implemented by code"
      - identify_usecases: "Find use cases realized by code"
      - identify_dependencies: "Find dependent requirements"
      - assess_iso_impact: "Assess impact on ISO 25010 quality model"
      - assess_impact: "Assess impact on requirements"
      
    output:
      affected_requirements: ["REQ-FUNC-001", "REQ-SEC-001"]
      affected_usecases: ["UC-FUNC-001"]
      iso_characteristics_affected: ["Security", "Functional Suitability"]
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
    iso_standard: "ISO/IEC 25010:2023"
    
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
      iso_25010_mapping: "80%"
      
    gaps_summary:
      critical: 3
      high: 5
      medium: 8
      low: 4
      
  iso_25010_coverage:
    Functional_Suitability:
      requirements: 15
      coverage: "85%"
      
    Performance_Efficiency:
      requirements: 8
      coverage: "75%"
      
    Compatibility:
      requirements: 4
      coverage: "80%"
      
    Usability:
      requirements: 6
      coverage: "70%"
      
    Reliability:
      requirements: 5
      coverage: "80%"
      
    Security:
      requirements: 10
      coverage: "90%"
      
    Maintainability:
      requirements: 4
      coverage: "85%"
      
    Portability:
      requirements: 3
      coverage: "75%"
      
  category_breakdown:
    01_business:
      requirements: 8
      usecases: 6
      implementations: 15
      coverage: "92%"
      
    02_compliance:
      requirements: 4
      usecases: 4
      implementations: 10
      coverage: "100%"
      
    03_constraint:
      requirements: 3
      usecases: 2
      implementations: 5
      coverage: "85%"
      
    04_functional:
      requirements: 15
      usecases: 12
      implementations: 45
      coverage: "95%"
      
    05_performance:
      requirements: 8
      usecases: 6
      implementations: 20
      coverage: "80%"
      
    06_compatibility:
      requirements: 4
      usecases: 3
      implementations: 10
      coverage: "75%"
      
    07_usability:
      requirements: 6
      usecases: 4
      implementations: 12
      coverage: "70%"
      
    08_reliability:
      requirements: 5
      usecases: 4
      implementations: 15
      coverage: "85%"
      
    09_security:
      requirements: 10
      usecases: 8
      implementations: 25
      coverage: "90%"
      
    10_maintainability:
      requirements: 4
      usecases: 3
      implementations: 10
      coverage: "80%"
      
    11_portability:
      requirements: 3
      usecases: 2
      implementations: 8
      coverage: "70%"
      
    12_architecture:
      requirements: 5
      usecases: 4
      implementations: 15
      coverage: "88%"
      
    13_data:
      requirements: 6
      usecases: 5
      implementations: 18
      coverage: "85%"
      
  gap_details:
    - id: "GAP-001"
      type: "missing_usecase"
      requirement: "REQ-PERF-002"
      severity: "high"
      description: "Performance requirement has no use case"
      recommendation: "Design use case for performance requirement"
      
    - id: "GAP-002"
      type: "missing_implementation"
      usecase: "UC-REL-003"
      severity: "high"
      description: "Reliability use case has no implementation"
      recommendation: "Implement failover use case"
      
    - id: "GAP-003"
      type: "orphan_code"
      file: "src/utils/helper.ts"
      severity: "medium"
      description: "Code has no requirement annotation"
      recommendation: "Add requirement annotation or verify as infrastructure code"
      
    - id: "GAP-004"
      type: "missing_iso_mapping"
      requirement: "REQ-PERF-005"
      severity: "medium"
      description: "Performance requirement missing ISO 25010 mapping"
      recommendation: "Add ISO 25010 Performance Efficiency reference"
      
  recommendations:
    - priority: "critical"
      action: "Address 3 critical gaps in reliability requirements"
      effort: "2 days"
      
    - priority: "high"
      action: "Complete traceability for 5 high-severity gaps"
      effort: "3 days"
      
    - priority: "medium"
      action: "Add annotations to 8 orphan code files"
      effort: "1 day"
      
    - priority: "medium"
      action: "Add ISO 25010 mapping to 10 requirements"
      effort: "4 hours"
```

## Integration with Other Skills

### Input from [usecase-designer](file:///d:/repos/aether-go/skills/skills/usecase-designer/SKILL.md)

```yaml
input:
  usecases:
    - id: "UC-{CATEGORY}-{NUMBER}"
      name: "Use case name"
      requirement_links:
        - "REQ-{CATEGORY}-{NUMBER}"
      iso_25010_reference:
        characteristic: "..."
        subcharacteristic: "..."
```

### Input from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)

```yaml
input:
  classified_requirements:
    01_business: [...]
    02_compliance: [...]
    03_constraint: [...]
    04_functional: [...]
    05_performance: [...]
    06_compatibility: [...]
    07_usability: [...]
    08_reliability: [...]
    09_security: [...]
    10_maintainability: [...]
    11_portability: [...]
    12_architecture: [...]
    13_data: [...]
  iso_25010_references: [...]
```

### Output to [requirements-to-code-docs](file:///d:/repos/aether-go/skills/skills/requirements-to-code-docs/SKILL.md)

```yaml
output:
  traceability_matrix:
    layers: [...]
    coverage: [...]
    gaps: [...]
    iso_25010_coverage: [...]
```
