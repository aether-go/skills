---
name: atdd-acceptance-test-generator
description: Use when generating executable acceptance tests from requirements to drive development and ensure delivered functionality meets stakeholder expectations
---

# ATDD Acceptance Test Generator

## Overview
Generate executable acceptance tests from business requirements using Acceptance Test-Driven Development (ATDD) principles. Creates concrete, testable acceptance criteria that guide development, validate functionality from user perspective, and ensure delivered software meets stakeholder expectations.

## When to Use

```
Requirements defined? ───────────────────┐
                                         │
Need concrete acceptance criteria? ───────┤
                                         ├─► Use atdd-acceptance-test-generator
Development about to start? ──────────────┤
                                         │
Stakeholder validation critical? ─────────┘
```

Use when:
- Requirements have been collected but need testable form
- Starting development and need clear acceptance criteria
- Stakeholders need concrete examples to validate understanding
- Creating executable specifications for development teams
- Ensuring developed functionality matches business expectations
- Bridging communication gap between business and technical teams
- Need automated validation of requirements implementation

Don't use when:
- Requirements are still vague or unstable
- Only need high-level test scenarios (use BDD instead)
- Technical implementation details only
- Unit or integration testing needed (use TDD skills)

## Core Pattern

### ATDD Workflow Integration

```
Business Requirements → Acceptance Criteria → Executable Tests → Development Guide
         ↓                     ↓                     ↓                  ↓
Stakeholder Needs      Concrete Examples     Automated Tests     Implementation
         ↓                     ↓                     ↓                  ↓
┌─────────────────────────────────────────────────────────────────────────────┐
│                  Continuous Validation & Feedback Loop                      │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Before (Vague Acceptance Criteria)
```
Requirement: "Users can search for products"
Acceptance Criteria: "Search should work properly"
Development: Implements basic keyword search
Testing: Finds issues with filters, sorting, pagination
Stakeholders: "This isn't what we meant by search!"
```

### After (ATDD-Generated Tests)
```yaml
# Requirement: Product Search Functionality
requirement_id: "REQ-SEARCH-001"
description: "Users can search for products with various criteria"

# Generated Acceptance Tests
acceptance_tests:
  - test_id: "AT-SEARCH-001"
    name: "Basic keyword search"
    given: "User is on product search page with 100 products in database"
    when: "User enters 'laptop' in search field and clicks search"
    then: "System displays 15 products containing 'laptop' in title or description"
    and: "Results are sorted by relevance"
    priority: "must"
    
  - test_id: "AT-SEARCH-002"
    name: "Search with filters"
    given: "User has searched for 'shoes' and gotten 50 results"
    when: "User applies filter for size '10' and color 'black'"
    then: "System displays 8 products matching all criteria"
    and: "Filters are clearly displayed as active"
    priority: "must"
    
  - test_id: "AT-SEARCH-003"
    name: "Empty search results"
    given: "User is on product search page"
    when: "User searches for 'nonexistentproductxyz'"
    then: "System displays 'No products found' message"
    and: "Suggests alternative search terms or categories"
    priority: "should"
    
  - test_id: "AT-SEARCH-004"
    name: "Search performance"
    given: "Database contains 10,000 products"
    when: "User searches for common term 'book'"
    then: "Results appear within 2 seconds (P95)"
    and: "Search is cancelable if taking too long"
    priority: "should"

