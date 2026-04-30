# Aether.go Skills 汇总

---

**语言**: [English](SKILLS_SUMMARY.md) | [中文](SKILLS_SUMMARY_CN.md)

---

基于 Aether.go 方法论融合框架 V2.1 和 OpenCode skills 规范，已创建 **99个skills**，覆盖五层推导模型的完整八个推导域(D1-D8)以及扩展域。

## 架构更新 (2026-04-30)

基于 [method-paper.md](../ai-docs/layer3/aether-go/method-paper.md) 和 [ai-agent-architecture-proposal.md V2.1](../ai-docs/layer3/aether-go/ai-agent-architecture-proposal.md)，已实施以下架构改进：

### 核心Skills: D1-D8推导域 (49个Skills)

| 域 | 名称 | Skills数量 | 说明 |
|---|------|-----------|------|
| **D1** | 价值推导域 | 5 | L1→L2: 业务目标到功能需求 |
| **D2** | 架构推导域 | 5 | L2→L3: 功能需求到架构决策 |
| **D3** | 规范推导域 | 5 | L3→L4: 系统规范到GWT验收标准 |
| **D4** | 契约推导域 | 6 | L4→L5: 验收标准到测试分层 |
| **D5** | 实现推导域 | 6 | L4→L5: 契约到单元测试和代码 |
| **D6** | 场景适配域 | 8 | 8种场景模式，支持情境感知工作流 |
| **D7** | 演进优化域 | 5 | P9-P10: 递归优化和技能资产化 |
| **D8** | 元能力域 | 9 | 自验证、自调整、语义确认 |

### 扩展域 (D4.5, D7.5)

| 域 | 名称 | Skills数量 | 说明 |
|---|------|-----------|------|
| **D4.5** | 生成调度域 | 5 | 确定性评估、代码生成器调度、契约一致性门控 |
| **D7.5** | 知识引擎域 | 2 | 代码图分析、仓库Wiki生成 |

### 五层推导模型

```
L1: 业务价值层
    └── business-requirements-collector → value-decomposer → metrics-definer
L2: 系统行为层
    └── architecture-pattern-selector → tech-stack-selector → data-flow-analyzer → interface-contract-designer
L3: 验收标准层
    └── spec-parser → spec-to-scenario → scenario-completeness-checker → usecase-designer → nfr-analyzer
L4: 组件契约层
    └── test-pyramid-deriver → e2e-test-generator → integration-test-generator → contract-test-generator → system-test-generator → test-pyramid-validator
L4.5: 生成调度层
    └── deterministic-evaluator → code-generator-dispatcher → contract-consistency-gate → confidence-based-reviewer
L5: 单元实现层
    └── unit-test-generator → tdd-cycle-runner → contract-driven-code-generator → backend-code-generator → frontend-code-generator → code-refactor-engine
```

### 协议支持 (ARGUE-001至ARGUE-005, META-001至META-005)

- **ARGUE-001**: UniversalSkeptic → WorkflowOrchestrator (质疑结果)
- **ARGUE-002**: ConstitutionGuardian → ChangeAndTaskAgent (原则违规)
- **ARGUE-003**: RecursiveOptimizer → WorkflowOrchestrator (优化建议)
- **ARGUE-004**: ContextManager → 任意Agent (上下文质量)
- **ARGUE-005**: HumanAIBoundaryGuard → 用户 (语义确认)

### 动态原则加权

ConstitutionGuardian 支持实时动态加权以解决原则冲突：
- 紧急模式: P6 (测试先行) 降低至 0.4
- POC模式: P2, P4 豁免
- 交付压力: P9 (递归优化) 降低

---

## 按域分类的Skills清单

### D1: 价值推导域 (5个Skills) — L1→L2

1. **business-requirements-collector**
   - 描述：收集、分析和优先排序来自干系人的业务需求
   - 位置：`skills/business-requirements-collector/SKILL.md`

2. **value-decomposer** ⭐
   - 描述：将业务目标分解为可衡量的功能需求
   - 位置：`skills/value-decomposer/SKILL.md`

3. **metrics-definer**
   - 描述：定义业务和技术指标及监控配置
   - 位置：`skills/metrics-definer/SKILL.md`

