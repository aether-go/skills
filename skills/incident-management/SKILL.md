---
name: incident-management
description: Use when managing production incidents with ITIL-aligned processes for detection, response, resolution, and post-incident review
---

# Incident Management

## Overview
Manage production incidents end-to-end following ITIL best practices: from detection and classification to response, resolution, and post-incident review. Ensures rapid restoration of service, minimizes business impact, and drives continuous improvement through systematic learning.

## When to Use

```
Production incident detected? ───────┐
                                     │
Service degradation or outage? ──────┤
                                     ├─► Use incident-management
Need structured response process? ────┤
                                     │
Post-incident analysis needed? ───────┘
```

Use when:
- Production service incidents occur (outages, degradation, errors)
- Need structured incident response process
- Coordinating multiple teams during incidents
- Conducting post-incident reviews and root cause analysis
- Implementing or improving incident management processes
- Training teams on incident response procedures
- Integrating monitoring alerts with incident management

Don't use when:
- Minor bugs or non-production issues
- Planned maintenance or changes
- Routine operational tasks without service impact
- Individual debugging sessions

## Core Pattern

### ITIL Incident Management Lifecycle

```
Detection → Logging → Classification → Prioritization → Investigation → Diagnosis
    ↓           ↓           ↓              ↓               ↓             ↓
Monitoring  Incident   Category &      Impact &       Initial       Root Cause
  Alerts     Record    Urgency         Priority       Analysis      Hypothesis
    ↓                                                                   ↓
Escalation ←─────── Resolution Implementation ←─────── Solution ←───────┤
    ↓                   ↓                     ↓           ↓              ↓
To Problem   Temporary/Workaround   Permanent Fix   Verification   Confirmation
Management
    ↓
Closure → Post-Incident Review → Knowledge Base Update → Process Improvement
```

### Before (Ad-hoc Incident Response)
```yaml
Incident: Database connection timeout
Response:
  - Engineer tries random fixes
  - No clear communication to stakeholders
  - Multiple people working independently
  - No documentation of actions taken
  - Root cause never identified
  - Same incident repeats next week
Result: Extended downtime, frustrated users, recurring issues
```

### After (Structured Incident Management)
```yaml
Incident: Database connection timeout
Process:
  1. Detection: Monitoring alert at 02:14 UTC
  2. Logging: Incident INC-2025-001 created automatically
  3. Classification: Database/Connectivity, Severity 2
  4. Prioritization: High impact (affects 80% users), urgent
  
  5. Response:
     - On-call engineer assigned (2 min)
     - War room established (5 min)
     - Stakeholders notified with ETA (10 min)
     
  6. Investigation:
     - Database connection pool exhausted
     - Recent deployment changed connection settings
     
  7. Resolution:
     - Workaround: Restart database connections (15 min)
     - Permanent fix: Adjust connection pool settings
     - Verification: All services restored (30 min)
     
  8. Post-Incident:
     - RCA identified deployment process gap
     - Knowledge base article created
     - Monitoring enhanced for connection pools
     - Process improvement: Pre-deployment validation

Metrics:
  - MTTA: 2 minutes
  - MTTR: 30 minutes
  - Business impact: Minimal (revenue loss < 0.1%)
  - Customer satisfaction: 4.8/5 (transparent communication)
```

## Quick Reference

### Incident Severity Levels

| Level | Name | Impact | Response Time | Example |
|-------|------|--------|---------------|---------|
| **SEV-0** | Critical | Service completely down, all users affected | < 15 min | Complete outage, data loss |
| **SEV-1** | High | Major functionality impaired, many users affected | < 30 min | Payment processing down |
| **SEV-2** | Medium | Partial functionality loss, some users affected | < 2 hours | Slow performance, feature broken |
| **SEV-3** | Low | Minor issue, workaround available | < 8 hours | UI bug, non-critical error |
| **SEV-4** | Informational | No current impact, potential future issue | Next business day | Capacity warning, deprecation notice |

### Incident Response Roles

