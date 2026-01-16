---
name: spec-parser
description: Use when parsing natural language requirements into structured technical specifications
---

# Spec Parser

## Overview
Convert natural language user stories and requirements into structured, machine-readable specifications (YAML/JSON) that can drive development, testing, and documentation.

## When to Use

```
Requirements in natural language? ─────────┐
                                        │
Need structured specs? ─────────────────────┤
                                        ├─► Use spec-parser
Starting development project? ─────────────┤
                                        │
Aether.go SDD methodology? ───────────────┘
```

Use when:
- Converting user stories to technical specs
- Starting new features or projects
- Requirements need version control
- Generating test cases from specs
- Creating documentation automatically
- Bridging business and technical teams

Don't use when:
- Requirements already structured
- Simple one-off tasks
- No need for traceability

## Core Pattern

### Before (Unstructured)

```
User Story:
"As a user, I want to reset my password."

Issues:
- No clear acceptance criteria
- No edge cases defined
- Not testable
- Ambiguous requirements
```

### After (Structured)

```yaml
spec_id: "REQ-AUTH-005"
title: "Password Reset"
version: "1.0"
status: "draft"

user_story: |
  As a user,
  I want to reset my password,
  So that I can regain access to my account.

acceptance_criteria:
  - id: "AC-001"
    description: "User receives reset email within 30 seconds"
    priority: "must"
    test_type: "integration"

  - id: "AC-002"
    description: "Reset link expires in 1 hour"
    priority: "must"
    test_type: "unit"

  - id: "AC-003"
    description: "Reset link can only be used once"
    priority: "must"
    test_type: "security"

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
  related_specs: ["REQ-AUTH-001", "REQ-AUTH-010"]
```

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
