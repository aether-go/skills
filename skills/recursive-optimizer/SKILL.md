---
name: recursive-optimizer
description: Use when optimizing AI skills, prompts, and workflows based on execution results and user feedback
---

# Recursive Optimizer

## Overview
Continuously optimize AI skills, prompt templates, and workflows based on execution results, success rates, and user feedback. Implements recursive improvement cycle for better AI assistance.

## When to Use

```
Skill performance issues? ───────────────┐
                                        │
Need to improve prompts? ───────────────┤
                                        ├─► Use recursive-optimizer
Collecting user feedback? ──────────────┤
                                        │
Running A/B tests on prompts? ──────────┘
```

Use when:
- Skills underperform
- Users report issues
- Running A/B tests
- Collecting metrics on effectiveness
- Quarterly skill maintenance
- Promoting skills to production

Don't use when:
- First deployment of skill
- No metrics/feedback available
- One-off optimization

## Core Pattern

### Optimization Cycle

```
┌───────────────┐
│  Deploy Skill │
└───────┬───────┘
        ↓
┌───────────────┐
│ Collect Data │  Usage, feedback, metrics
└───────┬───────┘
        ↓
┌───────────────┐
│ Analyze Gaps │  Identify issues, patterns
└───────┬───────┘
        ↓
┌───────────────┐
│ Optimize     │  Update prompts, add content
└───────┬───────┘
        ↓
┌───────────────┐
│ Test Impact  │  A/B test, validate improvements
└───────┬───────┘
        ↓
   (Loop back)
```

## Implementation

### Metrics Collection

```python
class SkillMetrics:
    def __init__(self):
        self.usage_count = 0
        self.success_rate = 0.0
        self.average_satisfaction = 0.0
        self.common_errors = []
        self.execution_time = []

    def record_execution(self, success, satisfaction=None, duration=None, error=None):
        """Record skill execution metrics."""

        self.usage_count += 1

        if success:
            self.success_rate = (
                self.success_rate * (self.usage_count - 1) + 1
            ) / self.usage_count
        else:
            self.success_rate = (
                self.success_rate * (self.usage_count - 1) + 0
            ) / self.usage_count

        if satisfaction:
            self.average_satisfaction = (
                self.average_satisfaction * (self.usage_count - 1) + satisfaction
            ) / self.usage_count

        if duration:
            self.execution_time.append(duration)

        if error:
            self.track_error(error)

    def track_error(self, error):
        """Track common error patterns."""

        for existing in self.common_errors:
            if existing['type'] == error.type:
                existing['count'] += 1
                return

        self.common_errors.append({
            'type': error.type,
            'message': error.message,
            'count': 1
        })
```

### Gap Analysis

```python
def analyze_gaps(skill, metrics, user_feedback):
    """Analyze where skill is underperforming."""

    gaps = []

    # Low success rate
    if metrics.success_rate < 0.8:
        gaps.append({
            'issue': 'Low success rate',
            'current': f"{metrics.success_rate*100:.1f}%",
            'target': '80%',
            'action': 'Review skill content, add missing scenarios'
        })

    # Common errors
    for error in metrics.common_errors:
        if error['count'] > metrics.usage_count * 0.1:
            gaps.append({
                'issue': f'Frequent error: {error["type"]}',
                'count': error['count'],
                'action': f'Add guidance to prevent {error["type"]}'
            })

    # Negative feedback
    negative_feedback = [f for f in user_feedback if f.sentiment < 3]
    if negative_feedback:
        themes = extract_themes(negative_feedback)
        for theme in themes:
            gaps.append({
                'issue': f'User complaint: {theme}',
                'count': len([f for f in negative_feedback if theme in f.comment]),
                'action': f'Improve content addressing {theme}'
            })

    return gaps
```

### Optimization Strategies

```python
def optimize_skill(skill, gaps):
    """Generate optimization recommendations."""

    optimizations = []

    for gap in gaps:
        if gap['issue'] == 'Low success rate':
            optimizations.extend([
                'Add more examples',
                'Simplify instructions',
                'Add edge case coverage'
            ])

        elif 'Frequent error' in gap['issue']:
            optimizations.append(
                f'Add explicit error handling for {gap["issue"]}'
            )

        elif 'User complaint' in gap['issue']:
            optimizations.append(
                f'Rewrite confusing section about {gap["issue"]}'
            )

    return optimizations
```

### A/B Testing

```python
class PromptABTest:
    def __init__(self, prompt_a, prompt_b):
        self.prompt_a = prompt_a
        self.prompt_b = prompt_b
        self.results_a = []
        self.results_b = []

    def record_result(self, variant, success, satisfaction):
        """Record result for A/B test variant."""

        if variant == 'A':
            self.results_a.append({'success': success, 'satisfaction': satisfaction})
        else:
            self.results_b.append({'success': success, 'satisfaction': satisfaction})

    def analyze(self):
        """Analyze A/B test results."""

        success_a = sum(1 for r in self.results_a if r['success']) / len(self.results_a)
        success_b = sum(1 for r in self.results_b if r['success']) / len(self.results_b)

        sat_a = sum(r['satisfaction'] for r in self.results_a) / len(self.results_a)
        sat_b = sum(r['satisfaction'] for r in self.results_b) / len(self.results_b)

        return {
            'winner': 'A' if success_a > success_b else 'B',
            'a_success': success_a,
            'b_success': success_b,
            'a_satisfaction': sat_a,
            'b_satisfaction': sat_b
        }
```

### Feedback Collection

```python
def collect_user_feedback(task, skill, execution_time):
    """Collect structured feedback from user."""

    questions = [
        "Did the skill help you complete the task? (1-5)",
        "Was the skill easy to understand? (1-5)",
        "What could be improved?",
        "What was most helpful?"
    ]

    feedback = ask_user(questions)

    return {
        'task': task,
        'skill': skill,
        'timestamp': datetime.now(),
        'execution_time': execution_time,
        'helpful_rating': feedback[0],
        'clarity_rating': feedback[1],
        'improvement_suggestion': feedback[2],
        'most_helpful': feedback[3]
    }
```