# Executable Test Code (Generated)
executable_tests:
  - framework: "Cypress"
    code: |
      describe('Product Search', () => {
        it('should return relevant results for keyword search', () => {
          cy.visit('/products')
          cy.get('[data-testid="search-input"]').type('laptop')
          cy.get('[data-testid="search-button"]').click()
          cy.get('[data-testid="product-card"]').should('have.length', 15)
          cy.contains('laptop').should('exist')
        })
        
        it('should filter search results', () => {
          cy.visit('/products?q=shoes')
          cy.get('[data-testid="size-filter"]').select('10')
          cy.get('[data-testid="color-filter"]').check('black')
          cy.get('[data-testid="product-card"]').should('have.length', 8)
          cy.get('[data-testid="active-filter"]').should('contain', 'Size: 10')
        })
      })
  
  - framework: "Postman/Newman"
    code: |
      {
        "name": "Search API Tests",
        "item": [
          {
            "name": "Basic search",
            "request": {
              "method": "GET",
              "url": "{{baseUrl}}/api/products/search?q=laptop",
              "header": []
            },
            "response": [
              {
                "name": "Valid response",
                "originalRequest": {...},
                "status": "OK",
                "code": 200,
                "header": [...],
                "body": "{\"results\": [...], \"total\": 15}"
              }
            ]
          }
        ]
      }

# Stakeholder Validation Examples
validation_examples:
  - scenario: "Marketing team review"
    example_data:
      search_query: "wireless headphones"
      expected_filters: ["brand", "price range", "connectivity", "color"]
      expected_sorting: ["best match", "price low-high", "customer rating"]
    validation_question: "Are these the right filters for headphone searches?"
    stakeholder_feedback: "Add 'battery life' filter, remove 'color' filter"
    
  - scenario: "Customer support review"
    example_data:
      edge_case: "User searches for 'red blue green shoes'"
      expected_behavior: "Treat as multiple keywords, show shoes with any color"
      error_handling: "If no results, suggest searching by individual colors"
    validation_question: "How should we handle complex multi-word searches?"
    stakeholder_feedback: "Also highlight products matching all colors if available"
```

## Quick Reference

### ATDD Test Types and Patterns

| Test Type | Purpose | Example Pattern | Generated Artifacts |
|-----------|---------|-----------------|---------------------|
| **Happy Path** | Validate main success scenarios | Given valid inputs, When action performed, Then expected outcome | Test cases, example data |
| **Edge Cases** | Validate boundary conditions | Given edge case inputs, When processed, Then appropriate handling | Edge case catalog, error handling tests |
| **Error Conditions** | Validate error handling | Given invalid inputs, When action performed, Then appropriate error | Error response tests, validation tests |
| **Performance** | Validate non-functional requirements | Given load/volume, When operation performed, Then meets performance targets | Performance test scripts, benchmarks |
| **Security** | Validate security requirements | Given attack vector, When exploited, Then prevented/detected | Security test cases, penetration tests |
| **Usability** | Validate user experience | Given user persona, When performing task, Then intuitive experience | Usability test scripts, user journey tests |
| **Integration** | Validate system interactions | Given external systems, When integrated, Then correct behavior | Integration test suites, API contract tests |

### Acceptance Test Template

```yaml
acceptance_test:
  id: "AT-{FEATURE}-{NUMBER}"
  version: "1.0"
  status: "draft | reviewed | approved | automated"
  
  # Test metadata
  requirement_id: "REQ-{FEATURE}-{NUMBER}"
  feature: "Descriptive feature name"
  priority: "critical | high | medium | low"
  risk_level: "high | medium | low"
  
  # Test scenario
  name: "Descriptive test name"
  description: "What this test validates"
  
  # Test steps (Given-When-Then)
  given:
    - "Precondition 1"
    - "Precondition 2"
    - "Data setup description"
    
  when:
    - "Action 1 performed"
    - "Action 2 performed"
    
  then:
    - "Expected outcome 1"
    - "Expected outcome 2"
    - "Expected system state"
    
  # Test data
  test_data:
    setup:
      - "Create test user with specific attributes"
      - "Load test products into database"
      - "Configure system settings"
    inputs:
      - "name: search_query, value: 'wireless headphones', type: string"
      - "name: filters, value: {brand: 'Sony', price_max: 200}, type: object"
    expected_outputs:
      - "name: results_count, value: '> 0', type: range"
      - "name: response_time, value: '< 2000ms', type: threshold"
  
  # Automation details
  automation:
    framework: "cypress | playwright | postman | jest"
    location: "path/to/test/file"
    dependencies: ["test database", "mock services"]
    execution_time: "estimated execution duration"
    
  # Validation evidence
  validation:
    reviewed_by: ["stakeholder names"]
    approved_date: "YYYY-MM-DD"
    examples_validated: ["list of validated examples"]
    feedback_incorporated: ["list of incorporated feedback items"]
    
  # Traceability
  traceability:
    links_to_requirements: ["REQ-IDs"]
    links_to_user_stories: ["US-IDs"]
    links_to_test_cases: ["TC-IDs"]
    coverage_metrics: "requirements covered by this test"
