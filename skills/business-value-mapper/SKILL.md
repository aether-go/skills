---
name: business-value-mapper
description: Use when translating business goals into measurable technical metrics using BMAD framework
---

# Business Value Mapper

## Overview
Transform high-level business objectives into measurable technical metrics using the BMAD (Business-Driven Metrics for Architecture and Development) framework. Ensures every technical decision and implementation delivers tangible business value.

## When to Use

```
Business goal specified? ────────────────┐
                                            │
Need measurable metrics? ───────────────────┤
                                            ├─► Use business-value-mapper
Planning architecture/features? ─────────────┤
                                            │
Aether.go methodology? ─────────────────────┘
```

Use when:
- Starting a new project or feature
- Business requirements need technical translation
- Designing system architecture
- Prioritizing development work
- Measuring success of implementations
- Creating OKRs or KPIs
- Need to link technical work to business outcomes

Don't use when:
- Writing pure technical documentation
- Implementing already-mapped requirements
- Creating internal team metrics without business alignment
- Technical-only performance tuning

## Core Pattern

### BMAD Framework Components

```
Business Goal → Metric → Action → Data
      ↓           ↓         ↓        ↓
  "Improve     "Average    "Optimize  "Response
  revenue"      conversion   checkout  time
               rate"       flow"      logs"
```

### Before (Business-Only Requirements)
```
Business requirement:
"We need to improve the checkout experience."

Team interpretation:
- Developer A: "I'll improve the UI"
- Developer B: "I'll add more payment options"
- Developer C: "I'll cache the database"

Result:
- Scattered effort, unclear success criteria
- No measurement of actual improvement
- Technical work not aligned to business value
```

### After (BMAD-Mapped Requirements)
```yaml
Business Goal: Increase checkout completion rate by 20%

BMAD Matrix:
  Metric: Checkout completion rate (%)
    - Target: 80% completion (up from 60%)
    - Formula: completed_checkouts / initiated_checkouts * 100

  Action: Checkout flow optimization
    - Reduce checkout steps from 5 to 3
    - Implement auto-fill for returning users
    - Add progress indicator
    - Optimize payment API (target: < 3s)

  Data: Checkout funnel analytics
    - Track: initiated → step_1 → step_2 → step_3 → completed
    - Source: Google Analytics events
    - Dashboard: Checkout Funnel (PowerBI)

Success Criteria:
- Metric reaches 80% within 3 months
- Checkout time P95 < 5 seconds
- Abandonment rate at step_3 < 15%
```

## Quick Reference

| Business Goal | Example Metric | Example Action | Example Data Source |
|---------------|---------------|----------------|---------------------|
| **Increase revenue** | Conversion rate | A/B test pricing | Sales transactions |
| **Reduce costs** | Server cost per user | Optimize infrastructure | Cloud billing API |
| **Improve UX** | Task completion rate | Simplify UI flows | Analytics events |
| **Increase reliability** | Uptime percentage | Add redundancy | Monitoring alerts |
| **Accelerate delivery** | Deployment frequency | Improve CI/CD | Git commit history |
| **Enhance security** | Security incidents per month | Add security layers | Security audit logs |
| **Scale efficiently** | Cost per 1000 users | Auto-scaling rules | Resource metrics |

### BMAD Matrix Template

```yaml
# bmad-matrix.yaml
business_goal: "<Clear, measurable business objective>"
owner: "<Business owner>"
priority: <HIGH|MEDIUM|LOW>
timeline: "<Timeframe>"

metrics:
  - name: "<Metric name>"
    description: "<What does this measure?>"
    formula: "<How calculated>"
    target: "<Target value>"
    current: "<Current value>"
    unit: "<Unit of measurement>"
    data_source: "<Where data comes from>"

actions:
  - name: "<Technical initiative>"
    description: "<What will be done?>"
    implementation: "<How it will be done?>"
    owner: "<Technical owner>"
    effort_estimate: "<T-shirt size or hours>"
    dependencies: ["<Prerequisites>"]

data:
  - name: "<Data collection point>"
    type: "<event/metric/log>"
    collection_method: "<Automated/Manual/API>"
    frequency: "<How often collected>"
    storage: "<Where stored>"
    privacy: "<PII handling>"

success_criteria:
  - "<All metrics reach target>"
  - "<Actions completed on time>"
  - "<ROI positive>"
```

## Implementation

### BMAD Mapping Process

#### Step 1: Clarify Business Goal
```python
def clarify_business_goal(raw_goal):
    """Engage with stakeholders to clarify vague goals."""

    questions = [
        "What does 'improve' mean? Quantify it.",
        "What is the current baseline?",
        "What is the target timeframe?",
        "How will we know when we've succeeded?",
        "What is the business impact of not achieving this?",
        "What constraints exist (budget, timeline, resources)?"
    ]

    # Use conversation to gather requirements
    clarified_goal = engage_stakeholder(raw_goal, questions)

    return clarified_goal
```

