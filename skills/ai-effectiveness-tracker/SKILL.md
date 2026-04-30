---
name: ai-effectiveness-tracker
description: Use when tracking AI collaboration effectiveness metrics including token savings, generation quality, human review reduction, and iteration cycles. Part of D8 Meta-Capability Domain for dual-track optimization.
---

# AI Effectiveness Tracker

## Overview
Track AI collaboration effectiveness metrics including token savings, generation quality, human review reduction, and iteration cycles. Part of dual-track optimization (system quality + AI collaboration effectiveness), provides data for RecursiveOptimizer's AI effectiveness track.

## When to Use

```
Need to track AI effectiveness? ─────────┐
                                         │
Dual-track optimization active? ─────────┤
                                         ├─► Use ai-effectiveness-tracker
AI metrics reporting? ───────────────────┤
                                         │
RecursiveOptimizer needs data? ──────────┘
```

Use when:
- Need to track AI collaboration effectiveness
- Dual-track optimization is active
- AI metrics reporting is needed
- RecursiveOptimizer needs AI effectiveness data

Don't use when:
- Only system quality metrics are needed
- AI is not used in the workflow
- Effectiveness tracking is not a priority

## Core Pattern

### Tracking Process

```
AI Collaboration Data
    ├── Token Savings Analysis
    ├── Generation Quality Assessment
    ├── Human Review Reduction
    └── Iteration Cycle Count
         |
         v
    Effectiveness Metrics
         |
         v
    Optimization Input
```

### Effectiveness Dimensions

| Dimension | Metric | Target | Measurement |
|-----------|--------|--------|-------------|
| **Token Savings** | Token reduction rate | > 60% | Token usage comparison |
| **Generation Quality** | AI output quality | > 85% | Confidence scores |
| **Review Reduction** | Human review time saved | > 50% | Time tracking |
| **Iteration Cycles** | Cycles to acceptance | < 3 | Iteration count |
| **Acceptance Rate** | First-pass acceptance | > 70% | Acceptance tracking |
| **Time to Value** | Time from request to delivery | < baseline | Time tracking |

## Input Format

```yaml
tracking_request:
  workflow:
    id: "wf-001"
    tasks: 20
    
  ai_data:
    deterministic_tasks: 12
    ai_tasks: 8
    total_tokens_used: 45000
    estimated_manual_tokens: 120000
    
  human_data:
    reviews_conducted: 15
    auto_approved: 5
    iterations: 24
    
  baseline:
    manual_development_time: "40 hours"
    ai_assisted_time: "16 hours"
```

## Output Format

```yaml
effectiveness_report:
  workflow: "wf-001"
  timestamp: "2026-04-30T10:00:00Z"
  
  metrics:
    token_savings:
      rate: 0.625
      target: 0.60
      status: passed
      details: "Saved 75,000 tokens (45K vs 120K estimated)"
    
    generation_quality:
      score: 0.87
      target: 0.85
      status: passed
      details: "Average confidence: 0.87"
    
    review_reduction:
      rate: 0.60
      target: 0.50
      status: passed
      details: "Reduced from 25 reviews to 15"
    
    iteration_cycles:
      average: 2.4
      target: 3.0
      status: passed
      details: "24 iterations across 20 tasks"
    
    acceptance_rate:
      rate: 0.72
      target: 0.70
      status: passed
      details: "14/20 tasks accepted first pass"
    
    time_to_value:
      reduction: 0.60
      target: 0.50
      status: passed
      details: "16 hours vs 40 hours baseline"
  
  overall_score: 0.85
  trend: improving
  
  recommendations:
    - "Increase deterministic task identification"
    - "Improve prompt templates for common patterns"
    - "Add more leaf node auto-approvals"
```

## Integration with Aether.go Methodology

- **Input from**: RecursiveOptimizer, DispatchOrchestrator, confidence-based-reviewer
- **Output to**: RecursiveOptimizer, WorkflowOrchestrator
- **Part of**: D8 Meta-Capability Domain

## Examples

### Example 1: High Effectiveness
```yaml
workflow: "API Development"
metrics: {token_savings: 0.72, quality: 0.90, review_reduction: 0.65}
overall: 0.88
recommendations: ["Maintain current patterns", "Expand generator coverage"]
```

### Example 2: Low Effectiveness
```yaml
workflow: "Algorithm Development"
metrics: {token_savings: 0.30, quality: 0.65, review_reduction: 0.20}
overall: 0.55
recommendations: ["Improve contract definitions", "Add more training examples"]
```
