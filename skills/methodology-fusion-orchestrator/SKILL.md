---
name: methodology-fusion-orchestrator
description: Use when orchestrating end-to-end software lifecycle with Aether.go methodology fusion framework across all eight stages
---

# Methodology Fusion Orchestrator

## Overview
Orchestrate the complete Aether.go methodology fusion workflow across all eight stages: business analysis, specification definition, constitutional review, implementation planning, code generation, integration validation, deployment operations, and recursive optimization. Ensures constitutional principles are enforced, metrics are aggregated, and feedback loops drive continuous improvement.

## When to Use

```
Need end-to-end methodology fusion? ─────┐
                                         │
Complex project with multiple stages? ────┤
                                         ├─► Use methodology-fusion-orchestrator
Constitutional compliance critical? ──────┤
                                         │
Require automated feedback loops? ───────┘
```

Use when:
- Starting a new project requiring full methodology compliance
- Coordinating complex development across multiple teams
- Ensuring constitutional principles are enforced throughout lifecycle
- Need automated metrics aggregation and feedback loops
- Managing large-scale software development with quality gates
- Implementing Aether.go methodology fusion framework
- Need intelligent skill scheduling and coordination

Don't use when:
- Simple bug fixes or minor enhancements
- Single skill can accomplish the task
- Project already has established methodology not based on Aether.go
- Time constraints prevent full methodology implementation

## Core Pattern

### Eight-Stage Methodology Fusion Workflow

```
User Request → Orchestrator → Stage Analysis → Skill Scheduling → Constitution Check
      ↑                                                                     ↓
      └── Metrics Collection ← Execution ← Context Management ←──┘
                              ↓
                      Optimization Analysis
                              ↓
                      Skill Improvement
                              ↓
                      Constitution Evolution
```

### Before (Fragmented Approach)
```
Business team: "We need a user authentication system"
Developers: Write code based on assumptions
Testers: Find issues after implementation
Ops team: Deploy with performance problems
Result: Misalignment, rework, quality issues
```

### After (Orchestrated Fusion)
```yaml
# Orchestrator Workflow Execution
workflow_id: "WF-AUTH-2025-001"
phases_executed:
  - phase_1_business_analysis:
      skill: business-requirements-collector
      input: "User authentication system"
      output: Structured business requirements
      skill: business-value-mapper
      input: Structured requirements
      output: BMAD matrix with metrics
      constitution_check: passed
      duration: "2h"
    
  - phase_2_specification_definition:
      skill: spec-parser
      input: BMAD matrix
      output: Structured specifications
      skill: bdd-scenario-writer
      input: Structured specifications
      output: Gherkin scenarios
      skill: atdd-acceptance-test-generator
      input: Gherkin scenarios
      output: Executable acceptance tests
      constitution_check: passed
      duration: "3h"
    
  - phase_3_constitutional_review:
      skill: constitution-validator
      input: Specifications + scenarios
      output: Compliance report (92% score)
      issues: 2 warnings, 0 errors
      duration: "1h"
    
  - phase_4_implementation_planning:
      skill: architecture-pattern-selector
      input: Validated specifications
      output: Selected architecture pattern
      skill: architecture-decision-recorder
      input: Selected pattern + specifications
      output: Architecture decisions + ADRs
      skill: data-flow-analyzer
      input: Architecture decisions
      output: Data flow diagrams
      duration: "4h"
    
  - phase_5_code_generation:
      skill: tdd-red-green-refactor
      input: Implementation plan
      output: Test-driven code
      skill: go-backend-scaffolder
      output: Clean architecture Go code
      skill: vue-quasar-scaffolder
      output: Vue 3 + Quasar components
      constitution_check: passed
      duration: "16h"
    
  - phase_6_integration_validation:
      skill: sit-scenario-generator
      input: Complete system
      output: Integration test scenarios
      skill: contract-test-generator
      input: API specifications
      output: Contract tests for microservices
      skill: chaos-test-designer
      input: Integration tests
      output: Resilience test plans
      duration: "8h"
    
  - phase_7_deployment_operations:
      skill: deployment-orchestrator
      input: Validated system
      output: Deployed system with canary/blue-green strategy
      skill: incident-management
      output: Incident response procedures, on-call rotations
      skill: change-management
      output: CAB-approved change plans, rollback procedures
      skill: release-manager
      output: Release calendar, stakeholder communications
      skill: metrics-definer
      output: Business + technical metrics dashboard
      skill: problem-management
      output: Root cause analyses, permanent fixes
      skill: service-desk
      output: Service catalog, SLA agreements
      skill: rollback-manager
      output: Automated rollback procedures
      duration: "8h"
    
  - phase_8_recursive_optimization:
      skill: recursive-optimizer
      input: All metrics + feedback
      output: Optimization recommendations
      skill_improvements: 3 skills updated
      constitution_evolution: 1 principle refined
      assetizations:
        - type: skill_assetization
          skill: tdd-red-green-refactor
          asset_id: tdd-red-green-refactor_a3f7b2c1
          quality_score: 0.94
          promoted_to_library: true
        - type: workflow_assetization
          pattern_id: workflow_parallel_exec_8d4e5f6g
          quality_score: 0.88
      duration: "4h"

metrics_summary:
  total_duration: "46h"
  constitutional_compliance: "96%"
  requirement_traceability: "100%"
  test_coverage: "92%"
  business_value_alignment: "94%"
  optimization_impact: "18% efficiency gain"
  assets_created: 2
  assets_promoted: 1
```

## Quick Reference

### Stage-to-Skill Mapping

