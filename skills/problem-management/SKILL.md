---
name: problem-management
description: Use when conducting root cause analysis, problem investigation, and implementing permanent fixes to prevent incident recurrence following ITIL practices
---

# Problem Management

## Overview
Systematically identify, analyze, and resolve the root causes of incidents to prevent recurrence. Focuses on proactive problem prevention through trend analysis, known error databases, and permanent fixes rather than temporary workarounds.

## When to Use

```
Recurring incidents? ────────────────┐
                                     │
Need root cause analysis? ───────────┤
                                     ├─► Use problem-management
Preventive measures needed? ─────────┤
                                     │
Major incident post-mortem? ─────────┘
```

Use when:
- Incidents recur with similar symptoms
- Root cause analysis needed for major incidents
- Proactive problem identification from trends
- Implementing permanent fixes vs workarounds
- Maintaining known error database
- Reducing incident volume through prevention
- Analyzing incident patterns for systemic issues
- Technology debt or architecture issues causing incidents

Don't use when:
- First occurrence of unique incident
- Simple fix with no recurrence risk
- Minor issues with known workarounds
- Operational tasks without problem context
- Immediate incident response (use incident-management first)

## Core Pattern

### ITIL Problem Management Lifecycle

```
Problem Identification → Problem Logging → Problem Classification → Problem Prioritization
     ↓                       ↓                   ↓                       ↓
Incident Analysis     Problem Record     Category & Impact     Urgency & Resources
     ↓
Root Cause Analysis → Known Error Identification → Solution Development
     ↓                       ↓                           ↓
RCA Techniques        Error Database           Solution Alternatives
     ↓
Solution Evaluation → Solution Implementation → Solution Review → Problem Closure
     ↓                       ↓                       ↓               ↓
Cost-Benefit          Change Management       Effectiveness      Documentation
  Analysis                                    Verification
     ↓
Knowledge Base Update ←── Preventive Measures ←── Trend Analysis
     ↓                           ↓                       ↓
Future Prevention         Proactive Controls     Pattern Detection
```

### Before (Reactive Incident Fixing)
```yaml
Scenario: Database connection failures recurring weekly
Approach:
  - Each incident: Restart database, clear connections
  - Temporary fix works for a few days
  - No root cause investigation
  - Same incident repeats weekly
  - Team frustrated with firefighting
  - Business impact accumulates
Result: Chronic instability, wasted effort, customer dissatisfaction
```

### After (Proactive Problem Management)
```yaml
Scenario: Database connection failures recurring weekly
Process:
  1. Problem Identification: Pattern detected from incident history
  2. Problem Logging: Problem PRB-2025-001 created
  3. Root Cause Analysis:
     - Timeline analysis of 5 incidents
     - Connection pool exhaustion identified
     - Underlying cause: Connection leak in v1.2.0 deployment
     
  4. Solution Development:
     - Option A: Fix connection leak (permanent)
     - Option B: Increase pool size (temporary)
     - Option C: Add connection recycling
     
  5. Solution Evaluation:
     - Cost: 2 developer days for Option A
     - Benefit: Eliminates weekly incidents
     - ROI: 40 hours/month saved vs 16 hours fix
     
  6. Solution Implementation:
     - Code fix for connection leak
     - Testing and deployment via change management
     
  7. Verification:
     - Monitoring for 2 weeks shows no recurrence
     - Connection pool stable at 60% utilization
     
  8. Knowledge Management:
     - Known error added to database
     - Runbook updated for connection issues
     - Architecture review for connection management

Outcome:
  - Incidents eliminated
  - Team focus shifted to feature development
  - Customer satisfaction improved
  - System reliability increased
```

## Quick Reference

### Problem vs Incident Management

| Aspect | Incident Management | Problem Management |
|--------|-------------------|-------------------|
| **Focus** | Restore service quickly | Find and fix root cause |
| **Timeframe** | Immediate (minutes/hours) | Longer-term (days/weeks) |
| **Priority** | Urgency based on impact | Priority based on recurrence risk |
| **Output** | Service restoration | Permanent solution |
| **Mindset** | Reactive | Proactive |
| **Success Metric** | MTTR (Mean Time to Restore) | Problem resolution rate |

