---
name: rollback-manager
description: Use when planning, executing, and verifying rollback procedures for failed deployments or production incidents to ensure rapid recovery and minimal business impact
---

# Rollback Manager

## Overview
Plan, execute, and verify rollback procedures for failed deployments, production incidents, or undesirable changes. Ensure rapid recovery with minimal business impact through automated rollback capabilities, comprehensive testing, and safety verification.

## When to Use

```
Deployment failure? ──────────────┐
                                  │
Production incident? ──────────────┤
                                  ├─► Use rollback-manager
Undesirable change detected? ─────┤
                                  │
Need automated recovery? ─────────┘
```

Use when:
- Deployments fail or show degradation after release
- Production incidents require rapid rollback to stable state
- Undesirable changes are detected in production
- Automated rollback capabilities need to be implemented
- Rollback procedures require testing and validation
- Post-incident analysis of rollback effectiveness
- Designing deployment strategies with rollback safety
- Compliance requires proven recovery procedures

Don't use when:
- Simple configuration changes can be reverted manually
- Issues can be fixed forward without rollback
- Development environment testing only
- Non-production systems without business impact
- Changes are irreversible by nature (data migrations)
- Rollback would cause more damage than the issue

## Core Pattern

### Comprehensive Rollback Management Lifecycle

```
Rollback Planning → Automation Setup → Trigger Detection → Decision Making → Rollback Execution → Verification → Post-Rollback Analysis
      ↓                   ↓               ↓               ↓               ↓               ↓               ↓
Risk assessment    Automated      Monitoring      Continue vs    Safe execution   System health   Root cause
& procedure design rollback scripts metrics & alerts rollback decision of rollback plan validation & stabilization analysis & improvement
```

### Before (Manual, Ad-hoc Rollback)
```yaml
Scenario: Production deployment causes 50% error rate increase
Approach:
  - Panic and manual investigation
  - No predefined rollback procedure
  - Team debates whether to rollback or fix forward
  - Manual steps: identify previous version, stop services, deploy old version, restart
  - No verification of rollback success
  - Extended downtime (2+ hours)
  - Business impact: significant revenue loss, user frustration
Result: Extended outage, manual errors, incomplete recovery, no learning for future
```

### After (Structured Rollback Management)
```yaml
Scenario: Production deployment causes 50% error rate increase
Process:

1. Automatic Detection (Within 1 minute):
   - Monitoring alerts: error rate > 5% threshold
   - Automated health checks fail
   - Business metrics show degradation
   - Rollback trigger activated automatically

2. Decision Making (Within 2 minutes):
   - Automated decision engine evaluates:
     * Severity: High (affecting 50% of users)
     * Root cause: Likely deployment issue (timing correlation)
     * Fix-forward feasibility: Low (requires investigation)
     * Rollback safety: High (tested procedure available)
   - Decision: Execute automated rollback
   - Notification: Teams alerted, stakeholders informed

3. Rollback Execution (Within 5 minutes):
   - Automated rollback script executes:
     * Phase 1: Redirect traffic away from affected services
     * Phase 2: Deploy previous known-good version
     * Phase 3: Verify service health
     * Phase 4: Restore traffic gradually
   - Progress monitoring with automatic halt on issues

4. Verification (Within 10 minutes):
   - Health checks: All services reporting healthy
   - Error rate: Back to baseline (< 0.1%)
   - Business metrics: Recovering to normal
   - User impact: Minimal (5-10 minute partial degradation)
   - Rollback declared successful

5. Post-Rollback Analysis (Next 24 hours):
   - Root cause analysis of failed deployment
   - Rollback effectiveness assessment
   - Procedure improvement recommendations
   - Update deployment and rollback procedures
   - Stakeholder communication of resolution

Outcome: Rapid recovery (15 minutes total), minimal business impact, continuous improvement.
```

## Quick Reference

### Rollback Triggers and Severity Levels