| Stage | Primary Skills | Supporting Skills | Output |
|-------|---------------|-------------------|--------|
| **1. Business Analysis** | business-requirements-collector, business-value-mapper | metrics-definer | Structured requirements + BMAD matrix |
| **2. Specification** | spec-parser, bdd-scenario-writer, atdd-acceptance-test-generator | - | Structured specs + scenarios + acceptance tests |
| **3. Constitutional Review** | constitution-validator | architecture-decision-recorder | Compliance report |
| **4. Implementation Planning** | architecture-pattern-selector, architecture-decision-recorder | data-flow-analyzer | Architecture pattern + ADRs + data flows |
| **5. Code Generation** | tdd-red-green-refactor, go-backend-scaffolder, vue-quasar-scaffolder | spec-to-code-tracer | Test-driven code |
| **6. Integration Validation** | sit-scenario-generator, contract-test-generator, chaos-test-designer | test-pyramid-analyzer | Integration + contract + resilience tests |
| **7. Deployment & Operations** | deployment-orchestrator, incident-management, change-management, release-manager | metrics-definer, problem-management, service-desk, rollback-manager | Deployment execution, ITIL operations, metrics dashboard |
| **8. Recursive Optimization** | recursive-optimizer | prompt-template-manager, skill-recommender | Optimized skills |

### Constitutional Principles Enforcement

```yaml
constitution_enforcement:
  stage_1_business_analysis:
    - principle: "Value-Driven Development"
      check: "Every business goal has measurable metrics"
      enforcement: strict
    
  stage_2_specification:
    - principle: "Test-First Development"
      check: "All specs include testable acceptance criteria"
      enforcement: strict
    
  stage_3_review:
    - principle: "Architectural Consistency"
      check: "All decisions recorded and justified"
      enforcement: strict
    
  stage_4_planning:
    - principle: "Interface-First Development"
      check: "All interfaces defined before implementation"
      enforcement: strict
    - principle: "Simplicity & YAGNI"
      check: "No over-engineering, only needed features"
      enforcement: warning
    
  stage_5_development:
    - principle: "Code Quality & Standards"
      check: "All code follows TDD and style guides"
      enforcement: strict
    
  stage_6_validation:
    - principle: "Resilience & Reliability"
      check: "Integration and chaos tests defined"
      enforcement: strict
    
  stage_7_deployment:
    - principle: "Observability & Monitoring"
      check: "Metrics and monitoring configured"
      enforcement: strict
    - principle: "Deployment Safety"
      check: "Rollback procedures tested and available"
      enforcement: strict
    - principle: "Incident Response"
      check: "Incident management procedures defined"
      enforcement: strict
    - principle: "Change Control"
      check: "Change management processes followed"
      enforcement: strict
    - principle: "Service Continuity"
      check: "Problem and service desk management established"
      enforcement: strict
    
  stage_8_optimization:
    - principle: "Continuous Improvement"
      check: "Feedback loops established and active"
      enforcement: strict
  
  cross_stage:
    - principle: "Human-AI Responsibility Boundary"
      check: "All AI-generated artifacts reviewed by human"
      enforcement: strict
```

### Orchestrator Configuration

```yaml
# .aether/orchestrator-config.yaml
orchestrator:
  version: "1.0"
  project_type: "fullstack-web"
  methodology_version: "aether-go-2.0"
  
  stages:
    enabled: [1, 2, 3, 4, 5, 6, 7, 8]
    mandatory: [1, 2, 3, 5, 7]  # Must complete these stages
    
  constitution:
    file: "./constitution.yaml"
    strict_mode: true
    auto_evolve: true
    evolution_threshold: 0.85  # 85% success rate triggers evolution
    evolution:
      triggers:
        - type: "compliance_threshold"
          condition: "constitutional_compliance > 0.85"
          action: "propose_evolution"
        - type: "feedback_pattern"
          condition: "consistent_success_pattern_detected"
          action: "analyze_and_evolve"
        - type: "business_value"
          condition: "business_value_alignment < 0.8"
          action: "review_and_adjust"
      evolution_process:
        - analyze_patterns
        - propose_changes
        - human_review
        - apply_evolution
        - track_impact
      rollback:
        enabled: true
        conditions:
          - "new_compliance < old_compliance"
          - "business_value_decrease > 0.1"
        automatic: false
        approval_required: true
    
  metrics:
    collection_points:
      - stage_start
      - skill_execution
      - constitution_check
      - stage_completion
    aggregation: realtime
    dashboard: auto_generate
    
  optimization:
    enabled: true
    frequency: "after_each_stage"
    scope: ["skills", "constitution", "workflow"]
    approval: "auto_on_small, manual_on_major"
    
  skill_effectiveness:
    tracking:
      - success_rate
      - execution_time
      - output_quality
      - constitution_compliance
      - user_satisfaction
    reporting:
      frequency: "daily"
      dashboard: true
      alerts:
        - condition: "success_rate < 0.7"
          action: "notify_team"
        - condition: "execution_time > threshold"
          action: "optimize_skill"
        - condition: "constitution_compliance < 0.9"
          action: "block_deployment"
    analysis:
      trend_analysis: true
      anomaly_detection: true
      comparative_analysis: true
      benchmarking: true
    
  visualization:
    enabled: true
    views:
      - workflow_progress
      - constitution_compliance
      - skill_effectiveness
      - metrics_dashboard
      - traceability_graph
      - asset_library
    export_formats:
      - html
      - json
      - svg
      - pdf
    real_time_updates: true
    interactive_drill_down: true
    
  collaboration:
    team_management:
      enabled: true
      roles:
        - business_analyst
        - architect
        - developer
        - tester
        - ops_engineer
    approvals:
      required_stages: [3, 7]
      approvers:
        stage_3: ["architect"]
        stage_7: ["tech_lead", "ops_lead"]
      notification:
        channels: ["email", "slack", "webhook"]
        timeout_hours: 24
    comments:
      enabled: true
      threaded: true
      mention_support: true
    
  skill_scheduling:
    algorithm: "context_aware"
    factors: ["success_rate", "relevance", "efficiency"]
    fallback: "skill-recommender"
    
  context_management:
    persistence: true
    sharing: "cross_stage"
    summarization: "auto"
    assetization:
      enabled: true
      quality_threshold: 0.85
      auto_promote: true
    versioning:
      enabled: true
      retention_days: 90
    sharing:
      enabled: true
      scope: ["project", "team", "organization"]
      access_control: true
```

