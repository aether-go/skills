---
name: service-desk
description: Use when managing user requests, incidents, and service inquiries through single point of contact following ITIL service desk practices
---

# Service Desk

## Overview
Provide single point of contact for users to report incidents, make service requests, and seek information. Streamline request fulfillment, incident logging, and communication while maintaining service catalog and knowledge base for efficient resolution.

## When to Use

```
User needs help? ───────────────────┐
                                     │
Service request? ────────────────────┤
                                     ├─► Use service-desk
Incident reporting? ─────────────────┤
                                     │
Information or access needed? ───────┘
```

Use when:
- Users report issues or need assistance
- Service requests require fulfillment
- Access management requests (onboarding, offboarding)
- Information and documentation requests
- Coordinating between users and technical teams
- Managing service catalog and request workflows
- Tracking and reporting on service performance
- Maintaining knowledge base for self-service

Don't use when:
- Direct technical implementation (use specific technical skills)
- Strategic planning or architecture decisions
- Major incident management (use incident-management skill)
- Problem investigation (use problem-management skill)
- Change implementation (use change-management skill)

## Core Pattern

### ITIL Service Desk Operation Model

```
User Contact → Request Capture → Classification → Routing → Fulfillment → Closure
    ↓              ↓              ↓            ↓         ↓           ↓
Multiple     Standardized    Service     Automatic   Workflow   User
Channels     Forms &        Catalog     or Manual   Tracking   Satisfaction
             Templates                 Assignment              Survey
    ↓
Knowledge Base ←── Resolution & Communication ←── Status Updates
    ↓                      ↓                           ↓
Self-Service         Timely Updates            Proactive Notifications
Articles            to Users                  on Progress
```

### Before (Fragmented Support)
```yaml
Scenario: User needs access to reporting tool
Approach:
  - User emails random IT staff
  - Email gets lost or ignored
  - User tries Slack, gets partial response
  - Different people give conflicting information
  - No tracking of request status
  - Access takes days to provision
  - No record of who approved or implemented
Result: User frustration, security risk, inefficiency, no metrics
```

### After (Structured Service Desk)
```yaml
Scenario: User needs access to reporting tool
Process:
  1. User Contact:
     - Uses self-service portal
     - Selects "Access Request" from service catalog
     - Fills standardized form with details
     
  2. Request Capture:
     - Ticket SR-2025-001 automatically created
     - All details captured in structured format
     - Automated validation of required information
     
  3. Classification & Routing:
     - Classified as "Access Management" request
     - Routed to Identity & Access Management team
     - Priority set based on user role and urgency
     
  4. Fulfillment Workflow:
     - Automated approval workflow triggered
     - Manager approval obtained (automated email)
     - IAM team provisions access (15 minutes)
     - Automated verification of access granted
     
  5. Communication:
     - User receives acknowledgement immediately
     - Status updates at each stage
     - Completion notification with instructions
     
  6. Closure & Feedback:
     - Ticket closed with resolution details
     - User satisfaction survey sent
     - Knowledge base article referenced
     - Metrics recorded for reporting

Outcome:
  - Request fulfilled in 30 minutes (vs days)
  - Complete audit trail
  - User satisfaction: 5/5
  - Process efficiency metrics captured
  - Knowledge base improved
```

## Quick Reference

### Service Desk Channels

| Channel | Best For | Response Time | Automation Level |
|---------|----------|---------------|------------------|
| **Self-Service Portal** | Standard requests, knowledge lookup | Immediate (automated) | High |
| **Email** | Formal requests, documentation | < 4 hours | Medium |
| **Chat/Chatbot** | Quick questions, simple issues | < 15 minutes | High |
| **Phone** | Urgent issues, complex explanations | < 5 minutes | Low |
| **Walk-up** | Hands-on assistance, training | Variable | None |
| **API/Webhook** | Automated integrations, monitoring alerts | Immediate | Very High |

### Service Request Types

| Request Type | Examples | SLA | Automation Potential |
|--------------|----------|-----|----------------------|
| **Access Management** | User onboarding, access changes, offboarding | 4 hours | High |
| **Software Requests** | Application installation, license requests | 8 hours | Medium |
| **Hardware Requests** | Laptop provision, peripheral requests | 24 hours | Low |
| **Information Requests** | Documentation, reports, data requests | 8 hours | High |
| **Service Configuration** | Email setup, shared drive access | 4 hours | Medium |
| **Incident Reporting** | System issues, error reports | Based on severity | Medium |
| **Problem Reporting** | Recurring issue reports | 24 hours | Low |

