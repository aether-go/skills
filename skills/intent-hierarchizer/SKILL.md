---
name: intent-hierarchizer
description: Use when layering business intent into three levels (business intent, functional intent, implementation intent) for intent-driven development. Implements P11 Intent-Hierarchization Principle.
---

# Intent Hierarchizer

## Overview
Layer business intent into three levels (business intent, functional intent, implementation intent) for intent-driven development. Implements P11 Intent-Hierarchization Principle, ensuring intent is clearly structured and traceable.

## When to Use

```
Business intent captured? ───────────────┐
                                         │
Need intent layering? ───────────────────┤
                                         ├─► Use intent-hierarchizer
Intent-driven mode active? ──────────────┤
                                         │
P11 compliance check? ───────────────────┘
```

Use when:
- Business intent is captured and needs layering
- Intent-driven development mode is active
- P11 compliance check is needed
- Need to structure intent for AI-native build

Don't use when:
- Intent is not yet captured
- Only single-level intent exists
- Norm-driven mode with full planning

## Core Pattern

### Layering Process

```
Business Intent
    |
    ├── Business Intent (Why)
    │   └── Business goals, value proposition, success metrics
    |
    ├── Functional Intent (What)
    │   └── Features, user stories, acceptance criteria
    |
    └── Implementation Intent (How)
        └── Technical approach, architecture, technology choices
```

### Intent Levels

| Level | Question | Content | Example |
|-------|----------|---------|---------|
| **Business Intent** | Why? | Business goals, value, metrics | "Reduce customer support tickets by 80%" |
| **Functional Intent** | What? | Features, capabilities | "Auto-classify tickets, generate responses, escalate complex issues" |
| **Implementation Intent** | How? | Technical approach | "Use LLM for classification, RAG for responses, rules for escalation" |

### Validation Rules

- Business intent must be measurable
- Functional intent must trace to business intent
- Implementation intent must support functional intent
- All three levels must be consistent

## Input Format

```yaml
intent_request:
  project:
    name: "AI Customer Support"
    description: "Automate customer support with AI"
  
  raw_intent:
    business: "Reduce support costs and improve response time"
    functional: "Auto-classify and respond to customer tickets"
    implementation: "Use AI for classification and response generation"
  
  validation:
    check_consistency: true
    check_traceability: true
    check_measurability: true
```

## Output Format

```yaml
intent_result:
  project: "AI Customer Support"
  
  layers:
    business:
      intent: "Reduce customer support operational costs by 50% while maintaining 95% customer satisfaction"
      goals:
        - "Reduce average response time from 4 hours to 5 minutes"
        - "Automate 80% of routine support tickets"
        - "Maintain customer satisfaction score > 95%"
      metrics:
        - "cost_reduction_percentage"
        - "response_time_minutes"
        - "automation_rate"
        - "csat_score"
      file: "intent/business-intent.md"
    
    functional:
      intent: "Provide intelligent ticket classification, automated response generation, and smart escalation"
      features:
        - "Auto-classify incoming tickets by category and urgency"
        - "Generate contextual responses based on knowledge base"
        - "Escalate complex or sensitive issues to human agents"
        - "Learn from agent feedback to improve accuracy"
      trace_to_business:
        - "Auto-classify -> automation_rate"
        - "Response generation -> response_time_minutes"
        - "Escalation -> csat_score"
      file: "intent/functional-intent.md"
    
    implementation:
      intent: "Build AI pipeline using LLM for NLP, vector database for knowledge retrieval, and workflow engine for escalation"
      approach:
        - "LLM integration for text understanding and generation"
        - "Vector database for semantic knowledge retrieval"
        - "Rule engine for escalation logic"
        - "Feedback loop for continuous improvement"
      trace_to_functional:
        - "LLM -> auto-classify + response generation"
        - "Vector DB -> contextual responses"
        - "Rule engine -> escalation"
      file: "intent/implementation-intent.md"
  
  consistency_check:
    status: passed
    issues: []
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: business-requirements-collector, scenario-detector
- **Output to**: ai-native-build-workflow, ConstitutionGuardian
- **Part of**: D6 Scenario Adaptation Domain

## Examples

### Example 1: E-commerce Platform
```yaml
business: "Increase conversion rate by 20%"
functional: "Personalized recommendations, streamlined checkout"
implementation: "ML recommendation engine, one-click checkout"
consistency: passed
```

### Example 2: Healthcare App
```yaml
business: "Reduce appointment no-shows by 30%"
functional: "Smart reminders, easy rescheduling"
implementation: "SMS/email notifications, calendar integration"
consistency: passed
```