4. **value-architecture-tracer** ⭐
   - 描述：验证功能需求与架构决策之间的双向映射
   - 位置：`skills/value-architecture-tracer/SKILL.md`

5. **requirement-implementation-tracer**
   - 描述：建立需求、用例和实现之间的三层双向可追溯性
   - 位置：`skills/requirement-implementation-tracer/SKILL.md`

### D2: 架构推导域 (5个Skills) — L2→L3

6. **architecture-decision-recorder**
   - 描述：记录具有业务理由和备选方案分析的架构决策
   - 位置：`skills/architecture-decision-recorder/SKILL.md`

7. **architecture-pattern-selector**
   - 描述：基于需求、约束和团队能力选择架构模式
   - 位置：`skills/architecture-pattern-selector/SKILL.md`

8. **tech-stack-selector**
   - 描述：应用类型、语言、框架、数据库的交互式技术栈选择
   - 位置：`skills/tech-stack-selector/SKILL.md`

9. **data-flow-analyzer**
   - 描述：分析数据流和价值链以识别瓶颈
   - 位置：`skills/data-flow-analyzer/SKILL.md`

10. **interface-contract-designer** ⭐
    - 描述：设计具有完整输入/输出/前置/后置条件的接口契约
    - 位置：`skills/interface-contract-designer/SKILL.md`

### D3: 规范推导域 (5个Skills) — L3→L4

11. **usecase-designer**
    - 描述：设计与需求双向可追溯的用例
    - 位置：`skills/usecase-designer/SKILL.md`

12. **nfr-analyzer**
    - 描述：分析具有可衡量指标和验证标准的非功能需求
    - 位置：`skills/nfr-analyzer/SKILL.md`

13. **spec-to-scenario** ⭐
    - 描述：将结构化规范转换为GWT (Given-When-Then) 验收场景
    - 位置：`skills/spec-to-scenario/SKILL.md`

14. **scenario-completeness-checker** ⭐
    - 描述：验证GWT场景覆盖完整性，包括正向/负向路径和边界
    - 位置：`skills/scenario-completeness-checker/SKILL.md`

15. **spec-version-manager** ⭐
    - 描述：管理具有演进跟踪和影响分析的规范版本（合并自spec-evolution-tracker）
    - 位置：`skills/spec-version-manager/SKILL.md`

### D4: 契约推导域 (6个Skills) — L3→L4 (最关键域)

16. **test-pyramid-deriver** ⭐
    - 描述：从GWT验收标准推导测试分层计划，支持META-005验证
    - 位置：`skills/test-pyramid-deriver/SKILL.md`

17. **integration-test-generator** ⭐
    - 描述：为跨内部边界的组件协作生成集成测试
    - 位置：`skills/integration-test-generator/SKILL.md`

18. **contract-test-generator**
    - 描述：生成消费者驱动的契约测试以确保微服务API兼容性
    - 位置：`skills/contract-test-generator/SKILL.md`

19. **e2e-test-generator** ⭐
    - 描述：为跨系统边界的完整用户旅程生成端到端测试
    - 位置：`skills/e2e-test-generator/SKILL.md`

20. **system-test-generator** ⭐
    - 描述：为性能、安全性、可靠性、可扩展性生成非功能系统测试
    - 位置：`skills/system-test-generator/SKILL.md`

21. **test-pyramid-validator** ⭐
    - 描述：验证测试比例并分析覆盖度/分布（合并自test-pyramid-analyzer）
    - 位置：`skills/test-pyramid-validator/SKILL.md`

### D4.5: 生成调度域 (5个Skills) — L4→L4.5 (新增)

22. **deterministic-evaluator** ⭐
    - 描述：评估组件契约的确定性分数以决定生成策略（传统vs AI）
    - 位置：`skills/deterministic-evaluator/SKILL.md`

23. **code-generator-dispatcher** ⭐
    - 描述：基于模式匹配将确定性任务分派给适当的传统代码生成器
    - 位置：`skills/code-generator-dispatcher/SKILL.md`

24. **contract-consistency-gate** ⭐
    - 描述：验证生成的代码是否符合组件契约后才进入L5（GATE-001）
    - 位置：`skills/contract-consistency-gate/SKILL.md`

25. **confidence-based-reviewer** ⭐
    - 描述：对AI生成的代码进行置信度评分并路由到适当的人工审查级别
    - 位置：`skills/confidence-based-reviewer/SKILL.md`