### Service Level Agreements (SLAs)

```yaml
service_level_agreements:
  incident_response:
    critical: "15 minutes"
    high: "1 hour"
    medium: "4 hours"
    low: "8 hours"
    
  request_fulfillment:
    standard: "8 business hours"
    complex: "24 business hours"
    emergency: "2 business hours"
    
  resolution_time:
    critical: "4 hours"
    high: "8 hours"
    medium: "24 hours"
    low: "3 business days"
    
  availability:
    service_desk: "99.5% during business hours"
    self_service: "99.9% 24/7"
    
  customer_satisfaction:
    target: "4.5/5"
    survey_response_rate: "> 30%"
```

### Key Performance Indicators (KPIs)

| KPI | Formula | Target | Purpose |
|-----|---------|--------|---------|
| **First Contact Resolution** | Resolved on first contact / Total contacts | > 70% | Efficiency |
| **Average Response Time** | Sum(response times) / Total tickets | < 15 min | Responsiveness |
| **Average Resolution Time** | Sum(resolution times) / Total tickets | Varies by priority | Effectiveness |
| **SLA Compliance Rate** | Tickets within SLA / Total tickets | > 95% | Reliability |
| **Customer Satisfaction** | Average satisfaction score | > 4.5/5 | Quality |
| **Ticket Volume Trend** | Monthly ticket volume comparison | Stable or decreasing | Workload management |
| **Self-Service Utilization** | Self-service tickets / Total tickets | > 40% | Automation effectiveness |
| **Knowledge Base Usage** | KB articles accessed / Total users | Increasing | Self-help effectiveness |

## Implementation

### Service Desk Workflow Engine

