# Aether.go Skills Summary

根据 `overall.md` 中的规划和 OpenCode skills 规范，已成功创建所有 38 个技能（原有31个 + 新增7个），覆盖Aether.go方法论融合框架的完整七个阶段。

## 新增 Skills 背景：方法论融合框架完善

基于对 `method-paper.md` 中描述的Aether.go方法论融合框架的深入分析，新增了7个关键技能以填补方法论执行缺口，实现端到端的智能软件生命周期管理。

### 方法论融合框架分析结果

**现有覆盖良好的领域：**
- ✅ **战略层**：BMAD框架完整（business-value-mapper, metrics-definer）
- ✅ **战术层**：SDD核心组件齐全（spec-parser, constitution-validator等）
- ✅ **执行层**：测试金字塔完整（BDD/TDD/SIT/Chaos）
- ✅ **全栈开发**：Go+Vue+Quasar工作流完备
- ✅ **AI协作**：上下文管理、技能推荐、递归优化

**识别出的关键缺口：**
- ✅ **业务分析**：已解决 - business-requirements-collector技能提供需求收集和利益相关者分析
- ✅ **验收测试**：已解决 - atdd-acceptance-test-generator技能提供ATDD验收测试生成
- ✅ **流程协调**：已解决 - methodology-fusion-orchestrator技能提供端到端方法论融合协调

### 新增 Skills 设计目标

1. **完善方法论覆盖**：填补业务分析、验收测试、流程协调等关键缺口
2. **实现端到端协调**：通过总控协调器实现七个阶段的无缝衔接
3. **加强宪法贯穿**：确保宪法原则在所有阶段得到执行
4. **建立反馈循环**：实现度量收集和递归优化的完整闭环
5. **支持智能调度**：根据上下文智能调用合适的子技能

**注意**：新增的5个技能与现有25个技能深度集成，形成完整的方法论融合生态系统。

## 技能清单

### 方法论融合协调层 Skills - 1个

1. **methodology-fusion-orchestrator**
   - 描述：协调端到端Aether.go方法论融合工作流，覆盖所有七个阶段
   - 功能：工作流编排、宪法贯穿、度量聚合、技能调度、优化触发
   - 位置：`skills/methodology-fusion-orchestrator/SKILL.md`

### 战略层 Skills（BMAD 驱动）- 5个

2. **business-requirements-collector**
   - 描述：收集、分析和优先处理来自利益相关者的业务需求
   - 功能：利益相关者分析、需求启发、优先级排序、验证
   - 位置：`skills/business-requirements-collector/SKILL.md`

3. **business-value-mapper**
   - 描述：使用BMAD框架将业务目标转化为可衡量的技术指标
   - 功能：生成BMAD矩阵，连接业务目标与技术指标
   - 位置：`skills/business-value-mapper/SKILL.md`

4. **metrics-definer**
   - 描述：为特定系统类型定义业务和技术指标及监控配置
   - 功能：定义指标清单，内置电商/SaaS/IoT等场景模板
   - 位置：`skills/metrics-definer/SKILL.md`

5. **architecture-decision-recorder**
   - 描述：记录架构决策及其业务依据和备选方案分析
   - 功能：创建ADR文档，记录决策理由和权衡
   - 位置：`skills/architecture-decision-recorder/SKILL.md`

6. **data-flow-analyzer**
   - 描述：分析数据流和价值链以识别瓶颈和优化机会
   - 功能：可视化数据流动，追踪价值链
   - 位置：`skills/data-flow-analyzer/SKILL.md`

### 战术层 Skills（SDD + 宪法约束）- 7个

7. **spec-parser**
   - 描述：将自然语言需求解析为结构化技术规范
   - 功能：转换用户故事为YAML/JSON规范
   - 位置：`skills/spec-parser/SKILL.md`

8. **constitution-validator**
   - 描述：验证代码和规范是否符合架构原则和宪法约束
   - 功能：自动检查合规性，生成合规报告
   - 位置：`skills/constitution-validator/SKILL.md`

9. **spec-to-code-tracer**
   - 描述：建立规范与代码实现之间的双向可追溯性
   - 功能：创建追溯矩阵，支持影响分析
   - 位置：`skills/spec-to-code-tracer/SKILL.md`

