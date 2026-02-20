---
name: spec-parser
description: Use when parsing natural language requirements into structured technical specifications with 7-category support
---

# Spec Parser

## Overview
Convert natural language user stories and requirements into structured, machine-readable specifications (YAML/JSON) that can drive development, testing, and documentation. Supports the 7-category requirement classification system with cross-category relationship mapping.

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

### Seven-Category Spec Structure

```
Classified Requirements → Category-Specific Parsing → Structured Specs
         ↓                        ↓                        ↓
   7 Categories          Category Templates         Unified Spec Format
         ↓                        ↓                        ↓
┌─────────────────────────────────────────────────────────────────────┐
│                    Cross-Category Relationship Mapping               │
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
```

### After (Structured with 7-Category Support)

```yaml
spec_id: "REQ-FUNC-005"
title: "Password Reset"
version: "1.0"
status: "draft"

category:
  primary: "03_functional"
  subcategory: "authentication"
  
cross_category_relations:
  - related_category: "06_security"
    relation_type: "depends_on"
    related_spec: "REQ-SEC-001"
    rationale: "Password reset depends on security requirements"
    
  - related_category: "04_non_functional"
    relation_type: "constrained_by"
    related_spec: "REQ-NFR-002"
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
    category_link: "REQ-NFR-002"

  - id: "AC-002"
    description: "Reset link expires in 1 hour"
    priority: "must"
    test_type: "unit"
    category_link: "REQ-SEC-003"

  - id: "AC-003"
    description: "Reset link can only be used once"
    priority: "must"
    test_type: "security"
    category_link: "REQ-SEC-001"

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
  related_specs: ["REQ-BUS-001", "REQ-SEC-001", "REQ-NFR-002"]
```

## Quick Reference

### Seven-Category Spec Templates

| Category | ID Prefix | Spec Focus | Key Sections | Example |
|----------|-----------|------------|--------------|---------|
| **01-Business Requirements** | REQ-BUS | Business goals, KPIs | objectives, success_metrics, stakeholders | "Increase retention by 20%" |
| **02-Architecture Requirements** | REQ-ARCH | Architecture decisions | patterns, constraints, interfaces | "Use microservices architecture" |
| **03-Functional Requirements** | REQ-FUNC | Features, behaviors | user_story, acceptance_criteria, api | "User can reset password" |
| **04-Non-Functional Requirements** | REQ-NFR | Quality attributes | metrics, thresholds, validation | "Response time < 200ms" |
| **05-Compliance Requirements** | REQ-COMP | Regulatory compliance | regulations, controls, audits | "GDPR data protection" |
| **06-Security Requirements** | REQ-SEC | Security controls | threats, mitigations, validation | "Password hashing required" |
| **07-Scalability Requirements** | REQ-SCAL | Scaling capabilities | capacity, growth, limits | "Support 1M concurrent users" |

### Cross-Category Relation Types

| Relation | Description | Example |
|----------|-------------|---------|
| **drives** | One requirement drives another | REQ-BUS drives REQ-FUNC |
| **constrains** | One constrains another | REQ-ARCH constrains REQ-FUNC |
| **depends_on** | Dependency relationship | REQ-FUNC depends_on REQ-SEC |
| **conflicts_with** | Conflicting objectives | REQ-SEC conflicts_with REQ-SCAL |
| **validates** | Validation relationship | REQ-COMP validates REQ-SEC |
| **supports** | Support relationship | REQ-NFR supports REQ-BUS |
| **enables** | Enablement relationship | REQ-ARCH enables REQ-SCAL |

## Implementation

### Parsing Strategy

```python
def parse_requirement(natural_language):
    """Parse natural language into structured spec."""

    # Extract components using NLP patterns
    spec = {
        'title': extract_title(natural_language),
        'user_story': extract_user_story(natural_language),
        'acceptance_criteria': extract_criteria(natural_language),
        'edge_cases': infer_edge_cases(natural_language),
        'api_requirements': infer_api(natural_language)
    }

    return spec
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
```

### Seven-Category Spec Templates

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
  - related_category: "03_functional"
    relation_type: "drives"
    related_spec: "REQ-FUNC-XXX"
    rationale: "Business goal drives functional requirement"

constraints:
  budget: "Budget constraints"
  timeline: "Timeline constraints"
  resources: "Resource constraints"
```

#### 02-架构需求 Spec Template
```yaml
spec_id: "REQ-ARCH-{NUMBER}"
title: "Architecture Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "02_architecture"
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

cross_category_relations:
  - related_category: "03_functional"
    relation_type: "constrains"
    related_spec: "REQ-FUNC-XXX"
    rationale: "Architecture constrains functional design"
  - related_category: "07_scalability"
    relation_type: "enables"
    related_spec: "REQ-SCAL-XXX"
    rationale: "Architecture enables scalability"

