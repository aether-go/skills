---
name: change-management
description: Use when managing changes to IT services using standardized methods and procedures to minimize disruption and ensure successful implementation
---

# Change Management

## Overview
Manage changes to IT services through standardized processes that ensure risks are assessed, approvals are obtained, changes are planned and tested, and successful implementation is verified. Balances the need for change with the need to protect live services.

## When to Use

```
Planning system changes? ────────────┐
                                     │
Risk assessment needed? ─────────────┤
                                     ├─► Use change-management
Multiple teams coordination? ────────┤
                                     │
Compliance requirements? ─────────────┘
```

Use when:
- Deploying software changes to production
- Making infrastructure modifications
- Implementing configuration changes
- Performing database migrations
- Upgrading third-party dependencies
- Changing security settings or access controls
- Coordinating changes across multiple services
- High-risk or high-impact changes
- Compliance-regulated environments

Don't use when:
- Development environment changes only
- Low-risk documentation updates
- Routine operational tasks with no service impact
- Emergency changes during incidents (use emergency change process)
- Personal development environment changes

## Core Pattern

### ITIL Change Management Lifecycle

```
Change Request → Change Recording → Change Assessment → Change Authorization
     ↓                ↓                ↓                  ↓
Initiation      Change Record    Risk & Impact      CAB Review
     ↓                                                       
Change Planning → Change Build & Test → Change Deployment → Change Review
     ↓                ↓                  ↓                  ↓
Schedule         Development &       Implementation    Post-Implementation
Resources        Testing            Verification       Review
     ↓
Change Closure → Knowledge Update → Metrics Collection
     ↓                ↓                  ↓
Documentation    CMDB Update       Process Improvement
```

### Before (Uncontrolled Changes)
```yaml
Scenario: Database schema update
Approach:
  - Developer makes changes directly in production
  - No testing in staging environment
  - No rollback plan prepared
  - No communication to other teams
  - Change fails, causes service outage
  - Rollback attempted but causes data corruption
Result: Extended outage, data loss, customer impact, blame culture
```

### After (Controlled Change Management)
```yaml
Scenario: Database schema update
Process:
  1. Change Request:
     - RFC-2025-001: "Add user preferences table"
     - Submitted with business justification
     - Impact analysis: Affects user service only
     
  2. Change Assessment:
     - Risk: Medium (data migration required)
     - Testing: Required in staging
     - Rollback: Full database backup before change
     
  3. Change Authorization:
     - CAB approval obtained
     - Scheduled for low-traffic window
     - Change window: 2 hours allocated
     
  4. Change Planning:
     - Detailed implementation plan
     - Communication plan to stakeholders
     - Rollback procedure documented
     - Verification checklist created
     
  5. Change Build & Test:
     - Schema changes developed
     - Migration script tested in staging
     - Performance impact validated
     - Rollback tested successfully
     
  6. Change Deployment:
     - Pre-change: Database backup completed
     - Implementation: Migration executed
     - Verification: All checks pass
     - Post-change: Monitoring activated
     
  7. Change Review:
     - Post-implementation review conducted
     - Success criteria met
     - Knowledge base updated
     - Metrics recorded

Outcome:
  - Change implemented successfully
  - Zero downtime during change
  - Rollback plan unused but available
  - Team confidence in change process
  - Process improvement for future changes
```

## Quick Reference

### Change Types and Approval Levels

| Change Type | Risk Level | Approval Required | Examples |
|------------|------------|-------------------|----------|
| **Standard Change** | Low | Pre-approved | Routine patches, minor updates |
| **Normal Change** | Medium | CAB approval | New features, infrastructure changes |
| **Emergency Change** | High | Emergency CAB | Incident remediation, security fixes |
| **Major Change** | Very High | Senior Management | Platform migration, architecture changes |

### Change Advisory Board (CAB) Composition

| Role | Responsibility | Voting Power |
|------|---------------|--------------|
| **Change Manager** | Process owner, facilitator | Deciding vote |
| **Technical Lead** | Technical feasibility | Technical veto |
| **Operations Lead** | Operational impact | Operational veto |
| **Business Lead** | Business impact | Business veto |
| **Security Lead** | Security assessment | Security veto |
| **Quality Lead** | Testing & verification | Quality veto |
| **Customer Representative** | User impact | Advisory only |

### Change Success Criteria