### Root Cause Analysis Techniques

| Technique | When to Use | Complexity | Output |
|-----------|------------|------------|--------|
| **5 Whys** | Simple, linear causes | Low | Chain of causation |
| **Fishbone Diagram** | Multiple potential causes | Medium | Categorized root causes |
| **Fault Tree Analysis** | Complex systems, reliability engineering | High | Probability-based analysis |
| **Timeline Analysis** | Sequence-dependent incidents | Medium | Chronological cause chain |
| **Change Analysis** | Recent changes involved | Low | Change-to-incident correlation |
| **Barrier Analysis** | Safety-critical systems | High | Defense layer failures |

### Problem Prioritization Matrix

```yaml
prioritization_matrix:
  dimensions:
    - recurrence_frequency: [daily, weekly, monthly, quarterly]
    - business_impact: [critical, high, medium, low]
    - fix_complexity: [simple, moderate, complex, very-complex]
    
  scoring:
    recurrence:
      daily: 4, weekly: 3, monthly: 2, quarterly: 1
    impact:
      critical: 4, high: 3, medium: 2, low: 1
    complexity:
      simple: 4, moderate: 3, complex: 2, very-complex: 1
      
  priority_levels:
    p0: score >= 10  # Immediate attention
    p1: score 7-9    # High priority
    p2: score 4-6    # Medium priority
    p3: score <= 3   # Low priority
```

### Known Error Database Structure

```yaml
known_error_database:
  schema:
    error_id: "KE-YYYY-NNN"
    title: "Short descriptive title"
    symptoms: ["symptom1", "symptom2"]
    root_cause: "Detailed root cause description"
    solution: "Permanent fix or workaround"
    workaround: "Temporary mitigation steps"
    affected_components: ["component1", "component2"]
    detection_methods: ["monitoring_alert", "user_report"]
    related_incidents: ["INC-001", "INC-002"]
    status: ["active", "resolved", "archived"]
    created_date: "YYYY-MM-DD"
    last_occurrence: "YYYY-MM-DD"
    occurrence_count: integer
    resolution_date: "YYYY-MM-DD"
    
  usage_scenarios:
    incident_matching: "Match new incidents to known errors"
    faster_resolution: "Apply known workarounds immediately"
    proactive_prevention: "Identify patterns before incidents"
    knowledge_sharing: "Cross-team learning from past issues"
```

## Implementation

### Problem Management Workflow Engine

