# Aether.go Skills

A set of intelligent AI skills for the Aether.go project, based on spec-driven, value-oriented, and test-first development methodology.

---

**Language**: [English](README.md) | [中文](README_CN.md)

---

## Directory Structure

```
skills/
├── README.md                       # This file (English)
├── README_CN.md                    # This file (Chinese)
├── SKILLS_SUMMARY.md               # Detailed skills list (English)
├── SKILLS_SUMMARY_CN.md            # Detailed skills list (Chinese)
├── MIGRATION.md                   # Migration guide (English)
├── MIGRATION_CN.md                # Migration guide (Chinese)
├── skills.sh                       # Skills management script
├── AGENTS.md                       # AI assistant usage guide
├── LICENSE                         # MIT License
├── .gitignore                      # Git ignore configuration
│
├── Execution Layer Skills (ATDD/BDD/TDD/SIT/Chaos)
│   ├── bdd-scenario-writer/       # BDD scenario writer
│   │   └── SKILL.md
│   ├── tdd-red-green-refactor/    # TDD cycle guide
│   │   └── SKILL.md
│   ├── test-pyramid-analyzer/     # Test pyramid analyzer
│   │   └── SKILL.md
│   ├── sit-scenario-generator/    # SIT scenario generator
│   │   └── SKILL.md
│   ├── chaos-test-designer/       # Chaos engineering experiment designer
│   │   └── SKILL.md
│   └── atdd-acceptance-test-generator/ # ATDD acceptance test generator
│       └── SKILL.md
│
├── Strategic Layer Skills (BMAD Driven)
│   ├── business-requirements-collector/ # Business requirements collector
│   │   └── SKILL.md
│   ├── business-value-mapper/     # Business value mapper
│   │   └── SKILL.md
│   ├── metrics-definer/           # Metrics definer
│   │   └── SKILL.md
│   ├── architecture-decision-recorder/ # Architecture decision recorder
│   │   └── SKILL.md
│   └── data-flow-analyzer/        # Data flow analyzer
│       └── SKILL.md
│
├── Tactical Layer Skills (SDD + Constitution Constraints)
│   ├── spec-parser/               # Specification parser
│   │   └── SKILL.md
│   ├── constitution-validator/    # Constitution validator
│   │   └── SKILL.md
│   ├── spec-to-code-tracer/       # Specification to code tracer
│   │   └── SKILL.md
│   ├── spec-evolution-tracker/    # Specification evolution tracker
│   │   └── SKILL.md
│   ├── architecture-pattern-selector/ # Architecture pattern selector
│   │   └── SKILL.md
│   ├── generic-code-generator/    # Generic code generator
│   │   └── SKILL.md
│   └── contract-test-generator/    # Contract test generator
│       └── SKILL.md
│
├── AI Collaboration & Optimization Skills
│   ├── context-manager/           # Context manager
│   │   └── SKILL.md
│   ├── skill-recommender/         # Skill recommender
│   │   └── SKILL.md
│   ├── recursive-optimizer/       # Recursive optimizer
│   │   └── SKILL.md
│   └── prompt-template-manager/   # Prompt template manager
│       └── SKILL.md
│
├── Go + Vue + Quasar Fullstack Development Skills (Production-Ready Patterns)
│   ├── go-backend-scaffolder/     # Go backend scaffolder
│   │   └── SKILL.md
│   ├── vue-quasar-scaffolder/     # Vue + Quasar frontend scaffolder
│   │   └── SKILL.md
│   ├── fullstack-project-setup/   # Fullstack project initialization
│   │   └── SKILL.md
│   ├── requirements-to-code-docs/ # Requirements to code documentation generator
│   │   └── SKILL.md
│   ├── go-vue-fullstack-workflow/ # Go + Vue fullstack workflow
│   │   └── SKILL.md
│   └── makefile-backend-generator/ # Makefile generator
│       └── SKILL.md
│
├── Tools & Integration Skills
│   ├── skill-packaging-tool/      # Skill packaging tool
│   │   └── SKILL.md
│   ├── go-cli-builder/            # Go CLI application builder
│   │   └── SKILL.md
│   ├── rust-cli-builder/          # Rust CLI application builder
│   │   └── SKILL.md
│   └── readme-license-generator/  # README & LICENSE generator
│       └── SKILL.md
│
└── Methodology Fusion Orchestration Layer Skills
    └── methodology-fusion-orchestrator/ # Methodology fusion orchestrator
        └── SKILL.md
```

## Skill Categories

### Quick Start

#### 1. View Skills List
See [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) for detailed descriptions of all 39 skills.

