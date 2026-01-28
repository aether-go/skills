---
name: deployment-orchestrator
description: Use when orchestrating complex deployments across multiple environments with strategies like blue-green, canary, rolling updates, and feature flags
---

# Deployment Orchestrator

## Overview
Orchestrate complex deployments across multiple environments using modern deployment strategies. Manage the entire deployment pipeline from build to production with safety gates, automated testing, and progressive rollout.

## When to Use

```
Complex deployment needed? ────────┐
                                   │
Multiple environments? ────────────┤
                                   ├─► Use deployment-orchestrator
Advanced strategies required? ─────┤
                                   │
Safety and rollback critical? ─────┘
```

Use when:
- Deploying to multiple environments (dev, staging, production)
- Implementing blue-green, canary, or rolling deployments
- Coordinating deployments across microservices
- Managing feature flags and gradual rollouts
- Ensuring deployment safety with automated gates
- Handling database migrations with application deployments
- Deploying to multiple regions or cloud providers
- Implementing GitOps or infrastructure as code deployments

Don't use when:
- Simple single-service deployments to development
- Manual deployments for testing purposes
- Infrastructure provisioning only (use IaC tools)
- Configuration changes without code deployment

## Core Pattern

### Modern Deployment Pipeline

```
Code Commit → Build → Test → Package → Deploy to Dev → Automated Testing → Promote to Staging
    ↓           ↓       ↓        ↓           ↓                ↓                   ↓
Version      Artifact Unit &   Docker    Environment     Integration      Performance &
Control      Creation Integration Images  Provisioning     Tests          Load Tests
             ↓       Tests      ↓           ↓                ↓                   ↓
         Registry   Quality   Container   Configuration   Validation       Validation
                    Gates     Registry      Management                     Gates
                              ↓
                     Deploy to Production → Monitor → Verify → Complete or Rollback
                              ↓                ↓         ↓             ↓
                        Selected Strategy  Metrics   Health     Success/Failure
                        (Canary, Blue-Green)        Checks     Handling
```

### Before (Manual Deployment)
```yaml
Scenario: Deploying v1.2.0 of user service
Approach:
  - Developer builds locally, creates artifact
  - Manual copy to server
  - Stop service, deploy, start service
  - Manual testing in production
  - No rollback plan
  - All users experience downtime
  - Issues affect 100% of users immediately
Result: High risk, potential extended downtime, poor user experience
```

### After (Orchestrated Deployment)
```yaml
Scenario: Deploying v1.2.0 of user service
Process:
  1. Pipeline Trigger:
     - Code merged to main, pipeline automatically starts
     - Build, test, package stages complete (15 minutes)
     
  2. Environment Deployment:
     - Dev: Automatic deployment, automated tests pass
     - Staging: Manual approval, performance tests pass
     
  3. Production Deployment Strategy (Canary):
     - Phase 1: Deploy to 5% of users, monitor metrics
     - Metrics: Error rate < 0.1%, latency < 200ms P95
     - Phase 2: Increase to 25% of users, continue monitoring
     - Phase 3: Increase to 50% of users
     - Phase 4: Full rollout to 100% of users
     
  4. Safety Gates:
     - Automated health checks after each phase
     - Business metric monitoring (conversion rate, revenue)
     - Automated rollback if metrics degrade
     - Manual override available at any phase
     
  5. Completion:
     - Deployment completed in 60 minutes
     - Zero downtime for users
     - Issues limited to 5% of users initially
     - Full observability throughout process
     - Automated documentation and notification

Outcome: Safe, controlled, observable deployment with minimal risk.
```

## Quick Reference

### Deployment Strategies

| Strategy | Best For | Risk | Downtime | Rollback Complexity |
|----------|----------|------|----------|---------------------|
| **Recreate** | Simple apps, scheduled maintenance | High | Full | Easy |
| **Rolling Update** | Stateless services, backward compatible | Medium | None | Medium |
| **Blue-Green** | Critical services, zero downtime | Low | None | Easy |
| **Canary** | User-facing services, risk reduction | Low | None | Easy |
| **A/B Testing** | Feature experimentation | Low | None | Easy |
| **Feature Flags** | Progressive feature rollout | Very Low | None | Very Easy |

### Deployment Safety Gates

