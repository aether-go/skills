---
name: ai-native-build-workflow
description: Use when executing AI-native build mode combining intent-driven development with hybrid generation pipeline. Supports the AI-native build scenario. Part of D6 Scenario Adaptation Domain.
---

# AI-Native Build Workflow

## Overview
Execute AI-native build mode combining intent-driven development with hybrid generation pipeline. Supports rapid prototyping and AI-first development where business intent is clearly layered and constraints are mechanized.

## When to Use

```
Building AI-native application? ─────────┐
                                         │
Intent-driven development? ──────────────┤
                                         ├─► Use ai-native-build-workflow
Hybrid generation pipeline? ─────────────┤
                                         │
Rapid prototyping with clear intent? ────┘
```

Use when:
- Building AI-native applications
- Intent-driven development mode is active
- Hybrid generation pipeline (deterministic + AI) is needed
- Rapid prototyping with clear business intent

Don't use when:
- Traditional regulated system development
- Intent is unclear or not layered
- Full constitutional compliance is mandatory

## Core Pattern

### AI-Native Build Process

```
Business Intent (L1)
    |
    v
Intent Layering (P11)
    ├── Business Intent
    ├── Functional Intent
    └── Implementation Intent
    |
    v
Constraint Mechanization (P13)
    ├── Load constraints/*.yml
    └── Enable GATE-001
    |
    v
Hybrid Generation Pipeline
    ├── Deterministic Tasks → Traditional Generators
    └── Non-Deterministic Tasks → AI Generation
    |
    v
Confidence-Based Review
    ├── > 0.90 → Auto-approve
    ├── 0.70-0.90 → Suggest confirmation
    └── < 0.70 → Mandatory review
    |
    v
Iterative Refinement
```

### Workflow Stages

1. **Intent Capture**: Layer business intent into three levels
2. **Constraint Loading**: Mechanize constraints from `constraints/` directory
3. **Generation Dispatch**: Route tasks to appropriate generators
4. **Confidence Review**: Grade and route AI-generated code
5. **Iterative Refinement**: Refine based on feedback

## Input Format

```yaml
ai_native_request:
  project:
    name: "AI Assistant Platform"
    type: "ai_native"
  
  intent:
    business: "Provide intelligent customer support automation"
    functional: "Natural language understanding, response generation, escalation"
    implementation: "LLM integration, vector database, conversation state management"
  
  constraints:
    performance: {response_time_ms: 500}
    security: {data_encryption: true, pii_handling: "strict"}
    compliance: {gdpr: true}
  
  tech_stack:
    language: "python"
    framework: "fastapi"
    ai_model: "gpt-4"
```

## Output Format

```yaml
ai_native_result:
  project: "AI Assistant Platform"
  mode: "intent_driven"
  
  intent_layers:
    business: {status: captured, file: "intent/business-intent.md"}
    functional: {status: captured, file: "intent/functional-intent.md"}
    implementation: {status: captured, file: "intent/implementation-intent.md"}
  
  generation_summary:
    deterministic_tasks: 12
    ai_tasks: 8
    token_savings_rate: 0.65
    
  code_generated:
    - path: "src/api/conversation.py"
      type: ai
      confidence: 0.88
      review: suggested_confirm
    - path: "src/models/vector_store.py"
      type: deterministic
      generator: "openapi-python"
  
  constraints_applied:
    - "Performance budget: 500ms"
    - "PII handling: strict"
    - "GDPR compliance: enabled"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: scenario-detector, mode-selector
- **Output to**: WorkflowOrchestrator, DispatchOrchestrator
- **Part of**: D6 Scenario Adaptation Domain

## Examples

### Example 1: AI Customer Support
```yaml
project: "AI Customer Support"
intent: {business: "Automate 80% of support tickets", functional: "Ticket classification, auto-response, escalation"}
result: {deterministic_tasks: 15, ai_tasks: 12, token_savings: 0.62}
```

### Example 2: Content Generation Platform
```yaml
project: "Content Generation Platform"
intent: {business: "Generate marketing content at scale", functional: "Template selection, content generation, review"}
result: {deterministic_tasks: 8, ai_tasks: 20, token_savings: 0.45}
```