| Role | Responsibilities | Tools |
|------|-----------------|-------|
| **Incident Commander** | Overall coordination, decision making | War room, status page |
| **Communications Lead** | Stakeholder updates, status pages | Slack, email, status page |
| **Technical Lead** | Technical investigation, solution design | Monitoring, logs, debugging |
| **Operations Lead** | Implementation, deployment, verification | CI/CD, deployment tools |
| **Business Lead** | Impact assessment, business decisions | Revenue data, customer feedback |

### Essential Incident Management Metrics

| Metric | Formula | Target | Purpose |
|--------|---------|--------|---------|
| **MTTA** (Mean Time to Acknowledge) | Sum(time to acknowledge) / incidents | < 5 min | Speed of initial response |
| **MTTR** (Mean Time to Resolve) | Sum(resolution time) / incidents | SEV-0: < 1h, SEV-1: < 4h | Time to restore service |
| **Incident Volume** | Count(incidents) / period | Trend analysis | Process effectiveness |
| **Reopen Rate** | Reopened incidents / total incidents | < 5% | Resolution quality |
| **Customer Satisfaction** | Survey scores post-incident | > 4/5 | Communication effectiveness |
| **SLA Compliance** | Incidents resolved within SLA / total | > 95% | Process reliability |

### Incident Management Tools Integration

```yaml
tool_integrations:
  detection:
    - prometheus: "AlertManager webhooks"
    - datadog: "Incident creation API"
    - new_relic: "Alert policies"
    - cloudwatch: "Alarms to PagerDuty"
    
  communication:
    - slack: "Incident channels, updates"
    - microsoft_teams: "War room coordination"
    - statuspage: "Public status updates"
    - email: "Stakeholder notifications"
    
  tracking:
    - jira: "Incident tickets, workflow"
    - servicenow: "ITSM integration"
    - freshservice: "Service desk"
    - gitlab: "Issues for tracking"
    
  collaboration:
    - zoom: "War room video"
    - miro: "Incident timeline"
    - google_docs: "Post-mortem documents"
    - confluence: "Knowledge base"
```

## Implementation

### Incident Management Workflow Engine

