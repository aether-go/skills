---
name: skill-optimizer
description: Use when optimizing skill parameters, templates, and logic based on performance metrics and feedback. Part of D8 Meta-Capability Domain for skill library optimization.
---

# Skill Optimizer

## Overview
Optimize skill parameters, templates, and logic based on performance metrics and feedback. Part of D8 Meta-Capability Domain for skill library optimization, ensures skills maintain high success rates and effectiveness.

## When to Use

```
Skill success rate < 85%? ───────────────┐
                                         │
Need skill parameter tuning? ────────────┤
                                         ├─► Use skill-optimizer
Skill feedback indicates issues? ────────┤
                                         │
SkillLibraryCurator needs optimization? ─┘
```

Use when:
- Skill success rate is below 85%
- Skill parameter tuning is needed
- Skill feedback indicates issues
- SkillLibraryCurator requests optimization

Don't use when:
- Skill is performing well (> 90% success)
- Only minor template updates are needed
- Skill is being retired

## Core Pattern

### Optimization Process

```
Skill Performance Data
    ├── Success Rate Analysis
    ├── Failure Pattern Analysis
    ├── Parameter Sensitivity Analysis
    └── Template Effectiveness Analysis
         |
         v
    Optimization Recommendations
         |
         v
    Parameter Updates
         |
         v
    Validation
```

### Optimization Dimensions

| Dimension | Description | Target |
|-----------|-------------|--------|
| **Parameters** | Temperature, model selection, token limits | Optimal values |
| **Templates** | Prompt templates, output formats | High effectiveness |
| **Logic** | Decision logic, branching rules | High accuracy |
| **Examples** | Few-shot examples, training data | High relevance |

## Input Format

```yaml
optimization_request:
  skill:
    name: "backend-code-generator"
    version: "1.2.3"
  
  performance_data:
    success_rate: 0.78
    target: 0.85
    usage_count: 45
    
    failures:
      - reason: "context_insufficient"
        count: 8
        percentage: 0.178
      - reason: "template_mismatch"
        count: 3
        percentage: 0.067
  
  current_config:
    temperature: 0.7
    model: "claude-sonnet-4-20250514"
    max_tokens: 4000
    
  feedback:
    - "Generated code sometimes misses error handling"
    - "Template doesn't account for middleware patterns"
```

## Output Format

```yaml
optimization_result:
  skill: "backend-code-generator"
  version: "1.2.3"
  timestamp: "2026-04-30T10:00:00Z"
  
  analysis:
    current_success_rate: 0.78
    target_success_rate: 0.85
    gap: 0.07
    
    root_causes:
      - cause: "context_insufficient"
        impact: 0.178
        recommendation: "Enhance context collection in pre-processing"
      - cause: "template_mismatch"
        impact: 0.067
        recommendation: "Add middleware pattern template"
  
  recommendations:
    - type: parameter
      parameter: "temperature"
      current: 0.7
      recommended: 0.5
      reason: "Lower temperature for more deterministic output"
    
    - type: template
      template: "middleware-handler"
      action: "add"
      reason: "Support middleware patterns in generated code"
    
    - type: logic
      logic: "context-validation"
      action: "enhance"
      reason: "Add pre-flight context completeness check"
  
  expected_improvement:
    success_rate: 0.87
    confidence: 0.82
  
  validation_plan:
    - "A/B test new parameters for 20 uses"
    - "Measure success rate improvement"
    - "Gather user feedback on template changes"
```

## Integration with Aether.go Methodology

- **Input from**: SkillLibraryCurator, skill-gap-analyzer
- **Output to**: SkillLibraryCurator, boundedness-checker
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: Parameter Optimization
```yaml
skill: "api-generator"
issue: "success_rate: 0.78"
recommendations:
  - "temperature: 0.7 -> 0.5"
  - "Add middleware template"
expected: "success_rate: 0.87"
```

### Example 2: Template Optimization
```yaml
skill: "test-generator"
issue: "missing edge case coverage"
recommendations:
  - "Add boundary value template"
  - "Enhance error path template"
expected: "coverage: +15%"
```