```python
class ProblemManagementWorkflow:
    """ITIL-aligned problem management workflow engine."""
    
    def __init__(self, incident_repository, knowledge_base):
        self.incident_repository = incident_repository
        self.knowledge_base = knowledge_base
        self.problem_repository = ProblemRepository()
        self.rca_engine = RootCauseAnalysisEngine()
        
    def identify_problem_from_incidents(self, incident_pattern):
        """Identify potential problem from incident patterns."""
        
        # Analyze incident history for patterns
        similar_incidents = self.incident_repository.find_similar(
            symptoms=incident_pattern['symptoms'],
            time_window=incident_pattern.get('time_window', '30d'),
            service=incident_pattern.get('service')
        )
        
        if len(similar_incidents) >= incident_pattern.get('threshold', 3):
            # Create problem record
            problem = Problem(
                title=f"Recurring: {incident_pattern['symptoms'][0]}",
                description=self._generate_problem_description(similar_incidents),
                related_incidents=[i.id for i in similar_incidents],
                identified_at=datetime.now(),
                priority=self._calculate_initial_priority(similar_incidents)
            )
            
            problem_id = self.problem_repository.save(problem)
            
            # Check known error database
            known_error = self.knowledge_base.find_similar_error(problem)
            if known_error:
                problem.link_to_known_error(known_error.id)
                
            return problem_id
            
        return None
    
    def conduct_root_cause_analysis(self, problem_id, technique='5_whys'):
        """Conduct root cause analysis using selected technique."""
        
        problem = self.problem_repository.get(problem_id)
        incidents = self.incident_repository.get_multiple(problem.related_incidents)
        
        if technique == '5_whys':
            root_cause = self._five_whys_analysis(incidents)
        elif technique == 'fishbone':
            root_cause = self._fishbone_analysis(incidents)
        elif technique == 'timeline':
            root_cause = self._timeline_analysis(incidents)
        else:
            root_cause = self.rca_engine.analyze(incidents, technique)
        
        problem.set_root_cause(root_cause)
        self.problem_repository.update(problem)
        
        return root_cause
    
    def develop_solutions(self, problem_id):
        """Develop solution alternatives for a problem."""
        
        problem = self.problem_repository.get(problem_id)
        
        solutions = []
        
        # Generate solution alternatives
        if problem.root_cause['category'] == 'code_issue':
            solutions.extend(self._develop_code_solutions(problem))
        elif problem.root_cause['category'] == 'configuration':
            solutions.extend(self._develop_configuration_solutions(problem))
        elif problem.root_cause['category'] == 'architecture':
            solutions.extend(self._develop_architecture_solutions(problem))
        elif problem.root_cause['category'] == 'process':
            solutions.extend(self._develop_process_solutions(problem))
        
        # Add workaround as temporary solution
        workaround = self._develop_workaround(problem)
        if workaround:
            solutions.append({
                'type': 'workaround',
                'description': workaround,
                'implementation_time': 'immediate',
                'permanence': 'temporary'
            })
        
        # Evaluate each solution
        evaluated_solutions = []
        for solution in solutions:
            evaluation = self._evaluate_solution(solution, problem)
            solution['evaluation'] = evaluation
            evaluated_solutions.append(solution)
        
        problem.set_solution_options(evaluated_solutions)
        self.problem_repository.update(problem)
        
        return evaluated_solutions
    
    def implement_solution(self, problem_id, solution_index, change_management=True):
        """Implement selected solution for a problem."""
        
        problem = self.problem_repository.get(problem_id)
        solution = problem.solution_options[solution_index]
        
        implementation_plan = {
            'problem_id': problem_id,
            'solution': solution,
            'planned_start': datetime.now(),
            'estimated_duration': solution['evaluation']['implementation_effort'],
            'resources_required': solution['evaluation']['resources'],
            'rollback_plan': self._create_rollback_plan(solution)
        }
        
        if change_management:
            # Create change request
            change_request = self.change_management.create_request(
                title=f"Problem Resolution: {problem.title}",
                description=solution['description'],
                implementation_plan=implementation_plan,
                risk_assessment=solution['evaluation']['risk_assessment']
            )
            
            implementation_plan['change_request_id'] = change_request.id
            
            # Track implementation through change management
            problem.set_implementation_plan(implementation_plan)
            problem.status = 'awaiting_change'
            
        else:
            # Direct implementation (for low-risk solutions)
            implementation_result = self._execute_implementation(implementation_plan)
            problem.set_implementation_result(implementation_result)
            problem.status = 'implemented'
        
        self.problem_repository.update(problem)
        
        return implementation_plan
    
    def verify_solution(self, problem_id, verification_period='14d'):
        """Verify solution effectiveness after implementation."""
        
        problem = self.problem_repository.get(problem_id)
        
        # Monitor for recurrence
        recurrence_check = self._check_incident_recurrence(
            problem.related_incidents,
            period=verification_period
        )
        
        # Measure improvement metrics
        before_metrics = self._calculate_before_metrics(problem)
        after_metrics = self._calculate_after_metrics(problem, verification_period)
        
        verification_result = {
            'recurrence_occurred': recurrence_check['recurred'],
            'recurrence_details': recurrence_check['details'],
            'metrics_comparison': {
                'before': before_metrics,
                'after': after_metrics,
                'improvement': self._calculate_improvement(before_metrics, after_metrics)
            },
            'stakeholder_feedback': self._gather_feedback(problem),
            'verification_period': verification_period,
            'verified_at': datetime.now()
        }
        
        if not recurrence_check['recurred'] and verification_result['metrics_comparison']['improvement'] > 0:
            verification_result['success'] = True
            problem.status = 'resolved'
            problem.resolved_at = datetime.now()
        else:
            verification_result['success'] = False
            problem.status = 'verification_failed'
            problem.add_note(f"Verification failed: {recurrence_check.get('reason', 'Unknown')}")
        
        problem.set_verification_result(verification_result)
        self.problem_repository.update(problem)
        
        return verification_result
```

