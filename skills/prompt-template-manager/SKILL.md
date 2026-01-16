---
name: prompt-template-manager
description: Use when managing, versioning, and optimizing AI prompt templates for consistent and effective AI interactions
---

# Prompt Template Manager

## Overview
Manage, version, and optimize AI prompt templates to ensure consistent and effective AI interactions. Provides centralized repository for reusable prompts with version control and performance tracking.

## When to Use

```
Need reusable prompt? ─────────────────┐
                                      │
Prompt needs versioning? ─────────────┤
                                      ├─► Use prompt-template-manager
A/B testing prompts? ─────────────────┤
                                      │
Documenting prompt patterns? ──────────┘
```

Use when:
- Creating reusable prompts
- Need prompt version control
- Running A/B tests
- Documenting best practices
- Standardizing AI interactions
- Sharing prompts across team

Don't use when:
- One-off custom prompt
- Simple question without structure
- Prompt in conversation (not template)

## Core Pattern

### Prompt Template Structure

```yaml
prompt_template:
  name: "code-review"
  version: "1.2.0"
  category: "quality"

  description: |
    Template for reviewing code changes and providing feedback

  variables:
    - name: "code_diff"
      type: "string"
      required: true
      description: "Code diff to review"

    - name: "context"
      type: "string"
      required: false
      description: "Additional context about change"

  template: |
    You are reviewing code changes for quality and adherence to standards.

    Code to review:
    {{code_diff}}

    {% if context %}
    Context:
    {{context}}
    {% endif %}

    Please provide:
    1. Overall assessment (pass/fail)
    2. Specific issues found
    3. Suggestions for improvement
    4. Positive aspects

  performance:
    success_rate: 0.92
    average_rating: 4.5
    usage_count: 342

  versions:
    - version: "1.2.0"
      date: "2024-01-15"
      changes: "Added security checklist"
    - version: "1.1.0"
      date: "2024-01-10"
      changes: "Improved clarity"
    - version: "1.0.0"
      date: "2024-01-01"
      changes: "Initial version"
```

## Implementation

### Template Rendering

```python
from jinja2 import Template

def render_prompt(template, variables):
    """Render prompt template with variables."""

    jinja_template = Template(template['template'])
    return jinja_template.render(**variables)

# Usage
template = load_template('code-review')
rendered = render_prompt(template, {
    'code_diff': '- def old_func():\n+ def new_func():',
    'context': 'Refactoring for performance'
})
```

### Version Management

```python
class PromptVersionManager:
    def __init__(self):
        self.templates = {}

    def create_version(self, name, template_content, changes):
        """Create new version of prompt template."""

        if name not in self.templates:
            self.templates[name] = {
                'name': name,
                'versions': []
            }

        latest_version = self.get_latest_version(name)
        new_version = increment_version(latest_version)

        version_data = {
            'version': new_version,
            'date': datetime.now(),
            'template': template_content,
            'changes': changes,
            'performance': None
        }

        self.templates[name]['versions'].append(version_data)
        return new_version

    def get_latest_version(self, name):
        """Get latest version of template."""
        versions = self.templates[name]['versions']
        return max([v['version'] for v in versions]) if versions else '0.0.0'

    def revert_to_version(self, name, version):
        """Revert to specific version."""
        template_data = self.templates[name]
        version_data = next(v for v in template_data['versions'] if v['version'] == version)

        # Restore as new version with note
        return self.create_version(
            name,
            version_data['template'],
            f"Reverted from {version}"
        )
```

### Performance Tracking

```python
class PromptPerformanceTracker:
    def __init__(self):
        self.metrics = {}

    def record_usage(self, name, version, success, rating):
        """Record prompt usage and performance."""

        key = f"{name}:{version}"

        if key not in self.metrics:
            self.metrics[key] = {
                'usage_count': 0,
                'success_count': 0,
                'total_rating': 0,
                'average_time': []
            }

        metrics = self.metrics[key]
        metrics['usage_count'] += 1

        if success:
            metrics['success_count'] += 1

        if rating:
            metrics['total_rating'] += rating

        metrics['average_time'].append(duration)

    def get_stats(self, name, version):
        """Get performance statistics for prompt."""

        key = f"{name}:{version}"
        metrics = self.metrics[key]

        return {
            'usage_count': metrics['usage_count'],
            'success_rate': metrics['success_count'] / metrics['usage_count'],
            'average_rating': metrics['total_rating'] / metrics['usage_count'],
            'average_time': sum(metrics['average_time']) / len(metrics['average_time'])
        }
```

### A/B Testing

```python
class PromptABTestManager:
    def __init__(self):
        self.active_tests = {}

    def start_test(self, name, version_a, version_b, sample_size=100):
        """Start A/B test between two prompt versions."""

        test_id = generate_test_id()

        self.active_tests[test_id] = {
            'name': name,
            'version_a': version_a,
            'version_b': version_b,
            'sample_size': sample_size,
            'results_a': [],
            'results_b': [],
            'started_at': datetime.now()
        }

        return test_id

    def record_result(self, test_id, variant, success, rating, duration):
        """Record result for A/B test."""

        test = self.active_tests[test_id]

        result = {
            'success': success,
            'rating': rating,
            'duration': duration
        }

        if variant == 'A':
            test['results_a'].append(result)
        else:
            test['results_b'].append(result)

        # Check if test complete
        total_results = len(test['results_a']) + len(test['results_b'])
        if total_results >= test['sample_size']:
            return self.analyze_test(test_id)

        return None

    def analyze_test(self, test_id):
        """Analyze A/B test results."""

        test = self.active_tests[test_id]

        success_a = sum(1 for r in test['results_a'] if r['success']) / len(test['results_a'])
        success_b = sum(1 for r in test['results_b'] if r['success']) / len(test['results_b'])

        rating_a = sum(r['rating'] for r in test['results_a']) / len(test['results_a'])
        rating_b = sum(r['rating'] for r in test['results_b']) / len(test['results_b'])

        # Statistical significance test (t-test)
        from scipy import stats
        t_stat, p_value = stats.ttest_ind(
            [r['rating'] for r in test['results_a']],
            [r['rating'] for r in test['results_b']]
        )

        significant = p_value < 0.05

        return {
            'test_id': test_id,
            'winner': 'A' if success_a > success_b else 'B',
            'success_a': success_a,
            'success_b': success_b,
            'rating_a': rating_a,
            'rating_b': rating_b,
            'statistically_significant': significant,
            'p_value': p_value,
            'recommendation': (
                f"Adopt version {test['version_a']}" if success_a > success_b
                else f"Adopt version {test['version_b']}"
            ) if significant else "No significant difference, continue testing"
        }
```

### Template Repository

```yaml
# prompt-registry.yaml
templates:
  code-review:
    name: "code-review"
    category: "quality"
    versions: ["1.2.0", "1.1.0", "1.0.0"]
    latest: "1.2.0"

  task-breakdown:
    name: "task-breakdown"
    category: "planning"
    versions: ["2.1.0", "2.0.0", "1.0.0"]
    latest: "2.1.0"

  documentation:
    name: "documentation"
    category: "writing"
    versions: ["1.5.0", "1.4.0", "1.3.0", "1.2.0", "1.1.0", "1.0.0"]
    latest: "1.5.0"

categories:
  planning: ["task-breakdown", "brainstorming"]
  implementation: ["code-review", "debugging"]
  writing: ["documentation", "api-docs"]
  quality: ["code-review", "testing"]
```