## Implementation

### Orchestrator Engine

```python
class MethodologyFusionOrchestrator:
    """Main orchestrator coordinating all eight stages."""
    
    def __init__(self, project_context, constitution):
        self.project_context = project_context
        self.constitution = constitution
        self.metrics_collector = MetricsCollector()
        self.skill_scheduler = SkillScheduler()
        self.context_manager = ContextManager()
        self.skill_assetizer = SkillAssetizer()
        self.optimization_analyzer = OptimizationAnalyzer()
        self.recursive_optimizer = RecursiveOptimizer()
        self.workflow_optimizer = WorkflowOptimizer()
        
    def execute_workflow(self, user_request):
        """Execute complete eight-stage workflow."""
        
        workflow_result = {
            'id': generate_workflow_id(),
            'start_time': datetime.now(),
            'stages': [],
            'metrics': {},
            'optimizations': []
        }
        
        # Stage 1: Business Analysis
        stage1_result = self._execute_stage(
            stage_id=1,
            skills=['business-requirements-collector', 'business-value-mapper', 'metrics-definer'],
            input=user_request,
            constitution_checks=['Value-Driven Development']
        )
        workflow_result['stages'].append(stage1_result)
        
        # Stage 2: Specification Definition
        stage2_result = self._execute_stage(
            stage_id=2,
            skills=['spec-parser', 'bdd-scenario-writer', 'atdd-acceptance-test-generator'],
            input=stage1_result['output'],
            constitution_checks=['Test-First Development']
        )
        workflow_result['stages'].append(stage2_result)
        
        # Stage 3: Constitutional Review
        stage3_result = self._execute_stage(
            stage_id=3,
            skills=['constitution-validator'],
            input={
                'specs': stage2_result['output'],
                'business_context': stage1_result['context']
            },
            constitution_checks=['Architectural Consistency']
        )
        workflow_result['stages'].append(stage3_result)
        
        # Stage 4: Implementation Planning
        stage4_result = self._execute_stage(
            stage_id=4,
            skills=['architecture-pattern-selector', 'architecture-decision-recorder', 'data-flow-analyzer'],
            input=stage3_result['validated_output'],
            constitution_checks=['Interface-First Development', 'Simplicity & YAGNI']
        )
        workflow_result['stages'].append(stage4_result)
        
        # Stage 5: Code Generation
        stage5_result = self._execute_stage(
            stage_id=5,
            skills=['tdd-red-green-refactor', 'go-backend-scaffolder', 'vue-quasar-scaffolder'],
            input=stage4_result['output'],
            constitution_checks=['Code Quality & Standards']
        )
        workflow_result['stages'].append(stage5_result)
        
        # Stage 6: Integration Validation
        stage6_result = self._execute_stage(
            stage_id=6,
            skills=['sit-scenario-generator', 'contract-test-generator', 'chaos-test-designer'],
            input=stage5_result['output'],
            constitution_checks=['Resilience & Reliability']
        )
        workflow_result['stages'].append(stage6_result)
        
        # Stage 7: Deployment & Operations
        stage7_result = self._execute_stage(
            stage_id=7,
            skills=['deployment-orchestrator', 'incident-management', 'change-management', 'release-manager', 'metrics-definer', 'problem-management', 'service-desk', 'rollback-manager'],
            input=stage6_result['validated_system'],
            constitution_checks=['Observability & Monitoring', 'Deployment Safety', 'Incident Response', 'Change Control', 'Service Continuity']
        )
        workflow_result['stages'].append(stage7_result)
        
        # Stage 8: Recursive Optimization
        stage8_result = self._execute_optimization_stage(workflow_result)
        workflow_result['stages'].append(stage8_result)
        
        # Aggregate metrics
        workflow_result['metrics'] = self.metrics_collector.aggregate(
            [s['metrics'] for s in workflow_result['stages']]
        )
        
        workflow_result['end_time'] = datetime.now()
        workflow_result['success'] = all(s['success'] for s in workflow_result['stages'])
        
        return workflow_result
    
    def _execute_stage(self, stage_id, skills, input, constitution_checks):
        """Execute a single stage with skill scheduling and constitution checks."""
        
        stage_result = {
            'stage_id': stage_id,
            'start_time': datetime.now(),
            'skills_executed': [],
            'constitution_checks': [],
            'metrics': {}
        }
        
        # Apply cross-stage constitution checks
        cross_stage_checks = self.constitution.get_cross_stage_principles()
        for principle in cross_stage_checks:
            check_result = self.constitution.check_compliance(
                principle=principle['name'],
                artifacts={'stage_id': stage_id, 'input': input},
                context=self.context_manager.get_context(stage_id)
            )
            stage_result['constitution_checks'].append(check_result)
            
            if not check_result['passed']:
                stage_result['blocked'] = True
                stage_result['block_reason'] = f"Cross-stage constitution violation: {principle['name']}"
        
        # Schedule and execute skills
        for skill_name in skills:
            skill_result = self.skill_scheduler.execute(
                skill_name=skill_name,
                input=input,
                context=self.context_manager.get_context(stage_id)
            )
            stage_result['skills_executed'].append(skill_result)
            
            # Collect metrics
            stage_result['metrics'].update(
                self.metrics_collector.collect_skill_metrics(skill_result)
            )
        
        # Apply stage-specific constitution checks
        for principle in constitution_checks:
            check_result = self.constitution.check_compliance(
                principle=principle,
                artifacts=stage_result['skills_executed'],
                context=self.context_manager.get_context(stage_id)
            )
            stage_result['constitution_checks'].append(check_result)
            
            if not check_result['passed']:
                stage_result['blocked'] = True
                stage_result['block_reason'] = f"Constitution violation: {principle}"
        
        stage_result['end_time'] = datetime.now()
        stage_result['duration'] = stage_result['end_time'] - stage_result['start_time']
        stage_result['success'] = not stage_result.get('blocked', False)
        
        # Update context for next stage
        self.context_manager.update_context(
            stage_id=stage_id,
            data=stage_result,
            constitution_checks=stage_result['constitution_checks']
        )
        
        return stage_result
    
    def _execute_optimization_stage(self, workflow_result):
        """Execute recursive optimization stage."""
        
        optimization_result = {
            'stage_id': 8,
            'type': 'recursive_optimization',
            'start_time': datetime.now(),
            'optimizations': [],
            'assetizations': []
        }
        
        # Analyze workflow metrics for optimization opportunities
        analysis = self.optimization_analyzer.analyze(workflow_result['metrics'])
        
        # Optimize skills
        for skill_analysis in analysis.get('skill_improvements', []):
            optimized_skill = self.recursive_optimizer.optimize_skill(
                skill_name=skill_analysis['skill'],
                performance_data=skill_analysis['metrics'],
                feedback=workflow_result['stages']
            )
            
            # Assetize successful patterns
            if optimized_skill['success_rate'] > 0.9:
                assetization_result = self.skill_assetizer.assetize(
                    skill_name=skill_analysis['skill'],
                    pattern=optimized_skill['pattern'],
                    metadata={
                        'usage_count': skill_analysis['usage_count'],
                        'success_rate': optimized_skill['success_rate'],
                        'last_used': datetime.now(),
                        'workflow_id': workflow_result['id']
                    }
                )
                optimization_result['assetizations'].append({
                    'type': 'skill_assetization',
                    'skill': skill_analysis['skill'],
                    'asset_id': assetization_result['asset_id'],
                    'quality_score': assetization_result['quality_score']
                })
            
            optimization_result['optimizations'].append({
                'type': 'skill_improvement',
                'skill': skill_analysis['skill'],
                'improvement': optimized_skill['improvement'],
                'impact': optimized_skill['expected_impact']
            })
        
        # Evolve constitution if needed
        constitution_score = workflow_result['metrics'].get('constitutional_compliance', 0)
        if constitution_score > self.constitution.evolution_threshold:
            evolved_constitution = self.constitution.evolve(
                workflow_data=workflow_result,
                success_patterns=analysis.get('success_patterns', [])
            )
            optimization_result['optimizations'].append({
                'type': 'constitution_evolution',
                'principles_evolved': evolved_constitution['changes'],
                'rationale': evolved_constitution['rationale']
            })
        
        # Optimize workflow patterns
        workflow_optimizations = self.workflow_optimizer.analyze_patterns(
            workflow_result['stages']
        )
        optimization_result['optimizations'].extend(workflow_optimizations)
        
        # Assetize successful workflow patterns
        for pattern in workflow_optimizations:
            if pattern.get('success_rate', 0) > 0.85:
                assetization_result = self.skill_assetizer.assetize(
                    skill_name='workflow_pattern',
                    pattern=pattern['pattern'],
                    metadata={
                        'type': 'workflow',
                        'success_rate': pattern['success_rate'],
                        'stages_involved': pattern['stages'],
                        'last_used': datetime.now(),
                        'workflow_id': workflow_result['id']
                    }
                )
                optimization_result['assetizations'].append({
                    'type': 'workflow_assetization',
                    'pattern_id': assetization_result['asset_id'],
                    'quality_score': assetization_result['quality_score']
                })
        
        optimization_result['end_time'] = datetime.now()
        optimization_result['duration'] = optimization_result['end_time'] - optimization_result['start_time']
        optimization_result['success'] = len(optimization_result['optimizations']) > 0
        
        return optimization_result
```

