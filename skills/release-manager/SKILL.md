---
name: release-manager
description: Use when planning, coordinating, and executing software releases including version management, release notes, stakeholder coordination, and production deployment scheduling
---

# Release Manager

## Overview
Plan, coordinate, and execute software releases from development through production. Manage release planning, versioning, release notes, stakeholder communication, and deployment scheduling to ensure smooth, predictable software delivery.

## When to Use

```
Need to release software? ────────┐
                                  │
Multiple teams/components? ───────┤
                                  ├─► Use release-manager
Stakeholder coordination needed? ─┤
                                  │
Production deployment planning? ──┘
```

Use when:
- Planning software releases with multiple teams or components
- Managing version numbers and semantic versioning
- Creating release notes and documentation
- Coordinating stakeholder communication and approvals
- Scheduling production deployments and change windows
- Managing release train or regular release cadence
- Handling hotfixes and emergency releases
- Ensuring regulatory or compliance requirements for releases
- Coordinating marketing and sales announcements with releases

Don't use when:
- Simple feature deployments without formal release process
- Individual developer code pushes to development
- Infrastructure-only changes without software changes
- Configuration-only updates without version changes
- Experimental or prototype deployments

## Core Pattern

### End-to-End Release Management Lifecycle

```
Release Planning → Version Management → Development Coordination → Testing Validation → Release Preparation → Production Deployment → Post-Release Review
      ↓                   ↓                   ↓                   ↓                   ↓                   ↓                   ↓
Release calendar    Semantic        Feature       Quality gates   Release notes    Deployment      Performance      Retrospective
& roadmap           versioning      freeze        & approvals     & docs           coordination   monitoring       & optimization
```

### Before (Ad-hoc Release Process)
```yaml
Scenario: Releasing v2.0.0 with major features
Approach:
  - Last-minute coordination between teams
  - Version numbers decided randomly
  - Release notes hastily written
  - Testing incomplete due to schedule pressure
  - Stakeholders unaware of release timing
  - Deployment conflicts with other changes
  - No rollback plan if issues arise
Result: Chaotic release, missed deadlines, production issues, stakeholder frustration
```

### After (Structured Release Management)
```yaml
Scenario: Releasing v2.0.0 with major features
Process:

1. Release Planning (Week -4 to -2):
   - Release theme and objectives defined
   - Features prioritized and scoped
   - Release calendar created with milestones
   - Stakeholder alignment meetings
   - Risk assessment and mitigation planning

2. Version Management (Week -2):
   - Semantic versioning: 2.0.0 (major.minor.patch)
   - Release branch created: release/2.0.0
   - Version tags applied to all components
   - Dependency compatibility verified

3. Development Coordination (Week -2 to -1):
   - Feature freeze declared
   - Bug fix prioritization and assignment
   - Integration testing across components
   - Performance and security validation

4. Release Preparation (Week -1):
   - Release notes drafted with categories:
     * New Features (5 items)
     * Improvements (12 items)  
     * Bug Fixes (8 items)
     * Breaking Changes (3 items)
     * Upgrade Instructions
   - Documentation updated
   - Marketing materials prepared
   - Stakeholder communications scheduled

5. Production Deployment (Release Day):
   - Change window scheduled (low business impact)
   - Deployment orchestration with rollback plan
   - Stakeholder notifications sent
   - Monitoring dashboards activated
   - Support team briefed and ready

6. Post-Release (Day +1 to +7):
   - Performance monitoring and validation
   - User feedback collection
   - Issue triage and hotfix planning
   - Release retrospective meeting
   - Metrics collection for process improvement

Outcome: Predictable, smooth release with clear communication, minimal disruption, and continuous improvement.
```

## Quick Reference

### Release Types and Cadences

| Release Type | Cadence | Risk Level | Testing Requirements | Stakeholder Notification |
|--------------|---------|------------|----------------------|--------------------------|
| **Major Release** | Quarterly | High | Extensive (all components) | 4 weeks notice, detailed comms |
| **Minor Release** | Monthly | Medium | Comprehensive (affected components) | 2 weeks notice, summary comms |
| **Patch Release** | Weekly | Low | Focused (specific fixes) | 3 days notice, technical comms |
| **Hotfix Release** | As needed | Critical | Emergency (minimal viable) | Immediate, urgent comms |
| **Security Release** | Immediate | Critical | Security-focused | Coordinated with security team |