```yaml
success_criteria:
  technical:
    - zero_service_outage: true
    - performance_within_sla: true
    - no_regressions: true
    - monitoring_healthy: true
    
  process:
    - change_completed_on_time: true
    - within_change_window: true
    - documentation_updated: true
    - knowledge_transfer_complete: true
    
  business:
    - business_goals_met: true
    - user_impact_minimal: true
    - no_revenue_loss: true
    - customer_satisfaction_maintained: true
    
  compliance:
    - audit_trail_complete: true
    - regulatory_requirements_met: true
    - security_controls_intact: true
    - data_integrity_preserved: true
```

### Change Management Metrics

| Metric | Formula | Target | Purpose |
|--------|---------|--------|---------|
| **Change Success Rate** | Successful changes / Total changes | > 95% | Process effectiveness |
| **Change Lead Time** | Time from request to implementation | Standard: < 7d, Emergency: < 4h | Process efficiency |
| **Change Failure Rate** | Failed changes / Total changes | < 5% | Risk management |
| **Emergency Change %** | Emergency changes / Total changes | < 10% | Process stability |
| **CAB Approval Time** | Time in approval queue | < 48h | Decision efficiency |
| **Rollback Rate** | Changes requiring rollback / Total changes | < 2% | Implementation quality |
| **Post-Implementation Issues** | Issues after change / Total changes | < 3% | Verification effectiveness |

## Implementation

### Change Management Workflow Engine