```python
class ServiceDeskWorkflow:
    """ITIL-aligned service desk workflow engine."""
    
    def __init__(self, config):
        self.config = config
        self.ticket_repository = TicketRepository()
        self.service_catalog = ServiceCatalog()
        self.knowledge_base = KnowledgeBase()
        self.notification_service = NotificationService()
        self.automation_engine = AutomationEngine()
        
    def handle_contact(self, contact_data, channel='portal'):
        """Handle user contact through any channel."""
        
        # Check if this is a known issue/solution
        kb_match = self.knowledge_base.find_match(contact_data['description'])
        if kb_match and kb_match['confidence'] > 0.8:
            # Provide immediate self-service solution
            return self._provide_self_service_solution(kb_match, contact_data)
        
        # Create ticket
        ticket = self._create_ticket(contact_data, channel)
        
        # Classify ticket
        classification = self._classify_ticket(ticket)
        ticket.set_classification(classification)
        
        # Route to appropriate queue
        queue = self._determine_queue(ticket)
        ticket.assign_to_queue(queue)
        
        # Apply automation if available
        if self.automation_engine.can_automate(ticket):
            automation_result = self.automation_engine.execute(ticket)
            if automation_result['success']:
                ticket.resolve_with_automation(automation_result)
                return ticket
        
        # Notify user and assignee
        self.notification_service.notify_ticket_created(ticket)
        
        return ticket
    
    def _create_ticket(self, contact_data, channel):
        """Create standardized ticket from contact data."""
        
        ticket = Ticket(
            title=contact_data.get('title', 'Untitled Request'),
            description=contact_data['description'],
            requester=contact_data['requester'],
            contact_channel=channel,
            priority=self._determine_initial_priority(contact_data),
            category=self._determine_initial_category(contact_data),
            created_at=datetime.now()
        )
        
        # Add any attachments
        if 'attachments' in contact_data:
            for attachment in contact_data['attachments']:
                ticket.add_attachment(attachment)
        
        # Check for duplicate tickets
        duplicates = self.ticket_repository.find_duplicates(ticket)
        if duplicates:
            ticket.mark_as_duplicate_of(duplicates[0].id)
        
        ticket_id = self.ticket_repository.save(ticket)
        
        return ticket
    
    def fulfill_service_request(self, ticket_id):
        """Fulfill standard service request."""
        
        ticket = self.ticket_repository.get(ticket_id)
        
        if ticket.type != 'service_request':
            raise ValueError("Ticket is not a service request")
        
        # Get request details from service catalog
        catalog_item = self.service_catalog.get_item(ticket.service_catalog_id)
        
        # Execute fulfillment workflow
        workflow = catalog_item['fulfillment_workflow']
        
        execution_log = {
            'start_time': datetime.now(),
            'steps': [],
            'approvals': [],
            'automated_actions': []
        }
        
        for step in workflow['steps']:
            step_result = self._execute_fulfillment_step(step, ticket)
            execution_log['steps'].append({
                'step': step['name'],
                'result': step_result,
                'timestamp': datetime.now()
            })
            
            if step['type'] == 'approval':
                approval_result = self._handle_approval(step, ticket)
                execution_log['approvals'].append(approval_result)
                
                if not approval_result['approved']:
                    ticket.hold_for_approval(approval_result)
                    break
            
            elif step['type'] == 'automated_action':
                automation_result = self.automation_engine.execute_action(
                    step['action'], ticket
                )
                execution_log['automated_actions'].append(automation_result)
                
                if not automation_result['success']:
                    ticket.flag_for_manual_intervention(automation_result)
                    break
            
            elif step['type'] == 'manual_action':
                # Assign to human for manual fulfillment
                ticket.assign_to_agent(step['role'])
                ticket.status = 'awaiting_manual_fulfillment'
                break
        
        # Check if workflow completed
        if all(s['result']['success'] for s in execution_log['steps']):
            execution_log['end_time'] = datetime.now()
            execution_log['success'] = True
            
            ticket.resolve(execution_log)
            self._notify_fulfillment_complete(ticket)
        else:
            execution_log['success'] = False
            ticket.set_fulfillment_log(execution_log)
        
        self.ticket_repository.update(ticket)
        
        return execution_log
    
    def handle_incident_report(self, ticket_id):
        """Handle incident report from service desk."""
        
        ticket = self.ticket_repository.get(ticket_id)
        
        if ticket.type != 'incident':
            raise ValueError("Ticket is not an incident")
        
        # Classify incident severity
        severity = self._classify_incident_severity(ticket)
        ticket.set_severity(severity)
        
        # Check for known errors
        known_error = self.knowledge_base.find_known_error(ticket)
        if known_error:
            ticket.link_to_known_error(known_error.id)
            
            # Apply known workaround if available
            if known_error.workaround:
                self._apply_known_workaround(ticket, known_error)
                ticket.add_note(f"Applied known workaround from {known_error.id}")
        
        # Route based on severity
        if severity in ['critical', 'high']:
            # Escalate to incident management
            incident_id = self.incident_management.create_from_ticket(ticket)
            ticket.link_to_incident(incident_id)
            ticket.status = 'escalated_to_incident_management'
            
        else:
            # Handle within service desk
            ticket.assign_to_agent('service_desk_agent')
            ticket.status = 'in_progress'
        
        self.ticket_repository.update(ticket)
        
        # Notify user of status
        self.notification_service.notify_incident_status(ticket)
        
        return ticket
    
    def provide_self_service_solution(self, ticket_id, solution_data):
        """Provide self-service solution and update knowledge base."""
        
        ticket = self.ticket_repository.get(ticket_id)
        
        # Check if solution worked
        if solution_data.get('effective', False):
            ticket.resolve_with_self_service(solution_data)
            
            # Update knowledge base if new solution
            if solution_data.get('is_new_solution', False):
                kb_article = self.knowledge_base.create_article(
                    title=solution_data['title'],
                    content=solution_data['solution_steps'],
                    symptoms=ticket.symptoms,
                    resolution=solution_data['resolution'],
                    tags=solution_data.get('tags', [])
                )
                ticket.link_to_knowledge_base(kb_article.id)
                
                # Notify relevant teams about new knowledge
                self.notification_service.notify_new_knowledge(
                    kb_article, ticket.category
                )
        else:
            ticket.add_note("Self-service solution attempted but unsuccessful")
            ticket.status = 'requires_agent_assistance'
        
        self.ticket_repository.update(ticket)
        
        return ticket
```

### Service Catalog Management

