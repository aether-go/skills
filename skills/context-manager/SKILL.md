---
name: context-manager
description: Use when managing project context, conversation history, and information retrieval for efficient AI assistance. Implements P7 Context-First Principle.
---

# Context Manager

## Overview
Manage project context, conversation history, and information to provide AI assistants with relevant information while minimizing context token usage. **Implements the Aether.go constitutional principle P7: Context-First Principle (上下文第一性原则).**

> **P7: Context-First Principle**
> AI-assisted development effectiveness depends on input context quality; context preparation precedes code generation.
> 
> *AI-generated code quality ∝ Input context quality*

## When to Use

```
Long conversation history? ──────────────┐
                                        │
Need to summarize context? ──────────────┤
                                        ├─► Use context-manager
Switching projects/tasks? ──────────────┤
                                        │
Saving important decisions? ──────────────┘
```

Use when:
- Conversation exceeds context limits
- Need to recall previous decisions
- Switching between projects/tasks
- Saving important discussions
- Preparing context for new sessions
- Documenting project knowledge
- **Implementing P7 Context-First Principle before code generation**

Don't use when:
- Simple one-off questions
- Short conversations (< 50 messages)
- No reuse expected

## Core Pattern

### P7 Context-First Principle Implementation

The Context Manager directly implements **P7: Context-First Principle** from the Aether.go constitution.

**Context Completeness Checklist (P7):**

Before any code generation, ensure context includes:

```yaml
context_completeness:
  requirements_context:
    - user_stories: "User needs and goals"
    - acceptance_criteria: "GWT format specifications"
    - business_rules: "Domain constraints and rules"
    - priority: "MUST HAVE before code generation"
    
  technical_context:
    - architecture_constraints: "System boundaries and patterns"
    - interface_contracts: "API definitions and protocols"
    - data_models: "Domain entities and relationships"
    - tech_stack: "Languages, frameworks, tools"
    - priority: "MUST HAVE before code generation"
    
  quality_context:
    - performance_requirements: "Latency, throughput, scalability"
    - security_constraints: "Authentication, authorization, data protection"
    - compliance_requirements: "Regulatory and standards compliance"
    - priority: "SHOULD HAVE before code generation"
```

**Context Quality Metrics:**

| Metric | Target | Measurement |
|--------|--------|-------------|
| Context Coverage | > 90% | % of required context items present |
| Context Relevance | > 85% | % of context used in generation |
| Context Freshness | < 7 days | Age of most recent update |
| Context Accuracy | > 95% | % of context verified as correct |

### Context Storage Locations

Context is stored according to `.aether/context/` directory structure:

```
.aether/context/
├── active/                     # Current active contexts
│   └── conv-{timestamp}.json
├── archived/                   # Archived contexts
│   └── 2024-03/
└── templates/                  # Context templates
    ├── specification.json
    ├── coding.json
    └── review.json
```

### Context Structure

```yaml
session_context:
  session_id: "conv-20260116-001"
  project: "aether-go"
  timestamp: "2026-01-16T10:00:00Z"
  storage_path: ".aether/context/active/conv-20260116-001.json"

  project_summary: |
    Aether.go is a methodology-driven development framework
    integrating BMAD, SDD, and constitutional principles.

  current_task: "Creating agent skills"
  task_state: "in_progress"

  key_decisions:
    - decision: "Use OpenCode skill format"
      date: "2026-01-16"
      rationale: "Standard format ensures discoverability"

  relevant_files:
    - ".opencode/skill/bdd-scenario-writer/SKILL.md"
    - "overall.md"

  context_size: 1250 tokens
  max_size: 2000 tokens
```

## Implementation

### Context Path Management

