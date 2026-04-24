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

### Recursive Self-Optimization (P9: Recursive-Self-Optimization Principle)

Implements the Aether.go constitutional principle P9: Recursive-Self-Optimization Principle (递归自我优化原则).

**Formal Model:**
```
S_{t+1} = S_t + O(F(S_t))
```
Where:
- S_t = System state at time t (skill state)
- O = Optimization operation
- F = Feedback function

### Optimization Cycle with Convergence

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
┌───────────────┐
│ Check        │  Verify convergence conditions
│ Convergence  │  Bounded? Monotonic? Terminated?
└───────┬───────┘
        │
        ├─ Converged? ──► Stop optimization
        │
        └─ Not converged ──► (Loop back)
```

### Convergence Conditions (P9 Implementation)

Per Aether.go methodology, recursive optimization must satisfy three convergence conditions:

#### 1. Boundedness (有界性)
**Condition:** ∃M, ∀t, |S_t| < M

**Interpretation:** Optimization magnitude must be limited to prevent runaway changes.

**Implementation:**
```yaml
boundedness:
  max_changes_per_iteration: 3
  max_prompt_length_change: 20%
  max_new_examples_per_iteration: 5
  rollback_threshold: "quality_decrease > 10%"
```

#### 2. Monotonicity (单调性)
**Condition:** Quality(S_{t+1}) ≥ Quality(S_t) - ε

**Interpretation:** Quality should not significantly decrease between iterations.

**Implementation:**
```yaml
monotonicity:
  quality_metrics:
    - success_rate
    - user_satisfaction
    - execution_time
  
  tolerance_epsilon: 0.05  # 5% tolerance
  
  validation:
    - compare_before_after: true
    - statistical_significance: 0.95
    - min_sample_size: 30
```

#### 3. Termination (终止条件)
**Condition:** |S_{t+1} - S_t| < δ OR Quality(S_t) > Threshold

**Interpretation:** Stop when changes become negligible or quality reaches target.

**Implementation:**
```yaml
termination:
  delta_threshold: 0.02  # 2% change threshold
  
  quality_thresholds:
    success_rate: 0.95
    user_satisfaction: 4.5  # out of 5
    
  max_iterations: 10
  
  early_stop:
    - no_improvement_for: 3
    - quality_plateau: true
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

### Convergence Checker (P9 Implementation)

```python
class ConvergenceChecker:
    """Check convergence conditions for recursive optimization."""
    
    def __init__(self, config):
        self.config = config
        self.iteration_history = []
        
    def check_convergence(self, current_state, previous_state=None):
        """
        Check all three convergence conditions:
        1. Boundedness
        2. Monotonicity  
        3. Termination
        """
        results = {
            'boundedness': self._check_boundedness(current_state),
            'monotonicity': self._check_monotonicity(current_state, previous_state),
            'termination': self._check_termination(current_state, previous_state),
            'converged': False
        }
        
        # Converged if termination condition met AND boundedness satisfied
        results['converged'] = (
            results['termination']['should_terminate'] and 
            results['boundedness']['satisfied']
        )
        
        return results
    
    def _check_boundedness(self, state):
        """Check boundedness condition: |S_t| < M"""
        checks = {
            'changes_count': state.get('changes_count', 0) <= self.config['max_changes_per_iteration'],
            'prompt_length_change': state.get('prompt_length_change', 0) <= self.config['max_prompt_length_change'],
            'new_examples': state.get('new_examples', 0) <= self.config['max_new_examples_per_iteration'],
        }
        
        return {
            'satisfied': all(checks.values()),
            'checks': checks,
            'recommendation': 'Reduce changes per iteration' if not all(checks.values()) else None
        }
    
    def _check_monotonicity(self, current_state, previous_state):
        """Check monotonicity: Quality(S_{t+1}) >= Quality(S_t) - epsilon"""
        if previous_state is None:
            return {'satisfied': True, 'quality_delta': None}
        
        epsilon = self.config['tolerance_epsilon']
        
        quality_metrics = ['success_rate', 'user_satisfaction']
        quality_deltas = {}
        
        for metric in quality_metrics:
            current = current_state.get(metric, 0)
            previous = previous_state.get(metric, 0)
            delta = current - previous
            quality_deltas[metric] = delta
        
        # Check if any metric decreased significantly
        monotonic = all(
            delta >= -epsilon for delta in quality_deltas.values()
        )
        
        return {
            'satisfied': monotonic,
            'quality_deltas': quality_deltas,
            'epsilon': epsilon,
            'recommendation': 'Consider rollback' if not monotonic else None
        }
    
    def _check_termination(self, current_state, previous_state):
        """Check termination conditions"""
        reasons = []
        
        # Check 1: Change magnitude below threshold
        if previous_state:
            state_diff = self._calculate_state_diff(current_state, previous_state)
            if state_diff < self.config['delta_threshold']:
                reasons.append(f'State change ({state_diff:.3f}) below threshold')
        
        # Check 2: Quality above threshold
        quality_thresholds = self.config.get('quality_thresholds', {})
        for metric, threshold in quality_thresholds.items():
            if current_state.get(metric, 0) >= threshold:
                reasons.append(f'{metric} ({current_state.get(metric, 0):.3f}) above threshold ({threshold})')
        
        # Check 3: Max iterations reached
        iteration = current_state.get('iteration', 0)
        if iteration >= self.config.get('max_iterations', 10):
            reasons.append(f'Max iterations ({self.config["max_iterations"]}) reached')
        
        # Check 4: No improvement for N iterations
        if self._check_plateau():
            reasons.append('Quality plateau detected')
        
        return {
            'should_terminate': len(reasons) > 0,
            'reasons': reasons,
            'iteration': iteration
        }
    
    def _calculate_state_diff(self, state_a, state_b):
        """Calculate difference between two states"""
        # Simplified: compare key metrics
        metrics = ['success_rate', 'user_satisfaction', 'execution_time']
        diffs = []
        
        for metric in metrics:
            if metric in state_a and metric in state_b:
                diffs.append(abs(state_a[metric] - state_b[metric]))
        
        return sum(diffs) / len(diffs) if diffs else 1.0
    
    def _check_plateau(self):
        """Check if quality has plateaued"""
        if len(self.iteration_history) < 3:
            return False
        
        recent = self.iteration_history[-3:]
        quality_changes = [
            abs(recent[i]['quality'] - recent[i-1]['quality'])
            for i in range(1, len(recent))
        ]
        
        return all(change < self.config['delta_threshold'] for change in quality_changes)
```

