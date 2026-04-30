---
name: scenario-detector
description: Use when detecting development scenarios (AI-native build, Harness reverse construction, Traditional waterfall) and recommending appropriate mode and strategy. Part of D6 Scenario Adaptation Domain.
---

# Scenario Detector

## Overview
Detect development scenarios (AI-native build, Harness reverse construction, Traditional waterfall) and recommend appropriate mode and strategy. Supports WorkflowOrchestrator's ModeManager by providing scenario detection and mode recommendations.

## When to Use

```
New project started? ────────────────────┐
                                         │
Need scenario detection? ────────────────┤
                                         ├─► Use scenario-detector
Mode recommendation needed? ─────────────┤
                                         │
WorkflowOrchestrator needs input? ───────┘
```

Use when:
- New project is started and scenario needs to be detected
- Mode recommendation is needed
- WorkflowOrchestrator needs scenario input
- Need to determine appropriate development strategy

Don't use when:
- Scenario is already known and defined
- Only mode switching is needed
- Project is already in progress with defined mode

## Core Pattern

### Detection Process

```
Project Context
    ├── Project Type
    ├── Team Maturity
    ├── Intent Clarity
    ├── Existing Codebase
    └── Delivery Constraints
         |
         v
    Scenario Detection
         |
         ├── AI-Native Build
         ├── Harness Reverse Construction
         └── Traditional Waterfall
```

### Scenario Definitions

| Scenario | Description | Indicators | Recommended Mode |
|----------|-------------|------------|-----------------|
| **AI-Native Build** | Building new AI-native application | Clear intent, greenfield, AI-first | Intent-Driven |
| **Harness Reverse Construction** | Reverse-engineering legacy system | Existing codebase, unclear constraints, refactoring | Norm-Driven with progressive constraint injection |
| **Traditional Waterfall** | Standard regulated development | Regulated industry, strict compliance, clear requirements | Norm-Driven |
| **Emergent Exploration** | POC or research project | Unclear requirements, experimental, rapid iteration | Emergent Exploration |

### Detection Indicators

| Indicator | AI-Native | Harness | Traditional | Emergent |
|-----------|-----------|---------|-------------|----------|
| Codebase state | Greenfield | Legacy | Greenfield/Legacy | Greenfield |
| Intent clarity | High | Low | High | Low |
| Compliance needs | Low | Medium | High | Low |
| Team maturity | High | Medium | High | Medium |
| Delivery pressure | Medium | High | Low | Low |
| AI utilization | High | Medium | Low | Medium |

## Input Format

```yaml
detection_request:
  project:
    name: "New Platform"
    type: "web_application"
    phase: "initiation"
  
  context:
    codebase_state: "greenfield"
    intent_clarity: "high"
    compliance_needs: "low"
    team_maturity: "high"
    delivery_pressure: "medium"
    ai_utilization: "high"
  
  constraints:
    regulatory_requirements: false
    existing_systems: false
    integration_complexity: "low"
```

## Output Format

```yaml
detection_result:
  project: "New Platform"
  
  scenario:
    detected: "ai_native_build"
    confidence: 0.92
    
    indicators:
      - indicator: "greenfield codebase"
        weight: 0.25
        evidence: "No existing code detected"
      - indicator: "high intent clarity"
        weight: 0.30
        evidence: "Business intent clearly documented"
      - indicator: "high AI utilization"
        weight: 0.25
        evidence: "AI-first development approach specified"
      - indicator: "low compliance needs"
        weight: 0.20
        evidence: "No regulatory requirements identified"
  
  recommendation:
    mode: "intent_driven"
    strategy: "ai_native_build"
    reasoning: "High intent clarity and AI utilization indicate AI-native build scenario"
  
  alternatives:
    - mode: "norm_driven"
      probability: 0.15
      reason: "Could be traditional if compliance needs increase"
  
  timestamp: "2026-04-30T10:00:00Z"
```

## Integration with Aether.go Methodology

- **Input from**: WorkflowOrchestrator, project initialization
- **Output to**: mode-selector, WorkflowOrchestrator
- **Part of**: D6 Scenario Adaptation Domain

## Examples

### Example 1: AI-Native Build
```yaml
project: "AI Customer Support"
indicators: {greenfield: true, intent_clear: true, ai_first: true}
scenario: "ai_native_build"
mode: "intent_driven"
confidence: 0.92
```

### Example 2: Harness Reverse Construction
```yaml
project: "Legacy Refactoring"
indicators: {legacy: true, intent_unclear: true, constraints_implicit: true}
scenario: "harness_reverse_construction"
mode: "norm_driven"
confidence: 0.88
```

### Example 3: Traditional Waterfall
```yaml
project: "Banking System"
indicators: {regulated: true, compliance_high: true, requirements_clear: true}
scenario: "traditional_waterfall"
mode: "norm_driven"
confidence: 0.95
```
