---
name: context-manager
description: Use when managing project context, conversation history, and information retrieval for efficient AI assistance
---

# Context Manager

## Overview
Manage project context, conversation history, and information to provide AI assistants with relevant information while minimizing context token usage. Enables efficient, focused assistance.

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

Don't use when:
- Simple one-off questions
- Short conversations (< 50 messages)
- No reuse expected

## Core Pattern

### Context Storage Locations

Context is stored in three tiers within `.aether/context/`:

```
.aether/context/
├── session/                    # Temporary session contexts
│   └── sess-{timestamp}.yaml
├── project/                    # Persistent project context
│   ├── context.yaml            # Main project context
│   └── history/                # Context version history
└── global/                     # Global shared context
    └── context.yaml
```

### Context Structure

```yaml
session_context:
  session_id: "sess-20260116-001"
  project: "aether-go"
  timestamp: "2026-01-16T10:00:00Z"
  storage_path: ".aether/context/session/sess-20260116-001.yaml"

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
    def get_session_path(cls, session_id=None, base_path='.'):
        """Get path for session context file."""
        if session_id is None:
            timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
            session_id = f"sess-{timestamp}"
        
        session_dir = Path(base_path) / cls.BASE_PATH / 'session'
        session_dir.mkdir(parents=True, exist_ok=True)
        return session_dir / f"{session_id}.yaml"
    
    @classmethod
    def get_project_path(cls, base_path='.'):
        """Get path for project context file."""
        project_dir = Path(base_path) / cls.BASE_PATH / 'project'
        project_dir.mkdir(parents=True, exist_ok=True)
        return project_dir / 'context.yaml'
    
    @classmethod
    def get_global_path(cls, base_path='.'):
        """Get path for global context file."""
        global_dir = Path(base_path) / cls.BASE_PATH / 'global'
        global_dir.mkdir(parents=True, exist_ok=True)
        return global_dir / 'context.yaml'
    
    @classmethod
    def get_history_path(cls, base_path='.'):
        """Get path for context history directory."""
        history_dir = Path(base_path) / cls.BASE_PATH / 'project' / 'history'
        history_dir.mkdir(parents=True, exist_ok=True)
        return history_dir
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
            'session': str(ContextPathManager.get_session_path(base_path=base_path)),
            'project': str(ContextPathManager.get_project_path(base_path=base_path)),
            'global': str(ContextPathManager.get_global_path(base_path=base_path))
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

def _archive_context(context, base_path='.'):
    """Archive current context before pruning."""
    history_dir = ContextPathManager.get_history_path(base_path)
    timestamp = datetime.now().strftime('%Y%m%d-%H%M%S')
    archive_path = history_dir / f"context-{timestamp}.yaml"
    
    with open(archive_path, 'w', encoding='utf-8') as f:
        yaml.dump(context, f)
```