```yaml
safety_gates:
  pre_deployment:
    - code_quality: "SonarQube score > A"
    - test_coverage: "> 80% unit test coverage"
    - security_scan: "No critical vulnerabilities"
    - integration_tests: "All integration tests pass"
    - performance_baseline: "Within 10% of baseline"
    
  during_deployment:
    - health_checks: "All pods/containers healthy"
    - readiness_probes: "Services reporting ready"
    - dependency_checks: "Dependent services available"
    - configuration_checks: "Configuration applied correctly"
    
  post_deployment:
    - smoke_tests: "Critical user journeys work"
    - business_metrics: "No degradation in KPIs"
    - error_rate: "Error rate < 0.1%"
    - latency: "P95 latency < SLA threshold"
    - resource_usage: "CPU/memory within limits"
    
  rollback_triggers:
    - error_rate_increase: "> 1% for 5 minutes"
    - latency_increase: "> 50% for 5 minutes"
    - health_check_failure: "> 30% unhealthy for 3 minutes"
    - business_metric_degradation: "> 10% drop in conversions"
    - manual_rollback_request: "Authorized personnel request"
```

### Multi-Environment Deployment Matrix

```yaml
environments:
  development:
    purpose: "Developer testing and integration"
    deployment: "Automatic on every merge"
    testing: "Unit and integration tests"
    scale: "Small, single instance"
    data: "Synthetic or sanitized"
    
  staging:
    purpose: "Pre-production validation"
    deployment: "Automatic after dev approval"
    testing: "Integration, performance, security"
    scale: "Production-like but smaller"
    data: "Sanitized production-like"
    
  production:
    purpose: "Live user traffic"
    deployment: "Controlled with strategies"
    testing: "Canary, A/B, smoke tests"
    scale: "Full production scale"
    data: "Live production data"
    
  disaster_recovery:
    purpose: "Business continuity"
    deployment: "Mirror of production"
    testing: "Failover and recovery tests"
    scale: "Production scale"
    data: "Replicated from production"
```

## Implementation

### Deployment Orchestrator Engine