```

### Test Generation Rules

```yaml
test_generation_rules:
  happy_path:
    rule: "For each requirement, generate at least one happy path test"
    template: "Given [valid context], When [action], Then [expected outcome]"
    variations: ["different valid inputs", "different user roles", "different system states"]
    
  edge_cases:
    rule: "For each input field, generate boundary value tests"
    boundaries: ["empty", "minimum", "maximum", "just above max", "just below min"]
    special_values: ["null", "undefined", "whitespace-only", "very long values"]
    
  error_conditions:
    rule: "For each validation rule, generate error test"
    error_types: ["invalid format", "missing required", "duplicate value", "unauthorized"]
    error_responses: ["appropriate status code", "helpful error message", "suggested fix"]
    
  business_rules:
    rule: "For each business rule, generate test validating rule application"
    rule_types: ["calculations", "workflows", "permissions", "validation logic"]
    verification: ["correct output", "audit trail", "notifications triggered"]
    
  integration_points:
    rule: "For each integration, generate contract tests"
    contracts: ["API endpoints", "message formats", "data schemas", "error responses"]
    scenarios: ["normal flow", "partner system down", "invalid data", "version mismatch"]
```

## Implementation

### Acceptance Test Generation Engine

```python
class AcceptanceTestGenerator:
    """Generate acceptance tests from requirements."""
    
    def generate_tests(self, requirements, context):
        """Generate comprehensive acceptance tests from requirements."""
        
        test_suite = {
            'metadata': {
                'generated_date': datetime.now().isoformat(),
                'requirement_count': len(requirements),
                'coverage_target': '100%',
                'context': context
            },
            'tests_by_requirement': {},
            'tests_by_category': {},
            'executable_tests': {},
            'validation_examples': []
        }
        
        for req in requirements:
            requirement_tests = self._generate_tests_for_requirement(req, context)
            test_suite['tests_by_requirement'][req['id']] = requirement_tests
            
            # Categorize tests
            for test in requirement_tests:
                category = test.get('category', 'general')
                if category not in test_suite['tests_by_category']:
                    test_suite['tests_by_category'][category] = []
                test_suite['tests_by_category'][category].append(test)
            
            # Generate executable tests
            if self._should_generate_executable(req, context):
                executable = self._generate_executable_tests(requirement_tests, context)
                test_suite['executable_tests'][req['id']] = executable
            
            # Generate validation examples
            examples = self._generate_validation_examples(req, requirement_tests, context)
            test_suite['validation_examples'].extend(examples)
        
        # Calculate coverage
        test_suite['coverage_metrics'] = self._calculate_coverage(
            test_suite['tests_by_requirement'], requirements
        )
        
        return test_suite
    
    def _generate_tests_for_requirement(self, requirement, context):
        """Generate tests for a single requirement."""
        
        tests = []
        
        # Generate happy path tests
        happy_path_tests = self._generate_happy_path_tests(requirement, context)
        tests.extend(happy_path_tests)
        
        # Generate edge case tests
        edge_case_tests = self._generate_edge_case_tests(requirement, context)
        tests.extend(edge_case_tests)
        
        # Generate error condition tests
        error_tests = self._generate_error_tests(requirement, context)
        tests.extend(error_tests)
        
        # Generate business rule tests
        business_rule_tests = self._generate_business_rule_tests(requirement, context)
        tests.extend(business_rule_tests)
        
        # Add metadata and traceability
        for test in tests:
            test['requirement_id'] = requirement['id']
            test['traceability'] = {
                'business_value': requirement.get('business_value'),
                'stakeholders': requirement.get('stakeholders', []),
                'acceptance_criteria': requirement.get('acceptance_criteria', [])
            }
        
        return tests
    
    def _generate_happy_path_tests(self, requirement, context):
        """Generate happy path acceptance tests."""
        
        happy_path_tests = []
        
        # Extract main scenarios from requirement
        main_scenarios = self._extract_main_scenarios(requirement)
        
        for i, scenario in enumerate(main_scenarios, 1):
            test = {
                'id': f"AT-{requirement['id']}-HP-{i:03d}",
                'type': 'happy_path',
                'name': f"Happy path: {scenario['name']}",
                'description': scenario['description'],
                'priority': 'must',
                'risk_level': 'low',
                'given': self._derive_preconditions(scenario, context),
                'when': self._derive_actions(scenario),
                'then': self._derive_expected_outcomes(scenario, context),
                'test_data': self._generate_test_data(scenario, 'happy_path'),
                'validation_focus': 'core functionality'
            }
            happy_path_tests.append(test)
        
        return happy_path_tests
    
    def _generate_edge_case_tests(self, requirement, context):
        """Generate edge case acceptance tests."""
        
        edge_case_tests = []
        
        # Identify edge cases from requirement analysis
        edge_cases = self._identify_edge_cases(requirement)
        
        for i, edge_case in enumerate(edge_cases, 1):
            test = {
                'id': f"AT-{requirement['id']}-EC-{i:03d}",
                'type': 'edge_case',
                'name': f"Edge case: {edge_case['name']}",
                'description': edge_case['description'],
                'priority': edge_case.get('priority', 'should'),
                'risk_level': edge_case.get('risk_level', 'medium'),
                'given': self._derive_edge_case_preconditions(edge_case, context),
                'when': self._derive_edge_case_actions(edge_case),
                'then': self._derive_edge_case_outcomes(edge_case, context),
                'test_data': self._generate_test_data(edge_case, 'edge_case'),
                'validation_focus': 'boundary conditions and unusual scenarios'
            }
            edge_case_tests.append(test)
        
        return edge_case_tests