| Trigger Type | Metrics/Monitoring | Severity | Response Time | Automation Level |
|--------------|-------------------|----------|---------------|------------------|
| **Critical Error Rate** | Error rate > 10% | Critical | < 2 minutes | Full automation |
| **Latency Degradation** | P95 latency > 200% baseline | High | < 5 minutes | Semi-automated |
| **Health Check Failure** | > 30% instances unhealthy | Critical | < 2 minutes | Full automation |
| **Business Metric Drop** | Revenue/conversion drop > 20% | High | < 5 minutes | Manual approval |
| **Security Incident** | Security scan/vulnerability detected | Critical | Immediate | Manual with automation |
| **Data Corruption** | Data integrity checks fail | Critical | Immediate | Manual with procedures |
| **Performance Regression** | Throughput drop > 50% | Medium | < 15 minutes | Semi-automated |
| **Feature Regression** | Key feature broken | Medium | < 30 minutes | Manual |

### Rollback Strategies by Deployment Type

```yaml
rollback_strategies:
  blue_green_deployment:
    strategy: "Traffic switch back to blue environment"
    execution_time: "< 1 minute"
    risk: "Very low"
    data_considerations: "None - blue environment has previous data state"
    automation: "Full automation possible"
  
  canary_deployment:
    strategy: "Redirect traffic away from canary, scale down"
    execution_time: "< 2 minutes"
    risk: "Low"
    data_considerations: "Canary instances may have new data - need data migration"
    automation: "Full automation possible"
  
  rolling_update:
    strategy: "Update deployment to previous version"
    execution_time: "5-15 minutes (depending on scale)"
    risk: "Medium"
    data_considerations: "Mixed versions during rollback - need compatibility"
    automation: "Semi-automated with verification"
  
  database_migrations:
    strategy: "Execute migration rollback scripts"
    execution_time: "Varies by migration size"
    risk: "High"
    data_considerations: "Critical - data loss possible"
    automation: "Manual with automated scripts"
  
  configuration_changes:
    strategy: "Revert to previous configuration"
    execution_time: "< 1 minute"
    risk: "Low"
    data_considerations: "None"
    automation: "Full automation possible"
  
  feature_flags:
    strategy: "Disable feature flag"
    execution_time: "< 30 seconds"
    risk: "Very low"
    data_considerations: "None"
    automation: "Full automation possible"
```

### Rollback Safety Gates

```yaml
safety_gates:
  pre_rollback_checks:
    - backup_verification: "Recent backup exists and is valid"
    - rollback_procedure_tested: "Procedure tested in staging"
    - impact_assessment: "Rollback impact less than issue impact"
    - authorization: "Proper authorization for rollback type"
    - communication: "Stakeholders notified"
  
  during_rollback_checks:
    - health_monitoring: "Monitor system health during rollback"
    - progress_validation: "Each step completes successfully"
    - automatic_halting: "Stop if any step fails"
    - manual_override: "Ability to pause or abort"
  
  post_rollback_verification:
    - system_health: "All services healthy"
    - functional_tests: "Key user journeys work"
    - performance_metrics: "Metrics back to baseline"
    - business_metrics: "Business KPIs recovering"
    - data_integrity: "Data consistent and valid"
  
  rollback_completion_criteria:
    - time_limit: "Rollback completes within SLA (e.g., 15 minutes)"
    - success_threshold: "> 95% of systems successfully rolled back"
    - user_impact: "User impact minimized and communicated"
    - documentation: "Rollback fully documented"
```

## Implementation

### Rollback Manager Engine