```python
class DeploymentOrchestrator:
    """Orchestrate complex deployments across environments."""
    
    def __init__(self, config):
        self.config = config
        self.environment_manager = EnvironmentManager()
        self.deployment_strategies = DeploymentStrategies()
        self.monitoring_integration = MonitoringIntegration()
        self.rollback_manager = RollbackManager()
        
    def execute_deployment_pipeline(self, deployment_spec):
        """Execute complete deployment pipeline."""
        
        deployment = Deployment(
            spec=deployment_spec,
            start_time=datetime.now(),
            status='initializing'
        )
        
        try:
            # Stage 1: Pre-deployment validation
            self._validate_deployment_spec(deployment_spec)
            deployment.status = 'validated'
            
            # Stage 2: Build and package
            artifacts = self._build_and_package(deployment_spec)
            deployment.artifacts = artifacts
            deployment.status = 'built'
            
            # Stage 3: Deploy to development
            dev_result = self._deploy_to_environment(
                environment='development',
                artifacts=artifacts,
                strategy='recreate'
            )
            deployment.add_environment_result('development', dev_result)
            
            # Stage 4: Run automated tests
            test_results = self._run_automated_tests(deployment_spec)
            if not test_results['success']:
                raise DeploymentError(f"Tests failed: {test_results['failures']}")
            deployment.test_results = test_results
            deployment.status = 'tested'
            
            # Stage 5: Deploy to staging
            staging_result = self._deploy_to_environment(
                environment='staging',
                artifacts=artifacts,
                strategy='blue-green'
            )
            deployment.add_environment_result('staging', staging_result)
            
            # Stage 6: Performance and integration tests
            perf_results = self._run_performance_tests(deployment_spec)
            deployment.performance_results = perf_results
            
            # Stage 7: Production deployment with selected strategy
            prod_strategy = deployment_spec.get('production_strategy', 'canary')
            prod_result = self._deploy_to_production(
                artifacts=artifacts,
                strategy=prod_strategy,
                parameters=deployment_spec.get('strategy_parameters', {})
            )
            deployment.add_environment_result('production', prod_result)
            deployment.status = 'deployed'
            
            # Stage 8: Post-deployment verification
            verification = self._verify_deployment(deployment_spec)
            deployment.verification = verification
            
            if verification['success']:
                deployment.status = 'completed'
                deployment.end_time = datetime.now()
                deployment.success = True
            else:
                deployment.status = 'verification_failed'
                deployment.success = False
                
                # Automatic rollback if configured
                if deployment_spec.get('auto_rollback_on_failure', True):
                    rollback_result = self.rollback_manager.execute_rollback(
                        deployment_id=deployment.id,
                        reason='verification_failed'
                    )
                    deployment.rollback = rollback_result
                    
        except Exception as e:
            deployment.status = 'failed'
            deployment.error = str(e)
            deployment.end_time = datetime.now()
            deployment.success = False
            
            # Emergency rollback
            if deployment_spec.get('auto_rollback_on_failure', True):
                self.rollback_manager.emergency_rollback(deployment)
        
        return deployment
    
    def _deploy_to_production(self, artifacts, strategy='canary', parameters=None):
        """Deploy to production using specified strategy."""
        
        strategy_executor = self.deployment_strategies.get_executor(strategy)
        
        deployment_plan = strategy_executor.create_plan(
            artifacts=artifacts,
            parameters=parameters or {}
        )
        
        execution_result = {
            'strategy': strategy,
            'plan': deployment_plan,
            'phases': [],
            'metrics': {},
            'decisions': []
        }
        
        # Execute each phase of the strategy
        for phase in deployment_plan['phases']:
            phase_result = self._execute_deployment_phase(phase)
            execution_result['phases'].append(phase_result)
            
            # Monitor during phase
            monitoring_data = self.monitoring_integration.monitor_during_deployment(
                phase=phase,
                duration=phase_result.get('duration')
            )
            
            # Make continue/rollback decision
            decision = self._make_deployment_decision(
                phase_result, monitoring_data, parameters
            )
            execution_result['decisions'].append(decision)
            
            if decision['action'] == 'rollback':
                execution_result['rolled_back'] = True
                execution_result['rollback_phase'] = phase['name']
                execution_result['rollback_reason'] = decision['reason']
                break
            elif decision['action'] == 'pause':
                execution_result['paused'] = True
                # Wait for manual intervention
                manual_decision = self._await_manual_decision(phase)
                if manual_decision == 'continue':
                    continue
                else:
                    execution_result['rolled_back'] = True
                    break
            elif decision['action'] == 'continue':
                continue
        
        execution_result['success'] = not execution_result.get('rolled_back', False)
        
        return execution_result
    
    def _execute_deployment_phase(self, phase):
        """Execute a single deployment phase."""
        
        phase_result = {
            'name': phase['name'],
            'start_time': datetime.now(),
            'actions': [],
            'status': 'in_progress'
        }
        
        for action in phase['actions']:
            action_result = self._execute_deployment_action(action)
            phase_result['actions'].append(action_result)
            
            if not action_result['success']:
                phase_result['status'] = 'failed'
                phase_result['error'] = action_result.get('error')
                break
        
        if phase_result['status'] != 'failed':
            phase_result['status'] = 'completed'
        
        phase_result['end_time'] = datetime.now()
        phase_result['duration'] = phase_result['end_time'] - phase_result['start_time']
        
        return phase_result
    
    def _make_deployment_decision(self, phase_result, monitoring_data, parameters):
        """Make continue/rollback/pause decision based on phase results."""
        
        decision = {
            'phase': phase_result['name'],
            'timestamp': datetime.now(),
            'monitoring_data': monitoring_data
        }
        
        # Check if phase failed
        if phase_result['status'] == 'failed':
            decision['action'] = 'rollback'
            decision['reason'] = 'phase_execution_failed'
            decision['details'] = phase_result.get('error')
            return decision
        
        # Check metrics against thresholds
        thresholds = parameters.get('thresholds', {})
        
        if 'error_rate' in monitoring_data:
            error_threshold = thresholds.get('error_rate', 0.01)  # 1%
            if monitoring_data['error_rate'] > error_threshold:
                decision['action'] = 'rollback'
                decision['reason'] = 'error_rate_exceeded'
                decision['details'] = f"{monitoring_data['error_rate']} > {error_threshold}"
                return decision
        
        if 'latency_p95' in monitoring_data:
            latency_threshold = thresholds.get('latency_p95', 1.5)  # 150% increase
            baseline = monitoring_data.get('baseline_latency')
            if baseline and monitoring_data['latency_p95'] > baseline * latency_threshold:
                decision['action'] = 'pause'
                decision['reason'] = 'latency_degradation'
                decision['details'] = f"P95 latency increased by {(monitoring_data['latency_p95']/baseline - 1)*100:.1f}%"
                return decision
        
        if 'business_metrics' in monitoring_data:
            business_threshold = thresholds.get('business_metric_degradation', 0.1)  # 10%
            for metric, value in monitoring_data['business_metrics'].items():
                baseline = monitoring_data.get('baseline_business_metrics', {}).get(metric)
                if baseline and value < baseline * (1 - business_threshold):
                    decision['action'] = 'pause'
                    decision['reason'] = 'business_metric_degradation'
                    decision['details'] = f"{metric} degraded by {(1 - value/baseline)*100:.1f}%"
                    return decision
        
        # Check manual intervention required
        if parameters.get('require_manual_approval', False) and phase_result['name'] == 'full_rollout':
            decision['action'] = 'pause'
            decision['reason'] = 'manual_approval_required'
            decision['details'] = 'Waiting for manual approval before full rollout'
            return decision
        
        # Default to continue
        decision['action'] = 'continue'
        decision['reason'] = 'all_checks_passed'
        
        return decision
```