```

### Executable Test Code Generation

```python
class ExecutableTestGenerator:
    """Generate executable test code from acceptance tests."""
    
    def generate_executable_tests(self, acceptance_tests, target_framework, context):
        """Generate executable tests for specific framework."""
        
        if target_framework == 'cypress':
            return self._generate_cypress_tests(acceptance_tests, context)
        elif target_framework == 'playwright':
            return self._generate_playwright_tests(acceptance_tests, context)
        elif target_framework == 'postman':
            return self._generate_postman_collection(acceptance_tests, context)
        elif target_framework == 'jest':
            return self._generate_jest_tests(acceptance_tests, context)
        elif target_framework == 'robotframework':
            return self._generate_robotframework_tests(acceptance_tests, context)
        else:
            raise ValueError(f"Unsupported framework: {target_framework}")
    
    def _generate_cypress_tests(self, acceptance_tests, context):
        """Generate Cypress.io test code."""
        
        test_file = {
            'filename': f"acceptance_{context['feature_name'].lower()}.cy.js",
            'content': f"""// Acceptance tests for {context['feature_name']}
// Generated from ATDD Acceptance Test Generator
// Date: {datetime.now().isoformat()}

describe('{context['feature_name']} - Acceptance Tests', () => {{
  beforeEach(() => {{
    // Setup test data
    cy.setupTestData('{context['feature_name'].lower()}');
  }});
  
  afterEach(() => {{
    // Cleanup test data
    cy.cleanupTestData();
  }});
"""
        }
        
        test_cases = []
        for test in acceptance_tests:
            if test['type'] == 'happy_path':
                test_case = self._generate_cypress_test_case(test, context)
                test_cases.append(test_case)
        
        test_file['content'] += '\n\n'.join(test_cases)
        test_file['content'] += '\n});'
        
        return test_file
    
    def _generate_cypress_test_case(self, test, context):
        """Generate single Cypress test case."""
        
        return f"""  it('{test['name']}', () => {{
    // Given: {', '.join(test['given'])}
    {self._generate_cypress_given(test['given'], context)}
    
    // When: {', '.join(test['when'])}
    {self._generate_cypress_when(test['when'], context)}
    
    // Then: {', '.join(test['then'])}
    {self._generate_cypress_then(test['then'], context)}
  }});"""
    
    def _generate_postman_collection(self, acceptance_tests, context):
        """Generate Postman collection for API testing."""
        
        collection = {
            'info': {
                'name': f"{context['feature_name']} - Acceptance Tests",
                'description': f"Generated acceptance tests for {context['feature_name']}",
                'schema': 'https://schema.getpostman.com/json/collection/v2.1.0/collection.json'
            },
            'item': []
        }
        
        for test in acceptance_tests:
            if test.get('api_testable', True):
                postman_item = self._create_postman_item(test, context)
                collection['item'].append(postman_item)
        
        # Add test scripts for assertions
        collection['event'] = [{
            'listen': 'test',
            'script': {
                'type': 'text/javascript',
                'exec': self._generate_postman_test_scripts(acceptance_tests)
            }
        }]
        
        return collection