```python
class IncidentManagementWorkflow:
    """ITIL-aligned incident management workflow engine."""
    
    def __init__(self, config):
        self.config = config
        self.incident_repository = IncidentRepository()
        self.notification_service = NotificationService()
        self.monitoring_integration = MonitoringIntegration()
        
    def handle_new_incident(self, alert_data):
        """Handle new incident from monitoring alert."""
        
        # Create incident record
        incident = Incident(
            title=alert_data['title'],
            description=alert_data['description'],
            source='monitoring',
            severity=self._calculate_severity(alert_data),
            detected_at=datetime.now()
        )
        
        # Store incident
        incident_id = self.incident_repository.save(incident)
        
        # Classify and prioritize
        classification = self.classify_incident(incident)
        priority = self.calculate_priority(incident, classification)
        
        # Assign initial responder
        responder = self.on_call_scheduler.get_responder(priority)
        incident.assign_to(responder)
        
        # Notify stakeholders
        self.notification_service.notify_stakeholders(
            incident=incident,
            level='initial',
            channels=['slack', 'email']
        )
        
        # Create war room if needed
        if incident.severity in ['SEV-0', 'SEV-1']:
            war_room = self.create_war_room(incident)
            incident.set_war_room(war_room)
        
        # Start incident timeline
        timeline_entry = TimelineEntry(
            incident_id=incident_id,
            event='incident_created',
            details='Incident detected and assigned',
            timestamp=datetime.now()
        )
        
        return incident_id
    
    def escalate_incident(self, incident_id, reason):
        """Escalate incident to higher severity or different team."""
        
        incident = self.incident_repository.get(incident_id)
        
        if reason == 'timeout':
            # Escalate due to time limits
            new_severity = self._increase_severity(incident.severity)
            incident.update_severity(new_severity)
            
            # Notify escalation managers
            self.notification_service.notify_escalation(
                incident=incident,
                reason='response_timeout'
            )
            
        elif reason == 'complexity':
            # Escalate to specialized team
            specialized_team = self._get_specialized_team(incident)
            incident.reassign_to_team(specialized_team)
            
        self.incident_repository.update(incident)
        
    def resolve_incident(self, incident_id, resolution_data):
        """Resolve incident with workaround or permanent fix."""
        
        incident = self.incident_repository.get(incident_id)
        
        resolution = Resolution(
            incident_id=incident_id,
            type=resolution_data['type'],  # workaround, permanent
            description=resolution_data['description'],
            implemented_by=resolution_data['implemented_by'],
            implemented_at=datetime.now()
        )
        
        # Verify resolution
        verification_result = self.verify_resolution(incident, resolution)
        
        if verification_result['success']:
            incident.resolve(
                resolution=resolution,
                resolved_at=datetime.now(),
                verification_details=verification_result
            )
            
            # Update stakeholders
            self.notification_service.notify_stakeholders(
                incident=incident,
                level='resolved',
                channels=['slack', 'statuspage', 'email']
            )
            
            # Trigger post-incident review
            if incident.severity in ['SEV-0', 'SEV-1']:
                self.schedule_post_incident_review(incident_id)
        else:
            # Resolution failed, continue incident
            incident.add_timeline_entry(
                event='resolution_failed',
                details=f"Resolution verification failed: {verification_result['reason']}"
            )
    
    def conduct_post_incident_review(self, incident_id):
        """Conduct structured post-incident review."""
        
        incident = self.incident_repository.get(incident_id)
        
        review = PostIncidentReview(
            incident_id=incident_id,
            conducted_at=datetime.now(),
            attendees=self._get_review_attendees(incident),
            timeline=incident.timeline
        )
        
        # Analyze timeline for root cause
        root_cause = self.root_cause_analyzer.analyze(incident.timeline)
        review.set_root_cause(root_cause)
        
        # Identify action items
        action_items = self._identify_action_items(incident, root_cause)
        review.set_action_items(action_items)
        
        # Generate knowledge base article
        if root_cause['category'] != 'unknown':
            kb_article = self.knowledge_base.create_article(
                title=f"Incident {incident.id}: {incident.title}",
                content=self._generate_kb_content(incident, review),
                tags=['incident', root_cause['category'], incident.service]
            )
            review.set_knowledge_base_article(kb_article)
        
        # Track action items
        for item in action_items:
            self.action_item_tracker.create(
                incident_id=incident_id,
                description=item['description'],
                owner=item['owner'],
                due_date=item['due_date']
            )
        
        # Close incident
        incident.close_post_review(review)
        self.incident_repository.update(incident)
        
        return review
```

### Incident Classification Algorithm

```python
class IncidentClassifier:
    """Classify incidents based on symptoms and impact."""
    
    def classify(self, incident_data):
        """Classify incident into standard categories."""
        
        categories = {
            'infrastructure': ['cpu', 'memory', 'disk', 'network', 'host'],
            'database': ['connection', 'query', 'replication', 'backup'],
            'application': ['api', 'service', 'microservice', 'container'],
            'security': ['breach', 'attack', 'vulnerability', 'access'],
            'deployment': ['release', 'rollback', 'migration', 'config'],
            'third_party': ['api', 'service', 'dependency', 'vendor'],
            'data': ['corruption', 'loss', 'integrity', 'quality']
        }
        
        # Match symptoms to categories
        matched_categories = []
        for category, keywords in categories.items():
            if any(keyword in incident_data['description'].lower() 
                   for keyword in keywords):
                matched_categories.append(category)
        
        # Use ML model for complex classification
        if not matched_categories:
            ml_classification = self.ml_model.predict(incident_data)
            matched_categories.append(ml_classification)
        
        return matched_categories[0] if matched_categories else 'unknown'
    
    def calculate_severity(self, incident_data, business_context):
        """Calculate incident severity based on impact and urgency."""
        
        impact_score = self._calculate_impact_score(
            incident_data['affected_users'],
            incident_data['affected_services'],
            business_context['critical_services']
        )
        
        urgency_score = self._calculate_urgency_score(
            incident_data['symptoms'],
            incident_data['degradation_level'],
            business_context['time_sensitivity']
        )
        
        # Map to severity levels
        if impact_score >= 9 and urgency_score >= 9:
            return 'SEV-0'
        elif impact_score >= 7 or urgency_score >= 7:
            return 'SEV-1'
        elif impact_score >= 5 or urgency_score >= 5:
            return 'SEV-2'
        elif impact_score >= 3 or urgency_score >= 3:
            return 'SEV-3'
        else:
            return 'SEV-4'
```