```python
class ChangeManagementWorkflow:
    """ITIL-aligned change management workflow engine."""
    
    def __init__(self, config):
        self.config = config
        self.change_repository = ChangeRepository()
        self.cab_scheduler = CABScheduler()
        self.risk_assessor = RiskAssessor()
        self.notification_service = NotificationService()
        
    def submit_change_request(self, change_data):
        """Submit and record a new change request."""
        
        change = ChangeRequest(
            title=change_data['title'],
            description=change_data['description'],
            requester=change_data['requester'],
            change_type=self._determine_change_type(change_data),
            business_justification=change_data.get('business_justification'),
            urgency=change_data.get('urgency', 'normal'),
            impact=change_data.get('impact', 'medium'),
            submitted_at=datetime.now()
        )
        
        # Auto-classify if possible
        if self._is_standard_change(change):
            change.change_type = 'standard'
            change.approval_required = False
        
        change_id = self.change_repository.save(change)
        
        # Route based on change type
        if change.change_type == 'standard':
            self._process_standard_change(change_id)
        elif change.change_type == 'emergency':
            self._process_emergency_change(change_id)
        else:
            self._process_normal_change(change_id)
        
        return change_id
    
    def assess_change(self, change_id):
        """Assess change for risks, impact, and resource requirements."""
        
        change = self.change_repository.get(change_id)
        
        assessment = {
            'technical_risks': self.risk_assessor.assess_technical_risks(change),
            'business_impact': self.risk_assessor.assess_business_impact(change),
            'resource_requirements': self._calculate_resource_requirements(change),
            'testing_requirements': self._determine_testing_requirements(change),
            'rollback_complexity': self._assess_rollback_complexity(change),
            'dependencies': self._identify_dependencies(change),
            'constraints': self._identify_constraints(change)
        }
        
        # Calculate overall risk score
        risk_score = self._calculate_risk_score(assessment)
        assessment['overall_risk_score'] = risk_score
        assessment['risk_level'] = self._determine_risk_level(risk_score)
        
        change.set_assessment(assessment)
        self.change_repository.update(change)
        
        return assessment
    
    def schedule_cab_review(self, change_id):
        """Schedule change for CAB review."""
        
        change = self.change_repository.get(change_id)
        
        # Determine CAB composition based on change
        cab_members = self._determine_cab_members(change)
        
        # Schedule CAB meeting
        cab_meeting = self.cab_scheduler.schedule_meeting(
            change_id=change_id,
            required_members=cab_members,
            urgency=change.urgency,
            preferred_time=change.requested_implementation_date
        )
        
        # Prepare CAB package
        cab_package = self._prepare_cab_package(change)
        
        # Notify CAB members
        self.notification_service.notify_cab_members(
            cab_members=cab_members,
            change=change,
            cab_meeting=cab_meeting,
            cab_package=cab_package
        )
        
        change.cab_meeting_id = cab_meeting.id
        change.status = 'awaiting_cab_review'
        self.change_repository.update(change)
        
        return cab_meeting
    
    def conduct_cab_review(self, change_id, cab_decisions):
        """Conduct CAB review and record decisions."""
        
        change = self.change_repository.get(change_id)
        
        cab_review = {
            'meeting_date': datetime.now(),
            'attendees': cab_decisions['attendees'],
            'decisions': {},
            'conditions': [],
            'action_items': []
        }
        
        # Record individual decisions
        for member, decision in cab_decisions['votes'].items():
            cab_review['decisions'][member] = {
                'vote': decision['vote'],
                'comments': decision.get('comments'),
                'conditions': decision.get('conditions', [])
            }
        
        # Determine overall decision
        if all(d['vote'] == 'approve' for d in cab_decisions['votes'].values()):
            cab_review['overall_decision'] = 'approved'
            change.status = 'approved'
            
            # Apply any conditions
            conditions = []
            for decision in cab_decisions['votes'].values():
                conditions.extend(decision.get('conditions', []))
            cab_review['conditions'] = conditions
            
        elif any(d['vote'] == 'reject' for d in cab_decisions['votes'].values()):
            cab_review['overall_decision'] = 'rejected'
            change.status = 'rejected'
            cab_review['rejection_reason'] = self._compile_rejection_reasons(cab_decisions)
            
        else:  # Some approvals with conditions
            cab_review['overall_decision'] = 'approved_with_conditions'
            change.status = 'approved_with_conditions'
            
            conditions = []
            for decision in cab_decisions['votes'].values():
                conditions.extend(decision.get('conditions', []))
            cab_review['conditions'] = conditions
        
        change.set_cab_review(cab_review)
        
        # Generate action items from conditions
        if cab_review['conditions']:
            action_items = self._create_action_items_from_conditions(
                change_id, cab_review['conditions']
            )
            cab_review['action_items'] = action_items
        
        self.change_repository.update(change)
        
        # Notify stakeholders of decision
        self.notification_service.notify_stakeholders(
            change=change,
            decision=cab_review['overall_decision'],
            conditions=cab_review.get('conditions'),
            action_items=cab_review.get('action_items')
        )
        
        return cab_review
    
    def plan_change_implementation(self, change_id):
        """Create detailed implementation plan for approved change."""
        
        change = self.change_repository.get(change_id)
        
        implementation_plan = {
            'schedule': self._create_implementation_schedule(change),
            'resources': self._allocate_resources(change),
            'communication_plan': self._create_communication_plan(change),
            'testing_plan': self._create_testing_plan(change),
            'rollback_plan': self._create_rollback_plan(change),
            'verification_checklist': self._create_verification_checklist(change),
            'success_criteria': self._define_success_criteria(change)
        }
        
        # Apply CAB conditions to plan
        if change.cab_review and change.cab_review.get('conditions'):
            implementation_plan = self._apply_cab_conditions(
                implementation_plan, change.cab_review['conditions']
            )
        
        change.set_implementation_plan(implementation_plan)
        change.status = 'planned'
        self.change_repository.update(change)
        
        return implementation_plan
    
    def execute_change(self, change_id, executor):
        """Execute change according to implementation plan."""
        
        change = self.change_repository.get(change_id)
        
        execution_log = {
            'start_time': datetime.now(),
            'executor': executor,
            'steps': [],
            'verifications': [],
            'issues': []
        }
        
        try:
            # Pre-implementation checks
            self._perform_pre_checks(change)
            execution_log['steps'].append({
                'step': 'pre_checks',
                'status': 'completed',
                'timestamp': datetime.now()
            })
            
            # Execute implementation steps
            for step in change.implementation_plan['steps']:
                step_result = self._execute_step(step, change)
                execution_log['steps'].append({
                    'step': step['name'],
                    'status': 'completed' if step_result['success'] else 'failed',
                    'details': step_result.get('details'),
                    'timestamp': datetime.now()
                })
                
                if not step_result['success']:
                    execution_log['issues'].append({
                        'step': step['name'],
                        'issue': step_result.get('error'),
                        'severity': 'high'
                    })
                    raise ChangeExecutionError(f"Step failed: {step['name']}")
            
            # Post-implementation verification
            verification_results = self._perform_post_verification(change)
            execution_log['verifications'] = verification_results
            
            # Check success criteria
            success_met = self._check_success_criteria(change, verification_results)
            
            if success_met:
                execution_log['end_time'] = datetime.now()
                execution_log['status'] = 'completed'
                execution_log['success'] = True
                
                change.status = 'implemented'
                change.implemented_at = datetime.now()
                change.implemented_by = executor
                
                # Update CMDB if applicable
                if change.requires_cmdb_update:
                    self.cmdb.update_from_change(change)
                
            else:
                execution_log['status'] = 'verification_failed'
                execution_log['success'] = False
                
                # Initiate rollback
                rollback_result = self._execute_rollback(change)
                execution_log['rollback'] = rollback_result
                
                change.status = 'failed'
                change.failure_reason = 'verification_failed'
                
        except Exception as e:
            execution_log['status'] = 'failed'
            execution_log['success'] = False
            execution_log['error'] = str(e)
            
            # Emergency rollback
            rollback_result = self._execute_rollback(change)
            execution_log['rollback'] = rollback_result
            
            change.status = 'failed'
            change.failure_reason = str(e)
        
        change.set_execution_log(execution_log)
        self.change_repository.update(change)
        
        # Notify stakeholders of outcome
        self.notification_service.notify_implementation_outcome(
            change=change,
            success=execution_log.get('success', False),
            details=execution_log
        )
        
        return execution_log
```