### Skill Scheduling Algorithm

```python
class SkillScheduler:
    """Intelligent scheduler for selecting and executing skills."""
    
    def execute(self, skill_name, input, context):
        """Execute a skill with intelligent scheduling."""
        
        # Get skill metadata and performance history
        skill_metadata = self.skill_registry.get(skill_name)
        performance_history = self.metrics_db.get_skill_performance(skill_name)
        
        # Check if skill needs optimization
        if performance_history.get('success_rate', 0) < 0.7:
            # Use fallback or optimized version
            alternative = self._find_alternative_skill(skill_name, context)
            if alternative:
                skill_name = alternative
                skill_metadata = self.skill_registry.get(skill_name)
        
        # Prepare execution context
        execution_context = {
            'skill': skill_name,
            'input': input,
            'project_context': context,
            'constitution': self.constitution.get_relevant_principles(skill_name),
            'previous_stage_output': context.get('previous_output'),
            'metrics_goals': context.get('metrics_targets', {})
        }
        
        # Execute skill
        skill_executor = SkillExecutor(skill_metadata)
        result = skill_executor.execute(execution_context)
        
        # Collect execution metrics
        execution_metrics = {
            'skill': skill_name,
            'duration': result['duration'],
            'success': result['success'],
            'output_quality': self._assess_output_quality(result['output'], context),
            'constitution_compliance': result.get('constitution_compliance', 1.0),
            'resource_usage': result.get('resource_usage', {})
        }
        
        # Update skill performance database
        self.metrics_db.record_execution(skill_name, execution_metrics)
        
        return {
                'skill': skill_name,
                'input': input,
                'output': result['output'],
                'metrics': execution_metrics,
                'context_used': execution_context,
                'success': result['success']
            }


class SkillAssetizer:
    """Manages skill assetization and promotion to skill library."""
    
    def __init__(self, skill_library, quality_threshold=0.85):
        self.skill_library = skill_library
        self.quality_threshold = quality_threshold
        self.asset_registry = {}
    
    def assetize(self, skill_name, pattern, metadata):
        """Assetize a successful skill pattern."""
        
        asset_id = f"{skill_name}_{generate_uuid()[:8]}"
        
        # Assess quality
        quality_score = self._assess_quality(pattern, metadata)
        
        if quality_score >= self.quality_threshold:
            # Register asset
            asset_record = {
                'asset_id': asset_id,
                'skill_name': skill_name,
                'pattern': pattern,
                'metadata': metadata,
                'quality_score': quality_score,
                'created_at': datetime.now(),
                'usage_count': 0,
                'status': 'active'
            }
            
            self.asset_registry[asset_id] = asset_record
            
            # Promote to skill library if quality is high
            if quality_score > 0.95:
                self.skill_library.add_asset(asset_record)
            
            return {
                'asset_id': asset_id,
                'quality_score': quality_score,
                'promoted_to_library': quality_score > 0.95
            }
        
        return {
            'asset_id': None,
            'quality_score': quality_score,
            'promoted_to_library': False,
            'reason': 'Quality below threshold'
        }
    
    def _assess_quality(self, pattern, metadata):
        """Assess the quality of a skill pattern."""
        
        quality_factors = {
            'success_rate': metadata.get('success_rate', 0) * 0.4,
            'usage_count': min(metadata.get('usage_count', 0) / 100, 1.0) * 0.2,
            'pattern_complexity': self._assess_complexity(pattern) * 0.2,
            'reusability': self._assess_reusability(pattern) * 0.2
        }
        
        return sum(quality_factors.values())
    
    def _assess_complexity(self, pattern):
        """Assess pattern complexity (lower is better)."""
        complexity = len(str(pattern))
        normalized = max(0, 1 - (complexity / 10000))
        return normalized
    
    def _assess_reusability(self, pattern):
        """Assess pattern reusability."""
        reusability_indicators = [
            'template' in str(pattern).lower(),
            'generic' in str(pattern).lower(),
            'parameter' in str(pattern).lower()
        ]
        return sum(reusability_indicators) / len(reusability_indicators)


class OptimizationAnalyzer:
    """Analyzes workflow metrics for optimization opportunities."""
    
    def analyze(self, metrics):
        """Analyze metrics and identify optimization opportunities."""
        
        analysis = {
            'skill_improvements': [],
            'success_patterns': [],
            'bottlenecks': []
        }
        
        # Identify skills needing improvement
        for skill_name, skill_metrics in metrics.get('skill_performance', {}).items():
            if skill_metrics.get('success_rate', 1.0) < 0.8:
                analysis['skill_improvements'].append({
                    'skill': skill_name,
                    'metrics': skill_metrics,
                    'priority': 'high' if skill_metrics['success_rate'] < 0.7 else 'medium'
                })
        
        # Identify success patterns
        for pattern in metrics.get('successful_patterns', []):
            if pattern.get('consistency', 0) > 0.9:
                analysis['success_patterns'].append(pattern)
        
        # Identify bottlenecks
        for stage in metrics.get('stage_metrics', []):
            if stage.get('duration') > stage.get('expected_duration', 0) * 1.5:
                analysis['bottlenecks'].append({
                    'stage': stage['stage_id'],
                    'duration': stage['duration'],
                    'expected_duration': stage['expected_duration']
                })
        
        return analysis


class RecursiveOptimizer:
    """Optimizes skills based on performance data and feedback."""
    
    def optimize_skill(self, skill_name, performance_data, feedback):
        """Optimize a skill based on performance data."""
        
        optimization = {
            'skill': skill_name,
            'improvement': None,
            'expected_impact': 0,
            'success_rate': performance_data.get('success_rate', 0),
            'pattern': None
        }
        
        # Analyze performance issues
        issues = self._identify_issues(performance_data, feedback)
        
        if issues:
            # Generate optimization pattern
            optimization['pattern'] = self._generate_optimization_pattern(
                skill_name, issues, feedback
            )
            
            # Calculate expected impact
            optimization['expected_impact'] = self._calculate_impact(
                performance_data, issues
            )
            
            optimization['improvement'] = {
                'type': 'pattern_optimization',
                'issues_addressed': len(issues),
                'estimated_improvement': optimization['expected_impact']
            }
        
        return optimization
    
    def _identify_issues(self, performance_data, feedback):
        """Identify performance issues."""
        
        issues = []
        
        if performance_data.get('success_rate', 1.0) < 0.8:
            issues.append('low_success_rate')
        
        if performance_data.get('execution_time', 0) > performance_data.get('expected_time', 0) * 1.5:
            issues.append('slow_execution')
        
        if performance_data.get('constitution_compliance', 1.0) < 0.9:
            issues.append('constitution_violation')
        
        return issues
    
    def _generate_optimization_pattern(self, skill_name, issues, feedback):
        """Generate optimization pattern."""
        
        pattern = {
            'skill': skill_name,
            'optimizations': [],
            'feedback_incorporated': []
        }
        
        for issue in issues:
            if issue == 'low_success_rate':
                pattern['optimizations'].append('add_error_handling')
                pattern['optimizations'].append('improve_input_validation')
            elif issue == 'slow_execution':
                pattern['optimizations'].append('optimize_algorithm')
                pattern['optimizations'].append('add_caching')
            elif issue == 'constitution_violation':
                pattern['optimizations'].append('enforce_constitution_checks')
        
        return pattern
    
    def _calculate_impact(self, performance_data, issues):
        """Calculate expected improvement impact."""
        
        base_score = performance_data.get('success_rate', 0)
        improvement_per_issue = 0.05
        expected_improvement = len(issues) * improvement_per_issue
        
        return min(expected_improvement, 1.0 - base_score)


class WorkflowOptimizer:
    """Optimizes workflow patterns based on execution data."""
    
    def analyze_patterns(self, stages):
        """Analyze workflow patterns for optimization."""
        
        optimizations = []
        
        # Analyze stage dependencies
        dependencies = self._analyze_dependencies(stages)
        if dependencies.get('optimization_opportunity'):
            optimizations.append({
                'type': 'dependency_optimization',
                'pattern': dependencies['pattern'],
                'stages': dependencies['stages'],
                'success_rate': dependencies.get('success_rate', 0),
                'expected_improvement': dependencies.get('expected_improvement', 0)
            })
        
        # Analyze parallel execution opportunities
        parallel_ops = self._analyze_parallel_opportunities(stages)
        if parallel_ops:
            optimizations.extend(parallel_ops)
        
        return optimizations
    
    def _analyze_dependencies(self, stages):
        """Analyze stage dependencies for optimization."""
        
        dependencies = {
            'stages': [],
            'pattern': None,
            'success_rate': 0,
            'expected_improvement': 0
        }
        
        # Find stages that could be parallelized
        for i, stage in enumerate(stages):
            if i > 0 and not stage.get('blocked', False):
                prev_stage = stages[i-1]
                if not prev_stage.get('blocked', False):
                    dependencies['stages'].extend([prev_stage['stage_id'], stage['stage_id']])
        
        if len(dependencies['stages']) >= 2:
            dependencies['pattern'] = 'parallel_execution'
            dependencies['success_rate'] = 0.92
            dependencies['expected_improvement'] = 0.15
            dependencies['optimization_opportunity'] = True
        
        return dependencies
    
    def _analyze_parallel_opportunities(self, stages):
        """Analyze opportunities for parallel execution."""
        
        opportunities = []
        
        # Look for independent stages
        independent_stages = []
        for stage in stages:
            if not stage.get('blocked', False):
                independent_stages.append(stage['stage_id'])
        
        if len(independent_stages) >= 2:
            opportunities.append({
                'type': 'parallel_execution',
                'pattern': {
                    'stages': independent_stages,
                    'execution_mode': 'parallel'
                },
                'stages': independent_stages,
                'success_rate': 0.88,
                'expected_improvement': 0.20
            })
        
        return opportunities


class Constitution:
    """Manages constitutional principles and compliance checking."""
    
    def __init__(self, constitution_file):
        self.constitution_file = constitution_file
        self.principles = self._load_constitution()
        self.evolution_threshold = 0.85
        self.evolution_history = []
    
    def _load_constitution(self):
        """Load constitution principles from file."""
        return {
            'stage_specific': {
                1: ['Value-Driven Development'],
                2: ['Test-First Development'],
                3: ['Architectural Consistency'],
                4: ['Interface-First Development', 'Simplicity & YAGNI'],
                5: ['Code Quality & Standards'],
                6: ['Resilience & Reliability'],
                7: ['Observability & Monitoring', 'Deployment Safety', 'Incident Response', 'Change Control', 'Service Continuity'],
                8: ['Continuous Improvement']
            },
            'cross_stage': [
                {
                    'name': 'Human-AI Responsibility Boundary',
                    'check': 'All AI-generated artifacts reviewed by human',
                    'enforcement': 'strict'
                }
            ]
        }
    
    def get_cross_stage_principles(self):
        """Get cross-stage constitutional principles."""
        return self.principles.get('cross_stage', [])
    
    def check_compliance(self, principle, artifacts, context):
        """Check compliance with a constitutional principle."""
        
        check_result = {
            'principle': principle,
            'passed': True,
            'violations': [],
            'warnings': []
        }
        
        # Simulate compliance check
        if principle == 'Value-Driven Development':
            if not artifacts.get('business_metrics'):
                check_result['passed'] = False
                check_result['violations'].append('No business metrics defined')
        
        elif principle == 'Test-First Development':
            if not artifacts.get('acceptance_tests'):
                check_result['passed'] = False
                check_result['violations'].append('No acceptance tests defined')
        
        elif principle == 'Interface-First Development':
            if not artifacts.get('interfaces'):
                check_result['passed'] = False
                check_result['violations'].append('No interfaces defined')
        
        elif principle == 'Human-AI Responsibility Boundary':
            if not context.get('human_review'):
                check_result['passed'] = False
                check_result['violations'].append('No human review recorded')
        
        return check_result
    
    def evolve(self, workflow_data, success_patterns):
        """Evolve constitution based on workflow data and success patterns."""
        
        evolution = {
            'changes': [],
            'rationale': []
        }
        
        # Analyze success patterns for new principles
        for pattern in success_patterns:
            if pattern.get('consistency', 0) > 0.95:
                new_principle = self._derive_principle_from_pattern(pattern)
                if new_principle:
                    evolution['changes'].append({
                        'type': 'add_principle',
                        'principle': new_principle
                    })
                    evolution['rationale'].append(
                        f"Derived from consistent pattern: {pattern['name']}"
                    )
        
        # Record evolution
        self.evolution_history.append({
            'timestamp': datetime.now(),
            'changes': evolution['changes'],
            'rationale': evolution['rationale'],
            'workflow_id': workflow_data.get('id')
        })
        
        return evolution
    
    def _derive_principle_from_pattern(self, pattern):
        """Derive a constitutional principle from a success pattern."""
        
        if 'parallel' in pattern.get('name', '').lower():
            return {
                'name': 'Parallel Execution Optimization',
                'description': 'Consider parallel execution for independent stages',
                'enforcement': 'warning'
            }
        
        return None


class ContextManager:
    """Manages context across workflow stages."""
    
    def __init__(self):
        self.context_store = {}
        self.version_history = {}
    
    def get_context(self, stage_id):
        """Get context for a specific stage."""
        return self.context_store.get(stage_id, {})
    
    def update_context(self, stage_id, data, constitution_checks):
        """Update context for a stage."""
        
        context_entry = {
            'stage_id': stage_id,
            'data': data,
            'constitution_checks': constitution_checks,
            'timestamp': datetime.now(),
            'version': len(self.version_history.get(stage_id, [])) + 1
        }
        
        self.context_store[stage_id] = context_entry
        
        if stage_id not in self.version_history:
            self.version_history[stage_id] = []
        self.version_history[stage_id].append(context_entry)
    
    def get_cross_stage_context(self):
        """Get context across all stages."""
        return {
            'stages': list(self.context_store.keys()),
            'timeline': [
                {
                    'stage_id': stage_id,
                    'timestamp': entry['timestamp'],
                    'success': entry['data'].get('success', False)
                }
                for stage_id, entry in self.context_store.items()
            ]
        }


class MetricsCollector:
    """Collects and aggregates metrics across workflow stages."""
    
    def __init__(self):
        self.metrics_store = {}
    
    def collect_skill_metrics(self, skill_result):
        """Collect metrics from skill execution."""
        
        return {
            f"{skill_result['skill']}_duration": skill_result['metrics'].get('duration', 0),
            f"{skill_result['skill']}_success": skill_result['success'],
            f"{skill_result['skill']}_quality": skill_result['metrics'].get('output_quality', 0),
            f"{skill_result['skill']}_constitution_compliance": skill_result['metrics'].get('constitution_compliance', 1.0)
        }
    
    def aggregate(self, stage_metrics_list):
        """Aggregate metrics from all stages."""
        
        aggregated = {
            'skill_performance': {},
            'stage_metrics': [],
            'constitutional_compliance': 0,
            'business_value_alignment': 0,
            'successful_patterns': []
        }
        
        for stage_metrics in stage_metrics_list:
            for key, value in stage_metrics.items():
                if key.endswith('_success'):
                    skill_name = key.replace('_success', '')
                    if skill_name not in aggregated['skill_performance']:
                        aggregated['skill_performance'][skill_name] = {}
                    aggregated['skill_performance'][skill_name]['success_rate'] = value
        
        # Calculate overall compliance
        compliance_scores = [
            m.get(k, 1.0) for m in stage_metrics_list
            for k in m.keys() if k.endswith('_constitution_compliance')
        ]
        aggregated['constitutional_compliance'] = sum(compliance_scores) / len(compliance_scores) if compliance_scores else 1.0
        
        return aggregated


class SkillExecutor:
    """Executes skills with proper context and error handling."""
    
    def __init__(self, skill_metadata):
        self.skill_metadata = skill_metadata
    
    def execute(self, execution_context):
        """Execute a skill with the given context."""
        
        start_time = datetime.now()
        
        try:
            # Simulate skill execution
            result = self._execute_implementation(execution_context)
            success = True
            error = None
        except Exception as e:
            result = None
            success = False
            error = str(e)
        
        end_time = datetime.now()
        
        return {
            'output': result,
            'success': success,
            'error': error,
            'duration': (end_time - start_time).total_seconds(),
            'constitution_compliance': execution_context.get('constitution', {}).get('compliance_score', 1.0),
            'resource_usage': {
                'memory': '128MB',
                'cpu': '50ms'
            }
        }
    
    def _execute_implementation(self, execution_context):
        """Actual implementation of skill execution."""
        return {
            'result': f"Executed {execution_context['skill']}",
            'context_used': execution_context
        }


def generate_uuid():
    """Generate a unique identifier."""
    import uuid
    return str(uuid.uuid4())
```

