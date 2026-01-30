# Aether.go Skills Summary

---

**Language**: [English](SKILLS_SUMMARY.md) | [中文](SKILLS_SUMMARY_CN.md)

---

Based on planning in `overall.md` and OpenCode skills specifications, 39 skills have been successfully created (31 original + 7 new + 1 Rust CLI builder), covering complete eight stages of Aether.go methodology fusion framework.

## Background of New Skills: Methodology Fusion Framework Enhancement

Based on an in-depth analysis of the Aether.go methodology fusion framework described in `method-paper.md`, 7 key skills have been added to fill methodology execution gaps and achieve end-to-end intelligent software lifecycle management.

## Skills List

### Methodology Fusion Orchestration Layer Skills - 1

1. **methodology-fusion-orchestrator**
   - Description: Coordinate end-to-end Aether.go methodology fusion workflow, covering all eight stages
   - Functions: Workflow orchestration, constitution enforcement, metrics aggregation, skill scheduling, optimization triggering
   - Location: `skills/methodology-fusion-orchestrator/SKILL.md`

### Strategic Layer Skills (BMAD Driven) - 5

2. **business-requirements-collector**
   - Description: Collect, analyze, and prioritize business requirements from stakeholders
   - Functions: Stakeholder analysis, requirements elicitation, prioritization, validation
   - Location: `skills/business-requirements-collector/SKILL.md`

3. **business-value-mapper**
   - Description: Transform business objectives into measurable technical metrics using BMAD framework
   - Functions: Generate BMAD matrix, connect business objectives to technical metrics
   - Location: `skills/business-value-mapper/SKILL.md`

4. **metrics-definer**
   - Description: Define business and technical metrics for specific system types with monitoring configuration
   - Functions: Define metrics list, built-in templates for e-commerce/SaaS/IoT scenarios
   - Location: `skills/metrics-definer/SKILL.md`

5. **architecture-decision-recorder**
   - Description: Record architecture decisions with business rationale and alternative analysis
   - Functions: Create ADR documentation, record decision rationale and trade-offs
   - Location: `skills/architecture-decision-recorder/SKILL.md`

6. **data-flow-analyzer**
   - Description: Analyze data flow and value chain to identify bottlenecks and optimization opportunities
   - Functions: Visualize data flow, track value chain
   - Location: `skills/data-flow-analyzer/SKILL.md`

### Tactical Layer Skills (SDD + Constitution Constraints) - 7

7. **spec-parser**
   - Description: Parse natural language requirements into structured technical specifications
   - Functions: Convert user stories to YAML/JSON specifications
   - Location: `skills/spec-parser/SKILL.md`

8. **constitution-validator**
   - Description: Validate that code and specifications comply with architectural principles and constitution constraints
   - Functions: Automated compliance checking, generate compliance reports
   - Location: `skills/constitution-validator/SKILL.md`

9. **spec-to-code-tracer**
   - Description: Establish bidirectional traceability between specifications and code implementations
   - Functions: Create traceability matrix, support impact analysis
   - Location: `skills/spec-to-code-tracer/SKILL.md`

10. **spec-evolution-tracker**
    - Description: Track specification change history and impact analysis
    - Functions: Version management, change impact assessment
    - Location: `skills/spec-evolution-tracker/SKILL.md`

11. **architecture-pattern-selector**
    - Description: Select architecture patterns based on requirements, constraints, and team capabilities
    - Functions: Systematic pattern evaluation, create decision matrix, generate ADR
    - Location: `skills/architecture-pattern-selector/SKILL.md`

12. **generic-code-generator**
    - Description: Generate production code across multiple languages and frameworks based on specifications, templates, or test-driven development patterns
    - Functions: Template-based code generation, specification transformation, TDD integration, multi-language pattern support
    - Location: `skills/generic-code-generator/SKILL.md`

13. **contract-test-generator**
    - Description: Generate consumer-driven contract tests to ensure microservice API compatibility and prevent integration failures
    - Functions: Contract generation, consumer-driven testing, Pact/OpenAPI integration, CI/CD validation gates
    - Location: `skills/contract-test-generator/SKILL.md`

### Execution Layer Skills (ATDD/BDD/TDD/SIT/Chaos) - 6

14. **atdd-acceptance-test-generator**
    - Description: Generate executable acceptance tests from requirements to drive development
    - Functions: Generate executable acceptance tests, stakeholder validation examples, test coverage analysis
    - Location: `skills/atdd-acceptance-test-generator/SKILL.md`