### Root Cause Analysis Engine

```python
class RootCauseAnalysisEngine:
    """Multi-technique root cause analysis engine."""
    
    def analyze(self, incidents, technique='auto'):
        """Analyze incidents to identify root cause."""
        
        if technique == 'auto':
            technique = self._select_technique(incidents)
        
        if technique == 'five_whys':
            return self._five_whys(incidents)
        elif technique == 'fishbone':
            return self._fishbone(incidents)
        elif technique == 'timeline':
            return self._timeline_analysis(incidents)
        elif technique == 'change_analysis':
            return self._change_analysis(incidents)
        elif technique == 'barrier_analysis':
            return self._barrier_analysis(incidents)
        else:
            return self._comprehensive_analysis(incidents)
    
    def _five_whys(self, incidents):
        """5 Whys analysis for linear cause chains."""
        
        primary_incident = incidents[0]  # Use most recent or severe
        
        why_chain = []
        current_cause = primary_incident.symptoms[0]
        
        for i in range(5):
            deeper_cause = self._ask_why(current_cause, incidents)
            if deeper_cause and deeper_cause != current_cause:
                why_chain.append({
                    'why_number': i + 1,
                    'question': f"Why {current_cause}?",
                    'answer': deeper_cause
                })
                current_cause = deeper_cause
            else:
                break
        
        root_cause = why_chain[-1]['answer'] if why_chain else current_cause
        
        return {
            'technique': '5_whys',
            'root_cause': root_cause,
            'why_chain': why_chain,
            'confidence': min(0.9, 0.7 + len(why_chain) * 0.05)
        }
    
    def _fishbone(self, incidents):
        """Fishbone (Ishikawa) diagram analysis for categorized causes."""
        
        categories = {
            'people': ['training', 'communication', 'skill', 'fatigue'],
            'process': ['procedure', 'workflow', 'documentation', 'approval'],
            'technology': ['software', 'hardware', 'network', 'database'],
            'materials': ['data', 'supplies', 'components', 'resources'],
            'measurement': ['metrics', 'monitoring', 'testing', 'validation'],
            'environment': ['infrastructure', 'location', 'external', 'regulatory']
        }
        
        cause_map = {category: [] for category in categories.keys()}
        
        for incident in incidents:
            for category, keywords in categories.items():
                if any(self._contains_keyword(incident.description, keyword) 
                       for keyword in keywords):
                    potential_causes = self._extract_causes(incident.description, keywords)
                    cause_map[category].extend(potential_causes)
        
        # Analyze cause distribution
        cause_distribution = {cat: len(causes) for cat, causes in cause_map.items()}
        primary_category = max(cause_distribution, key=cause_distribution.get)
        
        return {
            'technique': 'fishbone',
            'primary_category': primary_category,
            'cause_map': cause_map,
            'root_cause_candidates': cause_map[primary_category][:3],
            'confidence': 0.75
        }
    
    def _timeline_analysis(self, incidents):
        """Timeline analysis for chronological cause chains."""
        
        # Sort incidents chronologically
        sorted_incidents = sorted(incidents, key=lambda x: x.detected_at)
        
        timeline_events = []
        for incident in sorted_incidents:
            timeline_events.append({
                'timestamp': incident.detected_at,
                'event': incident.title,
                'details': incident.description,
                'preceding_changes': self._find_preceding_changes(incident)
            })
        
        # Look for patterns in timeline
        patterns = self._analyze_timeline_patterns(timeline_events)
        
        return {
            'technique': 'timeline',
            'timeline_events': timeline_events,
            'patterns_found': patterns,
            'root_cause_candidates': self._extract_root_candidates(patterns),
            'confidence': 0.8 if patterns else 0.6
        }
```