### Semantic Versioning Guidelines

```yaml
semantic_versioning:
  major_version:  # Breaking changes
    increment_when:
      - Incompatible API changes
      - Major architecture changes  
      - Significant breaking changes
      - End of support for features
    example: 1.0.0 → 2.0.0
  
  minor_version:  # New functionality (backward compatible)
    increment_when:
      - New features added
      - Deprecated features (still working)
      - Significant improvements
      - Minor API additions (compatible)
    example: 1.0.0 → 1.1.0
  
  patch_version:  # Bug fixes (backward compatible)
    increment_when:
      - Bug fixes
      - Security patches
      - Performance improvements
      - Documentation updates
    example: 1.0.0 → 1.0.1
  
  pre_release_labels:  # For testing/pre-release
    - alpha: Early testing, unstable
    - beta: Feature complete, testing
    - rc: Release candidate, final testing
    example: 1.0.0-rc.1
  
  build_metadata:  # Build information
    - commit hash: abc123
    - build timestamp: 20250128120000
    example: 1.0.0+abc123.20250128120000
```

### Release Communication Matrix

```yaml
communication_channels:
  internal:
    teams:
      - development: "Technical details, deployment plans"
      - operations: "Deployment schedules, monitoring"
      - support: "Known issues, workarounds"
      - product: "Feature impact, user documentation"
      - marketing: "Release announcements, positioning"
    
    timing:
      - planning_phase: "4 weeks before release"
      - feature_freeze: "2 weeks before release"
      - code_freeze: "1 week before release"
      - release_day: "Day of release"
      - post_release: "1 week after release"
  
  external:
    customers:
      - enterprise_clients: "Detailed release notes, upgrade guides"
      - smb_clients: "Feature highlights, upgrade instructions"
      - end_users: "What's new, benefits summary"
    
    channels:
      - email: "Newsletters, release announcements"
      - blog: "Detailed feature articles"
      - docs: "Updated documentation, API references"
      - support_portal: "Known issues, FAQs"
      - social_media: "Feature highlights, announcements"
```

## Implementation

### Release Manager Engine