10. **spec-evolution-tracker**
    - 描述：跟踪规范变更历史和影响分析
    - 功能：版本管理，变更影响评估
    - 位置：`skills/spec-evolution-tracker/SKILL.md`

11. **architecture-pattern-selector**
    - 描述：基于需求、约束和团队能力选择架构模式
    - 功能：系统化评估模式、创建决策矩阵、生成ADR
    - 位置：`skills/architecture-pattern-selector/SKILL.md`

12. **generic-code-generator**
    - 描述：根据规范、模板或测试驱动开发模式跨多种语言和框架生成生产代码
    - 功能：模板化代码生成、规范转换、TDD集成、多语言模式支持
    - 位置：`skills/generic-code-generator/SKILL.md`
13. **contract-test-generator**
    - 描述：生成消费者驱动的契约测试，确保微服务API兼容性，防止集成故障
    - 功能：契约生成、消费者驱动测试、Pact/OpenAPI集成、CI/CD验证门控
    - 位置：`skills/contract-test-generator/SKILL.md`

### 执行层 Skills（ATDD/BDD/TDD/SIT/Chaos）- 6个

14. **atdd-acceptance-test-generator**
    - 描述：从需求生成可执行的验收测试以驱动开发
    - 功能：生成可执行验收测试、利益相关者验证示例、测试覆盖分析
    - 位置：`skills/atdd-acceptance-test-generator/SKILL.md`

15. **bdd-scenario-writer**
    - 描述：将用户故事和需求转换为Gherkin BDD场景文件
    - 功能：生成Given-When-Then结构的场景，支持多语言
    - 位置：`skills/bdd-scenario-writer/SKILL.md`

16. **tdd-red-green-refactor**
    - 描述：使用测试驱动开发方法实现任何功能或修复错误
    - 功能：指导RED-GREEN-REFACTOR循环，支持多语言
    - 位置：`skills/tdd-red-green-refactor/SKILL.md`

17. **test-pyramid-analyzer**
    - 描述：分析测试覆盖率、分布和测试策略缺口
    - 功能：可视化测试分布，生成覆盖率报告，提供优化建议
    - 位置：`skills/test-pyramid-analyzer/SKILL.md`

18. **sit-scenario-generator**
    - 描述：创建跨多个服务或API端点的系统集成测试（SIT）场景
    - 功能：生成自动化SIT测试脚本，支持Cypress/Postman/k6
    - 位置：`skills/sit-scenario-generator/SKILL.md`

19. **chaos-test-designer**
    - 描述：设计混沌工程实验以测试系统弹性和容错能力
    - 功能：定义故障注入场景，支持LitmusChaos/Chaos Mesh
    - 位置：`skills/chaos-test-designer/SKILL.md`
### ITIL Service Management & Deployment Operations Skills - 7个

20. **incident-management**
    - 描述：ITIL对齐的事件处理流程和响应工作流
    - 功能：事件分类、优先级排序、升级、解决跟踪
    - 位置：`skills/incident-management/SKILL.md`

21. **problem-management**
    - 描述：根本原因分析和永久性修复管理
    - 功能：问题识别、根本原因分析、解决方案实施、预防措施
    - 位置：`skills/problem-management/SKILL.md`

22. **change-management**
    - 描述：受控变更流程与变更咨询委员会（CAB）审批
    - 功能：变更请求评估、风险评估、CAB审批、实施协调
    - 位置：`skills/change-management/SKILL.md`

23. **service-desk**
    - 描述：用户请求和问题的单一联系点管理
    - 功能：服务目录、SLA协议、用户沟通、请求跟踪
    - 位置：`skills/service-desk/SKILL.md`

24. **deployment-orchestrator**
    - 描述：高级部署策略编排（金丝雀、蓝绿、滚动更新）
    - 功能：部署策略选择、环境管理、发布协调、监控集成
    - 位置：`skills/deployment-orchestrator/SKILL.md`

25. **release-manager**
    - 描述：发布规划、版本管理和利益相关者协调
    - 功能：发布日历、版本控制、沟通计划、上线协调
    - 位置：`skills/release-manager/SKILL.md`