### Risk Assessment Engine

```python
class ChangeRiskAssessor:
    """Assess risks associated with changes."""
    
    def assess_technical_risks(self, change):
        """Assess technical risks of a change."""
        
        risks = []
        
        # Complexity risks
        if self._is_complex_change(change):
            risks.append({
                'category': 'complexity',
                'description': 'High complexity increases implementation risk',
                'likelihood': 'medium',
                'impact': 'high',
                'mitigation': 'Break into smaller changes, extensive testing'
            })
        
        # Dependency risks
        dependencies = self._identify_dependencies(change)
        if dependencies:
            risks.append({
                'category': 'dependencies',
                'description': f'Depends on {len(dependencies)} other components',
                'likelihood': 'medium',
                'impact': 'medium',
                'mitigation': 'Coordinate with dependent teams, test integration'
            })
        
        # Testing risks
        if not self._has_adequate_testing(change):
            risks.append({
                'category': 'testing',
                'description': 'Inadequate testing coverage',
                'likelihood': 'high',
                'impact': 'high',
                'mitigation': 'Increase test coverage, add integration tests'
            })
        
        # Rollback risks
        rollback_complexity = self._assess_rollback_complexity(change)
        if rollback_complexity == 'high':
            risks.append({
                'category': 'rollback',
                'description': 'Complex or impossible rollback',
                'likelihood': 'low',
                'impact': 'very_high',
                'mitigation': 'Implement phased rollback, feature flags'
            })
        
        # Performance risks
        if self._has_performance_impact(change):
            risks.append({
                'category': 'performance',
                'description': 'Potential performance degradation',
                'likelihood': 'medium',
                'impact': 'medium',
                'mitigation': 'Performance testing, monitoring during implementation'
            })
        
        return risks
    
    def assess_business_impact(self, change):
        """Assess business impact of a change."""
        
        impact = {
            'affected_services': self._identify_affected_services(change),
            'affected_users': self._estimate_affected_users(change),
            'business_criticality': self._determine_business_criticality(change),
            'revenue_impact': self._estimate_revenue_impact(change),
            'compliance_impact': self._assess_compliance_impact(change),
            'reputation_impact': self._assess_reputation_impact(change)
        }
        
        # Calculate overall impact score
        impact_score = 0
        weights = {
            'affected_users': 0.2,
            'business_criticality': 0.3,
            'revenue_impact': 0.25,
            'compliance_impact': 0.15,
            'reputation_impact': 0.1
        }
        
        for factor, weight in weights.items():
            factor_score = self._score_factor(impact[factor])
            impact_score += factor_score * weight
        
        impact['overall_score'] = impact_score
        impact['level'] = self._determine_impact_level(impact_score)
        
        return impact
    
    def calculate_overall_risk_score(self, technical_risks, business_impact):
        """Calculate overall risk score for a change."""
        
        # Technical risk score
        tech_risk_score = 0
        if technical_risks:
            risk_levels = {'low': 1, 'medium': 2, 'high': 3, 'very_high': 4}
            max_risk = max(
                risk_levels.get(r['impact'], 1) * risk_levels.get(r['likelihood'], 1)
                for r in technical_risks
            )
            tech_risk_score = max_risk / 16  # Normalize to 0-1
        
        # Business impact score (already normalized)
        business_impact_score = business_impact['overall_score']
        
        # Combined risk score (weighted)
        overall_score = (tech_risk_score * 0.6) + (business_impact_score * 0.4)
        
        return {
            'technical_risk': tech_risk_score,
            'business_impact': business_impact_score,
            'overall_risk': overall_score,
            'risk_level': self._determine_risk_level(overall_score)
        }
```