#### 2. Choose the Right Skill
Select the appropriate skill based on your development phase:
- **Project Initialization**: `fullstack-project-setup`, `go-backend-scaffolder`, `vue-quasar-scaffolder`
- **Requirements Analysis**: `business-requirements-collector`, `business-value-mapper`, `metrics-definer`
- **Specification Definition**: `spec-parser`, `bdd-scenario-writer`, `atdd-acceptance-test-generator`
- **Code Development**: `tdd-red-green-refactor`, `generic-code-generator`
- **Testing & Validation**: `test-pyramid-analyzer`, `sit-scenario-generator`, `chaos-test-designer`
- **Deployment & Operations**: `deployment-orchestrator`, `release-manager`, `incident-management`

#### 3. Use Skills
Request to use a specific skill directly in conversation, and the AI assistant will automatically load and execute it.

#### 4. View Migration Guide
If migrating from an old version, see [MIGRATION.md](MIGRATION.md) for detailed migration steps.

---

### Execution Layer (6 skills)
- `bdd-scenario-writer` - Convert requirements to Gherkin BDD scenarios
- `tdd-red-green-refactor` - Guide TDD RED-GREEN-REFACTOR cycle
- `test-pyramid-analyzer` - Analyze test distribution and coverage
- `sit-scenario-generator` - Generate system integration test scenarios
- `chaos-test-designer` - Design chaos engineering experiments
- `atdd-acceptance-test-generator` - Generate ATDD acceptance tests

### Strategic Layer (5 skills)
- `business-requirements-collector` - Collect and analyze business requirements
- `business-value-mapper` - BMAD business value mapping
- `metrics-definer` - Define business and technical metrics
- `architecture-decision-recorder` - Record architecture decisions (ADR)
- `data-flow-analyzer` - Analyze data flow and value chain

### Tactical Layer (7 skills)
- `spec-parser` - Parse natural language requirements into structured specifications
- `constitution-validator` - Validate constitution principle compliance
- `spec-to-code-tracer` - Establish bidirectional tracing between specifications and code
- `spec-evolution-tracker` - Track specification change history
- `architecture-pattern-selector` - Select architecture patterns based on requirements
- `generic-code-generator` - Generate code across languages based on specifications, templates, or TDD patterns
- `contract-test-generator` - Generate consumer-driven contract tests to ensure microservice API compatibility

### AI Collaboration Layer (4 skills)
- `context-manager` - Manage project context
- `skill-recommender` - Intelligently recommend relevant skills
- `recursive-optimizer` - Optimize skills based on feedback
- `prompt-template-manager` - Manage prompt templates

### Go + Vue + Quasar Fullstack Development Layer (6 skills)
- `go-backend-scaffolder` - Generate Go backend code based on production-ready patterns
- `vue-quasar-scaffolder` - Generate Vue 3 + Quasar frontend components based on production-ready patterns
- `fullstack-project-setup` - Initialize complete Go + Vue + Quasar fullstack project
- `requirements-to-code-docs` - Generate structured documentation from requirements to use cases to implementation
- `go-vue-fullstack-workflow` - Coordinate Go + Vue + Quasar fullstack development workflow
- `makefile-backend-generator` - Create production-ready Makefiles for Go backend projects

### Tools & Integration Layer (3 skills)
- `skill-packaging-tool` - Package skills into distributable packages
- `go-cli-builder` - Build enterprise-grade Go CLI applications based on cobra+viper best practices
- `rust-cli-builder` - Build enterprise-grade Rust CLI applications based on clap+serde+config best practices

### Methodology Fusion Orchestration Layer (1 skill)
- `methodology-fusion-orchestrator` - Coordinate end-to-end methodology fusion workflow

---

**Total**: 39 skills covering the complete software development lifecycle

## Usage

### Auto-discovery via OpenCode

OpenCode automatically searches from the current working directory upwards and discovers all skills in the `skills/` directory.

```bash
# In the user directory
git clone https://github.com/aether-go/skills.git
cp -Rv skills/* .opencode/skill/

# OpenCode will automatically discover all skills in the skills/ directory
```

### Skills Management Script

The project provides a convenient `skills.sh` script to manage skills (see [MIGRATION.md](MIGRATION.md) for details):

```bash
# List all skills
cd skills
./skills.sh list

# Show skill details
./skills.sh show bdd-scenario-writer

# Search skills
./skills.sh search testing

# View statistics
./skills.sh stats

# Validate skill format
./skills.sh validate

# Install skill to global location
./skills.sh install bdd-scenario-writer
```

### Manual Skill Invocation