26. **rollback-manager**
    - 描述：失败部署的自动化回滚程序
    - 功能：回滚触发器、状态恢复、数据一致性验证
    - 位置：`skills/rollback-manager/SKILL.md`

### AI 协作与优化 Skills - 4个

27. **context-manager**
    - 描述：管理项目上下文、对话历史和信息检索
    - 功能：保存和恢复上下文，最小化token使用
    - 位置：`skills/context-manager/SKILL.md`

28. **skill-recommender**
    - 描述：根据当前任务、项目上下文和开发阶段推荐相关AI技能
    - 功能：智能推荐，提高效率
    - 位置：`skills/skill-recommender/SKILL.md`

29. **recursive-optimizer**
    - 描述：基于执行结果和用户反馈优化AI技能、提示词和工作流
    - 功能：A/B测试，持续改进循环
    - 位置：`skills/recursive-optimizer/SKILL.md`

30. **prompt-template-manager**
    - 描述：管理、版本化和优化AI提示词模板
    - 功能：版本控制，性能跟踪，A/B测试
    - 位置：`skills/prompt-template-manager/SKILL.md`

### Go + Vue + Quasar 全栈开发 Skills - 6个（基于 bitcms 模式）

31. **go-backend-scaffolder**
    - 描述：基于bitcms模式生成干净架构的Go后端代码
    - 功能：创建Fiber + GORM + Swagger后端，支持分层架构和Cobra命令结构
    - 特点：main.go在根目录作为Cobra入口，cmd/存放独立命令（version/daemon/server），包含默认version命令
    - 位置：`skills/go-backend-scaffolder/SKILL.md`

32. **vue-quasar-scaffolder**
    - 描述：基于bitcms前端模式生成Vue 3 + Quasar + TypeScript组件
    - 功能：创建Composition API组件、Pinia存储、测试配置
    - 位置：`skills/vue-quasar-scaffolder/SKILL.md`

33. **fullstack-project-setup**
    - 描述：基于bitcms结构初始化完整的Go + Vue + Quasar全栈项目
    - 功能：创建项目结构、Docker配置、CI/CD管道、开发环境
    - 位置：`skills/fullstack-project-setup/SKILL.md`

34. **requirements-to-code-docs**
    - 描述：基于bitcms文档工作流从需求到用例到实现生成结构化文档
    - 功能：需求文档、用例文档、API文档、可追溯性矩阵
    - 位置：`skills/requirements-to-code-docs/SKILL.md`

35. **go-vue-fullstack-workflow**
    - 描述：协调使用bitcms模式和文档的Go + Vue + Quasar全栈开发工作流
    - 功能：集成所有相关技能，提供端到端开发工作流指导
    - 位置：`skills/go-vue-fullstack-workflow/SKILL.md`

36. **makefile-backend-generator**
    - 描述：基于bitcms模式为Go后端项目创建生产级Makefile
    - 功能：生成包含构建、测试、部署、数据库操作的完整Makefile，支持跨平台编译
    - 位置：`skills/makefile-backend-generator/SKILL.md`

### 工具与集成 Skills - 2个

37. **skill-packaging-tool**
    - 描述：将技能打包为可分发的可安装包
    - 功能：版本管理，依赖声明，安装脚本
    - 位置：`skills/skill-packaging-tool/SKILL.md`

38. **go-cli-builder**
    - 描述：构建企业级Go CLI应用，基于cobra+viper和最佳实践
    - 功能：生成生产级CLI应用结构，包含配置管理、结构化日志、自动版本嵌入、多平台构建和完整测试策略
    - 特点：支持多路径配置文件搜索（./ → ./config → /etc/应用名称），自动获取Git版本和Go SDK版本，内置shell补全命令
    - 位置：`skills/go-cli-builder/SKILL.md`

## 技能特点

### 遵循的规范

1. **OpenCode Skills 规范**
   - YAML frontmatter（仅name和description）
   - Description以"Use when..."开头
   - 名称使用小写字母、数字和连字符
   - 文件路径：`skills/<name>/SKILL.md`