### Incident Communication Templates

```yaml
communication_templates:
  initial_notification:
    subject: "Incident {{incident.id}}: {{incident.title}}"
    slack: |
      🚨 *INCIDENT DETECTED*
      *ID*: {{incident.id}}
      *Title*: {{incident.title}}
      *Severity*: {{incident.severity}}
      *Status*: Investigating
      *Impact*: {{incident.impact_description}}
      *Detected*: {{incident.detected_at}}
      *Assignee*: {{incident.assignee}}
      
      War room: {{incident.war_room_link}}
      Status page: {{status_page_link}}
      
      Next update in 15 minutes.
      
  status_update:
    subject: "Incident {{incident.id}} Update"
    slack: |
      🔄 *INCIDENT UPDATE*
      *ID*: {{incident.id}}
      *Status*: {{incident.status}}
      *Update*: {{update.message}}
      *Next steps*: {{update.next_steps}}
      *ETA*: {{update.eta}}
      
      Timeline: {{incident.timeline_link}}
      
  resolution_notification:
    subject: "RESOLVED: Incident {{incident.id}}"
    slack: |
      ✅ *INCIDENT RESOLVED*
      *ID*: {{incident.id}}
      *Title*: {{incident.title}}
      *Resolution*: {{incident.resolution.description}}
      *Resolution time*: {{incident.resolution_time}}
      *Root cause*: {{incident.root_cause}}
      
      Post-incident review scheduled for {{incident.review_time}}.
      
  post_incident_summary:
    subject: "Post-Incident Review: {{incident.id}}"
    email: |
      # Post-Incident Review: {{incident.id}}
      
      ## Incident Summary
      - **Title**: {{incident.title}}
      - **Duration**: {{incident.duration}}
      - **Impact**: {{incident.impact_summary}}
      - **Root Cause**: {{incident.root_cause}}
      
      ## Key Learnings
      {% for learning in incident.learnings %}
      - {{learning}}
      {% endfor %}
      
      ## Action Items
      {% for item in incident.action_items %}
      - [ ] {{item.description}} (Owner: {{item.owner}}, Due: {{item.due_date}})
      {% endfor %}
      
      ## Metrics
      - MTTA: {{incident.mtta}}
      - MTTR: {{incident.mttr}}
      - Customer Impact: {{incident.customer_impact}}
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| No incident commander | Confusion, duplicated effort, slow decisions | Always assign incident commander immediately |
| Poor communication | Stakeholders unaware, speculation spreads | Regular updates, clear channels, status page |
| Skipping post-incident review | Same incidents repeat, no learning | Mandatory review for SEV-0/1, track action items |
| No war room for major incidents | Siloed information, coordination overhead | Create war room immediately for high severity |
| Blame culture | Team hides information, psychological safety broken | Focus on systems not people, blame-free reviews |
| Ignoring workarounds | Extended downtime while seeking perfect fix | Implement workarounds first, then permanent fix |
| No incident documentation | Can't learn from past, repeat same mistakes | Document timeline, decisions, and learnings |
| Alert fatigue | Teams ignore alerts, miss critical incidents | Tune alerts, categorize, use escalation policies |

### Red Flags

- Incidents without assigned commander
- No regular status updates
- Post-incident reviews skipped
- Action items not tracked
- Same incident recurring
- MTTA/MTTR not measured
- Stakeholders unaware of incidents
- No knowledge base articles
- Blame in incident discussions
- War rooms not used for major incidents

## Real-World Impact

**Before (Ad-hoc Incident Response):**
- Extended downtime (hours vs minutes)
- Customer frustration and churn
- Repeated incidents with same root cause
- Team burnout from firefighting
- No learning or improvement
- Business impact not quantified
- Reputation damage

**After (Structured Incident Management):**
- Rapid service restoration (minutes)
- Transparent customer communication
- Systematic root cause elimination
- Continuous process improvement
- Measurable business impact
- Team confidence in handling incidents
- Knowledge base for future reference

**Outcome:** Higher availability, faster recovery, customer trust, team learning, predictable operations.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Measure business impact of incidents (revenue loss, user impact)
    - Align incident priorities with business criticality
    - Communicate business context during incidents
    
  metrics:
    - Track incident metrics (MTTA, MTTR, volume, reopen rate)
    - Correlate incidents with business metrics
    - Set SLA/SLO targets for incident response
    
  architecture:
    - Design for resilience and rapid recovery
    - Implement circuit breakers, fallbacks, redundancy
    - Architecture reviews based on incident patterns
    
  data:
    - Incident data for trend analysis
    - Root cause data for preventive measures
    - Customer impact data for prioritization
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include operational requirements in specs
    - Define monitoring and alerting requirements
    - Specify recovery procedures and runbooks
    
  constitution:
    - "Resilience & Reliability" principle enforcement
    - Incident response as constitutional requirement
    - Post-inciment learning for constitution evolution
    
  traceability:
    - Link incidents to specifications and implementations
    - Track incident-driven changes back to requirements
    - Update specifications based on incident learnings
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Deployment & Operations"
  triggers:
    - production_incident_detected
    - post_deployment_monitoring
    - scheduled_incident_review
    
  skills_chain:
    - incident-management (primary)
    - metrics-definer (for measurement)
    - recursive-optimizer (for improvement)
    - constitution-validator (for compliance)
    
  outputs:
    - incident_resolution_report
    - post_incident_review
    - action_items_tracking
    - updated_knowledge_base
    - process_improvement_recommendations
    
  feedback_loop:
    - incidents → metrics → optimization → constitution → specifications
```