### Constitution-Aware Execution

```python
class ConstitutionAwareExecutor:
    """Ensure all executions comply with constitutional principles."""
    
    def check_stage_compliance(self, stage_id, artifacts, context):
        """Check if stage execution complies with constitution."""
        
        relevant_principles = self.constitution.get_principles_for_stage(stage_id)
        compliance_report = {
            'stage_id': stage_id,
            'checks': [],
            'overall_score': 0,
            'violations': [],
            'warnings': []
        }
        
        total_weight = 0
        weighted_score = 0
        
        for principle in relevant_principles:
            check_result = self._check_principle_compliance(
                principle=principle,
                artifacts=artifacts,
                context=context
            )
            
            compliance_report['checks'].append(check_result)
            
            if check_result['violation_level'] == 'error':
                compliance_report['violations'].append({
                    'principle': principle['id'],
                    'description': check_result['description'],
                    'artifacts': check_result['violating_artifacts']
                })
            elif check_result['violation_level'] == 'warning':
                compliance_report['warnings'].append({
                    'principle': principle['id'],
                    'description': check_result['description'],
                    'suggestion': check_result['suggestion']
                })
            
            # Calculate weighted score
            weight = principle.get('weight', 1.0)
            total_weight += weight
            weighted_score += check_result['compliance_score'] * weight
        
        if total_weight > 0:
            compliance_report['overall_score'] = weighted_score / total_weight
        
        # Determine if stage should be blocked
        if compliance_report['violations']:
            compliance_report['blocked'] = True
            compliance_report['block_reason'] = "Constitutional violations found"
        
        return compliance_report
    
    def _check_principle_compliance(self, principle, artifacts, context):
        """Check compliance with a specific principle."""
        
        checker = self._get_checker_for_principle(principle['id'])
        result = checker.check(artifacts, context)
        
        return {
            'principle_id': principle['id'],
            'principle_name': principle['name'],
            'compliance_score': result.get('score', 0.0),
            'violation_level': result.get('violation_level', 'none'),
            'description': result.get('description', ''),
            'violating_artifacts': result.get('violating_artifacts', []),
            'suggestion': result.get('suggestion', ''),
            'evidence': result.get('evidence', [])
        }
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Skipping stages for "speed" | Breaks feedback loops, reduces quality | Always complete all mandatory stages |
| Ignoring constitution warnings | Leads to technical debt, architecture drift | Address warnings before proceeding |
| Not collecting metrics | Can't optimize or improve process | Enable metrics collection from start |
| Manual skill selection | Suboptimal skill choices, inefficiency | Trust orchestrator's scheduling |
| Disabling optimization | Stagnant process, missed improvements | Keep optimization enabled |
| Over-customization | Breaks methodology consistency | Follow standard workflow, customize carefully |
| Isolated stage execution | Loses context, reduces traceability | Use orchestrator for end-to-end flow |

### Red Flags

- Manual stage execution without orchestrator
- Constitution checks disabled or ignored
- No metrics being collected
- Optimization not happening after deployments
- Skills being used independently without coordination
- Context not shared between stages
- Feedback loops broken or incomplete

## Real-World Impact

**Before (Disconnected Methodology):**
- Business defines vague requirements
- Developers implement based on assumptions
- Testers find issues late in cycle
- Ops team struggles with deployment
- No feedback loops for improvement
- Quality varies by team and individual
- Architecture drifts over time

**After (Orchestrated Fusion):**
- Business goals mapped to measurable metrics
- Specifications are testable and clear
- Constitution ensures consistency
- Code follows standards and patterns
- Integration validates end-to-end flow
- Metrics drive continuous optimization
- Process improves with each iteration

**Outcome:** Predictable quality, faster delivery, consistent architecture, measurable business value, self-improving process.

## Integration with Aether.go Methodology

### Full Lifecycle Coverage

```
Business Context → Methodology Fusion Orchestrator → Deployed System
       ↑                                                   ↓
       └─────────────── Recursive Optimization ←──────────┘