```

### Stakeholder Validation and Example Generation

```python
class ValidationExampleGenerator:
    """Generate examples for stakeholder validation."""
    
    def generate_validation_examples(self, requirements, tests, stakeholders):
        """Generate concrete examples for stakeholder validation."""
        
        validation_package = {
            'overview': f"Validation examples for {len(requirements)} requirements",
            'generated_date': datetime.now().isoformat(),
            'stakeholders': stakeholders,
            'examples_by_stakeholder': {},
            'decision_points': [],
            'validation_workflow': self._create_validation_workflow(stakeholders)
        }
        
        # Group examples by stakeholder role
        for stakeholder in stakeholders:
            role = stakeholder['role']
            relevant_examples = self._get_relevant_examples_for_role(
                requirements, tests, role
            )
            validation_package['examples_by_stakeholder'][role] = {
                'stakeholder': stakeholder,
                'examples': relevant_examples,
                'validation_questions': self._generate_validation_questions(
                    relevant_examples, role
                ),
                'expected_feedback_types': self._get_expected_feedback_types(role)
            }
        
        # Identify key decision points
        validation_package['decision_points'] = self._identify_decision_points(
            requirements, tests, stakeholders
        )
        
        return validation_package
    
    def _get_relevant_examples_for_role(self, requirements, tests, role):
        """Get examples relevant to specific stakeholder role."""
        
        relevant_examples = []
        
        for req in requirements:
            # Check if requirement is relevant to this role
            if self._is_relevant_to_role(req, role):
                requirement_examples = self._create_examples_for_requirement(
                    req, tests, role
                )
                relevant_examples.extend(requirement_examples)
        
        return relevant_examples
    
    def _create_examples_for_requirement(self, requirement, tests, role):
        """Create concrete examples for a requirement."""
        
        examples = []
        
        # Get tests for this requirement
        requirement_tests = [t for t in tests if t.get('requirement_id') == requirement['id']]
        
        # Create examples based on role perspective
        if role in ['product_owner', 'business_analyst']:
            # Business-focused examples
            examples.extend(self._create_business_examples(requirement, requirement_tests))
        
        if role in ['end_user', 'ux_designer']:
            # User experience examples
            examples.extend(self._create_ux_examples(requirement, requirement_tests))
        
        if role in ['customer_support', 'operations']:
            # Operational examples
            examples.extend(self._create_operational_examples(requirement, requirement_tests))
        
        if role in ['developer', 'tester']:
            # Technical examples
            examples.extend(self._create_technical_examples(requirement, requirement_tests))
        
        return examples
    
    def _create_business_examples(self, requirement, tests):
        """Create business-focused validation examples."""
        
        examples = []
        
        for test in tests:
            if test['type'] == 'happy_path':
                example = {
                    'type': 'business_scenario',
                    'title': f"Business scenario: {test['name']}",
                    'narrative': self._create_business_narrative(test),
                    'business_value': requirement.get('business_value', 'Not specified'),
                    'success_metrics': self._extract_success_metrics(test),
                    'key_decisions': self._identify_business_decisions(test),
                    'validation_questions': [
                        "Does this scenario reflect real business needs?",
                        "Are the success metrics appropriate?",
                        "What business decisions need to be made?"
                    ]
                }
                examples.append(example)
        
        return examples