### Problem Trend Analysis

```python
class ProblemTrendAnalyzer:
    """Analyze problem trends for proactive prevention."""
    
    def __init__(self, problem_repository, incident_repository):
        self.problem_repo = problem_repository
        self.incident_repo = incident_repository
    
    def analyze_trends(self, time_window='90d'):
        """Analyze problem and incident trends for proactive insights."""
        
        problems = self.problem_repo.get_by_time_window(time_window)
        incidents = self.incident_repo.get_by_time_window(time_window)
        
        trends = {
            'problem_frequency': self._calculate_frequency_trend(problems),
            'incident_patterns': self._identify_incident_patterns(incidents),
            'root_cause_distribution': self._analyze_root_cause_distribution(problems),
            'recurrence_analysis': self._analyze_recurrence_patterns(problems, incidents),
            'emerging_risks': self._identify_emerging_risks(problems, incidents)
        }
        
        # Generate proactive recommendations
        recommendations = self._generate_recommendations(trends)
        
        return {
            'trends': trends,
            'recommendations': recommendations,
            'time_window': time_window,
            'analysis_date': datetime.now()
        }
    
    def _identify_emerging_risks(self, problems, incidents):
        """Identify emerging risks before they become problems."""
        
        emerging_risks = []
        
        # Look for increasing incident frequency
        incident_frequency = self._calculate_incident_frequency_by_service(incidents)
        for service, frequency in incident_frequency.items():
            if frequency['trend'] == 'increasing' and frequency['current'] > frequency['baseline'] * 1.5:
                emerging_risks.append({
                    'type': 'increasing_incident_frequency',
                    'service': service,
                    'current_rate': frequency['current'],
                    'baseline_rate': frequency['baseline'],
                    'increase_percentage': ((frequency['current'] - frequency['baseline']) / frequency['baseline']) * 100
                })
        
        # Look for new symptom patterns
        new_symptoms = self._identify_new_symptom_patterns(incidents)
        emerging_risks.extend(new_symptoms)
        
        # Look for technology stack risks
        tech_risks = self._identify_technology_risks(problems)
        emerging_risks.extend(tech_risks)
        
        return emerging_risks
    
    def _generate_recommendations(self, trends):
        """Generate proactive recommendations from trend analysis."""
        
        recommendations = []
        
        # Address recurrence patterns
        for recurrence in trends['recurrence_analysis'].get('high_recurrence', []):
            recommendations.append({
                'type': 'prevent_recurrence',
                'target': recurrence['pattern'],
                'action': 'Initiate problem management for recurring pattern',
                'priority': 'high',
                'expected_benefit': f"Reduce {recurrence['incident_count']} incidents"
            })
        
        # Address emerging risks
        for risk in trends['emerging_risks']:
            if risk['type'] == 'increasing_incident_frequency':
                recommendations.append({
                    'type': 'investigate_trend',
                    'target': risk['service'],
                    'action': 'Conduct proactive investigation before incidents become critical',
                    'priority': 'medium',
                    'expected_benefit': 'Prevent future problems'
                })
        
        # Address root cause patterns
        root_cause_patterns = trends['root_cause_distribution'].get('common_patterns', [])
        for pattern in root_cause_patterns[:3]:  # Top 3 patterns
            recommendations.append({
                'type': 'address_root_cause_pattern',
                'target': pattern['category'],
                'action': f"Implement systemic fix for {pattern['category']} issues",
                'priority': 'medium',
                'expected_benefit': f"Address {pattern['percentage']}% of problems"
            })
        
        return recommendations
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Confusing problems with incidents | Treating symptoms not causes | Clear separation: incidents for restoration, problems for root cause |
| Skipping RCA for "obvious" causes | Missing underlying systemic issues | Always conduct proper RCA, even for seemingly simple issues |
| No trend analysis | Reactive not proactive | Regular trend analysis to identify emerging issues |
| Focusing only on technical causes | Missing process or people factors | Consider all categories: people, process, technology, environment |
| Not maintaining known error database | Reinventing solutions | Build and maintain searchable known error database |
| Ignoring workarounds in problem management | Extended impact while seeking perfect fix | Document and use workarounds while developing permanent fixes |
| No verification of solutions | Assuming fixes work without evidence | Verify solutions with monitoring and metrics |
| Siloed problem management | Missing cross-system insights | Involve multiple teams and systems in problem analysis |

### Red Flags

- Same incidents recurring without problem records
- No root cause analysis documentation
- Known error database empty or outdated
- No trend analysis reports
- Problems taking months to resolve
- No distinction between incident and problem management
- Solutions implemented without verification
- Problem management isolated from incident management

## Real-World Impact

**Before (Reactive Firefighting):**
- Same incidents recur weekly/monthly
- Team constantly in firefighting mode
- No time for proactive improvement
- Business impact accumulates
- Customer trust erodes
- Team burnout and turnover
- Technical debt increases

**After (Proactive Problem Management):**
- Incident volume decreases over time
- Team focuses on feature development
- Systematic elimination of root causes
- Predictable system behavior
- Customer satisfaction improves
- Team morale and retention improve
- Business reliability increases

**Outcome:** Stable systems, efficient teams, happy customers, predictable operations.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Align problem priorities with business impact
    - Quantify business value of problem prevention
    - Communicate problem management ROI to stakeholders
    
  metrics:
    - Track problem resolution metrics
    - Measure reduction in incident volume
    - Correlate problem management with business metrics
    
  architecture:
    - Architecture reviews based on problem patterns
    - Design changes to eliminate recurring problems
    - Technology decisions informed by problem history
    
  data:
    - Problem data for predictive analytics
    - Root cause data for systemic improvements
    - Trend data for proactive prevention
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include reliability requirements in specs
    - Define problem management procedures
    - Specify monitoring for problem detection
    
  constitution:
    - "Continuous Improvement" principle enforcement
    - Problem learning for constitution evolution
    - Reliability as constitutional requirement
    
  traceability:
    - Link problems to specifications
    - Track problem-driven specification changes
    - Update specifications based on problem learnings
```