```

### Constitution Evolution Integration

```yaml
# Constitution evolution triggered by orchestrator
constitution_evolution:
  trigger: "metrics.constitutional_compliance > 0.85"
  process:
    1. Analyze successful patterns across stages
    2. Identify principles needing refinement
    3. Propose evolution with evidence
    4. Human review for major changes
    5. Auto-apply minor refinements
  outcomes:
    - Principles become more precise
    - Checks become more contextual
    - Enforcement adapts to project type
    - New principles emerge from patterns
```

### Metrics-Driven Optimization

```python
# Optimization based on aggregated metrics
def optimize_based_on_metrics(workflow_metrics):
    """Trigger optimization based on stage metrics."""
    
    optimizations = []
    
    # Skill optimization
    for skill_metrics in workflow_metrics.get('skill_performance', []):
        if skill_metrics['success_rate'] < 0.8:
            optimizations.append({
                'type': 'skill_refinement',
                'skill': skill_metrics['name'],
                'focus': 'success_rate_improvement',
                'target': 0.9
            })
    
    # Workflow optimization
    stage_durations = workflow_metrics.get('stage_durations', {})
    bottleneck = max(stage_durations, key=stage_durations.get)
    
    if stage_durations[bottleneck] > timedelta(hours=8):
        optimizations.append({
            'type': 'workflow_restructuring',
            'bottleneck': bottleneck,
            'current_duration': stage_durations[bottleneck],
            'target_reduction': '50%',
            'strategy': 'parallel_execution_or_skill_optimization'
        })
    
    # Constitution optimization
    compliance_scores = workflow_metrics.get('constitution_compliance', {})
    low_scoring_principles = [
        p for p, score in compliance_scores.items()
        if score < 0.7
    ]
    
    for principle in low_scoring_principles:
        optimizations.append({
            'type': 'constitution_clarification',
            'principle': principle,
            'current_score': compliance_scores[principle],
            'target_score': 0.85,
            'approach': 'provide_better_examples_and_checks'
        })
    
    return optimizations
```

### Cross-Skill Context Sharing

```yaml
# Context sharing across stages
context_sharing:
  enabled: true
  sharing_strategy: "selective_propagation"
  
  propagated_items:
    - business_goals: "From Stage 1 to all stages"
    - constitutional_decisions: "From Stage 3 to Stages 4-7"
    - architecture_constraints: "From Stage 4 to Stages 5-6"
    - performance_targets: "From Stage 1 to Stages 5-7"
    - user_experience_requirements: "From Stage 2 to Stages 5-6"
  
  context_enrichment:
    - each_stage: "Adds execution_context"
    - each_skill: "Adds skill_specific_insights"
    - constitution_checks: "Adds compliance_context"
    - metrics: "Adds performance_context"
  
  context_persistence:
    storage: "workflow_database"
    retention: "30_days"
    queryable: true
    used_for: "optimization_analysis, audit_trails, onboarding"
```