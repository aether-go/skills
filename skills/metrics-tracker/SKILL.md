---
name: metrics-tracker
description: Use when tracking AI collaboration effectiveness (token savings, generation quality, review reduction) and system quality (completeness, coverage, correctness) for dual-track recursive optimization. This skill unifies the metrics layer and replaces ai-effectiveness-tracker and system-quality-tracker.
---

# Metrics Tracker

## Overview

The unified skill for tracking dual-track metrics: AI collaboration effectiveness and system quality. This skill:
- Collects AI effectiveness metrics (token savings, generation quality, first-pass rate, review reduction)
- Collects system quality metrics (completeness, coverage, correctness, satisfaction, performance, security)
- Aggregates metrics into dual-track dashboards
- Feeds `recursive-optimizer` for improvement decisions
- Tracks trends over time

**Replaces** (consolidated from 2 skills):
- `ai-effectiveness-tracker`
- `system-quality-tracker`

## Dual-Track Metrics

### Track 1: AI Collaboration Effectiveness

| Metric | Formula | Target |
|--------|---------|--------|
| **Token savings rate** | `tokens_saved / total_potential_tokens` | 0.70+ |
| **Generation quality** | `weighted_avg(quality_dimensions)` | 0.90+ |
| **First-pass rate** | `tasks_passing_first_try / total_tasks` | 0.85+ |
| **Review reduction** | `manual_review_minutes_saved / baseline` | 0.50+ |
| **Iteration cycles** | `avg(loops_to_acceptance)` | < 2.0 |
| **Acceptance rate** | `tasks_accepted / tasks_generated` | 0.95+ |
| **Time to value** | `time_from_request_to_working_code` | < 1 day |

### Track 2: System Quality

| Metric | Formula | Target |
|--------|---------|--------|
| **Completeness** | `implemented_features / specified_features` | 0.95+ |
| **Test coverage** | `lines_covered / total_lines` | 0.85+ |
| **Correctness** | `passing_tests / total_tests` | 0.98+ |
| **Satisfaction** | `user_survey_score` | 4.0+ (of 5) |
| **Performance (p95)** | `latency_p95` | < budget |
| **Security score** | `no high vulnerabilities` | PASS |

## When to Use

```
Tracking AI effectiveness? ─────────────────┐
                                             │
Tracking system quality? ────────────────────┤
                                             │
Building metrics dashboards? ────────────────┼─► Use metrics-tracker
                                             │
Feeding recursive optimizer? ────────────────┤
                                             │
Need trend analysis over time? ──────────────┘
```

## Input Format

```yaml
metrics_collection:
  # Period
  period: "weekly"  # daily | weekly | monthly | sprint
  date_range:
    start: "2026-05-26"
    end: "2026-06-02"
  
  # Source data
  ai_effectiveness:
    generation_data:
      - {task_id: "T-001", tokens_used: 2500, tokens_saved_by_traditional: 0, first_pass: true, iterations: 1, review_minutes: 0}
      - {task_id: "T-002", tokens_used: 0, tokens_saved_by_traditional: 2500, first_pass: true, iterations: 0, review_minutes: 0}
      - {task_id: "T-003", tokens_used: 1800, tokens_saved_by_traditional: 0, first_pass: false, iterations: 3, review_minutes: 15}
    
    user_feedback:
      - {task_id: "T-001", rating: 5, comment: "Worked first try"}
      - {task_id: "T-003", rating: 3, comment: "Needed significant rework"}
  
  system_quality:
    test_data:
      total_tests: 450
      passing: 442
      coverage: 0.87
    
    performance_data:
      p50_ms: 45
      p95_ms: 148
      p99_ms: 280
      error_rate: 0.0006
    
    security_data:
      high_vulnerabilities: 0
      medium_vulnerabilities: 2
      low_vulnerabilities: 5
    
    completeness:
      specified_features: 24
      implemented_features: 24
      tested_features: 24
    
    satisfaction:
      survey_responses: 15
      avg_score: 4.3
```

## Output Format

