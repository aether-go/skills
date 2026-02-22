---
name: spec-parser
description: Use when parsing natural language requirements into structured technical specifications with 13-category support based on ISO/IEC 25010:2023
---

# Spec Parser

## Overview
Convert natural language user stories and requirements into structured, machine-readable specifications (YAML/JSON) that can drive development, testing, and documentation. Supports the 13-category requirement classification system based on ISO/IEC 25010:2023 with cross-category relationship mapping.

## When to Use

```
Requirements in natural language? ─────────┐
                                           │
Need structured specs? ─────────────────────┤
                                           ├─► Use spec-parser
Starting development project? ──────────────┤
                                           │
Aether.go SDD methodology? ────────────────┘
```

Use when:
- Converting user stories to technical specs
- Starting new features or projects
- Requirements need version control
- Generating test cases from specs
- Creating documentation automatically
- Bridging business and technical teams
- Processing requirements from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)
- Preparing specs for [bdd-scenario-writer](file:///d:/repos/aether-go/skills/skills/bdd-scenario-writer/SKILL.md)

Don't use when:
- Requirements already structured
- Simple one-off tasks
- No need for traceability

## Core Pattern

### Thirteen-Category Spec Structure (ISO/IEC 25010:2023 Based)

```
Classified Requirements → Category-Specific Parsing → Structured Specs
         ↓                        ↓                        ↓
  13 Categories          Category Templates         Unified Spec Format
         ↓                        ↓                        ↓
┌─────────────────────────────────────────────────────────────────────┐
│                    Cross-Category Relationship Mapping               │
│                    ISO 25010 Quality Trade-off Analysis              │
└─────────────────────────────────────────────────────────────────────┘
         ↓
   Input to BDD Scenario Writer
```

### Before (Unstructured)

```
User Story:
"As a user, I want to reset my password."

Issues:
- No clear acceptance criteria
- No edge cases defined
- Not testable
- Ambiguous requirements
- No category classification
- No ISO 25010 reference
```

### After (Structured with 13-Category Support)

```yaml
spec_id: "REQ-FUNC-005"
title: "Password Reset"
version: "1.0"
status: "draft"

category:
  primary: "04_functional"
  subcategory: "authentication"
  iso_reference:
    characteristic: "Functional Suitability"
    subcharacteristic: "Functional Completeness"
    
cross_category_relations:
  - related_category: "09_security"
    relation_type: "depends_on"
    related_spec: "REQ-SEC-001"
    rationale: "Password reset depends on security requirements"
    iso_trade_off: "Security vs Usability"
    
  - related_category: "05_performance"
    relation_type: "constrained_by"
    related_spec: "REQ-PERF-002"
    rationale: "Reset email must be sent within 30 seconds"

user_story: |
  As a user,
  I want to reset my password,
  So that I can regain access to my account.

acceptance_criteria:
  - id: "AC-001"
    description: "User receives reset email within 30 seconds"
    priority: "must"
    test_type: "integration"
    category_link: "REQ-PERF-002"
    iso_verification: "Performance Efficiency - Time Behavior"

  - id: "AC-002"
    description: "Reset link expires in 1 hour"
    priority: "must"
    test_type: "unit"
    category_link: "REQ-SEC-003"
    iso_verification: "Security - Authenticity"

  - id: "AC-003"
    description: "Reset link can only be used once"
    priority: "must"
    test_type: "security"
    category_link: "REQ-SEC-001"
    iso_verification: "Security - Integrity"

  - id: "AC-004"
    description: "User cannot reset with invalid email"
    priority: "must"
    test_type: "negative"

edge_cases:
  - description: "User requests reset twice"
    expected: "Second link invalidates first"
  - description: "Email doesn't exist"
    expected: "Generic error message (security)"

api_requirements:
  endpoint: "POST /auth/password-reset"
  request:
    email: "string (required)"
  responses:
    200: { message: "reset_email_sent" }
    400: { error: "invalid_email" }
    429: { error: "too_many_requests" }

dependencies:
  - "Email service"
  - "User database"
  - "Rate limiter"

traceability:
  bmad_metric: "user_recovery_rate"
  related_specs: ["REQ-BUS-001", "REQ-SEC-001", "REQ-PERF-002"]
  iso_quality_model: "Functional Suitability, Security"
```

## Quick Reference

### Thirteen-Category Spec Templates (ISO/IEC 25010:2023 Based)

| Category | ID Prefix | Spec Focus | ISO Reference | Key Sections |
|----------|-----------|------------|---------------|--------------|
| **01-Business Requirements** | REQ-BUS | Business goals, KPIs | - | objectives, success_metrics, stakeholders |
| **02-Compliance Requirements** | REQ-COMP | Regulatory compliance | - | regulations, controls, audits |
| **03-Constraint Requirements** | REQ-CONS | Budget, timeline, resources | - | constraints, limitations |
| **04-Functional Requirements** | REQ-FUNC | Features, behaviors | Functional Suitability | user_story, acceptance_criteria, api |
| **05-Performance Requirements** | REQ-PERF | Response time, throughput | Performance Efficiency | metrics, thresholds, validation |
| **06-Compatibility Requirements** | REQ-COMPAT | Integration, interoperability | Compatibility | interfaces, coexistence |
| **07-Usability Requirements** | REQ-USE | UX, accessibility | Usability | learnability, accessibility |
| **08-Reliability Requirements** | REQ-REL | Availability, fault tolerance | Reliability | availability, recovery |
| **09-Security Requirements** | REQ-SEC | Security controls | Security | threats, mitigations, validation |
| **10-Maintainability Requirements** | REQ-MAIN | Modularity, testability | Maintainability | code_quality, documentation |
| **11-Portability Requirements** | REQ-PORT | Cross-platform, migration | Portability | deployment, migration |
| **12-Architecture Requirements** | REQ-ARCH | Architecture decisions | - | patterns, constraints, interfaces |
| **13-Data Requirements** | REQ-DATA | Data model, governance | - | data_quality, retention |

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

### Cross-Category Relation Types

| Relation | Description | Example | ISO Trade-off |
|----------|-------------|---------|---------------|
| **drives** | One requirement drives another | REQ-BUS drives REQ-FUNC | - |
| **constrains** | One constrains another | REQ-ARCH constrains REQ-FUNC | - |
| **mandates** | Compliance mandates specific requirements | REQ-COMP mandates REQ-SEC | - |
| **depends_on** | Dependency relationship | REQ-FUNC depends_on REQ-SEC | - |
| **conflicts_with** | Conflicting objectives | REQ-SEC conflicts_with REQ-USE | Security vs Usability |
| **trades_off** | Quality trade-off relationship | REQ-PERF trades_off REQ-SEC | Performance vs Security |
| **validates** | Validation relationship | REQ-COMP validates REQ-SEC | - |
| **supports** | Support relationship | REQ-PERF supports REQ-BUS | - |
| **enables** | Enablement relationship | REQ-ARCH enables REQ-PERF | - |
| **influences** | Influence relationship | REQ-DATA influences REQ-ARCH | - |

## Implementation

### Parsing Strategy

```python
def parse_requirement(natural_language):
    """Parse natural language into structured spec."""

    spec = {
        'title': extract_title(natural_language),
        'user_story': extract_user_story(natural_language),
        'acceptance_criteria': extract_criteria(natural_language),
        'edge_cases': infer_edge_cases(natural_language),
        'api_requirements': infer_api(natural_language),
        'iso_reference': map_to_iso_25010(natural_language)
    }

    return spec

def map_to_iso_25010(statement):
    """Map requirement to ISO/IEC 25010:2023 quality model."""
    
    iso_mapping = {
        'functional': {
            'characteristic': 'Functional Suitability',
            'subcharacteristics': ['Functional completeness', 'Functional correctness', 'Functional appropriateness']
        },
        'performance': {
            'characteristic': 'Performance Efficiency',
            'subcharacteristics': ['Time behavior', 'Resource utilization', 'Capacity']
        },
        'compatibility': {
            'characteristic': 'Compatibility',
            'subcharacteristics': ['Coexistence', 'Interoperability']
        },
        'usability': {
            'characteristic': 'Usability',
            'subcharacteristics': ['Appropriateness recognizability', 'Learnability', 'Operability', 'Accessibility']
        },
        'reliability': {
            'characteristic': 'Reliability',
            'subcharacteristics': ['Maturity', 'Availability', 'Fault tolerance', 'Recoverability']
        },
        'security': {
            'characteristic': 'Security',
            'subcharacteristics': ['Confidentiality', 'Integrity', 'Non-repudiation', 'Authenticity']
        },
        'maintainability': {
            'characteristic': 'Maintainability',
            'subcharacteristics': ['Modularity', 'Reusability', 'Analysability', 'Modifiability', 'Testability']
        },
        'portability': {
            'characteristic': 'Portability',
            'subcharacteristics': ['Adaptability', 'Installability', 'Replaceability']
        }
    }
    
    return iso_mapping
```

### Gherkin to Spec

```gherkin
# Input: Gherkin feature
Feature: Password Reset

  Scenario: User resets password
    Given the user is registered
    When the user requests password reset
    Then they should receive reset email within 30 seconds
    And the reset link should expire in 1 hour
```

```yaml
# Output: Structured spec
scenarios:
  - id: "SCEN-001"
    name: "User resets password"
    given: "the user is registered"
    when: "the user requests password reset"
    then:
      - "they should receive reset email within 30 seconds"
      - "the reset link should expire in 1 hour"
    iso_verification:
      - "Performance Efficiency - Time Behavior"
      - "Security - Authenticity"
```

### Thirteen-Category Spec Templates

#### 01-业务需求 Spec Template
```yaml
spec_id: "REQ-BUS-{NUMBER}"
title: "Business Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "01_business"
  subcategory: "strategic | operational | financial"

business_context:
  background: "Current situation and problem"
  objectives:
    - "Primary business objective"
    - "Secondary objective"
  success_metrics:
    - metric: "KPI name"
      current: "Current value"
      target: "Target value"
      unit: "Unit"
      timeframe: "Achievement timeline"

stakeholders:
  - role: "Role name"
    influence: "high | medium | low"
    interest: "Interest description"
    
cross_category_relations:
  - related_category: "04_functional"
    relation_type: "drives"
    related_spec: "REQ-FUNC-XXX"
    rationale: "Business goal drives functional requirement"
```

#### 02-合规性需求 Spec Template
```yaml
spec_id: "REQ-COMP-{NUMBER}"
title: "Compliance Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "02_compliance"
  subcategory: "regulatory | legal | industry | internal"

compliance_framework:
  name: "GDPR | ISO 27001 | HIPAA | PCI DSS | SOC 2"
  version: "Framework version"
  scope: "Applicable scope"

requirements:
  - id: "COMP-001"
    description: "Compliance requirement description"
    control: "Control reference"
    evidence_required: "Required evidence"

controls:
  - id: "CTRL-001"
    name: "Control name"
    description: "Control description"
    implementation: "How implemented"
    verification: "How verified"

cross_category_relations:
  - related_category: "09_security"
    relation_type: "mandates"
    related_spec: "REQ-SEC-XXX"
    rationale: "Compliance mandates security controls"
  - related_category: "13_data"
    relation_type: "constrains"
    related_spec: "REQ-DATA-XXX"
    rationale: "Compliance constrains data handling"
```

#### 03-约束性需求 Spec Template
```yaml
spec_id: "REQ-CONS-{NUMBER}"
title: "Constraint Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "03_constraint"
  subcategory: "budget | timeline | resource | technical"

constraints:
  budget:
    limit: "Budget limit"
    currency: "Currency"
    flexibility: "fixed | flexible | negotiable"
    
  timeline:
    start_date: "Project start date"
    end_date: "Project end date"
    milestones:
      - name: "Milestone name"
        date: "Target date"
        
  resources:
    team_size: "Number of team members"
    skills_required: ["Skill 1", "Skill 2"]
    availability: "Resource availability"
    
  technical:
    platform: "Platform constraints"
    technology: "Technology constraints"
    integration: "Integration constraints"

cross_category_relations:
  - related_category: "12_architecture"
    relation_type: "constrains"
    related_spec: "REQ-ARCH-XXX"
    rationale: "Constraints limit architecture options"
```

#### 04-功能性需求 Spec Template
```yaml
spec_id: "REQ-FUNC-{NUMBER}"
title: "Functional Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "04_functional"
  subcategory: "feature | behavior | data | integration"
  iso_reference:
    characteristic: "Functional Suitability"
    subcharacteristic: "Functional Completeness"

user_story: |
  As a [role],
  I want [feature],
  So that [benefit].

acceptance_criteria:
  - id: "AC-001"
    description: "Acceptance criteria description"
    priority: "must | should | could"
    test_type: "unit | integration | e2e"
    category_link: "REQ-XXX-XXX"
    iso_verification: "Functional Correctness"

edge_cases:
  - description: "Edge case description"
    expected: "Expected behavior"

api_requirements:
  endpoint: "HTTP METHOD /path"
  request:
    field: "type (required|optional)"
  responses:
    200: { description: "Success response" }
    400: { description: "Error response" }

cross_category_relations:
  - related_category: "01_business"
    relation_type: "driven_by"
    related_spec: "REQ-BUS-XXX"
  - related_category: "09_security"
    relation_type: "depends_on"
    related_spec: "REQ-SEC-XXX"
    iso_trade_off: "Security vs Functionality"
```

#### 05-性能需求 Spec Template
```yaml
spec_id: "REQ-PERF-{NUMBER}"
title: "Performance Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "05_performance"
  subcategory: "response_time | throughput | latency | capacity"
  iso_reference:
    characteristic: "Performance Efficiency"
    subcharacteristic: "Time Behavior | Resource Utilization | Capacity"

metrics:
  - name: "Metric name"
    description: "What this measures"
    formula: "Calculation formula"
    unit: "Unit of measurement"
    target: "Target value"
    baseline: "Current baseline"
    threshold:
      excellent: "Excellent threshold"
      acceptable: "Acceptable threshold"
      warning: "Warning threshold"
      critical: "Critical threshold"

validation:
  strategy: "load_test | stress_test | capacity_test"
  tools: ["k6", "JMeter", "Locust"]
  scenarios:
    - name: "Test scenario"
      configuration: "Test configuration"
      expected_result: "Expected result"

cross_category_relations:
  - related_category: "08_reliability"
    relation_type: "supports"
    related_spec: "REQ-REL-XXX"
  - related_category: "12_architecture"
    relation_type: "influenced_by"
    related_spec: "REQ-ARCH-XXX"
```

#### 06-兼容性需求 Spec Template
```yaml
spec_id: "REQ-COMPAT-{NUMBER}"
title: "Compatibility Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "06_compatibility"
  subcategory: "coexistence | interoperability"
  iso_reference:
    characteristic: "Compatibility"
    subcharacteristic: "Coexistence | Interoperability"

coexistence_requirements:
  - system: "External system name"
    version: "Version requirements"
    interface: "Interface type"
    status: "required | optional"

interoperability_requirements:
  - standard: "Standard name (e.g., REST, GraphQL)"
    version: "Standard version"
    compliance_level: "full | partial"
    
  - protocol: "Protocol name"
    data_format: "JSON | XML | Protocol Buffers"
    encoding: "UTF-8 | ASCII"

validation:
  strategy: "integration_test | compatibility_test"
  tools: ["Postman", "Newman"]
  scenarios:
    - name: "Compatibility scenario"
      configuration: "Test configuration"
      expected_result: "Expected result"

cross_category_relations:
  - related_category: "04_functional"
    relation_type: "enables"
    related_spec: "REQ-FUNC-XXX"
  - related_category: "11_portability"
    relation_type: "supports"
    related_spec: "REQ-PORT-XXX"
```

#### 07-易用性需求 Spec Template
```yaml
spec_id: "REQ-USE-{NUMBER}"
title: "Usability Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "07_usability"
  subcategory: "learnability | operability | accessibility | user_error_protection"
  iso_reference:
    characteristic: "Usability"
    subcharacteristic: "Learnability | Operability | Accessibility"

usability_metrics:
  - name: "Task completion time"
    target: "Target time"
    baseline: "Current baseline"
    
  - name: "Error rate"
    target: "Target rate"
    baseline: "Current baseline"
    
  - name: "User satisfaction score"
    target: "Target score"
    baseline: "Current baseline"

accessibility_requirements:
  - standard: "WCAG 2.1"
    level: "A | AA | AAA"
    requirements:
      - "Specific accessibility requirement"

validation:
  strategy: "usability_test | accessibility_audit"
  tools: ["axe", "WAVE"]
  scenarios:
    - name: "Usability scenario"
      user_group: "Target user group"
      tasks: ["Task 1", "Task 2"]

cross_category_relations:
  - related_category: "09_security"
    relation_type: "trades_off"
    related_spec: "REQ-SEC-XXX"
    iso_trade_off: "Security vs Usability"
  - related_category: "04_functional"
    relation_type: "supports"
    related_spec: "REQ-FUNC-XXX"
```

#### 08-可靠性需求 Spec Template
```yaml
spec_id: "REQ-REL-{NUMBER}"
title: "Reliability Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "08_reliability"
  subcategory: "availability | fault_tolerance | recoverability | maturity"
  iso_reference:
    characteristic: "Reliability"
    subcharacteristic: "Availability | Fault Tolerance | Recoverability"

reliability_metrics:
  - name: "Availability"
    target: "99.9%"
    measurement: "uptime / total_time"
    
  - name: "MTBF (Mean Time Between Failures)"
    target: "1000 hours"
    measurement: "operating_time / failures"
    
  - name: "MTTR (Mean Time To Recovery)"
    target: "15 minutes"
    measurement: "total_downtime / incidents"

fault_tolerance:
  - fault_type: "Hardware failure"
    detection: "Detection method"
    response: "Response action"
    
  - fault_type: "Network failure"
    detection: "Detection method"
    response: "Response action"

recovery_requirements:
  rto: "Recovery Time Objective"
  rpo: "Recovery Point Objective"
  backup_frequency: "Backup frequency"

validation:
  strategy: "chaos_test | failover_test"
  tools: ["Chaos Monkey", "Gremlin"]
  scenarios:
    - name: "Failover scenario"
      fault: "Fault type"
      expected_result: "Expected behavior"

cross_category_relations:
  - related_category: "05_performance"
    relation_type: "depends_on"
    related_spec: "REQ-PERF-XXX"
  - related_category: "09_security"
    relation_type: "supports"
    related_spec: "REQ-SEC-XXX"
```

#### 09-安全性需求 Spec Template
```yaml
spec_id: "REQ-SEC-{NUMBER}"
title: "Security Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "09_security"
  subcategory: "confidentiality | integrity | authenticity | non_repudiation"
  iso_reference:
    characteristic: "Security"
    subcharacteristic: "Confidentiality | Integrity | Authenticity"

security_domain:
  cia_triad:
    confidentiality: "Confidentiality requirements"
    integrity: "Integrity requirements"
    availability: "Availability requirements"

threat_model:
  methodology: "STRIDE | DREAD | PASTA"
  threats:
    - id: "THREAT-001"
      type: "Spoofing | Tampering | Repudiation | Information Disclosure | Denial of Service | Elevation of Privilege"
      description: "Threat description"
      likelihood: "high | medium | low"
      impact: "high | medium | low"
      mitigation: "Mitigation strategy"

security_controls:
  - id: "SEC-CTRL-001"
    name: "Control name"
    type: "preventive | detective | corrective"
    description: "Control description"
    implementation: "Implementation details"

validation:
  strategy: "penetration_test | vulnerability_scan | security_audit"
  tools: ["OWASP ZAP", "Burp Suite"]
  frequency: "Testing frequency"

cross_category_relations:
  - related_category: "02_compliance"
    relation_type: "validates"
    related_spec: "REQ-COMP-XXX"
  - related_category: "07_usability"
    relation_type: "trades_off"
    related_spec: "REQ-USE-XXX"
    iso_trade_off: "Security vs Usability"
```

#### 10-可维护性需求 Spec Template
```yaml
spec_id: "REQ-MAIN-{NUMBER}"
title: "Maintainability Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "10_maintainability"
  subcategory: "modularity | reusability | analysability | modifiability | testability"
  iso_reference:
    characteristic: "Maintainability"
    subcharacteristic: "Modularity | Testability | Analysability"

maintainability_metrics:
  - name: "Code complexity"
    target: "< 15 cyclomatic complexity"
    measurement: "Static analysis"
    
  - name: "Test coverage"
    target: "> 80%"
    measurement: "Coverage tools"
    
  - name: "Documentation coverage"
    target: "> 90%"
    measurement: "Documentation analysis"

code_standards:
  - standard: "Language-specific standard"
    tools: ["ESLint", "Prettier", "golangci-lint"]
    
  - pattern: "Design pattern requirement"
    rationale: "Why this pattern"

testability_requirements:
  unit_test:
    coverage: "80%"
    tools: ["Jest", "Go test"]
    
  integration_test:
    coverage: "60%"
    tools: ["Cypress", "Postman"]

cross_category_relations:
  - related_category: "08_reliability"
    relation_type: "supports"
    related_spec: "REQ-REL-XXX"
  - related_category: "12_architecture"
    relation_type: "constrained_by"
    related_spec: "REQ-ARCH-XXX"
```

#### 11-可移植性需求 Spec Template
```yaml
spec_id: "REQ-PORT-{NUMBER}"
title: "Portability Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "11_portability"
  subcategory: "adaptability | installability | replaceability"
  iso_reference:
    characteristic: "Portability"
    subcharacteristic: "Adaptability | Installability | Replaceability"

platform_requirements:
  - platform: "Operating system or cloud provider"
    version: "Version requirements"
    priority: "required | optional"

containerization:
  required: true | false
  platform: "Docker | Kubernetes"
  registry: "Container registry"

deployment_requirements:
  - environment: "Development | Staging | Production"
    deployment_method: "CI/CD | Manual"
    rollback: "Rollback strategy"

migration_requirements:
  source: "Source system"
  target: "Target system"
  data_migration: "Data migration strategy"
  downtime_allowed: "Maximum downtime"

validation:
  strategy: "deployment_test | migration_test"
  tools: ["Docker", "Kubernetes"]
  scenarios:
    - name: "Deployment scenario"
      platform: "Target platform"
      expected_result: "Expected behavior"

cross_category_relations:
  - related_category: "06_compatibility"
    relation_type: "depends_on"
    related_spec: "REQ-COMPAT-XXX"
  - related_category: "12_architecture"
    relation_type: "influenced_by"
    related_spec: "REQ-ARCH-XXX"
```

#### 12-架构需求 Spec Template
```yaml
spec_id: "REQ-ARCH-{NUMBER}"
title: "Architecture Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "12_architecture"
  subcategory: "pattern | constraint | interface | technology"

architecture_context:
  current_state: "Current architecture"
  target_state: "Target architecture"
  drivers:
    - "Architecture driver 1"
    - "Architecture driver 2"

architecture_decisions:
  - decision: "Decision description"
    rationale: "Why this decision"
    alternatives:
      - name: "Alternative 1"
        pros: ["Pro 1"]
        cons: ["Con 1"]
    implications:
      - "Implication 1"

patterns:
  - name: "Architecture pattern (e.g., Microservices, Event-driven)"
    rationale: "Why this pattern"
    components:
      - "Component 1"
      - "Component 2"

quality_attributes:
  - attribute: "modifiability"
    requirement: "Specific requirement"
  - attribute: "scalability"
    requirement: "Specific requirement"

cross_category_relations:
  - related_category: "04_functional"
    relation_type: "constrains"
    related_spec: "REQ-FUNC-XXX"
    rationale: "Architecture constrains functional design"
  - related_category: "05_performance"
    relation_type: "enables"
    related_spec: "REQ-PERF-XXX"
    rationale: "Architecture enables performance"
  - related_category: "13_data"
    relation_type: "influences"
    related_spec: "REQ-DATA-XXX"
    rationale: "Architecture influences data design"
```

#### 13-数据需求 Spec Template
```yaml
spec_id: "REQ-DATA-{NUMBER}"
title: "Data Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "13_data"
  subcategory: "data_model | data_quality | data_governance | data_lifecycle"

data_model:
  entities:
    - name: "Entity name"
      attributes:
        - name: "Attribute name"
          type: "Data type"
          constraints: "Constraints"
      relationships:
        - target: "Related entity"
          type: "one-to-one | one-to-many | many-to-many"

data_quality:
  - dimension: "Accuracy"
    requirement: "Accuracy requirement"
    measurement: "How measured"
    
  - dimension: "Completeness"
    requirement: "Completeness requirement"
    measurement: "How measured"
    
  - dimension: "Consistency"
    requirement: "Consistency requirement"
    measurement: "How measured"

data_governance:
  ownership:
    - entity: "Data entity"
      owner: "Data owner"
      steward: "Data steward"
      
  classification:
    - level: "Public | Internal | Confidential | Restricted"
      criteria: "Classification criteria"
      handling: "Handling requirements"

data_lifecycle:
  retention:
    - data_type: "Data type"
      retention_period: "Retention period"
      archival: "Archival strategy"
      
  disposal:
    - data_type: "Data type"
      method: "Disposal method"
      verification: "Verification method"

cross_category_relations:
  - related_category: "02_compliance"
    relation_type: "constrained_by"
    related_spec: "REQ-COMP-XXX"
    rationale: "Data requirements constrained by compliance"
  - related_category: "09_security"
    relation_type: "depends_on"
    related_spec: "REQ-SEC-XXX"
    rationale: "Data requirements depend on security"
  - related_category: "12_architecture"
    relation_type: "influences"
    related_spec: "REQ-ARCH-XXX"
    rationale: "Data requirements influence architecture"
```

## Integration with Other Skills

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
  cross_category_relationships: [...]
  iso_quality_model_references: [...]
```

### Output to [bdd-scenario-writer](file:///d:/repos/aether-go/skills/skills/bdd-scenario-writer/SKILL.md)
```yaml
output:
  structured_specs:
    - spec_id: "REQ-{CATEGORY}-{NUMBER}"
      category: "..."
      iso_reference: "..."
      user_story: "..."
      acceptance_criteria: [...]
      cross_category_relations: [...]
```

### Output to [usecase-designer](file:///d:/repos/aether-go/skills/skills/usecase-designer/SKILL.md)
```yaml
output:
  specs_for_usecases:
    - spec_id: "REQ-FUNC-{NUMBER}"
      user_story: "..."
      acceptance_criteria: [...]
      iso_verification: [...]
```