15. **bdd-scenario-writer**
    - Description: Convert user stories and requirements to Gherkin BDD scenario files
    - Functions: Generate Given-When-Then structured scenarios, support multiple languages
    - Location: `skills/bdd-scenario-writer/SKILL.md`

16. **tdd-red-green-refactor**
    - Description: Implement any feature or fix bugs using test-driven development methodology
    - Functions: Guide RED-GREEN-REFACTOR cycle, support multiple languages
    - Location: `skills/tdd-red-green-refactor/SKILL.md`

17. **test-pyramid-analyzer**
    - Description: Analyze test coverage, distribution, and test strategy gaps
    - Functions: Visualize test distribution, generate coverage reports, provide optimization recommendations
    - Location: `skills/test-pyramid-analyzer/SKILL.md`

18. **sit-scenario-generator**
    - Description: Create system integration test (SIT) scenarios across multiple services or API endpoints
    - Functions: Generate automated SIT test scripts, support Cypress/Postman/k6
    - Location: `skills/sit-scenario-generator/SKILL.md`

19. **chaos-test-designer**
    - Description: Design chaos engineering experiments to test system resilience and fault tolerance
    - Functions: Define fault injection scenarios, support LitmusChaos/Chaos Mesh
    - Location: `skills/chaos-test-designer/SKILL.md`

### ITIL Service Management & Deployment Operations Skills - 7

20. **incident-management**
    - Description: ITIL-aligned incident handling processes and response workflows
    - Functions: Incident classification, prioritization, escalation, resolution tracking
    - Location: `skills/incident-management/SKILL.md`

21. **problem-management**
    - Description: Root cause analysis and permanent fix management
    - Functions: Problem identification, root cause analysis, solution implementation, preventive measures
    - Location: `skills/problem-management/SKILL.md`

22. **change-management**
    - Description: Controlled change processes and Change Advisory Board (CAB) approval
    - Functions: Change request evaluation, risk assessment, CAB approval, implementation coordination
    - Location: `skills/change-management/SKILL.md`

23. **service-desk**
    - Description: Single point of contact management for user requests and issues
    - Functions: Service catalog, SLA agreements, user communication, request tracking
    - Location: `skills/service-desk/SKILL.md`

24. **deployment-orchestrator**
    - Description: Advanced deployment strategy orchestration (canary, blue-green, rolling updates)
    - Functions: Deployment strategy selection, environment management, release coordination, monitoring integration
    - Location: `skills/deployment-orchestrator/SKILL.md`

25. **release-manager**
    - Description: Release planning, version management, and stakeholder coordination
    - Functions: Release calendar, version control, communication plan, go-live coordination
    - Location: `skills/release-manager/SKILL.md`

26. **rollback-manager**
    - Description: Automated rollback procedures for failed deployments
    - Functions: Rollback triggers, state restoration, data consistency verification
    - Location: `skills/rollback-manager/SKILL.md`

### AI Collaboration & Optimization Skills - 4

27. **context-manager**
    - Description: Manage project context, conversation history, and information retrieval
    - Functions: Save and restore context, minimize token usage
    - Location: `skills/context-manager/SKILL.md`

28. **skill-recommender**
    - Description: Recommend relevant AI skills based on current task, project context, and development stage
    - Functions: Intelligent recommendation, improve efficiency
    - Location: `skills/skill-recommender/SKILL.md`

29. **recursive-optimizer**
    - Description: Optimize AI skills, prompts, and workflows based on execution results and user feedback
    - Functions: A/B testing, continuous improvement loop
    - Location: `skills/recursive-optimizer/SKILL.md`

30. **prompt-template-manager**
    - Description: Manage, version, and optimize AI prompt templates
    - Functions: Version control, performance tracking, A/B testing
    - Location: `skills/prompt-template-manager/SKILL.md`

### Go + Vue + Quasar Fullstack Development Skills - 6 (Production-Ready Patterns)

31. **go-backend-scaffolder**
    - Description: Generate clean architecture Go backend code based on production-ready patterns
    - Functions: Create Fiber + GORM + Swagger backend, support layered architecture and Cobra command structure
    - Features: main.go in root directory as Cobra entry point, cmd/ contains independent commands (version/daemon/server), includes default version command
    - Location: `skills/go-backend-scaffolder/SKILL.md`

32. **vue-quasar-scaffolder**
    - Description: Generate Vue 3 + Quasar + TypeScript components based on production-ready frontend patterns
    - Functions: Create Composition API components, Pinia stores, test configuration
    - Location: `skills/vue-quasar-scaffolder/SKILL.md`