### Incident Management Integration

```yaml
incident_integration:
  workflow:
    - Incidents trigger problem investigation
    - Problem workarounds speed incident resolution
    - Post-incident reviews feed problem management
    
  data_flow:
    - Incident data → Problem identification
    - Problem solutions → Incident prevention
    - Known errors → Faster incident resolution
    
  collaboration:
    - Joint incident-problem war rooms
    - Shared timelines and analysis
    - Coordinated communication
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Recursive Optimization"
  triggers:
    - recurring_incidents_detected
    - post_incident_review_completed
    - trend_analysis_identifies_patterns
    
  skills_chain:
    - problem-management (primary)
    - incident-management (for context)
    - metrics-definer (for measurement)
    - recursive-optimizer (for systemic fixes)
    
  outputs:
    - root_cause_analysis
    - permanent_solutions
    - known_error_updates
    - trend_analysis_reports
    - proactive_recommendations
    
  feedback_loop:
    - incidents → problems → solutions → monitoring → verification
```

### Example Problem Management Workflow in Aether.go

```bash
# 1. Identify problem from recurring incidents
aether problem identify \
  --pattern="database_connection_failures" \
  --time-window="30d" \
  --threshold=3

# 2. Conduct root cause analysis
aether problem analyze \
  --problem-id="PRB-2025-001" \
  --technique="fishbone" \
  --include-timeline

# 3. Develop solution alternatives
aether problem solutions \
  --problem-id="PRB-2025-001" \
  --evaluate-cost-benefit

# 4. Implement selected solution
aether problem implement \
  --problem-id="PRB-2025-001" \
  --solution-index=0 \
  --change-management

# 5. Verify solution effectiveness
aether problem verify \
  --problem-id="PRB-2025-001" \
  --verification-period="14d" \
  --metrics="incident_volume,error_rate"

# 6. Update knowledge base
aether problem knowledge-base \
  --problem-id="PRB-2025-001" \
  --update-known-errors \
  --create-runbook

# 7. Proactive trend analysis
aether problem trends \
  --time-window="90d" \
  --generate-recommendations
```