```python
class ServiceCatalogManager:
    """Manage service catalog and request workflows."""
    
    def __init__(self):
        self.catalog_repository = CatalogRepository()
        self.workflow_engine = WorkflowEngine()
        self.approval_manager = ApprovalManager()
    
    def create_catalog_item(self, item_data):
        """Create new service catalog item."""
        
        catalog_item = CatalogItem(
            name=item_data['name'],
            description=item_data['description'],
            category=item_data['category'],
            owner=item_data.get('owner'),
            sla=item_data.get('sla', {}),
            cost=item_data.get('cost', {}),
            available_to=item_data.get('available_to', ['all']),
            approval_required=item_data.get('approval_required', False),
            automated_fulfillment=item_data.get('automated_fulfillment', False)
        )
        
        # Create fulfillment workflow
        if item_data.get('fulfillment_workflow'):
            workflow = self._create_fulfillment_workflow(
                item_data['fulfillment_workflow']
            )
            catalog_item.set_fulfillment_workflow(workflow)
        
        # Create request form
        if item_data.get('request_form'):
            request_form = self._create_request_form(
                item_data['request_form']
            )
            catalog_item.set_request_form(request_form)
        
        item_id = self.catalog_repository.save(catalog_item)
        
        # Publish to self-service portal
        self._publish_to_portal(catalog_item)
        
        return item_id
    
    def _create_fulfillment_workflow(self, workflow_spec):
        """Create fulfillment workflow from specification."""
        
        workflow = {
            'version': '1.0',
            'steps': [],
            'conditions': {},
            'timeouts': {},
            'escalations': {}
        }
        
        for step_spec in workflow_spec['steps']:
            step = {
                'name': step_spec['name'],
                'type': step_spec['type'],
                'description': step_spec.get('description'),
                'action': step_spec.get('action'),
                'role': step_spec.get('role'),
                'conditions': step_spec.get('conditions', []),
                'timeout': step_spec.get('timeout'),
                'on_timeout': step_spec.get('on_timeout', 'escalate')
            }
            
            # Validate step based on type
            if step['type'] == 'approval':
                if not step_spec.get('approvers'):
                    raise ValueError("Approval step requires approvers")
                step['approvers'] = step_spec['approvers']
                step['approval_method'] = step_spec.get('approval_method', 'any')
                
            elif step['type'] == 'automated_action':
                if not step_spec.get('action'):
                    raise ValueError("Automated action step requires action")
                step['action'] = step_spec['action']
                step['parameters'] = step_spec.get('parameters', {})
                
            elif step['type'] == 'manual_action':
                if not step_spec.get('role'):
                    raise ValueError("Manual action step requires role")
                step['role'] = step_spec['role']
                step['instructions'] = step_spec.get('instructions')
            
            workflow['steps'].append(step)
        
        return workflow
    
    def get_available_services(self, user_context):
        """Get services available to specific user."""
        
        all_items = self.catalog_repository.get_all()
        
        available_items = []
        for item in all_items:
            if self._is_available_to_user(item, user_context):
                # Format for display
                display_item = {
                    'id': item.id,
                    'name': item.name,
                    'description': item.description,
                    'category': item.category,
                    'sla': item.sla.get('fulfillment_time'),
                    'approval_required': item.approval_required,
                    'automated': item.automated_fulfillment,
                    'popularity': item.request_count
                }
                available_items.append(display_item)
        
        # Sort by category and popularity
        available_items.sort(key=lambda x: (x['category'], -x['popularity']))
        
        return available_items
    
    def analyze_service_usage(self, time_window='90d'):
        """Analyze service catalog usage patterns."""
        
        items = self.catalog_repository.get_all()
        usage_data = []
        
        for item in items:
            requests = self._get_requests_for_item(item.id, time_window)
            
            analysis = {
                'item_id': item.id,
                'item_name': item.name,
                'request_count': len(requests),
                'fulfillment_time_avg': self._calculate_avg_fulfillment_time(requests),
                'sla_compliance': self._calculate_sla_compliance(requests, item.sla),
                'user_satisfaction': self._calculate_user_satisfaction(requests),
                'automation_rate': self._calculate_automation_rate(requests),
                'peak_usage_times': self._analyze_peak_usage(requests),
                'common_issues': self._identify_common_issues(requests)
            }
            
            usage_data.append(analysis)
        
        # Generate recommendations
        recommendations = self._generate_recommendations(usage_data)
        
        return {
            'usage_analysis': usage_data,
            'recommendations': recommendations,
            'time_window': time_window
        }
```

### Knowledge Base Management

