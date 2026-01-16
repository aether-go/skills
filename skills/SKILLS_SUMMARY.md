# Aether.go Skills Summary

根据 `overall.md` 中的规划和 OpenCode skills 规范，已成功创建所有 18 个技能。

## 技能清单

### 执行层 Skills（ATDD/BDD/TDD/SIT）- 5个

1. **bdd-scenario-writer**
   - 描述：将用户故事和需求转换为 Gherkin BDD 场景文件
   - 功能：生成 Given-When-Then 结构的场景，支持多语言
   - 位置：`.opencode/skill/bdd-scenario-writer/SKILL.md`

2. **tdd-red-green-refactor**
   - 描述：使用测试驱动开发方法实现任何功能或修复错误
   - 功能：指导 RED-GREEN-REFACTOR 循环，支持多语言
   - 位置：`.opencode/skill/tdd-red-green-refactor/SKILL.md`

3. **test-pyramid-analyzer**
   - 描述：分析测试覆盖率、分布和测试策略缺口
   - 功能：可视化测试分布，生成覆盖率报告，提供优化建议
   - 位置：`.opencode/skill/test-pyramid-analyzer/SKILL.md`

4. **sit-scenario-generator**
   - 描述：创建跨多个服务或 API 端点的系统集成测试（SIT）场景
   - 功能：生成自动化 SIT 测试脚本，支持 Cypress/Postman/k6
   - 位置：`.opencode/skill/sit-scenario-generator/SKILL.md`

5. **chaos-test-designer**
   - 描述：设计混沌工程实验以测试系统弹性和容错能力
   - 功能：定义故障注入场景，支持 LitmusChaos/Chaos Mesh
   - 位置：`.opencode/skill/chaos-test-designer/SKILL.md`

### 战略层 Skills（BMAD 驱动）- 4个

6. **business-value-mapper**
   - 描述：使用 BMAD 框架将业务目标转化为可衡量的技术指标
   - 功能：生成 BMAD 矩阵，连接业务目标与技术指标
   - 位置：`.opencode/skill/business-value-mapper/SKILL.md`

7. **metrics-definer**
   - 描述：为特定系统类型定义业务和技术指标及监控配置
   - 功能：定义指标清单，内置电商/SaaS/IoT 等场景模板
   - 位置：`.opencode/skill/metrics-definer/SKILL.md`

8. **architecture-decision-recorder**
   - 描述：记录架构决策及其业务依据和备选方案分析
   - 功能：创建 ADR 文档，记录决策理由和权衡
   - 位置：`.opencode/skill/architecture-decision-recorder/SKILL.md`

9. **data-flow-analyzer**
   - 描述：分析数据流和价值链以识别瓶颈和优化机会
   - 功能：可视化数据流动，追踪价值链
   - 位置：`.opencode/skill/data-flow-analyzer/SKILL.md`

### 战术层 Skills（SDD + 宪法约束）- 4个

10. **spec-parser**
    - 描述：将自然语言需求解析为结构化技术规范
    - 功能：转换用户故事为 YAML/JSON 规范
    - 位置：`.opencode/skill/spec-parser/SKILL.md`

11. **constitution-validator**
    - 描述：验证代码和规范是否符合架构原则和宪法约束
    - 功能：自动检查合规性，生成合规报告
    - 位置：`.opencode/skill/constitution-validator/SKILL.md`

12. **spec-to-code-tracer**
    - 描述：建立规范与代码实现之间的双向可追溯性
    - 功能：创建追溯矩阵，支持影响分析
    - 位置：`.opencode/skill/spec-to-code-tracer/SKILL.md`

13. **spec-evolution-tracker**
    - 描述：跟踪规范变更历史和影响分析
    - 功能：版本管理，变更影响评估
    - 位置：`.opencode/skill/spec-evolution-tracker/SKILL.md`

### AI 协作与优化 Skills - 4个

14. **context-manager**
    - 描述：管理项目上下文、对话历史和信息检索
    - 功能：保存和恢复上下文，最小化 token 使用
    - 位置：`.opencode/skill/context-manager/SKILL.md`

15. **skill-recommender**
    - 描述：根据当前任务、项目上下文和开发阶段推荐相关 AI 技能
    - 功能：智能推荐，提高效率
    - 位置：`.opencode/skill/skill-recommender/SKILL.md`

16. **recursive-optimizer**
    - 描述：基于执行结果和用户反馈优化 AI 技能、提示词和工作流
    - 功能：A/B 测试，持续改进循环
    - 位置：`.opencode/skill/recursive-optimizer/SKILL.md`

17. **prompt-template-manager**
    - 描述：管理、版本化和优化 AI 提示词模板
    - 功能：版本控制，性能跟踪，A/B 测试
    - 位置：`.opencode/skill/prompt-template-manager/SKILL.md`

### 工具与集成 Skills - 1个

18. **skill-packaging-tool**
    - 描述：将技能打包为可分发的可安装包
    - 功能：版本管理，依赖声明，安装脚本
    - 位置：`.opencode/skill/skill-packaging-tool/SKILL.md`

## 技能特点

### 遵循的规范

1. **OpenCode Skills 规范**
   - YAML frontmatter（仅 name 和 description）
   - Description 以 "Use when..." 开头
   - 名称使用小写字母、数字和连字符
   - 文件路径：`.opencode/skill/<name>/SKILL.md`

2. **Writing-Skills TDD 原则**
   - RED-GREEN-REFACTOR 循环
   - 先写失败测试，再写代码
   - 每个技能包含测试用例

3. **Aether.go 方法论集成**
   - BMAD（业务驱动指标）框架
   - SDD（规范驱动开发）
   - 宪法约束原则
   - 规范与代码的可追溯性

### 技能结构

每个技能包含：
- Overview（概述）
- When to Use（何时使用）
- Core Pattern（核心模式）
- Quick Reference（快速参考）
- Implementation（实现细节）
- Common Mistakes（常见错误）
- Real-World Impact（实际影响）
- Integration with Aether.go Methodology（与 Aether.go 方法论的集成）

## 使用说明

### 技能发现

OpenCode 会自动从以下位置发现技能：
- 项目配置：`.opencode/skill/<name>/SKILL.md`
- 全局配置：`~/.config/opencode/skill/<name>/SKILL.md`

### 技能加载

在对话中，AI 助手会根据任务自动推荐和加载相关技能。你也可以显式请求使用特定技能。

### 技能分类

- **高优先级**：执行层技能（BDD/TDD/SIT/Chaos）
- **中优先级**：战略层和战术层技能
- **低优先级**：工具和集成技能

## 下一步

1. **测试验证**：使用 subagent 驱动开发测试每个技能的有效性
2. **性能优化**：根据使用反馈优化提示词和内容
3. **文档完善**：补充更多示例和使用场景
4. **分发打包**：使用 skill-packaging-tool 创建可安装包
5. **市场发布**：发布到技能市场供其他项目使用

## 注意事项

- 所有技能遵循 TDD 原则创建，需要进一步测试验证
- 技能可能需要根据实际使用场景进行优化
- 建议在使用技能前阅读完整的 SKILL.md 内容
- 欢迎反馈和改进建议

---

创建日期：2024-01-16
创建者：AI Assistant based on Aether.go methodology
参考文档：`overall.md`, `https://opencode.ai/docs/skills/`
