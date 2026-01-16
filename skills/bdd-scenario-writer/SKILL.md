---
name: bdd-scenario-writer
description: Use when converting user stories or requirements into Gherkin BDD scenario files
---

# BDD Scenario Writer

## Overview
Transform natural language requirements and user stories into executable Gherkin scenario files (`.feature` files) for behavior-driven development testing.

## When to Use

```
Need to write acceptance tests? ───────┐
                                        ├─► Use bdd-scenario-writer
Have user story requirements? ────────┘
```

Use when:
- Converting user stories into test scenarios
- Writing acceptance criteria in Gherkin format
- Creating `.feature` files for BDD frameworks (Cucumber, SpecFlow, Behave)
- Documenting business requirements as executable tests
- Translating requirements into Given-When-Then structure

Don't use when:
- Writing unit tests (use TDD skills instead)
- Requirements are already in Gherkin format
- Creating technical specifications without testable behavior

## Core Pattern

### Before (Raw User Story)
```
As a user, I want to log in with email and password so that I can access my account.
Acceptance criteria:
- Valid email and password should log me in
- Invalid password should show error
- Locked account should show message
```

### After (Gherkin Scenario)
```gherkin
Feature: User Authentication

  Scenario: Successful login with valid credentials
    Given the user has registered with email "user@example.com"
    And the user has set password "SecurePass123"
    When the user logs in with email "user@example.com" and password "SecurePass123"
    Then the user should be logged in successfully
    And the user should see "Welcome back"

  Scenario: Failed login with invalid password
    Given the user has registered with email "user@example.com"
    And the user has set password "SecurePass123"
    When the user logs in with email "user@example.com" and password "WrongPass"
    Then the login should fail
    And the user should see error message "Invalid credentials"

  Scenario: Login attempt on locked account
    Given the user account "user@example.com" is locked
    When the user attempts to log in
    Then the login should fail
    And the user should see message "Account locked. Contact support"
```

## Quick Reference

| Requirement Pattern | Gherkin Pattern | Example |
|---------------------|-----------------|---------|
| Success case | Normal scenario | Login succeeds with valid credentials |
| Error case | "Failed" or "Error" scenario | Failed login with invalid password |
| Edge case | Scenario with special condition | Login on locked/expired account |
| Multiple inputs | Examples table | Login with various email formats |
| Precondition | Given step | User exists in database |
| Action | When step | User submits login form |
| Expected outcome | Then step | User sees welcome message |

## Implementation

### Scenario Structure Rules

1. **Feature File Organization**
   - One feature file per user story or major functionality
   - File name: `kebab-case.feature` (e.g., `user-authentication.feature`)
   - Feature description summarizes business value

2. **Scenario Naming Convention**
   - Descriptive and testable: `Scenario: Action with condition`
   - Positive: `Successful login with valid credentials`
   - Negative: `Failed login with invalid password`
   - Edge: `Login on expired account`

3. **Given-When-Then Guidelines**
   - **Given**: Precondition or setup state
   - **When**: User action or system event
   - **Then**: Expected outcome or observable behavior
   - Use `And`/`But` for multiple steps of same type

4. **Language Selection**
   - Use natural language matching domain (Chinese for Chinese projects, English for English)
   - Keep scenarios readable by non-technical stakeholders
   - Avoid technical implementation details in scenarios

5. **Coverage Requirements**
   - Minimum 2 scenarios per feature: happy path + error path
   - Include edge cases (boundary values, nulls, empty inputs)
   - Use Examples table for data-driven scenarios

### Examples Table Format

```gherkin
Scenario Outline: User registration validation
  Given the user registers with email "<email>" and password "<password>"
  Then registration should <result>

  Examples:
    | email                  | password     | result            |
    | valid@example.com      | Secure123!   | succeed           |
    | invalid-email          | Secure123!   | fail with "Invalid email" |
    | valid@example.com      | short        | fail with "Password too short" |
    |                        | Secure123!   | fail with "Email required" |
```

### Common BDD Keywords (Multi-language)

| Type | English | Chinese |
|------|---------|---------|
| Feature | Feature | 功能 |
| Scenario | Scenario | 场景 |
| Given | Given | 假如 |
| When | When | 当 |
| Then | Then | 那么 |
| And | And | 并且 |
| But | But | 但是 |

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Scenarios with implementation details | `When user clicks submit button with id="login-btn"` exposes UI | `When user submits login form` - focus on intent |
| Missing error scenarios | Only testing happy path misses bugs | Add scenarios for invalid inputs, errors, edge cases |
| Too many steps per scenario | 10+ steps are hard to maintain and understand | Break into multiple scenarios or use background |
| Ambiguous assertions | `Then the system responds appropriately` is untestable | `Then user sees error "Invalid credentials"` is specific |
| Duplicate Given steps | Repeating setup in every scenario | Use `Background:` section for common preconditions |
| Scenarios with business logic | Implementing rules in steps makes them brittle | Keep business logic in code, steps should describe observable behavior |

## Real-World Impact

**Before:** Product team writes requirements in Word documents, developers interpret differently, tests don't match expectations.

**After:** All requirements expressed as executable Gherkin scenarios, tests automatically validate business rules, non-technical stakeholders can review and approve test coverage.

**Result:** 40% reduction in requirements misinterpretation bugs, faster delivery, clearer communication between teams.