26. **intent-hierarchizer** ⭐
    - 描述：将业务意图分层为三个级别（业务、功能、实现）以支持意图驱动开发（P11）
    - 位置：`skills/intent-hierarchizer/SKILL.md`

### D5: 实现推导域 (6个Skills) — L4→L5

27. **unit-test-generator** ⭐
    - 描述：从接口契约生成具有边界值分析的单元测试
    - 位置：`skills/unit-test-generator/SKILL.md`

28. **tdd-cycle-runner** ⭐
    - 描述：作为原子技能执行完整的TDD红-绿-重构循环
    - 位置：`skills/tdd-cycle-runner/SKILL.md`

29. **contract-driven-code-generator** ⭐
    - 描述：从接口契约生成骨架代码
    - 位置：`skills/contract-driven-code-generator/SKILL.md`

30. **backend-code-generator** ⭐
    - 描述：从契约和业务逻辑生成后端实现
    - 位置：`skills/backend-code-generator/SKILL.md`

31. **frontend-code-generator** ⭐
    - 描述：从契约和UI规范生成前端实现
    - 位置：`skills/frontend-code-generator/SKILL.md`

32. **code-refactor-engine** ⭐
    - 描述：在保持行为的同时进行自动化重构
    - 位置：`skills/code-refactor-engine/SKILL.md`

### D6: 场景适配域 (10个Skills) — 8+2种场景模式

33. **scenario-detector** ⭐
    - 描述：检测具有推导参数的适当开发场景模式
    - 位置：`skills/scenario-detector/SKILL.md`

34. **standard-mode-workflow** ⭐
    - 描述：具有完整五层推导的绿地项目标准工作流
    - 位置：`skills/standard-mode-workflow/SKILL.md`

35. **reverse-engineering-suite** ⭐
    - 描述：使用静态/动态分析从遗留系统提取规范
    - 位置：`skills/reverse-engineering-suite/SKILL.md`

36. **dual-track-validator** ⭐
    - 描述：具有行为等价的并行验证技术栈迁移
    - 位置：`skills/dual-track-validator/SKILL.md`

37. **strangler-pattern-suite** ⭐
    - 描述：使用防腐层的增量组件替换
    - 位置：`skills/strangler-pattern-suite/SKILL.md`

38. **poc-exemption-manager** ⭐
    - 描述：管理概念验证项目的宪法原则豁免
    - 位置：`skills/poc-exemption-manager/SKILL.md`

39. **wartime-hotfix-workflow** ⭐
    - 描述：具有两阶段流程的紧急生产修复（立即修复+事后规范化）
    - 位置：`skills/wartime-hotfix-workflow/SKILL.md`

40. **federal-constitution-manager** ⭐
    - 描述：具有全局+本地宪法和CDC契约的多团队开发
    - 位置：`skills/federal-constitution-manager/SKILL.md`

41. **harness-reverse-construction-workflow** ⭐ (新增)
    - 描述：通过知识引擎从现有代码库逆向推导约束和架构
    - 位置：`skills/harness-reverse-construction-workflow/SKILL.md`

42. **ai-native-build-workflow** ⭐ (新增)
    - 描述：执行结合意图驱动开发和混合生成管道的AI原生构建模式
    - 位置：`skills/ai-native-build-workflow/SKILL.md`

### D7: 演进优化域 (5个Skills) — P9-P10

43. **convergence-checker** ⭐
    - 描述：检查递归优化的收敛条件（有界性、单调性、终止性）
    - 位置：`skills/convergence-checker/SKILL.md`

44. **improvement-budget-allocator** ⭐
    - 描述：分配改进预算并执行持续改进工作流（合并自continuous-improvement-suite）
    - 位置：`skills/improvement-budget-allocator/SKILL.md`

45. **tech-debt-quantifier** ⭐
    - 描述：量化并编目技术债务及影响分析
    - 位置：`skills/tech-debt-quantifier/SKILL.md`

46. **skill-lifecycle-manager** ⭐
    - 描述：管理技能资产生命周期，从创建、验证到退役
    - 位置：`skills/skill-lifecycle-manager/SKILL.md`

