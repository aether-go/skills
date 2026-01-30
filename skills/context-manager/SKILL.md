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

### Context Structure

```yaml
session_context:
  session_id: "sess-20260116-001"
  project: "aether-go"
  timestamp: "2026-01-16T10:00:00Z"

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
def retrieve_relevant_context(query, knowledge_base):
    """Retrieve relevant context based on query."""

    # Vector similarity search
    relevant_docs = knowledge_base.search(query, top_k=5)

    context = {
        'relevant_files': [d['file'] for d in relevant_docs],
        'key_concepts': [d['concepts'] for d in relevant_docs],
        'similar_conversations': find_similar_conversations(query)
    }

    return context
```

### Context Update Strategy

```python
def update_context(context, new_information):
    """Update context with new information."""

    # Determine information type
    if new_information.type == 'decision':
        context['key_decisions'].append(new_information)

    elif new_information.type == 'code_change':
        context['code_changes'].append(new_information)

    # Check context size
    if calculate_size(context) > context['max_size']:
        context = prune_old_context(context)

    return context
```