### Change Schedule Optimizer

```python
class ChangeScheduleOptimizer:
    """Optimize change schedule to minimize business impact."""
    
    def __init__(self, business_calendar, change_history):
        self.business_calendar = business_calendar
        self.change_history = change_history
    
    def find_optimal_window(self, change, constraints):
        """Find optimal implementation window for a change."""
        
        # Define search parameters
        start_date = constraints.get('earliest_start', datetime.now())
        end_date = constraints.get('latest_end', datetime.now() + timedelta(days=30))
        preferred_duration = constraints.get('duration', timedelta(hours=2))
        
        # Get business patterns
        business_hours = self.business_calendar.get_business_hours()
        peak_hours = self.business_calendar.get_peak_hours()
        maintenance_windows = self.business_calendar.get_maintenance_windows()
        
        # Analyze change history for patterns
        similar_changes = self._find_similar_changes(change)
        successful_windows = self._analyze_successful_windows(similar_changes)
        
        # Generate candidate windows
        candidate_windows = []
        
        for day in self._date_range(start_date, end_date):
            # Skip weekends if not 24/7 operation
            if not self.business_calendar.is_operational_day(day):
                continue
            
            # Generate windows within day
            day_windows = self._generate_day_windows(
                day, preferred_duration, business_hours, peak_hours, maintenance_windows
            )
            
            for window in day_windows:
                # Score window based on multiple factors
                score = self._score_window(window, change, successful_windows)
                
                candidate_windows.append({
                    'start': window['start'],
                    'end': window['end'],
                    'duration': window['duration'],
                    'score': score,
                    'factors': window['factors']
                })
        
        # Sort by score and return top candidates
        candidate_windows.sort(key=lambda x: x['score'], reverse=True)
        
        return candidate_windows[:5]  # Top 5 candidates
    
    def _score_window(self, window, change, successful_windows):
        """Score a potential implementation window."""
        
        score = 100  # Base score
        
        # Factor 1: Business impact (higher score for lower impact)
        business_impact = self._calculate_business_impact(window, change)
        score -= business_impact * 0.4
        
        # Factor 2: Historical success (learn from past)
        historical_success = self._calculate_historical_success(window, successful_windows)
        score += historical_success * 0.3
        
        # Factor 3: Resource availability
        resource_availability = self._check_resource_availability(window, change)
        score += resource_availability * 0.2
        
        # Factor 4: Dependencies coordination
        dependency_coordination = self._check_dependency_coordination(window, change)
        score += dependency_coordination * 0.1
        
        # Factor 5: Compliance constraints
        compliance_penalty = self._check_compliance_constraints(window, change)
        score -= compliance_penalty
        
        return max(0, score)  # Ensure non-negative
    
    def _calculate_business_impact(self, window, change):
        """Calculate business impact of implementing during window."""
        
        impact = 0
        
        # Time of day impact
        hour = window['start'].hour
        if 9 <= hour <= 17:  # Business hours
            impact += 30
        elif 17 < hour <= 20:  # Evening
            impact += 15
        else:  # Night
            impact += 5
        
        # Day of week impact
        weekday = window['start'].weekday()
        if weekday < 5:  # Weekday
            impact += 20
        else:  # Weekend
            impact += 5
        
        # Seasonal impact (e.g., holiday season)
        if self.business_calendar.is_peak_season(window['start']):
            impact += 25
        
        # Service-specific peak times
        if self._is_service_peak_time(window, change.affected_services):
            impact += 35
        
        return impact
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Bypassing change management for "small" changes | Accumulated risk, undocumented changes | All changes go through process, use standard changes for routine tasks |
| Inadequate risk assessment | Unexpected issues during implementation | Comprehensive risk assessment for all changes |
| Poor communication | Stakeholders unaware, surprises during implementation | Clear communication plan, regular updates |
| No rollback plan | Can't recover from failed changes | Always have tested rollback plan |
| Skipping post-implementation review | Can't learn and improve | Mandatory review for all changes |
| Overly bureaucratic process | Slows down development, encourages bypassing | Streamline process, differentiate by risk level |
| Not updating CMDB | Configuration drift, inaccurate documentation | Automate CMDB updates as part of change |
| Ignoring dependencies | Breaks other services | Map and coordinate dependencies |

### Red Flags

- Changes implemented without tickets
- No risk assessment documentation
- Frequent emergency changes
- High change failure rate
- CAB meetings consistently overruled
- No post-implementation reviews
- CMDB out of sync with reality
- Developers bypassing process
- No metrics on change success

## Real-World Impact

**Before (Uncontrolled Changes):**
- Frequent production outages
- Blame culture around failures
- No learning from mistakes
- Configuration drift
- Compliance violations
- Customer dissatisfaction
- Team stress and burnout

**After (Controlled Change Management):**
- Predictable change success
- Learning and continuous improvement
- Accurate configuration information
- Compliance assurance
- Customer confidence
- Team confidence in changes
- Business reliability

**Outcome:** Stable operations, compliant environment, efficient changes, continuous improvement.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Align change priorities with business goals
    - Quantify business value of changes
    - Manage business risk of changes
    
  metrics:
    - Track change success metrics
    - Measure change lead time and efficiency
    - Correlate changes with business outcomes
    
  architecture:
    - Architecture reviews for major changes
    - Design for safe deployment and rollback
    - Technology decisions through change process
    
  data:
    - Change data for analytics and prediction
    - Configuration data in CMDB
    - Risk data for future assessments
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include deployment requirements in specs
    - Define change management procedures
    - Specify rollback and verification criteria
    
  constitution:
    - "Controlled Evolution" principle enforcement
    - Change management as constitutional requirement
    - Risk management in constitution
    
  traceability:
    - Link changes to specifications
    - Track specification changes through change process
    - Update specifications based on change outcomes
```