## V2.1 Enhancement: ChangeAndTaskAgent Linkage

In V2.1, RecursiveOptimizer integrates with ChangeAndTaskAgent for task-based optimization execution:

```yaml
recursive_optimizer_with_cta:
  linkage:
    - RecursiveOptimizer generates optimization task清单
    - ChangeAndTaskAgent schedules and executes tasks
    - /opsx-ff: Fast feedback phase (quick validation)
    - /opsx-apply: Formal application phase (persistent changes)
    
  convergence_control:
    - convergence-checker判定 directly controls task调度
    - When converged: RecursiveOptimizer stops, notifies ChangeAndTaskAgent
    - ChangeAndTaskAgent persists final state to .aether/state/
```

### ARGUE-003 Protocol Integration

```
RecursiveOptimizer detects convergence
    │
    ├── ARGUE-003 → WorkflowOrchestrator
    │     └── optimization suggestions + convergence status
    │
    └── If converged:
          └── ChangeAndTaskAgent finalizes optimization tasks
```

### Recursive Optimization Runner

```python
class RecursiveOptimizer:
    """Main optimizer implementing P9 recursive self-optimization."""
    
    def __init__(self, skill, config):
        self.skill = skill
        self.config = config
        self.convergence_checker = ConvergenceChecker(config)
        self.iteration = 0
        self.history = []
        
    def optimize(self, max_iterations=10):
        """Run recursive optimization with convergence checking."""
        
        print(f"Starting recursive optimization for skill: {self.skill.name}")
        
        while self.iteration < max_iterations:
            self.iteration += 1
            print(f"\n=== Iteration {self.iteration} ===")
            
            # 1. Collect current state
            current_state = self._collect_state()
            
            # 2. Check convergence
            previous_state = self.history[-1] if self.history else None
            convergence = self.convergence_checker.check_convergence(
                current_state, previous_state
            )
            
            if convergence['converged']:
                print(f"✅ Convergence achieved!")
                print(f"Reasons: {convergence['termination']['reasons']}")
                return {
                    'success': True,
                    'iterations': self.iteration,
                    'final_state': current_state,
                    'convergence': convergence
                }
            
            # 3. Analyze gaps
            gaps = self._analyze_gaps(current_state)
            
            # 4. Optimize
            optimized_skill = self._optimize_skill(gaps)
            
            # 5. Validate boundedness
            if not convergence['boundedness']['satisfied']:
                print(f"⚠️ Boundedness check failed, reducing changes")
                optimized_skill = self._reduce_changes(optimized_skill)
            
            # 6. Test impact
            test_results = self._test_impact(optimized_skill)
            
            # 7. Check monotonicity
            if not convergence['monotonicity']['satisfied']:
                print(f"⚠️ Monotonicity check failed, considering rollback")
                if self._should_rollback(test_results):
                    print(f"Rolling back to previous version")
                    continue
            
            # 8. Update skill and record
            self.skill = optimized_skill
            self.history.append(current_state)
            
            print(f"Iteration {self.iteration} complete")
            print(f"Success rate: {current_state.get('success_rate', 0):.2%}")
        
        print(f"\n⚠️ Max iterations ({max_iterations}) reached without convergence")
        return {
            'success': False,
            'iterations': self.iteration,
            'final_state': current_state,
            'reason': 'max_iterations_reached'
        }
    
    def _collect_state(self):
        """Collect current skill state metrics"""
        return {
            'iteration': self.iteration,
            'success_rate': self.skill.metrics.success_rate,
            'user_satisfaction': self.skill.metrics.average_satisfaction,
            'execution_time': self.skill.metrics.average_execution_time,
            'changes_count': self.skill.get_changes_count(),
            'prompt_length': len(self.skill.prompt),
            'new_examples': self.skill.get_new_examples_count()
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