```python
class RollbackManager:
    """Manage complete rollback lifecycle from detection to analysis."""
    
    def __init__(self, config):
        self.config = config
        self.monitoring_integration = MonitoringIntegration()
        self.deployment_integration = DeploymentIntegration()
        self.decision_engine = RollbackDecisionEngine()
        self.execution_engine = RollbackExecutionEngine()
        self.verification_engine = RollbackVerificationEngine()
        
    def detect_and_handle_incident(self, incident_data):
        """Detect incident and manage rollback decision/execution."""
        
        incident = Incident(
            data=incident_data,
            detected_at=datetime.now(),
            status='detected'
        )
        
        try:
            # Phase 1: Incident Analysis
            incident.analysis = self._analyze_incident(incident_data)
            incident.severity = self._assess_severity(incident.analysis)
            incident.status = 'analyzed'
            
            # Phase 2: Rollback Decision
            decision = self.decision_engine.make_rollback_decision(incident)
            incident.decision = decision
            incident.status = 'decision_made'
            
            if decision['action'] == 'rollback':
                # Phase 3: Rollback Planning
                rollback_plan = self._create_rollback_plan(incident, decision)
                incident.rollback_plan = rollback_plan
                incident.status = 'planned'
                
                # Phase 4: Rollback Execution
                execution_result = self.execution_engine.execute_rollback(rollback_plan)
                incident.execution_result = execution_result
                incident.status = 'executed'
                
                # Phase 5: Verification
                verification = self.verification_engine.verify_rollback(
                    incident, execution_result
                )
                incident.verification = verification
                
                if verification['success']:
                    incident.status = 'resolved'
                    incident.resolution = 'rollback_successful'
                else:
                    incident.status = 'verification_failed'
                    incident.resolution = 'rollback_verification_failed'
                    
            elif decision['action'] == 'fix_forward':
                incident.status = 'fix_forward_initiated'
                incident.resolution = 'fixing_forward'
                
            elif decision['action'] == 'monitor':
                incident.status = 'monitoring'
                incident.resolution = 'monitoring_continue'
                
            # Phase 6: Post-Incident Analysis
            incident.post_analysis = self._conduct_post_incident_analysis(incident)
            incident.status = 'analysis_complete'
            
        except Exception as e:
            incident.status = 'error'
            incident.error = str(e)
            incident.resolution = 'error_during_handling'
            
        finally:
            incident.completed_at = datetime.now()
            incident.duration = incident.completed_at - incident.detected_at
            
            # Record metrics
            incident.metrics = self._collect_incident_metrics(incident)
            
            return incident
    
    def _analyze_incident(self, incident_data):
        """Analyze incident to understand scope and impact."""
        
        analysis = {
            'metrics_analysis': {},
            'root_cause_indicators': [],
            'impact_assessment': {},
            'timeline_analysis': {}
        }
        
        # Analyze monitoring metrics
        metrics = incident_data.get('metrics', {})
        for metric_name, metric_value in metrics.items():
            baseline = self.monitoring_integration.get_baseline(metric_name)
            if baseline:
                deviation = abs(metric_value - baseline) / baseline
                analysis['metrics_analysis'][metric_name] = {
                    'value': metric_value,
                    'baseline': baseline,
                    'deviation': deviation,
                    'severity': self._classify_deviation_severity(deviation, metric_name)
                }
        
        # Identify potential root causes
        analysis['root_cause_indicators'] = self._identify_root_cause_indicators(
            incident_data
        )
        
        # Assess business impact
        analysis['impact_assessment'] = self._assess_business_impact(
            incident_data, analysis['metrics_analysis']
        )
        
        # Analyze timeline (when did issues start?)
        analysis['timeline_analysis'] = self._analyze_incident_timeline(
            incident_data
        )
        
        return analysis
    
    def _create_rollback_plan(self, incident, decision):
        """Create detailed rollback plan for execution."""
        
        plan = {
            'incident_id': incident.id,
            'created_at': datetime.now(),
            'target_state': decision.get('target_state', 'previous_stable'),
            'strategy': decision.get('strategy', 'automated_rollback'),
            'phases': [],
            'safety_checks': [],
            'rollback_triggers': [],
            'completion_criteria': []
        }
        
        # Determine rollback strategy based on deployment type
        deployment_type = incident.analysis.get('deployment_type', 'unknown')
        strategy_details = self._get_strategy_details(deployment_type)
        plan['strategy_details'] = strategy_details
        
        # Build rollback phases
        if deployment_type == 'blue_green':
            plan['phases'] = self._create_blue_green_rollback_phases(incident)
        elif deployment_type == 'canary':
            plan['phases'] = self._create_canary_rollback_phases(incident)
        elif deployment_type == 'rolling_update':
            plan['phases'] = self._create_rolling_update_rollback_phases(incident)
        elif deployment_type == 'database_migration':
            plan['phases'] = self._create_database_rollback_phases(incident)
        else:
            plan['phases'] = self._create_generic_rollback_phases(incident)
        
        # Add safety checks for each phase
        for phase in plan['phases']:
            phase['safety_checks'] = self._create_phase_safety_checks(phase)
        
        # Define rollback triggers (when to abort)
        plan['rollback_triggers'] = self._create_rollback_triggers(incident)
        
        # Define completion criteria
        plan['completion_criteria'] = self._create_completion_criteria(incident)
        
        # Estimate rollback duration
        plan['estimated_duration'] = self._estimate_rollback_duration(plan)
        
        # Identify risks and mitigation
        plan['risks'] = self._identify_rollback_risks(plan)
        plan['risk_mitigations'] = self._create_risk_mitigations(plan['risks'])
        
        return plan
    
    def _create_blue_green_rollback_phases(self, incident):
        """Create rollback phases for blue-green deployment."""
        
        phases = [
            {
                'name': 'traffic_redirect',
                'description': 'Redirect traffic from green (current) back to blue (previous)',
                'actions': [
                    {
                        'type': 'update_load_balancer',
                        'config': {
                            'target': 'blue_environment',
                            'weight': 100
                        },
                        'timeout_seconds': 30
                    },
                    {
                        'type': 'drain_connections',
                        'config': {
                            'environment': 'green',
                            'timeout_seconds': 60
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'traffic_verification',
                        'check': '> 99% traffic going to blue'
                    }
                ],
                'estimated_duration': '2 minutes'
            },
            {
                'name': 'green_environment_cleanup',
                'description': 'Scale down green environment to conserve resources',
                'actions': [
                    {
                        'type': 'scale_down',
                        'config': {
                            'environment': 'green',
                            'replicas': 0
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'scale_verification',
                        'check': 'green environment has 0 replicas'
                    }
                ],
                'estimated_duration': '1 minute'
            },
            {
                'name': 'monitor_stabilization',
                'description': 'Monitor system stability after rollback',
                'actions': [
                    {
                        'type': 'monitor_metrics',
                        'config': {
                            'duration_minutes': 5,
                            'metrics': ['error_rate', 'latency', 'throughput']
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'health_verification',
                        'check': 'all metrics back to baseline'
                    }
                ],
                'estimated_duration': '5 minutes'
            }
        ]
        
        return phases
    
    def _create_canary_rollback_phases(self, incident):
        """Create rollback phases for canary deployment."""
        
        phases = [
            {
                'name': 'traffic_shift_from_canary',
                'description': 'Shift traffic away from canary instances',
                'actions': [
                    {
                        'type': 'update_traffic_routing',
                        'config': {
                            'canary_weight': 0,
                            'stable_weight': 100
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'traffic_verification',
                        'check': '0% traffic to canary instances'
                    }
                ],
                'estimated_duration': '1 minute'
            },
            {
                'name': 'canary_termination',
                'description': 'Terminate canary instances',
                'actions': [
                    {
                        'type': 'terminate_instances',
                        'config': {
                            'group': 'canary',
                            'drain_timeout_seconds': 30
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'instance_verification',
                        'check': 'no canary instances running'
                    }
                ],
                'estimated_duration': '2 minutes'
            },
            {
                'name': 'stable_environment_verification',
                'description': 'Verify stable environment is handling full load',
                'actions': [
                    {
                        'type': 'monitor_metrics',
                        'config': {
                            'duration_minutes': 3,
                            'metrics': ['error_rate', 'latency', 'cpu_utilization']
                        }
                    }
                ],
                'verification': [
                    {
                        'type': 'performance_verification',
                        'check': 'stable environment performing within thresholds'
                    }
                ],
                'estimated_duration': '3 minutes'
            }
        ]
        
        return phases
```