```yaml
metrics_report:
  period: "weekly"
  date_range: {start: "2026-05-26", end: "2026-06-02"}
  generated_at: "2026-06-02T10:00:00Z"
  
  # === Track 1: AI Effectiveness ===
  ai_effectiveness:
    overall_score: 0.88
    status: "passing"  # passing | warning | failing
    
    metrics:
      token_savings_rate:
        current: 0.65
        target: 0.70
        delta: -0.05
        trend: "stable"
        status: "warning"
        detail: "65% savings, target 70%. Increase deterministic generation coverage."
      
      generation_quality:
        current: 0.89
        target: 0.90
        delta: +0.02
        trend: "improving"
        status: "passing"
      
      first_pass_rate:
        current: 0.85
        target: 0.85
        delta: +0.05
        trend: "improving"
        status: "passing"
      
      review_reduction:
        current: 0.50
        target: 0.50
        delta: 0
        trend: "stable"
        status: "passing"
      
      iteration_cycles:
        current: 1.8
        target: 2.0
        delta: -0.2
        trend: "improving"
        status: "passing"
    
    by_skill:
      - skill: "test-planner"
        success_rate: 0.92
        avg_iterations: 1.3
      - skill: "code-generator"
        success_rate: 0.85
        avg_iterations: 1.8
      - skill: "scenario-engine"
        success_rate: 0.95
        avg_iterations: 1.0
    
    recommendations:
      - "Increase deterministic generation coverage (target 70%)"
      - "Optimize test-planner for high-complexity scenarios"
  
  # === Track 2: System Quality ===
  system_quality:
    overall_score: 0.91
    status: "passing"
    
    metrics:
      completeness:
        current: 1.0  # 24/24
        target: 0.95
        delta: 0
        trend: "stable"
        status: "passing"
      
      test_coverage:
        current: 0.87
        target: 0.85
        delta: +0.02
        trend: "improving"
        status: "passing"
      
      correctness:
        current: 0.982  # 442/450
        target: 0.98
        delta: +0.005
        trend: "stable"
        status: "passing"
      
      performance_p95:
        current_ms: 148
        target_ms: 200
        delta: -5
        trend: "improving"
        status: "passing"
      
      security:
        high: 0
        medium: 2
        low: 5
        status: "passing"
      
      satisfaction:
        current: 4.3
        target: 4.0
        delta: +0.1
        trend: "improving"
        status: "passing"
    
    recommendations:
      - "Address 2 medium security vulnerabilities"
      - "Continue current trajectory; all targets met"
  
  # === Joint Insights ===
  insights:
    - "AI effectiveness and system quality both trending up; healthy state"
    - "Token savings below target — push for more deterministic generation"
    - "Security vulnerabilities introduced this week; investigate"
  
  # === Feed to Recursive Optimizer ===
  optimization_input:
    current_state: {ai: 0.88, system: 0.91}
    targets: {ai: 0.92, system: 0.93}
    bottlenecks:
      - "Token savings rate (AI track)"
      - "2 medium security vulnerabilities (system track)"
    suggested_actions: [...]
```

## Implementation

### Metrics Collection

```python
def collect_metrics(period: str, date_range: dict) -> dict:
    """Collect all metrics for the period."""
    return {
        "ai_effectiveness": collect_ai_metrics(date_range),
        "system_quality": collect_system_metrics(date_range),
    }

def collect_ai_metrics(date_range: dict) -> dict:
    """Aggregate AI effectiveness metrics."""
    generations = load_generation_data(date_range)
    return {
        "token_savings_rate": compute_token_savings(generations),
        "first_pass_rate": compute_first_pass(generations),
        "iteration_cycles": compute_avg_iterations(generations),
        "by_skill": aggregate_by_skill(generations),
    }

def collect_system_metrics(date_range: dict) -> dict:
    """Aggregate system quality metrics."""
    return {
        "test_coverage": collect_coverage(date_range),
        "correctness": collect_test_results(date_range),
        "performance": collect_perf_metrics(date_range),
        "security": collect_security_scan_results(date_range),
        "satisfaction": collect_survey_data(date_range),
    }
```

### Trend Analysis

```python
def compute_trend(metric_name: str, current: float, history: list) -> str:
    """Determine trend direction."""
    if len(history) < 2:
        return "insufficient_data"
    recent = history[-4:]  # Last 4 periods
    if current > recent[0]:
        return "improving"
    elif current < recent[0]:
        return "degrading"
    return "stable"
```

### Status Determination

```python
def determine_status(metric: dict) -> str:
    """Determine pass/warning/fail based on target."""
    if metric["current"] >= metric["target"]:
        return "passing"
    elif metric["current"] >= metric["target"] * 0.9:  # Within 10%
        return "warning"
    return "failing"
```

## Validation Rules

- ✅ All metrics computed consistently across periods
- ✅ Trends shown with delta vs. previous period
- ✅ Status determined by target comparison
- ✅ Recommendations actionable and specific
- ✅ Both tracks reported separately and jointly

## Integration with Aether.go Methodology

- **Input from**:
  - `generation-dispatcher` (AI effectiveness)
  - `test-planner` (test coverage, correctness)
  - `deployment-orchestrator` (performance, security)
  - `constitution-validator` (compliance)
  - User feedback (satisfaction)
- **Output to**:
  - `recursive-optimizer` (drives optimization)
  - `architecture-auditor` (health check)
  - Dashboards / reports
- **Part of**: Metrics & Evolution Layer
- **Principle alignment**:
  - **P13 Recursive-Self-Optimization**: Core data source
  - **P8 Tool-System-Adaptation**: Token savings tracking
  - **P11 NFR-Built-in**: Performance/security metrics

## Migration Notes

This skill consolidates 2 previously separate skills:
- `ai-effectiveness-tracker` → Track 1
- `system-quality-tracker` → Track 2

**Invocation parameters**:
- `track: ai` → Track 1 only
- `track: system` → Track 2 only
- `track: both` (default) → Both tracks
- `period: daily|weekly|monthly` → Aggregation period