In conversation, AI assistant will automatically recommend and load relevant skills based on tasks:

```
User: "I need to write BDD test scenarios for user login functionality"

AI Assistant: Using bdd-scenario-writer skill to convert requirements to Gherkin scenarios...
```

### Methodology Fusion Orchestrator Usage Examples

The `methodology-fusion-orchestrator` is the most powerful skill that coordinates all other skills across the complete eight-stage workflow. Here are practical examples:

#### Example 1: E-commerce User Authentication System (Basic)

```
I need to develop an e-commerce user authentication system.

Business Goals:
- Primary: Increase user registration conversion rate by 30%
- Secondary: Reduce authentication-related customer support inquiries by 50%

Success Metrics:
- Registration success rate > 95%
- Average registration time < 60 seconds
- Third-party login usage rate > 40%
- Authentication API P99 latency < 200ms

Tech Stack:
- Backend: Go + Gin + PostgreSQL + Redis
- Frontend: Vue 3 + Quasar + Pinia

Please use methodology-fusion-orchestrator to execute the complete eight-stage workflow, ensuring constitutional compliance, enabling recursive optimization and assetization.
```

#### Example 2: Microservices Order Management System (Standard)

```
Project Type: Microservices Architecture
Tech Stack: Go Backend + Vue Frontend

BMAD Framework:
Business:
  - Primary Goal: Improve order processing efficiency by 50%
  - Secondary Goal: Reduce order error rate to below 0.1%

Metrics:
  Business:
    - Order processing time < 2 seconds
    - Order accuracy rate > 99.9%
  Technical:
    - API P99 latency < 100ms
    - System availability > 99.95%

Architecture:
  - Style: DDD + Event-Driven
  - Constraints: Support 100,000 concurrent orders

Data:
  - Types: Order data, user data, payment data
  - Flow: Order creation → Payment processing → Inventory update → Logistics notification

Please use methodology-fusion-orchestrator to execute the complete workflow, enabling all optimization and assetization features.
```

#### Example 3: Enterprise-Grade Full-Stack Application (Advanced)

```yaml
# Aether.go Methodology Fusion Orchestration Request

## Project Overview
project:
  name: "Enterprise Resource Planning System"
  type: "fullstack-web"
  version: "1.0.0"
  business_criticality: "high"
  compliance_requirements: ["SOC2", "GDPR"]

## BMAD Business Value Framework
business:
  primary_goals:
    - id: "BG-001"
      description: "Streamline inventory management"
      priority: "high"
      success_criteria: "Reduce inventory processing time by 40%"
    - id: "BG-002"
      description: "Improve order fulfillment"
      priority: "medium"
      success_criteria: "Achieve 99.5% order accuracy"

metrics:
  business:
    - name: "Inventory turnover rate"
      target: "12 times/year"
      measurement: "Calculated from inventory logs"
      frequency: "monthly"
      owner: "Operations Manager"
  
  technical:
    - name: "API response time"
      target: "P99 < 150ms"
      measurement: "APM monitoring"
      frequency: "continuous"
      owner: "DevOps Team"

architecture:
  style: "Clean Architecture + DDD"
  patterns: ["CQRS", "Event Sourcing"]
  constraints:
    - type: "performance"
      requirement: "Support 10,000 concurrent users"
    - type: "security"
      requirement: "Comply with OWASP Top 10"

data:
  entities:
    - name: "Customer data"
      sensitivity: "confidential"
      retention: "7 years"
      compliance: "GDPR"
  flows:
    - from: "Order service"
      to: "Inventory service"
      transformation: "Deduce inventory"
      validation: "Stock availability check"

## Constitution & Compliance Configuration
constitution:
  file: "./constitution.yaml"
  strict_mode: true
  auto_evolve: true
  evolution_threshold: 0.85

## Optimization & Assetization Configuration
optimization:
  enabled: true
  frequency: "after_each_stage"
  scope: ["skills", "constitution", "workflow"]

skill_effectiveness:
  tracking:
    - success_rate
    - execution_time
    - output_quality
    - constitution_compliance
  reporting:
    frequency: "daily"
    dashboard: true
    alerts:
      - condition: "success_rate < 0.7"
        action: "notify_team"

## Execution Requirements

Please use methodology-fusion-orchestrator to execute the complete eight-stage workflow and provide:
1. Detailed execution report for each stage
2. Constitutional compliance check results
3. Metrics aggregation summary
4. Optimization recommendations and assetization results
5. Visualization dashboard links

## Expected Outcomes
- Constitutional compliance score ≥ 95%
- Requirement traceability = 100%
- Test coverage ≥ 90%
- Business value alignment ≥ 90%
- Optimization efficiency gain ≥ 15%
- Assetized successful patterns ≥ 2
```