```python
class ReleaseManager:
    """Manage complete software release lifecycle."""
    
    def __init__(self, config):
        self.config = config
        self.version_manager = VersionManager()
        self.release_calendar = ReleaseCalendar()
        self.stakeholder_coordinator = StakeholderCoordinator()
        self.deployment_coordinator = DeploymentCoordinator()
        
    def plan_release(self, release_spec):
        """Plan a new software release."""
        
        release = Release(
            spec=release_spec,
            status='planning',
            created_at=datetime.now()
        )
        
        try:
            # Phase 1: Release Scoping
            release.scope = self._define_release_scope(release_spec)
            release.theme = release_spec.get('theme', '')
            release.objectives = release_spec.get('objectives', [])
            
            # Phase 2: Version Management
            release.version = self.version_manager.determine_version(
                current_version=release_spec.get('current_version'),
                change_types=release.scope.get('change_types', [])
            )
            release.branch = f"release/{release.version}"
            
            # Phase 3: Timeline Planning
            release.timeline = self._create_release_timeline(release_spec)
            release.critical_path = self._identify_critical_path(release.timeline)
            
            # Phase 4: Stakeholder Alignment
            release.stakeholders = self.stakeholder_coordinator.identify_stakeholders(
                release_spec
            )
            release.communication_plan = self._create_communication_plan(release)
            
            # Phase 5: Risk Assessment
            release.risks = self._assess_release_risks(release)
            release.mitigation_plans = self._create_mitigation_plans(release.risks)
            
            # Phase 6: Approval and Kickoff
            release.approval = self._obtain_release_approval(release)
            
            if release.approval['approved']:
                release.status = 'approved'
                release.kickoff_date = datetime.now()
                
                # Create release artifacts
                release.artifacts = self._create_release_artifacts(release)
                
                # Notify stakeholders
                self.stakeholder_coordinator.notify_stakeholders(
                    release=release,
                    phase='kickoff'
                )
                
                return release
            else:
                release.status = 'rejected'
                release.rejection_reason = release.approval.get('reason')
                return release
                
        except Exception as e:
            release.status = 'planning_failed'
            release.error = str(e)
            return release
    
    def execute_release(self, release_id):
        """Execute a planned release."""
        
        release = self.release_registry.get_release(release_id)
        if not release:
            raise ReleaseError(f"Release {release_id} not found")
        
        release.status = 'executing'
        release.execution_start = datetime.now()
        
        try:
            # Phase 1: Development Phase
            self._execute_development_phase(release)
            release.milestones.append('development_complete')
            
            # Phase 2: Testing Phase
            test_results = self._execute_testing_phase(release)
            release.test_results = test_results
            release.milestones.append('testing_complete')
            
            # Phase 3: Release Preparation
            release_artifacts = self._prepare_release_artifacts(release)
            release.artifacts = release_artifacts
            release.milestones.append('preparation_complete')
            
            # Phase 4: Pre-release Activities
            self._execute_pre_release_activities(release)
            release.milestones.append('pre_release_complete')
            
            # Phase 5: Production Deployment
            deployment_result = self.deployment_coordinator.execute_deployment(release)
            release.deployment_result = deployment_result
            
            if deployment_result['success']:
                release.status = 'deployed'
                release.deployment_time = datetime.now()
                release.milestones.append('deployment_complete')
                
                # Phase 6: Post-release Activities
                self._execute_post_release_activities(release)
                release.milestones.append('post_release_complete')
                
                release.status = 'completed'
                release.completion_time = datetime.now()
            else:
                release.status = 'deployment_failed'
                release.error = deployment_result.get('error')
                
                # Execute rollback plan
                rollback_result = self._execute_rollback(release)
                release.rollback_result = rollback_result
                
        except Exception as e:
            release.status = 'execution_failed'
            release.error = str(e)
            
            # Emergency handling
            self._handle_release_failure(release)
        
        finally:
            release.execution_end = datetime.now()
            release.duration = release.execution_end - release.execution_start
            
            # Record release metrics
            release.metrics = self._collect_release_metrics(release)
            
            # Update release registry
            self.release_registry.update_release(release)
            
            return release
    
    def _execute_development_phase(self, release):
        """Execute development phase of release."""
        
        phase_result = {
            'phase': 'development',
            'start_time': datetime.now(),
            'activities': [],
            'status': 'in_progress'
        }
        
        # 1. Create release branch
        branch_result = self.version_manager.create_release_branch(
            release.version, release.branch
        )
        phase_result['activities'].append(branch_result)
        
        # 2. Coordinate feature development
        for feature in release.scope.get('features', []):
            feature_result = self._coordinate_feature_development(feature, release)
            phase_result['activities'].append(feature_result)
            
            if not feature_result['success']:
                phase_result['status'] = 'failed'
                phase_result['error'] = f"Feature {feature['name']} failed"
                break
        
        # 3. Implement bug fixes
        for bug_fix in release.scope.get('bug_fixes', []):
            fix_result = self._coordinate_bug_fix(bug_fix, release)
            phase_result['activities'].append(fix_result)
            
            if not fix_result['success']:
                phase_result['status'] = 'failed'
                phase_result['error'] = f"Bug fix {bug_fix['id']} failed"
                break
        
        # 4. Feature freeze
        if phase_result['status'] != 'failed':
            freeze_result = self._implement_feature_freeze(release)
            phase_result['activities'].append(freeze_result)
            
            if freeze_result['success']:
                phase_result['status'] = 'completed'
            else:
                phase_result['status'] = 'failed'
                phase_result['error'] = 'Feature freeze failed'
        
        phase_result['end_time'] = datetime.now()
        phase_result['duration'] = phase_result['end_time'] - phase_result['start_time']
        
        return phase_result
    
    def _execute_testing_phase(self, release):
        """Execute testing phase of release."""
        
        phase_result = {
            'phase': 'testing',
            'start_time': datetime.now(),
            'test_suites': [],
            'status': 'in_progress'
        }
        
        # Execute different test types
        test_types = [
            ('unit_tests', self._execute_unit_tests),
            ('integration_tests', self._execute_integration_tests),
            ('system_tests', self._execute_system_tests),
            ('performance_tests', self._execute_performance_tests),
            ('security_tests', self._execute_security_tests),
            ('user_acceptance_tests', self._execute_uat)
        ]
        
        for test_name, test_executor in test_types:
            if test_name in release.scope.get('required_tests', []):
                test_result = test_executor(release)
                phase_result['test_suites'].append({
                    'type': test_name,
                    'result': test_result
                })
                
                if not test_result['success']:
                    phase_result['status'] = 'failed'
                    phase_result['error'] = f"{test_name} failed"
                    break
        
        if phase_result['status'] != 'failed':
            # All tests passed
            phase_result['status'] = 'completed'
            
            # Generate test report
            phase_result['report'] = self._generate_test_report(
                phase_result['test_suites']
            )
        
        phase_result['end_time'] = datetime.now()
        phase_result['duration'] = phase_result['end_time'] - phase_result['start_time']
        
        return phase_result
    
    def _prepare_release_artifacts(self, release):
        """Prepare all release artifacts."""
        
        artifacts = {
            'version': release.version,
            'prepared_at': datetime.now(),
            'items': []
        }
        
        # 1. Release notes
        release_notes = self._generate_release_notes(release)
        artifacts['items'].append({
            'type': 'release_notes',
            'content': release_notes,
            'formats': ['markdown', 'html', 'pdf']
        })
        
        # 2. Documentation updates
        docs = self._update_documentation(release)
        artifacts['items'].append({
            'type': 'documentation',
            'updates': docs
        })
        
        # 3. Deployment artifacts
        deployment_artifacts = self._prepare_deployment_artifacts(release)
        artifacts['items'].append({
            'type': 'deployment',
            'artifacts': deployment_artifacts
        })
        
        # 4. Marketing materials
        marketing_materials = self._prepare_marketing_materials(release)
        if marketing_materials:
            artifacts['items'].append({
                'type': 'marketing',
                'materials': marketing_materials
            })
        
        # 5. Communication templates
        communication_templates = self._prepare_communication_templates(release)
        artifacts['items'].append({
            'type': 'communication',
            'templates': communication_templates
        })
        
        return artifacts
    
    def _generate_release_notes(self, release):
        """Generate comprehensive release notes."""
        
        release_notes = {
            'version': release.version,
            'release_date': release.timeline.get('release_date'),
            'theme': release.theme,
            'highlights': [],
            'sections': {}
        }
        
        # Categorize changes
        categories = {
            'new_features': [],
            'improvements': [],
            'bug_fixes': [],
            'breaking_changes': [],
            'deprecations': [],
            'security_updates': [],
            'performance_improvements': []
        }
        
        # Populate categories from release scope
        for feature in release.scope.get('features', []):
            if feature.get('type') == 'new':
                categories['new_features'].append({
                    'name': feature['name'],
                    'description': feature.get('description', ''),
                    'impact': feature.get('impact', '')
                })
            elif feature.get('type') == 'improvement':
                categories['improvements'].append({
                    'name': feature['name'],
                    'description': feature.get('description', ''),
                    'before_after': feature.get('before_after', '')
                })
        
        for bug_fix in release.scope.get('bug_fixes', []):
            categories['bug_fixes'].append({
                'id': bug_fix['id'],
                'description': bug_fix.get('description', ''),
                'impact': bug_fix.get('impact', ''),
                'workaround': bug_fix.get('workaround', '')
            })
        
        # Add breaking changes if any
        breaking_changes = release.scope.get('breaking_changes', [])
        if breaking_changes:
            categories['breaking_changes'] = breaking_changes
        
        # Set highlights (top 3-5 items)
        if categories['new_features']:
            release_notes['highlights'].extend([
                f"New: {feat['name']}" 
                for feat in categories['new_features'][:3]
            ])
        
        if categories['improvements'] and len(release_notes['highlights']) < 5:
            release_notes['highlights'].extend([
                f"Improved: {imp['name']}"
                for imp in categories['improvements'][:2]
            ])
        
        # Format sections
        for category, items in categories.items():
            if items:
                # Convert category name to human readable
                section_name = category.replace('_', ' ').title()
                release_notes['sections'][section_name] = items
        
        # Add upgrade instructions
        if breaking_changes or release.scope.get('requires_migration'):
            release_notes['upgrade_instructions'] = self._generate_upgrade_instructions(
                release
            )
        
        # Add known issues
        known_issues = release.scope.get('known_issues', [])
        if known_issues:
            release_notes['known_issues'] = known_issues
        
        return release_notes
```