```

### Test Coverage and Traceability Analysis

```python
class TestCoverageAnalyzer:
    """Analyze test coverage and traceability."""
    
    def analyze_coverage(self, requirements, tests):
        """Analyze acceptance test coverage of requirements."""
        
        coverage_report = {
            'summary': {
                'total_requirements': len(requirements),
                'total_tests': len(tests),
                'tests_per_requirement': len(tests) / len(requirements) if requirements else 0,
                'generation_date': datetime.now().isoformat()
            },
            'requirement_coverage': [],
            'gap_analysis': [],
            'recommendations': []
        }
        
        # Analyze coverage for each requirement
        for req in requirements:
            requirement_tests = [t for t in tests if t.get('requirement_id') == req['id']]
            
            coverage = {
                'requirement_id': req['id'],
                'requirement_description': req.get('description', ''),
                'test_count': len(requirement_tests),
                'test_types': self._count_test_types(requirement_tests),
                'coverage_score': self._calculate_coverage_score(requirement_tests, req),
                'gaps': self._identify_coverage_gaps(requirement_tests, req),
                'traceability': self._analyze_traceability(requirement_tests, req)
            }
            
            coverage_report['requirement_coverage'].append(coverage)
            
            # Identify gaps
            if coverage['gaps']:
                coverage_report['gap_analysis'].append({
                    'requirement_id': req['id'],
                    'gaps': coverage['gaps'],
                    'risk_level': self._assess_gap_risk(coverage['gaps']),
                    'recommended_tests': self._recommend_tests_for_gaps(coverage['gaps'], req)
                })
        
        # Generate overall recommendations
        coverage_report['recommendations'] = self._generate_recommendations(
            coverage_report['requirement_coverage'],
            coverage_report['gap_analysis']
        )
        
        return coverage_report
    
    def _calculate_coverage_score(self, tests, requirement):
        """Calculate coverage score for a requirement."""
        
        if not tests:
            return 0.0
        
        # Base score for having tests
        score = 0.3
        
        # Bonus for different test types
        test_types = set(t['type'] for t in tests)
        score += len(test_types) * 0.1
        
        # Bonus for happy path tests
        happy_path_count = sum(1 for t in tests if t['type'] == 'happy_path')
        if happy_path_count >= 1:
            score += 0.2
        
        # Bonus for edge case tests
        edge_case_count = sum(1 for t in tests if t['type'] == 'edge_case')
        if edge_case_count >= 2:
            score += 0.2
        
        # Bonus for error tests
        error_count = sum(1 for t in tests if t['type'] == 'error_condition')
        if error_count >= 1:
            score += 0.1
        
        # Cap at 1.0
        return min(score, 1.0)
    
    def _identify_coverage_gaps(self, tests, requirement):
        """Identify gaps in test coverage for a requirement."""
        
        gaps = []
        
        # Check for missing test types
        expected_test_types = self._get_expected_test_types(requirement)
        existing_types = set(t['type'] for t in tests)
        
        for expected_type in expected_test_types:
            if expected_type not in existing_types:
                gaps.append({
                    'type': 'missing_test_type',
                    'test_type': expected_type,
                    'description': f"No {expected_type} tests for this requirement",
                    'risk': 'medium' if expected_type == 'happy_path' else 'low'
                })
        
        # Check acceptance criteria coverage
        acceptance_criteria = requirement.get('acceptance_criteria', [])
        for criterion in acceptance_criteria:
            if not self._is_criterion_covered(criterion, tests):
                gaps.append({
                    'type': 'uncovered_criterion',
                    'criterion': criterion,
                    'description': f"Acceptance criterion not covered by tests",
                    'risk': 'high'
                })
        
        # Check business rule coverage
        business_rules = requirement.get('business_rules', [])
        for rule in business_rules:
            if not self._is_rule_covered(rule, tests):
                gaps.append({
                    'type': 'uncovered_business_rule',
                    'rule': rule,
                    'description': f"Business rule not covered by tests",
                    'risk': 'medium'
                })
        
        return gaps
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| **Tests too technical** | Business stakeholders can't understand or validate | Use business language, focus on user outcomes |
| **Missing edge cases** | System fails in production with unexpected inputs | Systematically identify boundary conditions |
| **Tests not executable** | Can't automate validation, manual testing required | Generate executable test code alongside scenarios |
| **No stakeholder examples** | Misalignment between tests and business expectations | Create concrete examples for stakeholder review |
| **Poor traceability** | Can't verify which requirements are tested | Maintain clear links between tests and requirements |
| **Ignoring non-functional** | System meets functional needs but fails on performance | Include performance, security, usability tests |
| **Tests as afterthought** | Development completed before tests defined | Generate tests before development starts (ATDD) |
| **No validation feedback loop** | Tests don't improve based on stakeholder input | Incorporate feedback into test generation |