### Prompt Optimization Tips

1. **Define Business Value Clearly**: Always start with the BMAD framework, clarifying business goals, metrics, architecture, and data
2. **Specify Tech Stack**: Clearly define backend, frontend, database, and other technology choices
3. **Configure Constitution Options**: Adjust constitution strictness and evolution thresholds based on project requirements
4. **Enable Optimization Features**: Explicitly request recursive optimization, assetization, and automation
5. **Specify Output Format**: Request detailed execution reports, visualization dashboards, and optimization recommendations
6. **Set Quality Gates**: Define minimum requirements for constitutional compliance, test coverage, and code quality
7. **Configure Collaboration Flow**: Specify stages requiring approval and approvers
8. **Enable Visualization**: Request real-time updated dashboards and multiple export formats

### Skill Statistics

According to the detailed list in [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md):

- **Total Skills**: 38
- **Execution Layer**: 6 (BDD, TDD, Test Analysis, SIT, Chaos, ATDD)
- **Strategic Layer**: 5 (BMAD, Metrics, ADR, Data Flow, Requirements Collection)
- **Tactical Layer**: 7 (Parsing, Constitution, Tracing, Evolution, Architecture Selection, Code Generation, Contract Testing)
- **AI Collaboration Layer**: 4 (Context, Recommendation, Optimization, Templates)
- **Go + Vue + Quasar Fullstack Development Layer**: 6 (Backend Scaffolder, Frontend Scaffolder, Project Initialization, Documentation Generation, Workflow Coordination, Makefile Generation)
- **Tools & Integration Layer**: 2 (Skill Packaging, CLI Builder)
- **Methodology Fusion Orchestration Layer**: 1 (Methodology Fusion Orchestrator)

### Skill File Format

Each skill follows the OpenCode specification:

```markdown
---
name: skill-name
description: Use when [specific triggering conditions]
---

# Skill Title

## Overview
[What this skill does in 1-2 sentences]

## When to Use
[When to apply this skill]

## Core Pattern
[Before/After comparison]

## Quick Reference
[Table of common operations]

## Implementation
[Code examples and patterns]

## Common Mistakes
[What goes wrong and how to fix it]

## Real-World Impact
[Concrete results and benefits]
```

## Aether.go Methodology Integration

These skills are deeply integrated with the Aether.go core methodology, covering the complete software development lifecycle:

### Eight-Stage Methodology Fusion Workflow

See complete workflow diagram in [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md):

1. **Stage 1: Business Analysis**
   - `business-requirements-collector` - Collect and analyze business requirements
   - `business-value-mapper` - Map business objectives to technical metrics
   - `metrics-definer` - Define measurable business and technical metrics

2. **Stage 2: Specification Definition**
   - `spec-parser` - Parse natural language requirements into structured specifications
   - `bdd-scenario-writer` - Convert requirements to Gherkin BDD scenarios
   - `atdd-acceptance-test-generator` - Generate executable acceptance tests

3. **Stage 3: Constitutional Review**
   - `constitution-validator` - Validate that code and specifications comply with architectural principles

4. **Stage 4: Implementation Planning**
   - `architecture-decision-recorder` - Record architecture decisions (ADR)
   - `data-flow-analyzer` - Analyze data flow and value chain
   - `architecture-pattern-selector` - Select appropriate architecture patterns

5. **Stage 5: Code Generation**
   - `tdd-red-green-refactor` - Implement features using TDD methodology
   - `go-backend-scaffolder` - Generate Go backend code
   - `vue-quasar-scaffolder` - Generate Vue frontend components
   - `generic-code-generator` - Generate code across languages

6. **Stage 6: Integration Validation**
   - `sit-scenario-generator` - Generate system integration test scenarios
   - `chaos-test-designer` - Design chaos engineering experiments
   - `test-pyramid-analyzer` - Analyze test coverage and distribution
   - `contract-test-generator` - Generate contract tests

7. **Stage 7: Deployment & Operations**
   - `deployment-orchestrator` - Advanced deployment strategy orchestration
   - `release-manager` - Release planning and version management
   - `incident-management` - ITIL-aligned incident handling
   - `problem-management` - Root cause analysis
   - `change-management` - Controlled change process
   - `service-desk` - User request and issue management
   - `rollback-manager` - Automatic rollback of failed deployments