### Rollback Decision Engine

```python
class RollbackDecisionEngine:
    """Make data-driven rollback decisions based on incident analysis."""
    
    def __init__(self):
        self.decision_rules = DecisionRules()
        self.ml_model = MLDecisionModel()  # Optional ML for complex decisions
        self.historical_data = HistoricalDataStore()
        
    def make_rollback_decision(self, incident):
        """Make rollback decision based on incident analysis."""
        
        decision = {
            'incident_id': incident.id,
            'decision_time': datetime.now(),
            'factors_considered': [],
            'confidence_score': 0.0,
            'action': 'monitor',  # Default
            'reasoning': '',
            'recommendations': []
        }
        
        # Collect decision factors
        factors = self._collect_decision_factors(incident)
        decision['factors_considered'] = factors
        
        # Apply decision rules
        rule_based_decision = self.decision_rules.apply_rules(factors)
        
        # Consider ML recommendation if available
        ml_recommendation = None
        if self.ml_model.is_trained():
            ml_recommendation = self.ml_model.recommend(factors)
        
        # Make final decision
        if rule_based_decision['confidence'] > 0.8:
            # High confidence rule-based decision
            final_decision = rule_based_decision
            decision['decision_method'] = 'rule_based'
        elif ml_recommendation and ml_recommendation['confidence'] > 0.7:
            # ML recommendation with good confidence
            final_decision = ml_recommendation
            decision['decision_method'] = 'ml_based'
        else:
            # Manual decision required
            final_decision = {
                'action': 'manual_review',
                'confidence': 0.5,
                'reasoning': 'Insufficient confidence for automated decision'
            }
            decision['decision_method'] = 'manual_required'
        
        # Populate decision details
        decision['action'] = final_decision['action']
        decision['confidence_score'] = final_decision['confidence']
        decision['reasoning'] = final_decision['reasoning']
        
        # Add specific recommendations
        if final_decision['action'] == 'rollback':
            decision['recommendations'] = self._generate_rollback_recommendations(
                incident, factors
            )
        elif final_decision['action'] == 'fix_forward':
            decision['recommendations'] = self._generate_fix_forward_recommendations(
                incident, factors
            )
        
        # Check for required manual approval
        if self._requires_manual_approval(final_decision, incident):
            decision['requires_approval'] = True
            decision['approvers'] = self._identify_approvers(incident)
        else:
            decision['requires_approval'] = False
        
        return decision
    
    def _collect_decision_factors(self, incident):
        """Collect all factors for decision making."""
        
        factors = {
            'severity': incident.severity,
            'impact': incident.analysis.get('impact_assessment', {}),
            'root_cause_confidence': self._assess_root_cause_confidence(incident),
            'time_since_deployment': self._calculate_time_since_deployment(incident),
            'rollback_complexity': self._assess_rollback_complexity(incident),
            'fix_forward_complexity': self._assess_fix_forward_complexity(incident),
            'business_context': self._get_business_context(incident),
            'historical_patterns': self._check_historical_patterns(incident),
            'time_of_day': datetime.now().hour,
            'day_of_week': datetime.now().weekday()
        }
        
        # Add metric-specific factors
        metrics_analysis = incident.analysis.get('metrics_analysis', {})
        for metric, analysis in metrics_analysis.items():
            factors[f'metric_{metric}'] = {
                'deviation': analysis.get('deviation'),
                'severity': analysis.get('severity'),
                'trend': analysis.get('trend', 'unknown')
            }
        
        return factors
    
    def _assess_root_cause_confidence(self, incident):
        """Assess confidence that root cause is deployment-related."""
        
        confidence = 0.0
        indicators = incident.analysis.get('root_cause_indicators', [])
        
        # Strong indicators
        strong_indicators = [
            'deployment_timing_correlation',
            'version_specific_error',
            'configuration_change_related',
            'new_feature_related_error'
        ]
        
        # Weak indicators  
        weak_indicators = [
            'increased_load_correlation',
            'infrastructure_issue',
            'third_party_dependency',
            'data_related_issue'
        ]
        
        # Calculate confidence based on indicators
        strong_count = sum(1 for i in indicators if i in strong_indicators)
        weak_count = sum(1 for i in indicators if i in weak_indicators)
        
        if strong_count > 0:
            confidence = 0.7 + (strong_count * 0.1)  # 0.7-0.9 for strong indicators
        elif weak_count > 0:
            confidence = 0.3 + (weak_count * 0.1)  # 0.3-0.5 for weak indicators
        
        # Adjust based on time since deployment
        time_since = self._calculate_time_since_deployment(incident)
        if time_since < timedelta(minutes=30):
            confidence *= 1.2  # Increase confidence for recent deployments
        elif time_since > timedelta(hours=24):
            confidence *= 0.8  # Decrease confidence for old deployments
        
        return min(0.95, confidence)  # Cap at 0.95
    
    def _assess_rollback_complexity(self, incident):
        """Assess complexity of potential rollback."""
        
        complexity = {
            'score': 0,  # 0-100, higher = more complex
            'factors': [],
            'estimated_duration': 'unknown',
            'risk_level': 'unknown'
        }
        
        deployment_type = incident.analysis.get('deployment_type', 'unknown')
        
        # Base complexity by deployment type
        type_complexity = {
            'blue_green': 20,
            'feature_flag': 10,
            'canary': 30,
            'rolling_update': 40,
            'database_migration': 80,
            'unknown': 50
        }
        
        complexity['score'] = type_complexity.get(deployment_type, 50)
        complexity['factors'].append(f"deployment_type: {deployment_type}")
        
        # Adjust for data considerations
        if incident.analysis.get('has_data_changes', False):
            complexity['score'] += 30
            complexity['factors'].append('data_changes_present')
        
        # Adjust for multiple services
        service_count = incident.analysis.get('affected_services_count', 1)
        if service_count > 1:
            complexity['score'] += (service_count - 1) * 10
            complexity['factors'].append(f"multiple_services: {service_count}")
        
        # Adjust for dependencies
        dependency_count = incident.analysis.get('dependency_count', 0)
        if dependency_count > 0:
            complexity['score'] += dependency_count * 5
            complexity['factors'].append(f"dependencies: {dependency_count}")
        
        # Categorize complexity
        if complexity['score'] < 30:
            complexity['risk_level'] = 'low'
            complexity['estimated_duration'] = '< 5 minutes'
        elif complexity['score'] < 60:
            complexity['risk_level'] = 'medium'
            complexity['estimated_duration'] = '5-15 minutes'
        else:
            complexity['risk_level'] = 'high'
            complexity['estimated_duration'] = '15+ minutes'
        
        return complexity
```