### Red Flags

- Acceptance tests written in technical implementation language
- No concrete examples for stakeholder validation
- Tests don't cover all acceptance criteria
- Missing edge case and error condition tests
- No executable test code generated
- Poor traceability to business requirements
- Stakeholders not involved in test review
- Tests generated after development completed

## Real-World Impact

**Before (No ATDD):**
- Requirements: "Users can reset password"
- Development: Implements basic reset functionality
- Testing: Finds missing email validation, rate limiting
- Production: Users abuse system, support tickets increase
- Outcome: Rework required, unhappy stakeholders

**After (With ATDD):**
- Requirements: "Users can reset password securely"
- ATDD Tests: 12 acceptance tests covering all scenarios
- Stakeholder Validation: Examples reviewed and approved
- Development: Implements all validated scenarios
- Testing: Automated tests validate all acceptance criteria
- Production: Secure, robust password reset functionality
- Outcome: Right functionality first time, reduced support costs

**Benefits:** 40% reduction in defects, 30% faster development cycle, higher stakeholder satisfaction, automated regression suite.

## Integration with Aether.go Methodology

### Integration with BDD Scenarios

```yaml
# ATDD → BDD Integration
atdd_tests:
  input: "requirements_with_acceptance_criteria.yaml"
  process:
    1. Generate concrete acceptance tests
    2. Create stakeholder validation examples
    3. Produce executable test code
  
bdd_scenarios:
  input: "atdd_tests.yaml"
  process:
    1. Convert acceptance tests to Gherkin format
    2. Add context and background
    3. Create feature files with scenarios
  output: "*.feature files"

# Example flow
requirement: "Password reset with email verification"
  → atdd_test: "User receives reset email within 30 seconds"
  → bdd_scenario: |
      Scenario: Password reset email delivery
        Given a registered user with email "user@example.com"
        When they request password reset
        Then they should receive reset email within 30 seconds
```

### Integration with TDD Development