```python
from pathlib import Path
from datetime import datetime
import yaml

class ContextPathManager:
    """Manages context storage paths within .aether directory."""
    
    BASE_PATH = '.aether/context'
    
    @classmethod
    def get_active_path(cls, conversation_id=None, base_path='.'):
        """Get path for active context file."""
        if conversation_id is None:
            timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
            conversation_id = f"conv-{timestamp}"
        
        active_dir = Path(base_path) / cls.BASE_PATH / 'active'
        active_dir.mkdir(parents=True, exist_ok=True)
        return active_dir / f"{conversation_id}.json"
    
    @classmethod
    def get_archived_path(cls, conversation_id, year_month=None, base_path='.'):
        """Get path for archived context file."""
        if year_month is None:
            year_month = datetime.now().strftime('%Y-%m')
        
        archived_dir = Path(base_path) / cls.BASE_PATH / 'archived' / year_month
        archived_dir.mkdir(parents=True, exist_ok=True)
        return archived_dir / f"{conversation_id}.json"
    
    @classmethod
    def get_template_path(cls, template_name, base_path='.'):
        """Get path for context template file."""
        templates_dir = Path(base_path) / cls.BASE_PATH / 'templates'
        templates_dir.mkdir(parents=True, exist_ok=True)
        return templates_dir / f"{template_name}.json"
    
    @classmethod
    def list_active_contexts(cls, base_path='.'):
        """List all active context files."""
        active_dir = Path(base_path) / cls.BASE_PATH / 'active'
        if not active_dir.exists():
            return []
        return list(active_dir.glob('conv-*.json'))
```

### Context Summarization

```python
def summarize_conversation(messages, max_tokens=500):
    """Summarize conversation to reduce context size."""

    # Extract key decisions and actions
    decisions = extract_decisions(messages)
    code_blocks = extract_code_blocks(messages)
    questions = extract_questions(messages)

    summary = f"""
## Summary

### Decisions Made
{format_list(decisions)}

### Code Changes
{format_code_blocks(code_blocks[:5])}

### Open Questions
{format_list(questions)}

### Current Task
{messages[-1].content}
"""

    # Ensure within token limit
    while count_tokens(summary) > max_tokens:
        summary = reduce_summary(summary)

    return summary
```

### Context Retrieval

```python
def retrieve_relevant_context(query, knowledge_base, base_path='.'):
    """Retrieve relevant context based on query."""

    # Vector similarity search
    relevant_docs = knowledge_base.search(query, top_k=5)

    context = {
        'relevant_files': [d['file'] for d in relevant_docs],
        'key_concepts': [d['concepts'] for d in relevant_docs],
        'similar_conversations': find_similar_conversations(query),
        'storage_paths': {
            'active': str(ContextPathManager.get_active_path(base_path=base_path)),
            'archived': str(ContextPathManager.get_archived_path('conv-20260116-001', base_path=base_path)),
            'templates': str(ContextPathManager.get_template_path('specification', base_path=base_path))
        }
    }

    return context
```

### Context Update Strategy

```python
def update_context(context, new_information, base_path='.'):
    """Update context with new information."""

    # Determine information type
    if new_information.type == 'decision':
        context['key_decisions'].append(new_information)
        # Also log to memory
        _append_to_memory('decisions', new_information, base_path)

    elif new_information.type == 'code_change':
        context['code_changes'].append(new_information)

    # Check context size
    if calculate_size(context) > context['max_size']:
        # Archive old context before pruning
        _archive_context(context, base_path)
        context = prune_old_context(context)

    return context

def _append_to_memory(memory_type, information, base_path='.'):
    """Append information to memory files."""
    memory_path = Path(base_path) / '.aether/memory' / f'{memory_type}.md'
    memory_path.parent.mkdir(parents=True, exist_ok=True)
    
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    with open(memory_path, 'a', encoding='utf-8') as f:
        f.write(f"\n## {timestamp}\n\n{information}\n")

def _archive_context(context, conversation_id, base_path='.'):
    """Archive current context before pruning."""
    year_month = datetime.now().strftime('%Y-%m')
    archive_path = ContextPathManager.get_archived_path(conversation_id, year_month, base_path)
    
    with open(archive_path, 'w', encoding='utf-8') as f:
        json.dump(context, f, indent=2)
```