8. **Stage 8: Recursive Optimization**
   - `methodology-fusion-orchestrator` - Coordinate end-to-end methodology fusion workflow
   - `recursive-optimizer` - Optimize skills based on feedback
   - `skill-recommender` - Intelligently recommend relevant skills
   - `prompt-template-manager` - Manage prompt templates

### Core Methodologies

- **BMAD** (Business-Driven Metrics) - Business-driven metrics
  - `business-requirements-collector` - Collect and analyze business requirements
  - `business-value-mapper` - BMAD business value mapping
  - `metrics-definer` - Define business and technical metrics

- **SDD** (Spec-Driven Development) - Specification-driven development
  - `spec-parser` - Parse natural language requirements into structured specifications
  - `spec-to-code-tracer` - Establish bidirectional tracing between specifications and code
  - `spec-evolution-tracker` - Track specification change history

- **Constitution** - Constitution constraint principles
  - `constitution-validator` - Validate constitution principle compliance
  - `architecture-decision-recorder` - Record architecture decisions (ADR)

- **Testing** - Test-driven development
  - `bdd-scenario-writer` - Convert requirements to Gherkin BDD scenarios
  - `tdd-red-green-refactor` - Guide TDD RED-GREEN-REFACTOR cycle
  - `test-pyramid-analyzer` - Analyze test distribution and coverage
  - `atdd-acceptance-test-generator` - Generate ATDD acceptance tests

- **Resilience** - Resilience and reliability
  - `sit-scenario-generator` - Generate system integration test scenarios
  - `chaos-test-designer` - Design chaos engineering experiments
  - `contract-test-generator` - Generate contract tests to ensure microservice compatibility

- **Methodology Fusion** - Methodology fusion orchestration
  - `methodology-fusion-orchestrator` - Coordinate end-to-end methodology fusion workflow
  - `context-manager` - Manage project context
  - `recursive-optimizer` - Optimize skills based on feedback

## Development & Maintenance

### Adding New Skills

1. Create a new subdirectory in the `skills/` directory
2. Add a `SKILL.md` file
3. Follow the writing-skills specification and TDD principles
4. Run `./skills.sh validate` to verify format
5. Update [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) to add new skill description

### Modifying Existing Skills

1. Read the `SKILL.md` file
2. Modify using TDD methodology (write tests first)
3. Use recursive-optimizer for continuous improvement
4. Run `./skills.sh validate` to verify format
5. Update [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) to update skill description

### Testing Skills

Use subagent-driven development for skill validation:

```bash
# Test skill effectiveness
python scripts/test-skill.py <skill-name>

# Or use skills.sh to validate
./skills.sh validate <skill-name>
```

### Skill Version Management

All skill files should be under Git version control:

```bash
# Add new skills or modifications
git add skills/<skill-name>/SKILL.md
git add SKILLS_SUMMARY.md
git add README.md

# Commit changes
git commit -m "feat: add/update <skill-name> skill"
```

## Contributing

Contributions are welcome!

### Contribution Process

1. Fork the project
2. Create a feature branch (`git checkout -b feature/my-skill`)
3. Follow the writing-skills specification
4. Run `./skills.sh validate` to verify format
5. Update [SKILLS_SUMMARY.md](SKILLS_SUMMARY.md) to add new skill description
6. Update [README.md](README.md) with relevant documentation links
7. Submit a Pull Request

### Skill Specification

Each skill must follow these specifications:

1. **File Naming**: `skills/<skill-name>/SKILL.md` (SKILL.md must be uppercase)
2. **YAML Frontmatter**: Must include `name` and `description` fields
3. **Description Format**: Must start with "Use when"
4. **Naming Convention**: Skill names use lowercase letters, numbers, and hyphens
5. **Content Structure**: Include Overview, When to Use, Core Pattern, Quick Reference, Implementation, Common Mistakes, Real-World Impact

### Code Review Checklist

- [ ] Skill file is in the correct directory
- [ ] Filename is `SKILL.md` (uppercase)
- [ ] Contains required YAML frontmatter
- [ ] description starts with "Use when"
- [ ] Follows OpenCode specification
- [ ] Updated SKILLS_SUMMARY.md
- [ ] Run `./skills.sh validate`
- [ ] Added necessary tests

## License

This project is licensed under MIT License - see [LICENSE](LICENSE) file for details

---

Created: 2026-01-16
Last Updated: 2026-01-29
Maintainer: Aether.go Team

## Changelog

### 2026-01-29
- Removed all bitcms references to make skills more universally applicable
- Enhanced README.md documentation, added links to SKILLS_SUMMARY and MIGRATION
- Added quick start guide for skills
- Improved skill classification and statistics
- Added contribution process and code review checklist
- Added English and Chinese versions of documentation