#### Step 2: Identify Metrics
```python
def identify_metrics(business_goal):
    """Translate business goal into measurable metrics."""

    metric_templates = {
        'revenue': ['conversion_rate', 'average_order_value', 'revenue_per_user'],
        'cost': ['cost_per_user', 'infrastructure_cost', 'support_ticket_cost'],
        'speed': ['page_load_time', 'api_response_time', 'task_completion_time'],
        'reliability': ['uptime_percentage', 'error_rate', 'mean_time_to_recovery'],
        'user_engagement': ['daily_active_users', 'session_duration', 'feature_adoption'],
        'quality': ['bug_count', 'customer_satisfaction', 'nps_score']
    }

    # Select relevant metrics based on goal keywords
    relevant_metrics = []
    for category in metric_templates:
        if any(keyword in business_goal.lower() for keyword in category):
            relevant_metrics.extend(metric_templates[category])

    return relevant_metrics
```

#### Step 3: Define Actions
```python
def define_actions(metrics):
    """Define technical actions that impact the metrics."""

    action_catalog = {
        'conversion_rate': [
            'Simplify checkout flow',
            'Add social proof/testimonials',
            'Implement abandoned cart recovery',
            'Optimize page load speed'
        ],
        'api_response_time': [
            'Add caching layer',
            'Optimize database queries',
            'Implement CDN',
            'Add horizontal scaling'
        ],
        'uptime_percentage': [
            'Add load balancer',
            'Implement circuit breakers',
            'Add redundancy',
            'Enable health checks'
        ]
    }

    actions = []
    for metric in metrics:
        if metric in action_catalog:
            actions.extend(action_catalog[metric])

    return actions
```

#### Step 4: Identify Data Sources
```python
def identify_data_sources(metrics, actions):
    """Determine where data will be collected from."""

    data_sources = {
        'conversion_rate': {
            'type': 'event',
            'collection': 'frontend analytics',
            'tools': ['Google Analytics', 'Amplitude', 'Mixpanel']
        },
        'api_response_time': {
            'type': 'metric',
            'collection': 'APM monitoring',
            'tools': ['Datadog', 'New Relic', 'Prometheus']
        },
        'uptime_percentage': {
            'type': 'metric',
            'collection': 'synthetic monitoring',
            'tools': ['Pingdom', 'UptimeRobot', 'Statuspage']
        }
    }

    return data_sources
```

### Example BMAD Mapping Session

#### Business Goal: "Improve user onboarding"
```
AI: Let me clarify this goal to ensure we map it correctly.

    1. What does "improve" mean? Is it about speed, completion rate, or user satisfaction?

    2. What is the current baseline? How many users currently complete onboarding?

    3. What is the target timeframe? When do you want to achieve this?

    4. What is the target? What metric defines success?

Stakeholder:
    1. We want more users to actually complete the signup process
    2. Currently, only 30% of visitors sign up
    3. We want to achieve this within 3 months
    4. Target: 50% signup completion rate

AI: Great! Let me create the BMAD matrix for this goal.

    Business Goal: Increase user signup completion rate to 50%

    Metrics:
      - Signup completion rate: current 30%, target 50%
      - Time to first value: current 10 minutes, target 5 minutes

    Actions:
      - Reduce signup steps from 5 to 3
      - Add social login options
      - Implement progressive profiling
      - Add onboarding progress indicator

    Data:
      - Track signup funnel (visit → start → complete)
      - Track time spent per step
      - Source: Google Analytics events

    Success Criteria:
      - Signup completion rate reaches 50% in 3 months
      - Time to first value reduced to 5 minutes
      - ROI positive (user acquisition cost < user lifetime value)
```

### Generating BMAD Matrix

```python
def generate_bmad_matrix(business_goal, owner, timeline):
    """Generate complete BMAD matrix for business goal."""

    # Step 1: Clarify and parse the goal
    clarified_goal = clarify_business_goal(business_goal)

    # Step 2: Identify relevant metrics
    metrics = identify_metrics(clarified_goal)

    # Step 3: Define technical actions
    actions = define_actions(metrics)

    # Step 4: Identify data sources
    data_sources = identify_data_sources(metrics, actions)

    # Step 5: Generate matrix
    matrix = {
        'business_goal': clarified_goal,
        'owner': owner,
        'priority': 'HIGH',
        'timeline': timeline,
        'metrics': metrics,
        'actions': actions,
        'data': data_sources,
        'success_criteria': [
            f"All metrics reach target within {timeline}",
            "ROI > 1.0",
            "Stakeholder acceptance"
        ],
        'risks': [
            "Metric may not directly reflect business value",
            "Data collection may be delayed",
            "External factors may impact metrics"
        ]
    }

    return matrix
```

### BMAD Validation

