---
name: methodology-fusion-orchestrator
description: Use when orchestrating end-to-end software lifecycle with Aether.go methodology fusion framework across all seven stages
---

# Methodology Fusion Orchestrator

## Overview
Orchestrate the complete Aether.go methodology fusion workflow across all seven stages: business analysis, specification definition, constitutional review, implementation planning, code generation, integration validation, deployment metrics, and recursive optimization. Ensures constitutional principles are enforced, metrics are aggregated, and feedback loops drive continuous improvement.

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

### Seven-Stage Methodology Fusion Workflow

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
      skill: business-value-mapper
      input: "User authentication system"
      output: BMAD matrix with metrics
      constitution_check: passed
      duration: "2h"
    
  - phase_2_specification_definition:
      skill: spec-parser
      input: BMAD matrix
      output: Structured specifications
      skill: bdd-scenario-writer
      output: Gherkin scenarios
      constitution_check: passed
      duration: "3h"
    
  - phase_3_constitutional_review:
      skill: constitution-validator
      input: Specifications + scenarios
      output: Compliance report (92% score)
      issues: 2 warnings, 0 errors
      duration: "1h"
    
  - phase_4_implementation_planning:
      skill: architecture-decision-recorder
      input: Validated specifications
      output: Architecture decisions + ADRs
      skill: data-flow-analyzer
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
      skill: chaos-test-designer
      output: Resilience test plans
      duration: "8h"
    
  - phase_7_deployment_metrics:
      skill: metrics-definer
      input: Deployed system
      output: Business + technical metrics
      monitoring: Auto-configured
      duration: "2h"
    
  - phase_8_recursive_optimization:
      skill: recursive-optimizer
      input: All metrics + feedback
      output: Optimization recommendations
      skill_improvements: 3 skills updated
      constitution_evolution: 1 principle refined
      duration: "4h"

metrics_summary:
  total_duration: "40h"
  constitutional_compliance: "96%"
  requirement_traceability: "100%"
  test_coverage: "92%"
  business_value_alignment: "94%"
  optimization_impact: "18% efficiency gain"
```

## Quick Reference

### Stage-to-Skill Mapping

| Stage | Primary Skills | Supporting Skills | Output |
|-------|---------------|-------------------|--------|
| **1. Business Analysis** | business-value-mapper | metrics-definer | BMAD matrix |
| **2. Specification** | spec-parser, bdd-scenario-writer | - | Structured specs + scenarios |
| **3. Constitutional Review** | constitution-validator | architecture-decision-recorder | Compliance report |
| **4. Implementation Planning** | architecture-decision-recorder | data-flow-analyzer | ADRs + data flows |
| **5. Code Generation** | tdd-red-green-refactor, go-backend-scaffolder, vue-quasar-scaffolder | spec-to-code-tracer | Test-driven code |
| **6. Integration Validation** | sit-scenario-generator, chaos-test-designer | test-pyramid-analyzer | Integration + resilience tests |
| **7. Deployment Metrics** | metrics-definer | - | Metrics dashboard |
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
    
  stage_8_optimization:
    - principle: "Continuous Improvement"
      check: "Feedback loops established and active"
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
    
  skill_scheduling:
    algorithm: "context_aware"
    factors: ["success_rate", "relevance", "efficiency"]
    fallback: "skill-recommender"
    
  context_management:
    persistence: true
    sharing: "cross_stage"
    summarization: "auto"
```

## Implementation

### Orchestrator Engine

```python
class MethodologyFusionOrchestrator:
    """Main orchestrator coordinating all seven stages."""
    
    def __init__(self, project_context, constitution):
        self.project_context = project_context
        self.constitution = constitution
        self.metrics_collector = MetricsCollector()
        self.skill_scheduler = SkillScheduler()
        self.context_manager = ContextManager()
        
    def execute_workflow(self, user_request):
        """Execute complete seven-stage workflow."""
        
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
            skills=['business-value-mapper', 'metrics-definer'],
            input=user_request,
            constitution_checks=['Value-Driven Development']
        )
        workflow_result['stages'].append(stage1_result)
        
        # Stage 2: Specification Definition
        stage2_result = self._execute_stage(
            stage_id=2,
            skills=['spec-parser', 'bdd-scenario-writer'],
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
            skills=['architecture-decision-recorder', 'data-flow-analyzer'],
            input=stage3_result['validated_output'],
            constitution_checks=['Simplicity & YAGNI']
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
            skills=['sit-scenario-generator', 'chaos-test-designer'],
            input=stage5_result['output'],
            constitution_checks=['Resilience & Reliability']
        )
        workflow_result['stages'].append(stage6_result)
        
        # Stage 7: Deployment Metrics
        stage7_result = self._execute_stage(
            stage_id=7,
            skills=['metrics-definer'],
            input=stage6_result['validated_system'],
            constitution_checks=['Observability & Monitoring']
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
        
        # Apply constitution checks
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
            'optimizations': []
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
    
    def _find_alternative_skill(self, primary_skill, context):
        """Find alternative skill if primary has poor performance."""
        
        alternatives = self.skill_registry.find_alternatives(primary_skill)
        
        for alt_skill in alternatives:
            alt_performance = self.metrics_db.get_skill_performance(alt_skill)
            
            # Check if alternative is suitable
            if (alt_performance.get('success_rate', 0) > 0.8 and
                self._is_context_relevant(alt_skill, context)):
                return alt_skill
        
        # Use skill-recommender as fallback
        recommendation = self.skill_recommender.recommend(
            task=context.get('task_description', ''),
            context=context
        )
        
        return recommendation.get('primary_skill')
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