### Incident & Problem Management Integration

```yaml
incident_integration:
  emergency_changes:
    - Streamlined process for incident remediation
    - Post-incident review of emergency changes
    - Convert emergency changes to normal changes post-incident
    
  problem_management:
    - Changes to implement problem solutions
    - Risk assessment for problem fixes
    - Coordinate problem resolution changes
    
  knowledge_sharing:
    - Change outcomes inform incident response
    - Incident learnings improve change process
    - Shared metrics for continuous improvement
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Deployment & Operations"
  triggers:
    - deployment_planned
    - configuration_change_needed
    - infrastructure_modification
    
  skills_chain:
    - change-management (primary)
    - metrics-definer (for measurement)
    - incident-management (for emergency changes)
    - constitution-validator (for compliance)
    
  outputs:
    - change_implementation_plan
    - risk_assessment_report
    - implementation_results
    - post_implementation_review
    - process_improvement_recommendations
    
  feedback_loop:
    - changes → outcomes → metrics → optimization → process_improvement
```

### Example Change Management Workflow in Aether.go

```bash
# 1. Submit change request
aether change submit \
  --title="Database schema update for user preferences" \
  --type="normal" \
  --impact="medium" \
  --business-justification="Enable user customization features"

# 2. Assess change risks
aether change assess \
  --change-id="CHG-2025-001" \
  --technical-risk \
  --business-impact \
  --dependencies

# 3. Schedule CAB review
aether change schedule-cab \
  --change-id="CHG-2025-001" \
  --urgency="normal" \
  --required-members="technical,operations,business"

# 4. Conduct CAB review
aether change cab-review \
  --change-id="CHG-2025-001" \
  --decision="approve" \
  --conditions="complete_staging_testing,create_rollback_plan"

# 5. Plan implementation
aether change plan \
  --change-id="CHG-2025-001" \
  --window="2025-03-15 02:00-04:00 UTC" \
  --resources="dba-1,backend-2" \
  --create-rollback-plan

# 6. Execute change
aether change execute \
  --change-id="CHG-2025-001" \
  --executor="automation-system" \
  --monitor-progress

# 7. Post-implementation review
aether change review \
  --change-id="CHG-2025-001" \
  --verify-success-criteria \
  --update-knowledge-base \
  --record-metrics
```