```python
def validate_bmad_matrix(matrix):
    """Validate BMAD matrix for completeness and correctness."""

    errors = []
    warnings = []

    # Check required fields
    if not matrix.get('business_goal'):
        errors.append("Business goal is missing")

    if not matrix.get('metrics'):
        errors.append("Metrics are missing")

    if not matrix.get('actions'):
        errors.append("Actions are missing")

    if not matrix.get('data'):
        errors.append("Data sources are missing")

    # Check each metric
    for metric in matrix.get('metrics', []):
        if not metric.get('target'):
            warnings.append(f"Metric '{metric['name']}' has no target")

        if not metric.get('current'):
            warnings.append(f"Metric '{metric['name']}' has no baseline")

        if not metric.get('formula'):
            warnings.append(f"Metric '{metric['name']}' has no calculation formula")

    # Check each action
    for action in matrix.get('actions', []):
        if not action.get('implementation'):
            warnings.append(f"Action '{action['name']}' lacks implementation details")

    # Check data sources
    for data_source in matrix.get('data', []):
        if not data_source.get('collection_method'):
            warnings.append(f"Data source '{data_source['name']}' has no collection method")

    return {
        'valid': len(errors) == 0,
        'errors': errors,
        'warnings': warnings
    }
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Metrics don't directly measure business goal | No clear link to value | Ensure each metric directly reflects goal achievement |
| Actions don't impact metrics | Technical work is misaligned | Verify actions will drive metric improvements |
| Data sources unavailable | Can't measure progress | Select achievable data collection methods |
| No baseline established | Can't measure improvement | Capture current metrics before starting |
| Too many metrics | Unfocused effort | Focus on 2-3 critical metrics |
| Metrics too abstract | Not actionable | Use concrete, observable metrics |
| No owner assigned | No accountability | Assign clear ownership for each component |

### Red Flags

- Goal is vague ("improve performance")
- No target values defined
- Metrics are technical (e.g., "CPU usage") without business tie-in
- Actions are generic ("optimize code")
- No data collection plan
- No timeline or success criteria
- Stakeholder not involved in goal definition

## Real-World Impact

**Before (No BMAD):**
- "We need to make the site faster"
- Team optimizes database, adds caching
- Site is 20% faster
- Revenue unchanged
- Was the optimization worth it? Unknown.

**After (With BMAD):**
- Business Goal: "Increase conversion rate by 10%"
- Metric: Checkout completion rate (current 40%, target 44%)
- Action: Optimize checkout API to < 3 seconds (currently 5 seconds)
- Data: Track checkout funnel with Google Analytics
- Result: Checkout API at 2.8 seconds, completion rate at 45%
- Business Impact: 12.5% revenue increase, ROI 8:1

**Outcome:** Clear business justification, measurable success, confident prioritization.

## Integration with Aether.go Methodology

### BMAD + SDD (Spec-Driven Development)
```markdown
## Spec: REQ-CHECKOUT-001 - Checkout Optimization

### BMAD Alignment
**Business Goal**: Increase checkout completion rate from 60% to 80%

**Metric**: Checkout completion rate
- Formula: completed_checkouts / initiated_checkouts * 100
- Current: 60%, Target: 80%
- Data Source: Google Analytics checkout funnel

**Action**: Checkout flow simplification
- Reduce steps from 5 to 3
- Add auto-fill for returning users
- Optimize payment API

### Requirements
As a customer, I want to complete checkout in fewer steps so that I can purchase faster.

### Acceptance Criteria
- Checkout completion rate >= 80%
- P95 checkout time < 5 seconds
- Abandonment rate at step 3 < 15%
```

### BMAD + Constitution
```markdown
## Constitution Principle: Value-Driven Development

Every technical decision must be justified by business value.

**BMAD Checkpoint**:
1. What business goal does this address?
2. What metric will improve?
3. What is the expected impact?
4. How will we measure success?

**Example**:
- Decision: Add Redis caching
- Business Goal: Improve user experience
- Metric: Page load time (current 5s, target 3s)
- Expected Impact: 10% increase in engagement
- Measurement: Load time monitoring
```

### BMAD Dashboard

```python
def generate_bmad_dashboard(matrices):
    """Generate executive dashboard from BMAD matrices."""

    dashboard = {
        'overview': {
            'total_goals': len(matrices),
            'on_track': sum(1 for m in matrices if m['status'] == 'on_track'),
            'at_risk': sum(1 for m in matrices if m['status'] == 'at_risk'),
            'behind': sum(1 for m in matrices if m['status'] == 'behind')
        },
        'goals': []
    }

    for matrix in matrices:
        goal_summary = {
            'name': matrix['business_goal'],
            'owner': matrix['owner'],
            'priority': matrix['priority'],
            'progress': calculate_progress(matrix['metrics']),
            'status': determine_status(matrix['metrics']),
            'key_metrics': [
                {
                    'name': m['name'],
                    'current': m['current'],
                    'target': m['target'],
                    'trend': calculate_trend(m['history'])
                } for m in matrix['metrics'][:3]
            ]
        }
        dashboard['goals'].append(goal_summary)

    return dashboard
```