quality_attributes:
  - attribute: "modifiability"
    requirement: "Specific requirement"
  - attribute: "portability"
    requirement: "Specific requirement"
```

#### 03-功能性需求 Spec Template
```yaml
spec_id: "REQ-FUNC-{NUMBER}"
title: "Functional Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "03_functional"
  subcategory: "feature | behavior | data | integration"

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
  - related_category: "06_security"
    relation_type: "depends_on"
    related_spec: "REQ-SEC-XXX"

data_requirements:
  - entity: "Entity name"
    fields: ["field1", "field2"]
    validation: "Validation rules"
```

#### 04-非功能性需求 Spec Template
```yaml
spec_id: "REQ-NFR-{NUMBER}"
title: "Non-Functional Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "04_non_functional"
  subcategory: "performance | reliability | usability | maintainability"

quality_attribute:
  name: "Quality attribute name"
  iso_25010_category: "ISO 25010 category"

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
  strategy: "load_test | stress_test | chaos_test"
  tools: ["Tool 1", "Tool 2"]
  scenarios:
    - name: "Test scenario"
      configuration: "Test configuration"
      expected_result: "Expected result"

cross_category_relations:
  - related_category: "01_business"
    relation_type: "supports"
    related_spec: "REQ-BUS-XXX"
  - related_category: "07_scalability"
    relation_type: "constrains"
    related_spec: "REQ-SCAL-XXX"
```

#### 05-合规性需求 Spec Template
```yaml
spec_id: "REQ-COMP-{NUMBER}"
title: "Compliance Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "05_compliance"
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

audit_requirements:
  frequency: "Audit frequency"
  scope: "Audit scope"
  evidence:
    - "Evidence type 1"
    - "Evidence type 2"

cross_category_relations:
  - related_category: "06_security"
    relation_type: "validates"
    related_spec: "REQ-SEC-XXX"
  - related_category: "03_functional"
    relation_type: "constrains"
    related_spec: "REQ-FUNC-XXX"
```

#### 06-安全性需求 Spec Template
```yaml
spec_id: "REQ-SEC-{NUMBER}"
title: "Security Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "06_security"
  subcategory: "authentication | authorization | encryption | audit | data_protection"

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
  - related_category: "05_compliance"
    relation_type: "supports"
    related_spec: "REQ-COMP-XXX"
  - related_category: "04_non_functional"
    relation_type: "constrains"
    related_spec: "REQ-NFR-XXX"
```

#### 07-扩展性需求 Spec Template
```yaml
spec_id: "REQ-SCAL-{NUMBER}"
title: "Scalability Requirement Title"
version: "1.0"
status: "draft"

category:
  primary: "07_scalability"
  subcategory: "horizontal | vertical | data | geographic"

scaling_requirements:
  current_capacity:
    users: "Current user count"
    data_volume: "Current data volume"
    throughput: "Current throughput"
    
  target_capacity:
    users: "Target user count"
    data_volume: "Target data volume"
    throughput: "Target throughput"
    timeframe: "Achievement timeline"

scaling_strategy:
  approach: "horizontal | vertical | hybrid"
  triggers:
    - metric: "Scaling metric"
      threshold: "Threshold value"
      action: "Scaling action"
  limits:
    min_instances: "Minimum instances"
    max_instances: "Maximum instances"

capacity_planning:
  growth_model: "linear | exponential | logistic"
  projections:
    - period: "Time period"
      expected_growth: "Expected growth"
      required_capacity: "Required capacity"

validation:
  strategy: "stress_test | load_test | capacity_test"
  tools: ["k6", "Locust", "Gatling"]
  scenarios:
    - name: "Scaling scenario"
      configuration: "Test configuration"
      expected_result: "Expected scaling behavior"

cross_category_relations:
  - related_category: "02_architecture"
    relation_type: "driven_by"
    related_spec: "REQ-ARCH-XXX"
  - related_category: "04_non_functional"
    relation_type: "depends_on"
    related_spec: "REQ-NFR-XXX"
```

## Integration with Other Skills

### Input from [requirement-classifier](file:///d:/repos/aether-go/skills/skills/requirement-classifier/SKILL.md)
```yaml
input:
  classified_requirements:
    01_business: [...]
    02_architecture: [...]
    03_functional: [...]
    04_non_functional: [...]
    05_compliance: [...]
    06_security: [...]
    07_scalability: [...]
  cross_category_relationships: [...]
```

### Output to [bdd-scenario-writer](file:///d:/repos/aether-go/skills/skills/bdd-scenario-writer/SKILL.md)
```yaml
output:
  structured_specs:
    - spec_id: "REQ-{CATEGORY}-{NUMBER}"
      category: "..."
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
```