47. **skill-optimizer** ⭐
    - 描述：基于执行历史和成功率分析优化技能参数
    - 位置：`skills/skill-optimizer/SKILL.md`

### D7.5: 知识引擎域 (2个Skills) — (新增)

48. **code-graph-analyzer** ⭐
    - 描述：分析代码库结构、依赖关系和关联以构建代码图知识引擎
    - 位置：`skills/code-graph-analyzer/SKILL.md`

49. **repo-wiki-generator** ⭐
    - 描述：生成包含架构百科全书、设计决策和入职指南的仓库Wiki
    - 位置：`skills/repo-wiki-generator/SKILL.md`

### D8: 元能力域 (9个Skills) — 自验证与语义澄清

50. **derivation-chain-validator** ⭐
    - 描述：验证五层推导链的完整性
    - 位置：`skills/derivation-chain-validator/SKILL.md`

51. **principle-consistency-checker** ⭐
    - 描述：检查原则一致性并支持动态加权
    - 位置：`skills/principle-consistency-checker/SKILL.md`

52. **scenario-mode-recommender** ⭐
    - 描述：推荐场景模式并提供置信度评分和推导参数
    - 位置：`skills/scenario-mode-recommender/SKILL.md`

53. **meta-skeptic** ⭐
    - 描述：质疑代理/技能配置和关键推导输出
    - 位置：`skills/meta-skeptic/SKILL.md`

54. **architecture-self-auditor** ⭐
    - 描述：架构自审计，涵盖覆盖度、冗余、瓶颈、均衡度、演进
    - 位置：`skills/architecture-self-auditor/SKILL.md`

55. **skill-gap-analyzer** ⭐
    - 描述：分析方法论需求的技能覆盖差距
    - 位置：`skills/skill-gap-analyzer/SKILL.md`

56. **adjustment-proposer** ⭐
    - 描述：响应审计发现提出架构调整建议
    - 位置：`skills/adjustment-proposer/SKILL.md`

57. **adjustment-validator** ⭐
    - 描述：验证建议的调整的正确性和安全性
    - 位置：`skills/adjustment-validator/SKILL.md`

58. **semantic-intent-clarifier** ⭐
    - 描述：在关键需求节点生成结构化反向澄清问题
    - 位置：`skills/semantic-intent-clarifier/SKILL.md`

---

## 辅助Skills (41个工具)

### 质疑验证Skills (4个)

59. **correctness-checker**
    - 描述：验证事实准确性和逻辑一致性

60. **completeness-checker**
    - 描述：验证内容完整性和覆盖度

61. **consistency-checker**
    - 描述：验证跨层和跨域一致性

62. **boundedness-checker**
    - 描述：验证优化的有界性约束

### 方法论编排 (2个)

63. **methodology-fusion-orchestrator**
    - 描述：协调端到端的Aether.go方法论融合工作流

64. **requirement-classifier**
    - 描述：将需求分类为7个类别并建立跨类别关系

### 规范与测试 (4个)

65. **spec-parser**
    - 描述：将自然语言需求解析为结构化规范

66. **bdd-scenario-writer**
    - 描述：将用户故事转换为Gherkin BDD场景文件

67. **atdd-acceptance-test-generator**
    - 描述：从需求生成可执行的验收测试

68. **sit-scenario-generator**
    - 描述：创建跨服务的系统集成测试场景

### 宪法与可追溯性 (2个)

69. **constitution-validator**
    - 描述：验证代码和规范是否符合宪法原则

70. **spec-to-code-tracer**
    - 描述：建立规范与代码之间的双向可追溯性

### AI协作与优化 (6个)

71. **context-manager**
    - 描述：管理项目上下文、对话历史和信息检索

72. **skill-recommender**
    - 描述：基于当前任务和上下文推荐相关技能

73. **recursive-optimizer**
    - 描述：基于反馈优化技能、提示词和工作流

74. **prompt-template-manager**
    - 描述：管理、版本控制和优化AI提示词模板

75. **ai-effectiveness-tracker** (新增)
    - 描述：追踪AI协作效果指标（Token节省、生成质量、审查减少）

76. **system-quality-tracker** (新增)
    - 描述：追踪系统质量指标（完整性、覆盖率、正确性、满意度）

### IT服务管理与部署 (7个)

77. **deployment-orchestrator**
    - 描述：高级部署策略编排（金丝雀、蓝绿、滚动）