```yaml
# ATDD → TDD Flow
atdd_acceptance_tests:
  role: "Define what to build from user perspective"
  output: "Executable acceptance criteria"

tdd_development:
  role: "Implement how to build it"
  process:
    1. Read acceptance tests as requirements
    2. Write failing unit tests
    3. Implement code to pass unit tests
    4. Refactor
    5. Verify acceptance tests pass

# Development workflow
workflow:
  - phase: "ATDD Test Generation"
    activities: ["Generate acceptance tests", "Stakeholder validation"]
    outputs: ["validated_acceptance_tests.yaml", "executable_tests.js"]
    
  - phase: "TDD Implementation"
    activities: ["Write unit tests", "Implement functionality", "Run acceptance tests"]
    outputs: ["production_code", "passing_acceptance_tests"]
    
  - phase: "Continuous Validation"
    activities: ["Run test suite", "Monitor production", "Collect feedback"]
    outputs: ["quality_metrics", "improvement_opportunities"]
```

### Constitution Integration for Test Quality

```yaml
# Constitutional Principles for Testing
constitution_principles:
  - principle: "Test-First Development"
    description: "Acceptance tests must be defined before implementation begins"
    atdd_requirement: "Generate tests during requirements phase"
    validation: "Check test creation date vs implementation start date"
    
  - principle: "Stakeholder Validation"
    description: "Tests must be validated by business stakeholders"
    atdd_requirement: "Create validation examples for stakeholder review"
    validation: "Require stakeholder sign-off on test examples"
    
  - principle: "Executable Specifications"
    description: "Acceptance criteria must be executable as automated tests"
    atdd_requirement: "Generate executable test code alongside scenarios"
    validation: "Verify automated test execution and pass rates"
    
  - principle: "Comprehensive Coverage"
    description: "Tests must cover all acceptance criteria and edge cases"
    atdd_requirement: "Systematically generate tests for all scenarios"
    validation: "Calculate and report test coverage metrics"

constitution_validator:
  checks:
    - name: "ATDD Test Completeness"
      query: |
        SELECT COUNT(DISTINCT r.id) as requirements_without_tests
        FROM requirements r
        LEFT JOIN acceptance_tests t ON r.id = t.requirement_id
        WHERE t.id IS NULL
      threshold: 0
      severity: "error"
      
    - name: "Stakeholder Validation"
      query: |
        SELECT COUNT(*) as tests_without_validation
        FROM acceptance_tests
        WHERE stakeholder_validated = false
      threshold: "<= 10%"
      severity: "warning"
```

### Metrics and Feedback Integration

```python
# ATDD Metrics Collection
class ATDDMetricsCollector:
    """Collect metrics on ATDD effectiveness."""
    
    def collect_metrics(self, requirements, tests, implementation_results):
        """Collect comprehensive ATDD metrics."""
        
        metrics = {
            'test_generation_metrics': {
                'tests_generated': len(tests),
                'tests_per_requirement': len(tests) / len(requirements),
                'test_type_distribution': self._calculate_test_type_distribution(tests),
                'generation_time': self._calculate_generation_time(tests),
                'automation_rate': self._calculate_automation_rate(tests)
            },
            
            'validation_metrics': {
                'stakeholders_involved': self._count_stakeholders(requirements),
                'validation_examples_created': self._count_validation_examples(tests),
                'feedback_items_received': self._count_feedback_items(tests),
                'feedback_incorporation_rate': self._calculate_feedback_incorporation(tests)
            },
            
            'development_impact_metrics': {
                'defects_prevented': self._estimate_defects_prevented(tests, implementation_results),
                'rework_reduction': self._calculate_rework_reduction(implementation_results),
                'development_cycle_time': self._measure_cycle_time(requirements, implementation_results),
                'stakeholder_satisfaction': self._measure_stakeholder_satisfaction(requirements)
            },
            
            'coverage_metrics': {
                'requirement_coverage': self._calculate_requirement_coverage(tests, requirements),
                'acceptance_criteria_coverage': self._calculate_criteria_coverage(tests, requirements),
                'edge_case_coverage': self._calculate_edge_case_coverage(tests),
                'business_rule_coverage': self._calculate_business_rule_coverage(tests, requirements)
            }
        }
        
        return metrics
```

This integration ensures that ATDD acceptance tests serve as the bridge between business requirements and technical implementation, with constitution principles ensuring test quality and metrics tracking effectiveness throughout the development lifecycle.