33. **fullstack-project-setup**
    - Description: Initialize complete Go + Vue + Quasar fullstack project based on production-ready structure
    - Functions: Create project structure, Docker configuration, CI/CD pipelines, development environment
    - Location: `skills/fullstack-project-setup/SKILL.md`

34. **requirements-to-code-docs**
    - Description: Generate structured documentation from requirements to use cases to implementation based on production-ready documentation workflow
    - Functions: Requirements documentation, use case documentation, API documentation, traceability matrix
    - Location: `skills/requirements-to-code-docs/SKILL.md`

35. **go-vue-fullstack-workflow**
    - Description: Coordinate Go + Vue + Quasar fullstack development workflow using production-ready patterns and documentation
    - Functions: Integrate all related skills, provide end-to-end development workflow guidance
    - Location: `skills/go-vue-fullstack-workflow/SKILL.md`

36. **makefile-backend-generator**
    - Description: Create production-ready Makefiles for Go backend projects based on production-ready patterns
    - Functions: Generate complete Makefile with build, test, deployment, database operations, support cross-platform compilation
    - Location: `skills/makefile-backend-generator/SKILL.md`

### Tools & Integration Skills - 3

37. **skill-packaging-tool**
    - Description: Package skills into distributable installable packages
    - Functions: Version management, dependency declaration, installation scripts
    - Location: `skills/skill-packaging-tool/SKILL.md`

38. **go-cli-builder**
    - Description: Build enterprise-grade Go CLI applications based on cobra+viper and best practices
    - Functions: Generate production-grade CLI application structure, includes configuration management, structured logging, automatic version injection, multi-platform builds, and comprehensive testing strategy
    - Features: Support multi-path configuration file search (./ → ./config → /etc/app-name), automatic Git version and Go SDK version retrieval, built-in shell completion commands
    - Location: `skills/go-cli-builder/SKILL.md`

39. **rust-cli-builder**
    - Description: Build enterprise-grade Rust CLI applications based on clap+serde+config and best practices
    - Functions: Generate production-grade CLI application structure, includes configuration management, structured logging, automatic version injection, multi-platform builds, and comprehensive testing strategy
    - Features: Support multi-path configuration file search (./ → ./config → /etc/app-name), automatic Git version and Rust version retrieval, built-in shell completion commands
    - Location: `skills/rust-cli-builder/SKILL.md`

## Skill Characteristics

### Followed Specifications

1. **OpenCode Skills Specification**
   - YAML frontmatter (name and description only)
   - Description starts with "Use when..."
   - Names use lowercase letters, numbers, and hyphens
   - File path: `skills/<name>/SKILL.md`

2. **Writing-Skills TDD Principles**
   - RED-GREEN-REFACTOR cycle
   - Write failing tests first, then write code
   - Each skill includes test cases

3. **Aether.go Methodology Integration**
   - BMAD (Business-Driven Metrics) framework
   - SDD (Specification-Driven Development)
   - Constitution constraint principles
   - Traceability between specifications and code
   - Methodology fusion orchestration

### Skill Structure

Each skill contains:
- Overview
- When to Use
- Core Pattern
- Quick Reference
- Implementation
- Common Mistakes
- Real-World Impact
- Integration with Aether.go Methodology

## Skill Integration & Workflow

### Eight-Stage Methodology Fusion Workflow

The newly added `methodology-fusion-orchestrator` skill coordinates the complete eight stages:

```
Stage 1: Business Analysis
  ├── business-requirements-collector
  ├── business-value-mapper
  └── metrics-definer

Stage 2: Specification Definition
  ├── spec-parser
  ├── bdd-scenario-writer
  └── atdd-acceptance-test-generator

Stage 3: Constitutional Review
  └── constitution-validator

Stage 4: Implementation Planning
  ├── architecture-decision-recorder
  └── data-flow-analyzer

Stage 5: Code Generation
  ├── tdd-red-green-refactor
  ├── go-backend-scaffolder
  └── vue-quasar-scaffolder

Stage 6: Integration Validation
  ├── sit-scenario-generator
  └── chaos-test-designer

Stage 7: Deployment & Operations
  ├── deployment-orchestrator
  ├── incident-management
  ├── change-management
  ├── release-manager
  ├── metrics-definer
  ├── problem-management
  ├── service-desk
  └── rollback-manager

Stage 8: Recursive Optimization
  ├── recursive-optimizer
  ├── skill-recommender
  └── prompt-template-manager
```

*Note: The workflow diagram shows key representative skills for each stage, not all 39 skills. For the complete skills list, please refer to the Skills List section above.*