78. **incident-management**
    - 描述：符合ITIL的事件处理流程

79. **problem-management**
    - 描述：根本原因分析和永久修复管理

80. **change-management**
    - 描述：受控变更流程和CAB审批

81. **service-desk**
    - 描述：单一联系点管理

82. **release-manager**
    - 描述：发布计划和干系人协调

83. **rollback-manager**
    - 描述：自动化回滚程序

### 全栈开发工具 (9个)

84. **go-backend-scaffolder**
    - 描述：生成整洁架构Go后端代码

85. **vue-quasar-scaffolder**
    - 描述：生成Vue 3 + Quasar + TypeScript组件

86. **fullstack-project-setup**
    - 描述：初始化完整的Go + Vue + Quasar全栈项目

87. **requirements-to-code-docs**
    - 描述：生成结构化文档工作流

88. **go-vue-fullstack-workflow**
    - 描述：协调Go + Vue全栈开发

89. **makefile-backend-generator**
    - 描述：为Go项目创建生产级Makefile

90. **go-cli-builder**
    - 描述：构建企业级Go CLI应用

91. **rust-cli-builder**
    - 描述：构建企业级Rust CLI应用

92. **readme-license-generator**
    - 描述：生成双语README和LICENSE文件

### 附加工具 (7个)

93. **business-value-mapper**
    - 描述：使用BMAD将业务目标转换为可衡量指标

94. **chaos-test-designer**
    - 描述：设计混沌工程实验

95. **generic-code-generator**
    - 描述：跨多种语言生成生产代码

96. **skill-packaging-tool**
    - 描述：将技能打包为可分发包

97. **mode-selector** (新增)
    - 描述：管理三种模式切换（规范驱动、涌现探索、意图驱动）并调整原则强度

98. **non-functional-gate-checker** (新增)
    - 描述：验证非功能需求，包括性能预算、安全扫描、合规检查（P14）

99. **constraint-check-runner** (新增)
    - 描述：执行从constraints/*.yml文件加载的约束检查（P13, GATE-001）

---

## Skill统计

| 类别 | Skills数量 | 说明 |
|-----|-----------|------|
| **D1-D5推导域** | 27 | 五层推导模型技能 |
| **D4.5生成调度域** | 5 | 生成策略调度技能 |
| **D6场景域** | 10 | 10种场景模式适配 |
| **D7演进域** | 5 | 递归优化与资产化 |
| **D7.5知识引擎域** | 2 | 代码图和仓库Wiki生成 |
| **D8元能力域** | 9 | 自验证与调整 |
| **辅助工具** | 41 | 工具与验证 |
| **总计** | **99** | 完整技能库 |

---

## 最近更新 (2026-04-30)

### 新增Skills (16个)

1. **D4.5生成调度域** (5个skills)
   - `deterministic-evaluator` - 评估任务确定性以选择生成策略
   - `code-generator-dispatcher` - 分派到传统代码生成器
   - `contract-consistency-gate` - GATE-001协议实现
   - `confidence-based-reviewer` - 基于置信度的人工审查路由
   - `intent-hierarchizer` - P11意图分层原则实现

2. **D6场景适配域** (2个skills)
   - `harness-reverse-construction-workflow` - 从遗留代码逆向构建
   - `ai-native-build-workflow` - 具有混合管道的AI原生构建模式

3. **D7.5知识引擎域** (2个skills)
   - `code-graph-analyzer` - 代码库结构和依赖分析
   - `repo-wiki-generator` - 仓库Wiki和文档生成

4. **AI协作与优化** (2个skills)
   - `ai-effectiveness-tracker` - 双轨AI效果指标
   - `system-quality-tracker` - 双轨系统质量指标

5. **附加工具** (3个skills)
   - `mode-selector` - 三种模式切换及原则强度调整
   - `non-functional-gate-checker` - P14 NFR验证
   - `constraint-check-runner` - P13约束机制化

### 架构增强

- 在L4和L5之间添加L4.5生成调度层
- 添加D7.5知识引擎域用于上下文增强
- 实现双轨优化（系统质量 + AI效果）
- 添加三种开发模式支持（规范驱动、涌现探索、意图驱动）
- 使用GATE-001协议增强约束机制化
