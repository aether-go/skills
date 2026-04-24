---
name: semantic-intent-clarifier
description: Use when generating structured reverse clarification questions at critical requirement semantic nodes to prevent perfect derivation but wrong software
---

# Semantic Intent Clarifier

## Overview
Generate structured reverse clarification questions at critical requirement semantic nodes to prevent "perfect derivation, wrong software". Executes ARGUE-005 semantic confirmation protocol by challenging the alignment between decomposed functional requirements and original business intent.

## When to Use

```
Business goal decomposed? ───────────────┐
                                         │
Need semantic validation? ───────────────┤
                                         ├─► Use semantic-intent-clarifier
ARGUE-005 triggered? ────────────────────┤
                                         │
Critical requirement node reached? ──────┘
```

Use when:
- Business goal decomposition is complete (L1->L2)
- Need to validate semantic alignment between requirements and intent
- ARGUE-005 protocol is triggered by HumanAIBoundaryGuard
- Critical requirement semantic node reached
- Before establishing core specifications (L2->L3 transition)

Don't use when:
- Business goals are not yet decomposed
- Only technical implementation details need clarification
- Requirements are already validated and confirmed

## Core Pattern

### ARGUE-005 Protocol Flow

```
Business Goal Decomposition Complete (L1->L2)
    |
    v
HumanAIBoundaryGuard triggers ARGUE-005
    |
    v
SemanticIntentClarifier generates structured questions
    |
    v
Questions issued to user/developer
    |
    v
User provides structured response
    |
    v
Semantic alignment validated or corrected
```

### Clarification Question Types

| Question Type | Purpose | Example |
|--------------|---------|---------|
| **Intent Validation** | Verify decomposition matches original intent | "Does FR-001 accurately reflect BG-001?" |
| **Scope Confirmation** | Confirm requirement scope | "Are social login methods within scope?" |
| **Priority Verification** | Validate priority alignment | "Is priority ranking aligned with business value?" |
| **Exception Clarification** | Clarify edge case behavior | "What should happen when [edge case] occurs?" |
| **Stakeholder Alignment** | Confirm stakeholder consensus | "Have all stakeholders confirmed this interpretation?" |
| **Assumption Challenge** | Surface hidden assumptions | "Are you assuming users have email addresses?" |
| **Success Criteria** | Define measurable success | "How will you know when this requirement is met?" |

### Before (Without Semantic Clarification)
```yaml
business_goal: "Improve user onboarding"

decomposition:
  fr-001: "Add tutorial overlay"
  fr-002: "Send welcome email"
  fr-003: "Create user profile page"

result:
  - Tutorial overlay is annoying, users skip it
  - Welcome email goes to spam
  - Profile page is empty and confusing
  - Business goal NOT achieved despite "perfect" derivation
```

### After (With Semantic Clarification)
```yaml
business_goal: "Improve user onboarding"

semantic_clarification:
  q1:
    type: "intent_validation"
    question: "When you say 'improve onboarding', do you mean reduce time-to-value or increase completion rate?"
    response: "Reduce time-to-value - users should complete first transaction within 5 minutes"
    
  q2:
    type: "assumption_challenge"
    question: "Are you assuming users already know what your product does?"
    response: "No, most users discover us through ads and don't understand the value proposition"
    
  q3:
    type: "success_criteria"
    question: "How will you measure onboarding improvement?"
    response: "Time to first transaction < 5 minutes, onboarding completion rate > 80%"

decomposition:
  fr-001: "Value proposition explanation on first screen"
  fr-002: "Progressive disclosure - only ask essential info"
  fr-003: "Skip optional steps, allow completion later"
  fr-004: "First transaction guided flow with clear CTA"
  fr-005: "Welcome email with quick-start guide (not just greeting)"

result:
  - Users understand value proposition immediately
  - Reduced form friction increases completion
  - Guided first transaction achieves time-to-value goal
  - Business goal ACHIEVED through semantic alignment
```

## Quick Reference

### Question Generation Rules

1. **One Question Per Semantic Node**: Each question targets a specific ambiguity
2. **Multiple Choice Where Possible**: Reduce user cognitive load
3. **Provide Context**: Include the requirement being questioned
4. **Suggest Alternatives**: Offer options to guide thinking
5. **Track Assumptions**: Surface hidden assumptions explicitly

### Critical Semantic Nodes