2. **Writing-Skills TDD 原则**
   - RED-GREEN-REFACTOR循环
   - 先写失败测试，再写代码
   - 每个技能包含测试用例

3. **Aether.go 方法论集成**
   - BMAD（业务驱动指标）框架
   - SDD（规范驱动开发）
   - 宪法约束原则
   - 规范与代码的可追溯性
   - 方法论融合协调

### 技能结构

每个技能包含：
- Overview（概述）
- When to Use（何时使用）
- Core Pattern（核心模式）
- Quick Reference（快速参考）
- Implementation（实现细节）
- Common Mistakes（常见错误）
- Real-World Impact（实际影响）
- Integration with Aether.go Methodology（与Aether.go方法论的集成）

## 技能集成与工作流

### 七阶段方法论融合工作流

新增的`methodology-fusion-orchestrator`技能协调完整的七个阶段：

```
阶段1: 业务分析 (Business Analysis)
  ├── business-requirements-collector
  ├── business-value-mapper
  └── metrics-definer

阶段2: 规范定义 (Specification Definition)
  ├── spec-parser
  ├── bdd-scenario-writer
  └── atdd-acceptance-test-generator

阶段3: 宪法审查 (Constitutional Review)
  └── constitution-validator

阶段4: 实现计划 (Implementation Planning)
  ├── architecture-decision-recorder
  └── data-flow-analyzer

阶段5: 代码生成 (Code Generation)
  ├── tdd-red-green-refactor
  ├── go-backend-scaffolder
  └── vue-quasar-scaffolder

阶段6: 集成验证 (Integration Validation)
  ├── sit-scenario-generator
  └── chaos-test-designer

阶段7: 部署与运维 (Deployment & Operations)
   ├── deployment-orchestrator
   ├── incident-management
   ├── change-management
   ├── release-manager
   ├── metrics-definer
   ├── problem-management
   ├── service-desk
   └── rollback-manager

阶段8: 递归优化 (Recursive Optimization)
  ├── recursive-optimizer
  ├── skill-recommender
  └── prompt-template-manager
```

### 宪法贯穿执行

`methodology-fusion-orchestrator`确保宪法原则在所有阶段得到执行：

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

### 智能技能调度

`methodology-fusion-orchestrator`实现智能技能调度：

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

### 度量聚合与反馈循环

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

## 使用说明

### 技能发现

OpenCode会自动从以下位置发现技能：
- 项目配置：`skills/<name>/SKILL.md`
- 全局配置：`~/.config/opencode/skill/<name>/SKILL.md`

### 技能加载

在对话中，AI助手会根据任务自动推荐和加载相关技能。你也可以显式请求使用特定技能。

### 技能分类

- **高优先级**：方法论融合协调技能（methodology-fusion-orchestrator）、执行层技能（ATDD/BDD/TDD/SIT/Chaos）
- **中优先级**：战略层和战术层技能、全栈开发技能
- **低优先级**：工具和集成技能、项目初始化技能

## 下一步

1. **测试验证**：使用subagent驱动开发测试每个技能的有效性
2. **性能优化**：根据使用反馈优化提示词和内容
3. **文档完善**：补充更多示例和使用场景
4. **分发打包**：使用skill-packaging-tool创建可安装包
5. **市场发布**：发布到技能市场供其他项目使用

## 注意事项

- 所有技能遵循TDD原则创建，需要进一步测试验证
- 技能可能需要根据实际使用场景进行优化
- 建议在使用技能前阅读完整的SKILL.md内容
- **方法论融合协调**：通过methodology-fusion-orchestrator实现端到端工作流协调
- **宪法贯穿执行**：新增技能确保宪法原则在所有阶段得到执行
- **反馈循环建立**：实现度量收集和递归优化的完整闭环
- 欢迎反馈和改进建议

---

创建日期：2024-01-16  
最后更新：2026-01-27  
创建者：AI Assistant based on Aether.go methodology  
参考文档：`method-paper.md`, `https://opencode.ai/docs/skills/`
更新记录：
- 2026-01-21: 更新go-backend-scaffolder技能，采用bitcms风格的Cobra命令结构
- 2026-01-27: 新增3个关键技能填补方法论缺口，实现完整的七阶段融合工作流