# Aether.go Skills Summary

---

**语言**: [English](SKILLS_SUMMARY.md) | [中文](SKILLS_SUMMARY_CN.md)

---

基于 Aether.go 方法论融合框架 V2.1 和 OpenCode skills 规范，已创建 **87个skills**，覆盖五层推导模型的完整八个推导域(D1-D8)。

## 架构更新 (2026-04-24)

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

### 五层推导模型

```
L1: 业务价值层
    └── business-requirements-collector → value-decomposer → metrics-definer
L2: 系统行为层
    └── architecture-pattern-selector → tech-stack-selector → data-flow-analyzer → interface-contract-designer
L3: 验收标准层
    └── spec-parser → spec-to-scenario → scenario-completeness-checker → usecase-designer → nfr-analyzer
L4: 组件契约层
    └── test-pyramid-deriver → e2e-test-generator → integration-test-generator → contract-test-generator → system-test-generator → test-pyramid-analyzer
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
   - 描述：应用类型、语言，框架，数据库的交互式技术栈选择
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

15. **spec-evolution-tracker**
    - 描述：跟踪规范变更历史和影响分析
    - 位置：`skills/spec-evolution-tracker/SKILL.md`

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

21. **test-pyramid-analyzer**
    - 描述：分析测试覆盖、分布和测试策略缺口
    - 位置：`skills/test-pyramid-analyzer/SKILL.md`

### D5: 实现推导域 (6个Skills) — L4→L5

22. **unit-test-generator** ⭐
    - 描述：从接口契约生成具有边界值分析的单元测试
    - 位置：`skills/unit-test-generator/SKILL.md`

23. **tdd-cycle-runner** ⭐
    - 描述：作为原子技能执行完整的TDD红-绿-重构循环
    - 位置：`skills/tdd-cycle-runner/SKILL.md`

24. **contract-driven-code-generator** ⭐
    - 描述：从接口契约生成骨架代码
    - 位置：`skills/contract-driven-code-generator/SKILL.md`

25. **backend-code-generator** ⭐
    - 描述：从契约和业务逻辑生成后端实现
    - 位置：`skills/backend-code-generator/SKILL.md`

26. **frontend-code-generator** ⭐
    - 描述：从契约和UI规范生成前端实现
    - 位置：`skills/frontend-code-generator/SKILL.md`

27. **code-refactor-engine** ⭐
    - 描述：在保持行为的同时进行自动化重构
    - 位置：`skills/code-refactor-engine/SKILL.md`

### D6: 场景适配域 (8个Skills) — 8种场景模式

28. **scenario-detector** ⭐
    - 描述：检测具有推导参数的适当开发场景模式
    - 位置：`skills/scenario-detector/SKILL.md`

29. **standard-mode-workflow** ⭐
    - 描述：具有完整五层推导的绿地项目标准工作流
    - 位置：`skills/standard-mode-workflow/SKILL.md`

30. **reverse-engineering-suite** ⭐
    - 描述：使用静态/动态分析从遗留系统提取规范
    - 位置：`skills/reverse-engineering-suite/SKILL.md`

31. **dual-track-validator** ⭐
    - 描述：具有行为等价的并行验证技术栈迁移
    - 位置：`skills/dual-track-validator/SKILL.md`

32. **strangler-pattern-suite** ⭐
    - 描述：使用防腐层的增量组件替换
    - 位置：`skills/strangler-pattern-suite/SKILL.md`

33. **poc-exemption-manager** ⭐
    - 描述：管理概念验证项目的宪法原则豁免
    - 位置：`skills/poc-exemption-manager/SKILL.md`

34. **wartime-hotfix-workflow** ⭐
    - 描述：两阶段流程的紧急生产修复（即时+事后规范化）
    - 位置：`skills/wartime-hotfix-workflow/SKILL.md`

35. **federal-constitution-manager** ⭐
    - 描述：具有全局+局部宪法和CDC契约的多团队开发
    - 位置：`skills/federal-constitution-manager/SKILL.md`

### D7: 演进优化域 (5个Skills) — P9-P10

36. **convergence-checker** ⭐
    - 描述：检查递归优化的收敛条件（有界性、单调性、终止）
    - 位置：`skills/convergence-checker/SKILL.md`

37. **improvement-budget-allocator** ⭐
    - 描述：按照70/20/10规则分配改进预算（交付/债务/实验）
    - 位置：`skills/improvement-budget-allocator/SKILL.md`

38. **tech-debt-quantifier** ⭐
    - 描述：量化和编目技术债务及影响分析
    - 位置：`skills/tech-debt-quantifier/SKILL.md`

39. **skill-lifecycle-manager** ⭐
    - 描述：从创建到验证到退役的技能资产生命周期管理
    - 位置：`skills/skill-lifecycle-manager/SKILL.md`

40. **skill-optimizer** ⭐
    - 描述：基于执行历史和成功率分析优化技能参数
    - 位置：`skills/skill-optimizer/SKILL.md`

### D8: 元能力域 (9个Skills) — 自验证与语义确认

41. **derivation-chain-validator** ⭐
    - 描述：验证五层推导链的完整性
    - 位置：`skills/derivation-chain-validator/SKILL.md`

42. **principle-consistency-checker** ⭐
    - 描述：具有动态加权支持的原则一致性检查
    - 位置：`skills/principle-consistency-checker/SKILL.md`

43. **scenario-mode-recommender** ⭐
    - 描述：具有置信度评分和推导参数的场景模式推荐
    - 位置：`skills/scenario-mode-recommender/SKILL.md`

44. **meta-skeptic** ⭐
    - 描述：对Agent/Skill配置和关键推导输出进行质疑
    - 位置：`skills/meta-skeptic/SKILL.md`

45. **architecture-self-auditor** ⭐
    - 描述：跨覆盖度、冗余度、瓶颈度、均衡度、演化度的架构自审
    - 位置：`skills/architecture-self-auditor/SKILL.md`

46. **skill-gap-analyzer** ⭐
    - 描述：分析与方法论要求相比的技能覆盖缺口
    - 位置：`skills/skill-gap-analyzer/SKILL.md`

47. **adjustment-proposer** ⭐
    - 描述：响应审计发现提出架构调整建议
    - 位置：`skills/adjustment-proposer/SKILL.md`

48. **adjustment-validator** ⭐
    - 描述：验证建议调整的正确性和安全性
    - 位置：`skills/adjustment-validator/SKILL.md`

49. **semantic-intent-clarifier** ⭐
    - 描述：在关键需求节点生成结构化反向澄清问题
    - 位置：`skills/semantic-intent-clarifier/SKILL.md`

---

## 支持性Skills (38个工具类)

### 质疑验证Skills (4个)

50. **correctness-checker** - 验证事实正确性和逻辑一致性
51. **completeness-checker** - 验证内容完整性和覆盖度
52. **consistency-checker** - 验证跨层和跨域一致性
53. **boundedness-checker** - 验证优化的有界性约束

### 方法论编排 (2个)

54. **methodology-fusion-orchestrator** - 协调端到端Aether.go方法论融合工作流
55. **requirement-classifier** - 将需求分类为7类并分析跨类关系

### 规范与测试 (4个)

56. **spec-parser** - 将自然语言需求解析为结构化规范
57. **bdd-scenario-writer** - 将用户故事转换为Gherkin BDD场景文件
58. **atdd-acceptance-test-generator** - 从需求生成可执行验收测试
59. **sit-scenario-generator** - 创建跨服务的系统集成测试场景

### 宪法与追溯 (2个)

60. **constitution-validator** - 验证代码和规范是否符合宪法原则
61. **spec-to-code-tracer** - 建立规范与代码之间的双向可追溯性

### AI协作与优化 (4个)

62. **context-manager** - 管理项目上下文、对话历史和信息检索
63. **skill-recommender** - 基于当前任务和上下文推荐相关Skills
64. **recursive-optimizer** - 基于反馈优化Skills、提示词和工作流
65. **prompt-template-manager** - 管理、版本控制和优化AI提示词模板

### IT服务管理与部署 (7个)

66. **deployment-orchestrator** - 高级部署策略编排（金丝雀、蓝绿、滚动）
67. **incident-management** - ITIL对齐的事件处理流程
68. **problem-management** - 根因分析和永久修复管理
69. **change-management** - 受控变更流程和CAB审批
70. **service-desk** - 单点联系管理
71. **release-manager** - 发布计划和干系人协调
72. **rollback-manager** - 自动化回滚程序

### 全栈开发工具 (9个)

73. **go-backend-scaffolder** - 生成清晰架构的Go后端代码
74. **vue-quasar-scaffolder** - 生成Vue 3 + Quasar + TypeScript组件
75. **fullstack-project-setup** - 初始化完整的Go + Vue + Quasar全栈项目
76. **requirements-to-code-docs** - 生成结构化文档工作流
77. **go-vue-fullstack-workflow** - 协调Go + Vue全栈开发
78. **makefile-backend-generator** - 为Go项目创建生产就绪的Makefile
79. **go-cli-builder** - 构建企业级Go CLI应用程序
80. **rust-cli-builder** - 构建企业级Rust CLI应用程序
81. **readme-license-generator** - 生成双语README和LICENSE文件

### 其他工具 (6个)

82. **business-value-mapper** - 使用BMAD将业务目标转化为可衡量指标
83. **chaos-test-designer** - 设计混沌工程实验
84. **generic-code-generator** - 跨多种语言生成生产代码
85. **skill-packaging-tool** - 将Skills打包成分发包
86. **tdd-red-green-refactor** - 使用TDD方法论实现功能
87. **scenario-mode-selector** - 选择适当的场景模式（建议使用scenario-detector）

---

## Skills结构

每个Skill遵循OpenCode规范：
- YAML前导matter（名称和描述）
- 描述以"Use when..."开头
- 名称使用小写字母、数字和连字符
- 文件路径：`skills/<name>/SKILL.md`

---

**创建日期**: 2026-01-16
**最后更新**: 2026-04-24
**参考文档**: `method-paper.md`, `ai-agent-architecture-proposal.md V2.1`