```python
class KnowledgeBaseManager:
    """Manage knowledge base for self-service and agent assistance."""
    
    def __init__(self):
        self.article_repository = ArticleRepository()
        self.search_engine = SearchEngine()
        self.analytics = KnowledgeAnalytics()
    
    def create_article(self, article_data):
        """Create knowledge base article."""
        
        article = KnowledgeArticle(
            title=article_data['title'],
            content=article_data['content'],
            category=article_data.get('category', 'general'),
            tags=article_data.get('tags', []),
            symptoms=article_data.get('symptoms', []),
            resolution=article_data.get('resolution', ''),
            author=article_data.get('author'),
            created_at=datetime.now(),
            status='draft'
        )
        
        # Validate content
        if not self._validate_article_content(article):
            raise ValueError("Article content validation failed")
        
        article_id = self.article_repository.save(article)
        
        # Index for search
        self.search_engine.index_article(article)
        
        return article_id
    
    def find_solution(self, query, context=None):
        """Find knowledge base solutions for a query."""
        
        # Search articles
        search_results = self.search_engine.search(
            query=query,
            filters=context,
            limit=10
        )
        
        # Rank results by relevance
        ranked_results = []
        for result in search_results:
            relevance_score = self._calculate_relevance(result, query, context)
            
            ranked_results.append({
                'article_id': result['article_id'],
                'title': result['title'],
                'summary': self._generate_summary(result['content']),
                'relevance_score': relevance_score,
                'category': result['category'],
                'tags': result['tags'],
                'symptoms': result.get('symptoms', []),
                'resolution': result.get('resolution', ''),
                'last_updated': result['last_updated'],
                'helpfulness_score': result.get('helpfulness_score', 0.5)
            })
        
        # Sort by relevance and helpfulness
        ranked_results.sort(
            key=lambda x: (x['relevance_score'], x['helpfulness_score']),
            reverse=True
        )
        
        return ranked_results[:5]  # Top 5 results
    
    def update_article_helpfulness(self, article_id, feedback):
        """Update article helpfulness based on user feedback."""
        
        article = self.article_repository.get(article_id)
        
        current_score = article.helpfulness_score or 0.5
        feedback_score = 1.0 if feedback['helpful'] else 0.0
        
        # Update with exponential moving average
        alpha = 0.1  # Learning rate
        new_score = (alpha * feedback_score) + ((1 - alpha) * current_score)
        
        article.helpfulness_score = new_score
        article.feedback_count = (article.feedback_count or 0) + 1
        
        # Record feedback details
        feedback_record = {
            'timestamp': datetime.now(),
            'helpful': feedback['helpful'],
            'comments': feedback.get('comments'),
            'user_context': feedback.get('user_context')
        }
        article.add_feedback(feedback_record)
        
        # Update article if consistently unhelpful
        if article.feedback_count >= 5 and new_score < 0.3:
            article.status = 'needs_review'
            article.add_note("Low helpfulness score, needs review")
        
        self.article_repository.update(article)
        
        return new_score
    
    def analyze_knowledge_gaps(self, tickets, time_window='30d'):
        """Analyze tickets to identify knowledge gaps."""
        
        unresolved_tickets = [t for t in tickets if t.status != 'resolved']
        
        # Group by symptoms and categories
        symptom_groups = {}
        for ticket in unresolved_tickets:
            symptoms = tuple(sorted(ticket.symptoms or []))
            if symptoms not in symptom_groups:
                symptom_groups[symptoms] = []
            symptom_groups[symptoms].append(ticket)
        
        # Identify gaps (symptoms without articles)
        gaps = []
        for symptoms, tickets in symptom_groups.items():
            if symptoms:
                # Check if knowledge exists for these symptoms
                existing_articles = self.search_engine.search_by_symptoms(symptoms)
                
                if not existing_articles or len(existing_articles) == 0:
                    gaps.append({
                        'symptoms': symptoms,
                        'ticket_count': len(tickets),
                        'ticket_examples': tickets[:3],
                        'category': tickets[0].category if tickets else 'unknown',
                        'priority': self._calculate_gap_priority(tickets)
                    })
        
        # Sort by priority
        gaps.sort(key=lambda x: x['priority'], reverse=True)
        
        return {
            'knowledge_gaps': gaps,
            'total_gaps': len(gaps),
            'time_window': time_window,
            'analysis_date': datetime.now()
        }
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Single channel only | Users can't contact through preferred method | Support multiple channels with unified backend |
| No self-service options | Overwhelms agents with simple requests | Develop comprehensive knowledge base and automation |
| Poor knowledge management | Agents can't find solutions, reinvent wheel | Maintain searchable, updated knowledge base |
| No service catalog | Users don't know what they can request | Publish clear service catalog with SLAs |
| Inadequate training | Agents give inconsistent or wrong answers | Regular training, knowledge sharing sessions |
| No metrics or reporting | Can't improve what you don't measure | Track KPIs, analyze trends, report regularly |
| Ignoring user feedback | Can't improve user experience | Regular surveys, feedback loops, act on insights |
| Siloed from other ITIL processes | Inefficient handoffs, lost context | Integrate with incident, problem, change management |

### Red Flags

- High ticket volume for simple requests
- Low first contact resolution rate
- Poor customer satisfaction scores
- Knowledge base outdated or unused
- Long wait times for response
- High agent turnover
- No service catalog or unclear services
- Multiple systems not integrated
- No self-service adoption
- Repeated questions about same issues

## Real-World Impact

**Before (Chaotic Support):**
- Users frustrated, don't know where to go for help
- Simple requests take days to fulfill
- Agents overwhelmed, high burnout
- No learning or improvement
- Security risks from ad-hoc access grants
- No visibility into support performance
- Business impacted by slow support

**After (Structured Service Desk):**
- Users get quick, consistent help
- Efficient request fulfillment
- Agents have tools and knowledge to succeed
- Continuous improvement through metrics
- Secure, audited processes
- Business visibility into support
- Proactive problem prevention

**Outcome:** Efficient support, satisfied users, empowered agents, business alignment.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Align services with business needs
    - Measure business impact of service quality
    - Prioritize based on business value
    
  metrics:
    - Track service desk KPIs
    - Measure user satisfaction
    - Correlate support with business outcomes
    
  architecture:
    - Design for supportability and usability
    - Architecture decisions consider support impact
    - Technology choices based on support requirements
    
  data:
    - Support data for analytics and improvement
    - User feedback for product improvement
    - Knowledge data for AI training
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include support requirements in specs
    - Define service desk procedures
    - Specify knowledge base requirements
    
  constitution:
    - "User-Centric Design" principle enforcement
    - Supportability as constitutional requirement
    - Knowledge sharing in constitution
    
  traceability:
    - Link support issues to specifications
    - Track specification changes from support feedback
    - Update specifications based on support patterns
```