### Rollback Automation Framework

```python
class RollbackAutomationFramework:
    """Framework for automating rollback procedures."""
    
    def __init__(self):
        self.script_repository = ScriptRepository()
        self.execution_engine = ExecutionEngine()
        self.verification_engine = VerificationEngine()
        self.audit_logger = AuditLogger()
        
    def create_automated_rollback(self, deployment_spec):
        """Create automated rollback procedure for a deployment."""
        
        automation = {
            'deployment_id': deployment_spec['id'],
            'created_at': datetime.now(),
            'status': 'designing',
            'components': {}
        }
        
        # 1. Design rollback procedure
        procedure = self._design_rollback_procedure(deployment_spec)
        automation['procedure'] = procedure
        
        # 2. Generate automation scripts
        scripts = self._generate_rollback_scripts(procedure)
        automation['scripts'] = scripts
        
        # 3. Create verification checks
        verification_checks = self._create_verification_checks(procedure)
        automation['verification_checks'] = verification_checks
        
        # 4. Define triggers and thresholds
        triggers = self._define_rollback_triggers(deployment_spec)
        automation['triggers'] = triggers
        
        # 5. Test automation in staging
        test_result = self._test_automation_in_staging(automation)
        automation['test_result'] = test_result
        
        if test_result['success']:
            automation['status'] = 'tested'
            
            # 6. Deploy automation to production
            deployment_result = self._deploy_automation_to_production(automation)
            automation['deployment_result'] = deployment_result
            
            if deployment_result['success']:
                automation['status'] = 'active'
                automation['activated_at'] = datetime.now()
            else:
                automation['status'] = 'deployment_failed'
        else:
            automation['status'] = 'testing_failed'
        
        return automation
    
    def _design_rollback_procedure(self, deployment_spec):
        """Design rollback procedure for specific deployment."""
        
        procedure = {
            'name': f"rollback_{deployment_spec['id']}",
            'description': f"Rollback procedure for {deployment_spec['name']}",
            'assumptions': [],
            'preconditions': [],
            'steps': [],
            'postconditions': [],
            'safety_measures': []
        }
        
        # Analyze deployment to understand what needs rollback
        deployment_analysis = self._analyze_deployment_for_rollback(deployment_spec)
        
        # Design steps based on deployment type
        if deployment_analysis['type'] == 'application_deployment':
            procedure['steps'] = self._design_application_rollback_steps(
                deployment_analysis
            )
        elif deployment_analysis['type'] == 'database_migration':
            procedure['steps'] = self._design_database_rollback_steps(
                deployment_analysis
            )
        elif deployment_analysis['type'] == 'configuration_change':
            procedure['steps'] = self._design_configuration_rollback_steps(
                deployment_analysis
            )
        elif deployment_analysis['type'] == 'infrastructure_change':
            procedure['steps'] = self._design_infrastructure_rollback_steps(
                deployment_analysis
            )
        
        # Add safety measures
        procedure['safety_measures'] = self._design_safety_measures(
            deployment_analysis, procedure['steps']
        )
        
        # Define preconditions (what must be true before rollback)
        procedure['preconditions'] = self._define_preconditions(deployment_analysis)
        
        # Define postconditions (what should be true after rollback)
        procedure['postconditions'] = self._define_postconditions(deployment_analysis)
        
        return procedure
    
    def _design_application_rollback_steps(self, deployment_analysis):
        """Design rollback steps for application deployment."""
        
        steps = []
        
        # Step 1: Determine target version
        steps.append({
            'id': 'determine_target_version',
            'description': 'Identify previous stable version to rollback to',
            'action': 'query_version_history',
            'parameters': {
                'application': deployment_analysis['application'],
                'environment': deployment_analysis['environment'],
                'count': 2  # Get last 2 versions
            },
            'output_to': 'target_version',
            'timeout_seconds': 30
        })
        
        # Step 2: Redirect traffic (if load balancer)
        if deployment_analysis.get('has_load_balancer', False):
            steps.append({
                'id': 'redirect_traffic',
                'description': 'Redirect traffic away from current version',
                'action': 'update_load_balancer',
                'parameters': {
                    'load_balancer': deployment_analysis['load_balancer'],
                    'action': 'drain',
                    'target': deployment_analysis['current_version']
                },
                'verification': {
                    'type': 'traffic_check',
                    'threshold': 'traffic < 1%'
                },
                'timeout_seconds': 60
            })
        
        # Step 3: Deploy previous version
        steps.append({
            'id': 'deploy_previous_version',
            'description': 'Deploy previous stable version',
            'action': 'deploy_version',
            'parameters': {
                'application': deployment_analysis['application'],
                'version': '${target_version.previous}',
                'environment': deployment_analysis['environment']
            },
            'verification': {
                'type': 'deployment_status',
                'expected': 'healthy'
            },
            'timeout_seconds': 300  # 5 minutes
        })
        
        # Step 4: Restore traffic
        if deployment_analysis.get('has_load_balancer', False):
            steps.append({
                'id': 'restore_traffic',
                'description': 'Restore traffic to rolled back version',
                'action': 'update_load_balancer',
                'parameters': {
                    'load_balancer': deployment_analysis['load_balancer'],
                    'action': 'restore',
                    'target': '${target_version.previous}',
                    'weight': 100
                },
                'verification': {
                    'type': 'traffic_check',
                    'threshold': 'traffic > 99%'
                },
                'timeout_seconds': 30
            })
        
        # Step 5: Clean up failed version
        steps.append({
            'id': 'cleanup_failed_version',
            'description': 'Clean up resources from failed version',
            'action': 'cleanup_resources',
            'parameters': {
                'application': deployment_analysis['application'],
                'version': deployment_analysis['current_version'],
                'environment': deployment_analysis['environment']
            },
            'timeout_seconds': 120
        })
        
        return steps
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| No rollback plan | Can't recover quickly from failures | Always create and test rollback plan before deployment |
| Untested rollback procedures | Rollback may fail or cause more issues | Test rollback in staging environment |
| Manual rollback steps | Slow, error-prone, inconsistent | Automate rollback procedures |
| Ignoring data consistency | Data loss or corruption during rollback | Design data rollback strategies |
| No rollback triggers | Late detection, extended impact | Define clear metrics and thresholds |
| Over-complicated rollback | Takes too long, higher risk | Keep rollback simple and fast |
| Skipping verification | May leave system in bad state | Comprehensive post-rollback verification |
| No post-rollback analysis | Repeat same mistakes | Analyze and improve after each rollback |

### Red Flags

- No rollback procedure documented
- Rollback not tested before production
- Manual steps required for rollback
- No automated monitoring or triggers
- Data rollback not considered
- No verification of rollback success
- Rollback takes longer than deployment
- No learning from rollback experiences

## Real-World Impact

**Before (Chaotic Rollback):**
- Extended downtime during incidents
- Manual errors during recovery
- Data loss or corruption
- Repeated incidents with same root cause
- High stress for operations teams
- Business impact from extended outages
- No improvement in recovery processes

**After (Structured Rollback Management):**
- Rapid recovery from incidents (minutes vs hours)
- Consistent, reliable rollback procedures
- Data safety during rollback
- Continuous improvement from each incident
- Reduced stress for teams
- Minimal business impact from incidents
- Confidence in deployment safety

**Outcome:** Resilient systems with fast, reliable recovery capabilities and continuous improvement.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Minimize business impact during incidents
    - Align rollback strategies with business risk tolerance
    - Measure business metrics during rollback recovery
    
  metrics:
    - Track rollback success rates and duration
    - Measure time to detect and decision making
    - Monitor recovery effectiveness metrics
    
  architecture:
    - Design for rollback capability
    - Architecture supports safe rollback procedures
    - Technology choices enable automated rollback
    
  data:
    - Rollback data for analytics and improvement
    - Performance data for rollback decisions
    - Business data for impact analysis
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include rollback requirements in deployment specs
    - Define rollback procedures and success criteria
    - Specify monitoring and trigger thresholds
  
  constitution:
    - "Safe Evolution" principle requires rollback capability
    - Rollback safety as constitutional requirement
    - Verification and validation in constitution
  
  traceability:
    - Link rollback procedures to deployments
    - Track rollback outcomes for process improvement
    - Update specifications based on rollback learnings
```