### Release Calendar Management

```python
class ReleaseCalendar:
    """Manage release schedules and coordination."""
    
    def __init__(self):
        self.calendar = {}
        self.conflict_detector = ConflictDetector()
        
    def schedule_release(self, release, preferred_dates=None):
        """Schedule a release on the calendar."""
        
        # Find optimal release window
        release_window = self._find_release_window(
            release=release,
            preferred_dates=preferred_dates
        )
        
        if not release_window:
            raise SchedulingError("No suitable release window found")
        
        # Check for conflicts
        conflicts = self.conflict_detector.check_conflicts(
            release_window, self.calendar
        )
        
        if conflicts:
            # Attempt to resolve conflicts
            resolved = self._resolve_conflicts(conflicts, release_window)
            if not resolved:
                raise SchedulingError(f"Unable to resolve conflicts: {conflicts}")
        
        # Schedule the release
        release.schedule = {
            'window': release_window,
            'scheduled_at': datetime.now(),
            'scheduled_by': 'release_manager'
        }
        
        # Add to calendar
        self._add_to_calendar(release)
        
        # Notify affected parties
        self._notify_schedule_change(release)
        
        return release.schedule
    
    def _find_release_window(self, release, preferred_dates):
        """Find optimal release window considering constraints."""
        
        constraints = release.constraints or {}
        
        # Default constraints
        default_constraints = {
            'avoid_weekends': True,
            'avoid_business_hours': constraints.get('type') == 'major',
            'min_duration_hours': 2 if constraints.get('type') == 'major' else 1,
            'max_duration_hours': 8,
            'preferred_timezone': 'UTC'
        }
        
        # Merge constraints
        merged_constraints = {**default_constraints, **constraints}
        
        # Calculate possible windows
        possible_windows = self._calculate_possible_windows(
            merged_constraints, preferred_dates
        )
        
        if not possible_windows:
            return None
        
        # Score and select best window
        scored_windows = []
        for window in possible_windows:
            score = self._score_window(window, release)
            scored_windows.append((score, window))
        
        # Select highest scoring window
        scored_windows.sort(key=lambda x: x[0], reverse=True)
        best_score, best_window = scored_windows[0]
        
        return best_window
    
    def _score_window(self, window, release):
        """Score a release window based on multiple factors."""
        
        score = 100  # Base score
        
        # Factor 1: Business impact (lower is better)
        business_impact = self._estimate_business_impact(window, release)
        score -= business_impact * 10
        
        # Factor 2: Team availability (higher is better)
        team_availability = self._check_team_availability(window, release)
        score += team_availability * 20
        
        # Factor 3: Dependency readiness
        dependency_readiness = self._check_dependency_readiness(window, release)
        score += dependency_readiness * 15
        
        # Factor 4: Risk factors
        risk_factors = self._assess_risk_factors(window, release)
        score -= risk_factors * 25
        
        # Factor 5: Compliance requirements
        compliance_score = self._check_compliance(window, release)
        score += compliance_score * 10
        
        return max(0, score)  # Ensure non-negative
```