### Incident, Problem, Change Management Integration

```yaml
process_integration:
  incident_management:
    - Service desk as primary incident intake
    - Escalation to incident management for major incidents
    - Status communication through service desk
    
  problem_management:
    - Problem identification from service desk trends
    - Known error database integrated with knowledge base
    - Problem solutions published to knowledge base
    
  change_management:
    - Change requests through service desk
    - User communication about changes
    - Post-change support through service desk
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Business Analysis & Operations"
  triggers:
    - user_support_request
    - service_catalog_query
    - knowledge_gap_identified
    
  skills_chain:
    - service-desk (primary)
    - knowledge-base-manager (for solutions)
    - metrics-definer (for measurement)
    - recursive-optimizer (for process improvement)
    
  outputs:
    - service_request_fulfillment
    - user_support_resolution
    - knowledge_base_updates
    - service_metrics_report
    - process_improvement_recommendations
    
  feedback_loop:
    - user_requests → fulfillment → feedback → optimization → improved_services
```

### Example Service Desk Workflow in Aether.go

```bash
# 1. User submits request via self-service portal
aether service-desk request \
  --type="access_request" \
  --service="reporting_tool" \
  --user="alice@company.com" \
  --justification="Monthly reporting responsibilities"

# 2. Service desk processes request
aether service-desk process \
  --ticket-id="SR-2025-001" \
  --auto-classify \
  --auto-route

# 3. Automated approval workflow
aether service-desk approve \
  --ticket-id="SR-2025-001" \
  --approver="manager@company.com" \
  --auto-escalate-if-delayed

# 4. Automated fulfillment
aether service-desk fulfill \
  --ticket-id="SR-2025-001" \
  --automation="provision_access" \
  --parameters="tool=reporting,role=viewer"

# 5. Knowledge base integration
aether service-desk knowledge \
  --ticket-id="SR-2025-001" \
  --create-article-if-new \
  --link-existing-articles

# 6. User feedback collection
aether service-desk feedback \
  --ticket-id="SR-2025-001" \
  --survey="satisfaction" \
  --analyze-feedback

# 7. Metrics and reporting
aether service-desk metrics \
  --time-window="7d" \
  --kpis="fcr,sla_compliance,satisfaction" \
  --generate-report
```