### Deployment Orchestrator Integration

```yaml
deployment_integration:
  coordination:
    - deployment-orchestrator executes deployments
    - rollback-manager provides rollback capability
    - Continuous feedback between deployment and rollback
  
  safety:
    - Rollback plan created for each deployment
    - Automated rollback triggers integrated
    - Verification after both deployment and rollback
  
  metrics_sharing:
    - Deployment metrics inform rollback planning
    - Rollback outcomes inform deployment strategies
    - Shared metrics for continuous improvement
```

### Incident Management Integration

```yaml
incident_management_integration:
  process:
    - incident-management detects and classifies incidents
    - rollback-manager handles deployment-related incidents
    - Coordinated response and communication
  
  workflow:
    - Detect → Analyze → Decide → Execute → Verify → Learn
    - Seamless handoff between incident and rollback management
  
  communication:
    - Shared status updates during rollback
    - Coordinated stakeholder communication
    - Unified post-incident reporting
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Rollback Management"
  triggers:
    - deployment_failure_detected
    - production_incident_requires_rollback
    - monitoring_thresholds_exceeded
  
  skills_chain:
    - rollback-manager (primary execution)
    - incident-management (incident handling)
    - deployment-orchestrator (deployment coordination)
    - metrics-definer (monitoring and verification)
  
  outputs:
    - rollback_execution_report
    - post_rollback_verification
    - incident_resolution_documentation
    - process_improvement_recommendations
  
  feedback_loop:
    - incident → rollback → analyze → improve → prevent
```