| Node | When to Clarify | Typical Questions |
|------|----------------|-------------------|
| **Business Goal -> Functional Requirements** | After value-decomposer | Intent validation, scope confirmation |
| **Functional Requirements -> Use Cases** | After usecase-designer | Actor identification, flow validation |
| **Use Cases -> Specifications** | After spec-parser | Edge cases, NFR clarification |
| **Specifications -> Architecture** | After architecture decisions | Technical constraints, scalability |
| **Architecture -> Implementation** | Before coding | Technology choices, integration points |

## Implementation

### Question Generator

```python
class SemanticIntentClarifier:
    def __init__(self, decomposition_output):
        self.decomposition = decomposition_output
        self.questions = []
        
    def generate_questions(self):
        """Generate structured clarification questions."""
        
        # Intent validation questions
        self.add_intent_validation_questions()
        
        # Scope confirmation questions
        self.add_scope_confirmation_questions()
        
        # Priority verification questions
        self.add_priority_verification_questions()
        
        # Exception clarification questions
        self.add_exception_clarification_questions()
        
        # Assumption challenge questions
        self.add_assumption_challenge_questions()
        
        return self.questions
    
    def add_intent_validation_questions(self):
        """Add questions to validate decomposition intent."""
        
        for fr in self.decomposition.functional_requirements:
            question = {
                'type': 'intent_validation',
                'question': f"Does '{fr.description}' accurately reflect the business goal '{fr.business_goal}'?",
                'expected_response_type': 'boolean_with_rationale',
                'context': {
                    'business_goal': fr.business_goal,
                    'functional_requirement': fr.id,
                    'description': fr.description
                }
            }
            self.questions.append(question)
    
    def add_scope_confirmation_questions(self):
        """Add questions to confirm requirement scope."""
        
        # Identify ambiguous scope items
        ambiguous_items = self.identify_ambiguous_scope()
        
        for item in ambiguous_items:
            question = {
                'type': 'scope_confirmation',
                'question': f"Is '{item.description}' within the scope of this iteration?",
                'expected_response_type': 'enum',
                'options': ['in_scope', 'out_of_scope', 'future_iteration'],
                'context': {
                    'item': item.id,
                    'description': item.description
                }
            }
            self.questions.append(question)
    
    def identify_ambiguous_scope(self):
        """Identify items with ambiguous scope."""
        
        ambiguous = []
        for fr in self.decomposition.functional_requirements:
            # Check for vague terms
            vague_terms = ['etc', 'and so on', 'including but not limited to', 'future']
            if any(term in fr.description.lower() for term in vague_terms):
                ambiguous.append(fr)
            
            # Check for unspecified options
            if 'options' in fr.description.lower() and not fr.get('options'):
                ambiguous.append(fr)
        
        return ambiguous
```

## Output Format

```yaml
semantic_clarification:
  clarification_id: "ARGUE005-20250424-001"
  checkpoint: "L1-decomposition-complete"
  trigger_skill: "value-decomposer"
  
  clarification_questions:
    - id: "Q1"
      type: "intent_validation"
      question: "Does FR-001 (user registration) fully capture BG-001 (grow user base)?"
      expected_response_type: "boolean_with_rationale"
      context:
        business_goal: "BG-001: Grow user base by 30%"
        functional_requirement: "FR-001: Multi-channel user registration"
      
    - id: "Q2"
      type: "scope_confirmation"
      question: "Are social login methods (WeChat/Google) within the scope of this iteration?"
      expected_response_type: "enum"
      options: ["in_scope", "out_of_scope", "future_iteration"]
      context:
        functional_requirement: "FR-001: Multi-channel user registration"
        
    - id: "Q3"
      type: "exception_clarification"
      question: "How should the system handle duplicate email registration attempts?"
      expected_response_type: "text"
      context:
        functional_requirement: "FR-001: Multi-channel user registration"
        
    - id: "Q4"
      type: "assumption_challenge"
      question: "Are you assuming all users have email addresses?"
      expected_response_type: "boolean_with_alternative"
      context:
        functional_requirement: "FR-001: Multi-channel user registration"
        
  deadline: "2025-04-24T14:00:00Z"
  suspension_reason: "awaiting_semantic_confirmation"
```

## Integration with Aether.go Methodology

- **Input from**: value-decomposer (decomposition output), business-requirements-collector (business goals)
- **Output to**: human-ai-boundary-guard (ARGUE-005 execution)
- **Validates with**: correctness-checker (question quality)
- **Part of**: D8 Meta-Capability Domain (ARGUE-005 execution)

## Validation Rules

- Each question MUST target a specific semantic ambiguity
- Questions MUST be answerable by the user
- Context MUST be provided for each question
- Response types MUST be specified
- Questions MUST cover all critical semantic nodes
- At least one question MUST validate intent alignment