### Recursive Optimization Integration

```yaml
optimization_integration:
  data_sources:
    - incident_timelines
    - resolution_times
    - root_cause_analysis
    - customer_impact_data
    - team_feedback
    
  optimization_targets:
    - reduce_mtta (Mean Time to Acknowledge)
    - reduce_mttr (Mean Time to Resolve)
    - prevent_recurrence
    - improve_communication
    - enhance_monitoring
    
  optimization_cycle:
    1. Collect incident data and metrics
    2. Analyze patterns and bottlenecks
    3. Generate optimization hypotheses
    4. Implement changes (process, tools, training)
    5. Measure impact on future incidents
    6. Refine optimization strategies
```

### Example Incident Management Workflow in Aether.go

```bash
# 1. Incident detected via monitoring
aether incident detect \
  --source="prometheus" \
  --alert="HighErrorRate" \
  --service="payment-service"

# 2. Incident management workflow triggered
aether incident manage \
  --incident-id="INC-2025-001" \
  --severity="SEV-1" \
  --auto-assign \
  --create-war-room

# 3. Stakeholder communication
aether incident communicate \
  --incident-id="INC-2025-001" \
  --message="Investigating payment service errors" \
  --channels="slack,statuspage,email"

# 4. Resolution implementation
aether incident resolve \
  --incident-id="INC-2025-001" \
  --resolution="Rollback deployment v1.2.3" \
  --type="workaround"

# 5. Post-incident review
aether incident review \
  --incident-id="INC-2025-001" \
  --generate-action-items \
  --update-knowledge-base

# 6. Optimization based on learnings
aether optimize incident-process \
  --from-incident="INC-2025-001" \
  --target="reduce_mttr" \
  --strategy="automated_rollback"
```