### Deployment Strategies Implementation

```python
class DeploymentStrategies:
    """Implement various deployment strategies."""
    
    def get_executor(self, strategy_name):
        """Get executor for specific deployment strategy."""
        
        if strategy_name == 'canary':
            return CanaryDeploymentExecutor()
        elif strategy_name == 'blue-green':
            return BlueGreenDeploymentExecutor()
        elif strategy_name == 'rolling':
            return RollingDeploymentExecutor()
        elif strategy_name == 'recreate':
            return RecreateDeploymentExecutor()
        elif strategy_name == 'feature-flag':
            return FeatureFlagDeploymentExecutor()
        else:
            raise ValueError(f"Unknown deployment strategy: {strategy_name}")
    
    class CanaryDeploymentExecutor:
        """Execute canary deployments with progressive traffic shifting."""
        
        def create_plan(self, artifacts, parameters):
            """Create canary deployment plan."""
            
            phases = []
            
            # Phase 1: Initial canary (small percentage)
            phases.append({
                'name': 'canary_5_percent',
                'percentage': parameters.get('initial_percentage', 5),
                'duration_minutes': parameters.get('canary_duration', 15),
                'actions': [
                    self._create_deploy_action(artifacts, 'canary'),
                    self._create_traffic_shift_action(5)
                ]
            })
            
            # Phase 2: Expand canary
            phases.append({
                'name': 'canary_25_percent',
                'percentage': 25,
                'duration_minutes': parameters.get('expansion_duration', 15),
                'actions': [
                    self._create_traffic_shift_action(25)
                ]
            })
            
            # Phase 3: Majority traffic
            phases.append({
                'name': 'canary_50_percent',
                'percentage': 50,
                'duration_minutes': parameters.get('majority_duration', 30),
                'actions': [
                    self._create_traffic_shift_action(50)
                ]
            })
            
            # Phase 4: Full rollout
            phases.append({
                'name': 'full_rollout',
                'percentage': 100,
                'actions': [
                    self._create_traffic_shift_action(100),
                    self._create_cleanup_action()
                ]
            })
            
            return {
                'strategy': 'canary',
                'phases': phases,
                'total_duration_estimate': sum(p.get('duration_minutes', 0) for p in phases),
                'rollback_plan': self._create_rollback_plan(artifacts)
            }
        
        def _create_traffic_shift_action(self, percentage):
            """Create action to shift traffic percentage."""
            
            return {
                'type': 'traffic_shift',
                'percentage': percentage,
                'implementation': 'load_balancer_rules'  # or service mesh, API gateway, etc.
            }
    
    class BlueGreenDeploymentExecutor:
        """Execute blue-green deployments with instant switchover."""
        
        def create_plan(self, artifacts, parameters):
            """Create blue-green deployment plan."""
            
            phases = []
            
            # Phase 1: Deploy green environment
            phases.append({
                'name': 'deploy_green',
                'actions': [
                    self._create_deploy_action(artifacts, 'green'),
                    self._create_test_action('green')
                ]
            })
            
            # Phase 2: Smoke test green
            phases.append({
                'name': 'smoke_test_green',
                'duration_minutes': parameters.get('smoke_test_duration', 10),
                'actions': [
                    self._create_smoke_test_action('green')
                ]
            })
            
            # Phase 3: Switch traffic
            phases.append({
                'name': 'switch_traffic',
                'actions': [
                    self._create_traffic_switch_action('green')
                ]
            })
            
            # Phase 4: Cleanup blue
            phases.append({
                'name': 'cleanup_blue',
                'delay_minutes': parameters.get('cleanup_delay', 60),  # Wait before cleanup
                'actions': [
                    self._create_cleanup_action('blue')
                ]
            })
            
            return {
                'strategy': 'blue-green',
                'phases': phases,
                'rollback_plan': self._create_rollback_plan(artifacts, 'blue')  # Switch back to blue
            }
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Big bang deployments | High risk, affects all users at once | Use progressive rollout strategies |
| No rollback plan | Can't recover from failed deployments | Always have tested rollback procedures |
| Ignoring database migrations | Data inconsistencies, failed deployments | Coordinate app and database deployments |
| No health checks | Deploy broken code without knowing | Implement comprehensive health checks |
| Manual deployment steps | Inconsistent, error-prone, slow | Automate entire deployment pipeline |
| No metrics monitoring | Can't make data-driven decisions | Monitor both technical and business metrics |
| Skipping staging | Production as test environment | Use staging for thorough testing |
| No deployment verification | Assume success without validation | Verify deployment with automated tests |

### Red Flags

- Manual deployment steps
- No rollback capability
- All-or-nothing deployments
- No health checks or monitoring
- Database changes without coordination
- No staging environment
- Long deployment windows
- Frequent deployment failures
- No deployment metrics

## Real-World Impact

**Before (Manual, Risky Deployments):**
- Frequent production outages
- Long deployment windows with downtime
- High stress during deployments
- Rollbacks difficult or impossible
- Inconsistent environments
- Slow release velocity
- Fear of deploying

**After (Orchestrated, Safe Deployments):**
- Zero-downtime deployments
- Confident, frequent releases
- Automated rollbacks when needed
- Consistent environments
- Fast release velocity
- Data-driven deployment decisions
- Happy teams and users

**Outcome:** Reliable, fast, safe software delivery.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Schedule deployments during low business impact times
    - Measure business metrics during deployments
    - Align deployment strategies with business risk tolerance
    
  metrics:
    - Track deployment success rates
    - Measure deployment duration and frequency
    - Monitor business metrics during deployments
    
  architecture:
    - Design for deployability and rollback
    - Architecture supports deployment strategies
    - Technology choices enable safe deployments
    
  data:
    - Deployment data for analytics
    - Performance data for deployment decisions
    - Business data for impact analysis
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include deployment requirements in specs
    - Define deployment strategies and procedures
    - Specify health checks and monitoring
    
  constitution:
    - "Safe Evolution" principle enforcement
    - Deployment safety as constitutional requirement
    - Rollback capability in constitution
    
  traceability:
    - Link deployments to specifications
    - Track deployment outcomes for specification updates
    - Update specifications based on deployment learnings
```

### Change Management Integration

```yaml
change_management_integration:
  process:
    - Deployment as change request
    - Risk assessment for deployments
    - CAB approval for major deployments
    
  coordination:
    - Coordinate deployment with change windows
    - Integrate deployment with change tracking
    - Post-deployment reviews as change verification
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Deployment & Metrics"
  triggers:
    - code_ready_for_deployment
    - scheduled_deployment_window
    - emergency_fix_required
    
  skills_chain:
    - deployment-orchestrator (primary)
    - change-management (for approval)
    - metrics-definer (for monitoring)
    - incident-management (for rollback handling)
    
  outputs:
    - deployment_execution_report
    - deployment_metrics
    - rollback_report_if_needed
    - post_deployment_verification
    
  feedback_loop:
    - deploy → monitor → verify → optimize → next_deployment
```