## Common Mistakes

| Mistake | Why It's Wrong | Fix |
|---------|---------------|-----|
| Last-minute release planning | Rushed decisions, missed dependencies | Start planning 4-6 weeks before release |
| Poor version management | Confusion about compatibility, breaking changes | Use semantic versioning consistently |
| Inadequate testing | Production issues, user impact | Comprehensive testing strategy for each release type |
| Lack of stakeholder communication | Surprised teams, missed requirements | Structured communication plan with regular updates |
| No rollback plan | Extended downtime if release fails | Always have tested rollback procedure |
| Ignoring dependencies | Integration failures, system instability | Map and validate all dependencies early |
| Overloading releases | Too many changes, higher risk | Limit scope per release based on risk tolerance |
| Skipping post-release review | Repeat same mistakes | Conduct retrospectives and update processes |

### Red Flags

- No release calendar or schedule
- Ad-hoc version numbering
- Missing release notes or documentation
- Last-minute feature additions
- Incomplete testing due to time pressure
- No stakeholder communication plan
- Lack of rollback capability
- Multiple major changes in single release
- No post-release monitoring or review

## Real-World Impact

**Before (Chaotic Release Process):**
- Frequent release delays and cancellations
- Production issues affecting users
- Confused stakeholders and customers
- High stress for development and operations teams
- Inconsistent release quality
- Difficulty coordinating multiple teams
- No learning from release experiences

