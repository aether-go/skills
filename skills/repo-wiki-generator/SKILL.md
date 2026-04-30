---
name: repo-wiki-generator
description: Use when generating or updating the repository wiki knowledge engine component with architecture encyclopedia, design decisions, and onboarding guides. Part of D7 Knowledge Engine Domain.
---

# Repo-Wiki Generator

## Overview
Generate or update the repository wiki knowledge engine component with architecture encyclopedia, design decisions (ADRs), and onboarding guides. Provides comprehensive documentation for context enrichment and team onboarding.

## When to Use

```
Need project documentation? ─────────────┐
                                         │
Building repo-wiki? ─────────────────────┤
                                         ├─► Use repo-wiki-generator
Updating architecture decisions? ────────┤
                                         │
Onboarding guides needed? ───────────────┘
```

Use when:
- Need to generate project documentation
- Building or updating repo-wiki knowledge engine
- Architecture decisions need to be documented
- Onboarding guides are needed for new team members

Don't use when:
- Documentation already exists and is current
- Only minor updates are needed
- Project is trivial

## Core Pattern

### Generation Process

```
Codebase + Context
    ├── Architecture Overview
    ├── Design Decisions (ADRs)
    ├── Tech Stack Documentation
    ├── Development Guides
    └── Onboarding Materials
         |
         v
    Repo-Wiki Update
         |
         v
    Context Enrichment
```

### Wiki Structure

| Section | Description | Update Frequency |
|---------|-------------|-----------------|
| **Architecture Overview** | High-level system design | On major changes |
| **ADRs** | Architecture Decision Records | Per decision |
| **Tech Stack** | Technology choices and versions | On updates |
| **Development Guides** | Coding standards, patterns | On process changes |
| **Onboarding** | New team member guides | On process changes |
| **API Documentation** | Interface specifications | On API changes |

## Input Format

```yaml
wiki_request:
  project:
    name: "Aether Platform"
    description: "AI-native development platform"
  
  codebase:
    path: "/project"
    language: "go"
  
  existing_docs:
    adrs: ".aether/decisions/"
    readme: "README.md"
  
  output:
    path: ".aether/repo-wiki/"
    format: "markdown"
```

## Output Format

```yaml
wiki_result:
  project: "Aether Platform"
  last_updated: "2026-04-30T10:00:00Z"
  
  pages:
    - title: "Architecture Overview"
      path: "architecture/overview.md"
      sections: ["System Diagram", "Component List", "Data Flow"]
    
    - title: "ADR-001: Authentication Strategy"
      path: "decisions/adr-001.md"
      status: accepted
      date: "2026-04-15"
    
    - title: "Tech Stack"
      path: "guides/tech-stack.md"
      technologies: ["Go", "Gin", "PostgreSQL", "Redis"]
    
    - title: "Getting Started"
      path: "onboarding/getting-started.md"
      estimated_time: "30 minutes"
    
    - title: "API Reference"
      path: "api/reference.md"
      endpoints: 24
  
  coverage: 0.85
  
  metrics:
    total_pages: 15
    adrs: 5
    guides: 6
    onboarding: 2
    api_docs: 2
```

## Integration with Aether.go Methodology

- **Input from**: ContextManager, code-graph-analyzer
- **Output to**: ContextManager, harness-reverse-construction-workflow
- **Part of**: D7 Knowledge Engine Domain

## Examples

### Example 1: New Project
```yaml
project: "E-commerce Platform"
pages: 12
coverage: 0.80
sections: ["Architecture", "ADRs", "Guides", "Onboarding"]
output: ".aether/repo-wiki/"
```

### Example 2: Legacy Documentation
```yaml
project: "Legacy Banking System"
pages: 25
coverage: 0.90
sections: ["Architecture", "ADRs", "Guides", "Onboarding", "Migration"]
output: ".aether/repo-wiki/"
```