### Constitution Enforcement Throughout Execution

`methodology-fusion-orchestrator` ensures that constitution principles are enforced across all stages:

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
```

### Intelligent Skill Scheduling

`methodology-fusion-orchestrator` implements intelligent skill scheduling:

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
        
        # Prepare execution context with constitution checks
        execution_context = {
            'skill': skill_name,
            'input': input,
            'project_context': context,
            'constitution': self.constitution.get_relevant_principles(skill_name),
            'previous_stage_output': context.get('previous_output'),
            'metrics_goals': context.get('metrics_targets', {})
        }
        
        # Execute skill with metrics collection
        skill_executor = SkillExecutor(skill_metadata)
        result = skill_executor.execute(execution_context)
        
        # Collect metrics for optimization
        execution_metrics = {
            'skill': skill_name,
            'duration': result['duration'],
            'success': result['success'],
            'output_quality': self._assess_output_quality(result['output'], context),
            'constitution_compliance': result.get('constitution_compliance', 1.0)
        }
        
        return result
```

### Metrics Aggregation & Feedback Loop

```python
class MetricsAggregator:
    """Aggregate metrics across all stages for feedback loops."""
    
    def aggregate_workflow_metrics(self, workflow_execution):
        """Aggregate metrics from complete workflow execution."""
        
        aggregated = {
            'temporal_metrics': {
                'total_duration': self._calculate_total_duration(workflow_execution),
                'stage_durations': self._extract_stage_durations(workflow_execution),
                'bottleneck_stage': self._identify_bottleneck(workflow_execution)
            },
            
            'quality_metrics': {
                'constitutional_compliance': self._calculate_compliance_score(workflow_execution),
                'requirement_traceability': self._calculate_traceability_score(workflow_execution),
                'test_coverage': self._calculate_test_coverage(workflow_execution),
                'defect_density': self._calculate_defect_density(workflow_execution)
            },
            
            'business_metrics': {
                'business_value_alignment': self._calculate_value_alignment(workflow_execution),
                'roi_estimate': self._estimate_roi(workflow_execution),
                'stakeholder_satisfaction': self._assess_satisfaction(workflow_execution)
            },
            
            'skill_performance_metrics': {
                'skill_success_rates': self._calculate_skill_success_rates(workflow_execution),
                'skill_efficiency': self._calculate_skill_efficiency(workflow_execution),
                'skill_improvement_opportunities': self._identify_improvement_opportunities(workflow_execution)
            }
        }
        
        # Trigger optimization based on metrics
        if self._should_trigger_optimization(aggregated):
            optimization_recommendations = self.optimization_engine.analyze(aggregated)
            return {
                'aggregated_metrics': aggregated,
                'optimization_recommendations': optimization_recommendations,
                'optimization_triggered': True
            }
        
        return {
            'aggregated_metrics': aggregated,
            'optimization_triggered': False
        }
```

## Usage Instructions

### Skill Discovery

OpenCode automatically discovers skills from the following locations:
- Project configuration: `skills/<name>/SKILL.md`
- Global configuration: `~/.config/opencode/skill/<name>/SKILL.md`

### Skill Loading

In conversation, the AI assistant will automatically recommend and load relevant skills based on tasks. You can also explicitly request to use a specific skill.

### Skill Prioritization

- **High Priority**: Methodology fusion orchestration skills (methodology-fusion-orchestrator), execution layer skills (ATDD/BDD/TDD/SIT/Chaos)
- **Medium Priority**: Strategic and tactical layer skills, fullstack development skills
- **Low Priority**: Tools and integration skills, project initialization skills

## Next Steps

1. **Test Validation**: Use subagent-driven development to test the effectiveness of each skill
2. **Performance Optimization**: Optimize prompts and content based on usage feedback
3. **Documentation Enhancement**: Add more examples and use cases
4. **Distribution Packaging**: Use skill-packaging-tool to create installable packages
5. **Market Release**: Publish to skills marketplace for other projects to use

## Notes

- All skills are created following TDD principles and require further testing and validation
- Skills may need optimization based on actual usage scenarios
- It is recommended to read the complete SKILL.md content before using skills
- **Methodology Fusion Orchestration**: Achieve end-to-end workflow coordination through methodology-fusion-orchestrator
- **Constitution Enforcement**: New skills ensure that constitution principles are enforced across all stages
- **Feedback Loop Establishment**: Implement a complete closed loop of metrics collection and recursive optimization
- Feedback and improvement suggestions are welcome

---