**After (Structured Release Management):**
- Predictable release cadence
- High release success rate
- Clear stakeholder communication
- Coordinated team efforts
- Consistent release quality
- Continuous process improvement
- Happy teams and satisfied customers

**Outcome:** Reliable, predictable software delivery with clear communication and continuous improvement.

## Integration with Aether.go Methodology

### BMAD Framework Integration

```yaml
bmad_integration:
  business:
    - Align releases with business goals and metrics
    - Schedule releases during low business impact periods
    - Measure business impact of releases
    
  metrics:
    - Track release success rates and metrics
    - Measure release cycle time and frequency
    - Monitor business metrics during releases
    
  architecture:
    - Design for releasability and version compatibility
    - Architecture supports release strategies
    - Technology choices enable smooth releases
    
  data:
    - Release data for analytics and improvement
    - Performance data for release decisions
    - Business data for impact analysis
```

### SDD Integration

```yaml
sdd_integration:
  specification:
    - Include release requirements in specifications
    - Define release processes and procedures
    - Specify versioning and compatibility requirements
  
  constitution:
    - "Safe Evolution" principle enforcement for releases
    - Release quality as constitutional requirement
    - Stakeholder communication in constitution
  
  traceability:
    - Link releases to specifications and requirements
    - Track release outcomes for specification updates
    - Update specifications based on release learnings
```

### Change Management Integration

```yaml
change_management_integration:
  process:
    - Releases as formal change requests
    - Risk assessment for each release
    - CAB approval for major releases
  
  coordination:
    - Coordinate releases with change windows
    - Integrate release management with change tracking
    - Post-release reviews as change verification
```

### Deployment Orchestrator Integration

```yaml
deployment_integration:
  coordination:
    - release-manager plans release schedule
    - deployment-orchestrator executes deployment
    - incident-management handles any issues
    - rollback-manager provides rollback capability
  
  workflow:
    - Plan → Prepare → Deploy → Monitor → Review
    - Continuous feedback between all components
  
  metrics_sharing:
    - Release metrics inform deployment strategies
    - Deployment outcomes inform release planning
    - Shared metrics for continuous improvement
```

### Methodology Fusion Orchestrator Integration

```yaml
orchestrator_integration:
  stage: "Release Management"
  triggers:
    - planned_release_date_approaching
    - feature_complete_for_release
    - emergency_fix_required
  
  skills_chain:
    - release-manager (primary planning)
    - deployment-orchestrator (execution)
    - change-management (approvals)
    - incident-management (issue handling)
    - rollback-manager (safety)
  
  outputs:
    - release_plan_and_schedule
    - release_execution_report
    - post_release_metrics
    - retrospective_and_improvements
  
  feedback_loop:
    - release → measure → learn → improve → next_release
```