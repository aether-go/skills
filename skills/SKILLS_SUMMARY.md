# Aether.go Skills Summary

根据 `overall.md` 中的规划和 OpenCode skills 规范，已成功创建所有 24 个技能（原有18个 + 新增6个）。

## 新增 Skills 背景：基于 bitcms 代码库分析

新增的 6 个技能基于对 `~/workspace/dgbic/bitcms` 代码库的深入分析，该代码库是一个完整的 Go + Vue 3 + Quasar 全栈项目。

### bitcms 代码库分析结果

**优点：**
- 完整的 Go + Vue 3 + Quasar 技术栈
- 后端采用干净架构（domain/application/infrastructure/interfaces）
- 前端组件分类清晰（business/ui/forms等）
- 结构化文档工作流（需求→用例→实现）

**潜在不足与改进建议：**

| 问题 | 影响 | 建议方案 |
|------|------|----------|
| **结构冗余**：`internal/handlers` 和 `internal/interfaces/handlers` 职责重叠 | 代码组织混乱，维护困难 | 统一到 `internal/interfaces/handlers`，明确接口层职责 |
| **测试覆盖不足**：缺少统一的测试规范和覆盖率要求 | 代码质量难以保证 | 添加测试金字塔规范，要求单元/集成/E2E测试覆盖率目标 |
| **文档自动化弱**：文档与代码同步依赖人工 | 文档容易过时 | 集成自动化文档生成，代码注释自动生成API文档 |
| **开发体验待优化**：缺少快速配置工具 | 新开发者上手慢 | 添加开发环境一键配置脚本和模板生成器 |

### 新增 Skills 设计目标
1. **快速创建 Web 应用**：通过标准化模板加速全栈项目开发
2. **支持 OpenCode/Claude Code 规范**：遵循技能规范，可与现有AI助手协同工作
3. **模块化组合工作流**：单个技能可独立使用，也可组合成完整工作流
4. **文档与代码同步**：自动化文档生成和可追溯性管理

## 技能清单

### 执行层 Skills（ATDD/BDD/TDD/SIT）- 5个

1. **bdd-scenario-writer**
   - 描述：将用户故事和需求转换为 Gherkin BDD 场景文件
   - 功能：生成 Given-When-Then 结构的场景，支持多语言
    - 位置：`skills/bdd-scenario-writer/SKILL.md`

2. **tdd-red-green-refactor**
   - 描述：使用测试驱动开发方法实现任何功能或修复错误
   - 功能：指导 RED-GREEN-REFACTOR 循环，支持多语言
   - 位置：`skills/tdd-red-green-refactor/SKILL.md`

3. **test-pyramid-analyzer**
   - 描述：分析测试覆盖率、分布和测试策略缺口
   - 功能：可视化测试分布，生成覆盖率报告，提供优化建议
   - 位置：`skills/test-pyramid-analyzer/SKILL.md`

4. **sit-scenario-generator**
   - 描述：创建跨多个服务或 API 端点的系统集成测试（SIT）场景
   - 功能：生成自动化 SIT 测试脚本，支持 Cypress/Postman/k6
   - 位置：`skills/sit-scenario-generator/SKILL.md`

5. **chaos-test-designer**
   - 描述：设计混沌工程实验以测试系统弹性和容错能力
   - 功能：定义故障注入场景，支持 LitmusChaos/Chaos Mesh
   - 位置：`skills/chaos-test-designer/SKILL.md`

### 战略层 Skills（BMAD 驱动）- 4个

6. **business-value-mapper**
   - 描述：使用 BMAD 框架将业务目标转化为可衡量的技术指标
   - 功能：生成 BMAD 矩阵，连接业务目标与技术指标
   - 位置：`skills/business-value-mapper/SKILL.md`

7. **metrics-definer**
   - 描述：为特定系统类型定义业务和技术指标及监控配置
   - 功能：定义指标清单，内置电商/SaaS/IoT 等场景模板
   - 位置：`skills/metrics-definer/SKILL.md`

8. **architecture-decision-recorder**
   - 描述：记录架构决策及其业务依据和备选方案分析
   - 功能：创建 ADR 文档，记录决策理由和权衡
   - 位置：`skills/architecture-decision-recorder/SKILL.md`

9. **data-flow-analyzer**
   - 描述：分析数据流和价值链以识别瓶颈和优化机会
   - 功能：可视化数据流动，追踪价值链
   - 位置：`skills/data-flow-analyzer/SKILL.md`

### 战术层 Skills（SDD + 宪法约束）- 4个

10. **spec-parser**
    - 描述：将自然语言需求解析为结构化技术规范
    - 功能：转换用户故事为 YAML/JSON 规范
    - 位置：`skills/spec-parser/SKILL.md`

11. **constitution-validator**
    - 描述：验证代码和规范是否符合架构原则和宪法约束
    - 功能：自动检查合规性，生成合规报告
    - 位置：`skills/constitution-validator/SKILL.md`

12. **spec-to-code-tracer**
    - 描述：建立规范与代码实现之间的双向可追溯性
    - 功能：创建追溯矩阵，支持影响分析
    - 位置：`skills/spec-to-code-tracer/SKILL.md`

13. **spec-evolution-tracker**
    - 描述：跟踪规范变更历史和影响分析
    - 功能：版本管理，变更影响评估
    - 位置：`skills/spec-evolution-tracker/SKILL.md`

### AI 协作与优化 Skills - 4个

14. **context-manager**
   - 描述：管理项目上下文、对话历史和信息检索
   - 功能：保存和恢复上下文，最小化 token 使用
   - 位置：`skills/context-manager/SKILL.md`

15. **skill-recommender**
   - 描述：根据当前任务、项目上下文和开发阶段推荐相关 AI 技能
   - 功能：智能推荐，提高效率
   - 位置：`skills/skill-recommender/SKILL.md`

16. **recursive-optimizer**
   - 描述：基于执行结果和用户反馈优化 AI 技能、提示词和工作流
   - 功能：A/B 测试，持续改进循环
   - 位置：`skills/recursive-optimizer/SKILL.md`

17. **prompt-template-manager**
   - 描述：管理、版本化和优化 AI 提示词模板
   - 功能：版本控制，性能跟踪，A/B 测试
   - 位置：`skills/prompt-template-manager/SKILL.md`

### Go + Vue + Quasar 全栈开发 Skills - 6个（基于 bitcms 模式）

18. **go-backend-scaffolder**
   - 描述：基于 bitcms 模式生成干净架构的 Go 后端代码
   - 功能：创建 Fiber + GORM + Swagger 后端，支持分层架构和 Cobra 命令结构
   - 特点：main.go 在根目录作为 Cobra 入口，cmd/ 存放独立命令（version/daemon/server），包含默认 version 命令
   - 位置：`skills/go-backend-scaffolder/SKILL.md`

19. **vue-quasar-scaffolder**
   - 描述：基于 bitcms 前端模式生成 Vue 3 + Quasar + TypeScript 组件
   - 功能：创建 Composition API 组件、Pinia 存储、测试配置
   - 位置：`skills/vue-quasar-scaffolder/SKILL.md`

20. **fullstack-project-setup**
   - 描述：基于 bitcms 结构初始化完整的 Go + Vue + Quasar 全栈项目
   - 功能：创建项目结构、Docker 配置、CI/CD 管道、开发环境
   - 位置：`skills/fullstack-project-setup/SKILL.md`

21. **requirements-to-code-docs**
   - 描述：基于 bitcms 文档工作流从需求到用例到实现生成结构化文档
   - 功能：需求文档、用例文档、API 文档、可追溯性矩阵
   - 位置：`skills/requirements-to-code-docs/SKILL.md`

22. **go-vue-fullstack-workflow**
    - 描述：协调使用 bitcms 模式和文档的 Go + Vue + Quasar 全栈开发工作流
    - 功能：集成所有相关技能，提供端到端开发工作流指导
    - 位置：`skills/go-vue-fullstack-workflow/SKILL.md`

23. **makefile-backend-generator**
    - 描述：基于 bitcms 模式为 Go 后端项目创建生产级 Makefile
    - 功能：生成包含构建、测试、部署、数据库操作的完整 Makefile，支持跨平台编译
    - 位置：`skills/makefile-backend-generator/SKILL.md`

### 工具与集成 Skills - 1个

24. **skill-packaging-tool**
    - 描述：将技能打包为可分发的可安装包
    - 功能：版本管理，依赖声明，安装脚本
    - 位置：`skills/skill-packaging-tool/SKILL.md`

## 技能特点

### 遵循的规范

1. **OpenCode Skills 规范**
   - YAML frontmatter（仅 name 和 description）
   - Description 以 "Use when..." 开头
   - 名称使用小写字母、数字和连字符
   - 文件路径：`skills/<name>/SKILL.md`

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

## 技能集成与工作流

### Go + Vue + Quasar 全栈技能套件工作流

新增的 6 个技能设计为模块化组合使用，既可独立完成特定任务，也可通过 `go-vue-fullstack-workflow` 技能协调完成端到端开发。

```
go-vue-fullstack-workflow (主工作流)
    ├── fullstack-project-setup (项目初始化)
    ├── requirements-to-code-docs (文档生成)
    ├── go-backend-scaffolder (后端开发)
    ├── makefile-backend-generator (Makefile 生成)
    └── vue-quasar-scaffolder (前端开发)
```

### 典型开发工作流

1. **项目初始化阶段**
   ```bash
   fullstack-project-setup create myapp --backend=go --frontend=vue-quasar
   ```

2. **需求分析阶段**
   ```bash
   requirements-to-code-docs requirement "用户认证系统"
   requirements-to-code-docs usecase-from-req "REQ-AUTH-001"
   ```

3. **后端开发阶段**
   ```bash
   # 生成项目结构后，创建标准化的 Makefile
   makefile-backend-generator create --app-name=myapp --module=github.com/org/myapp
   
   # 生成领域模型和 CRUD 端点
   go-backend-scaffolder generate domain User --fields="email:string,username:string"
   go-backend-scaffolder generate crud User --auth=required
   
   # 生成命令结构（自动包含 version 命令）
   go-backend-scaffolder command version
   go-backend-scaffolder command daemon --port=8080
   ```

4. **前端开发阶段**
   ```bash
   vue-quasar-scaffolder generate crud User --api="/api/v1/users"
   vue-quasar-scaffolder generate page Users --layout=admin --crud
   ```

5. **集成与文档阶段**
   ```bash
   requirements-to-code-docs api-from-code --update
   requirements-to-code-docs traceability --validate
   go-vue-fullstack-workflow execute --phase=integration
   ```

### 与现有 Aether.go 技能集成

新增技能可与现有技能无缝集成：

| 新技能 | 集成的现有技能 | 集成场景 |
|--------|----------------|----------|
| go-backend-scaffolder | tdd-red-green-refactor | 生成 Go 代码时自动应用 TDD 模式 |
| vue-quasar-scaffolder | test-pyramid-analyzer | 前端组件生成时包含测试金字塔配置 |
| requirements-to-code-docs | spec-parser, spec-to-code-tracer | 需求文档自动转换为规范并建立追溯 |
| go-vue-fullstack-workflow | business-value-mapper, architecture-decision-recorder | 工作流中集成业务价值映射和架构决策记录 |
| makefile-backend-generator | go-backend-scaffolder | 为生成的 Go 后端项目创建标准化 Makefile |

### 技能依赖关系

```
依赖关系：
go-vue-fullstack-workflow → [all other new skills]
requirements-to-code-docs → [spec-parser, spec-to-code-tracer]
go-backend-scaffolder → [tdd-red-green-refactor]
vue-quasar-scaffolder → [test-pyramid-analyzer]
makefile-backend-generator → [go-backend-scaffolder]  # 通常在后端项目创建后使用

目录结构特点（基于 bitcms 模式）：
backend/
├── main.go                         # Cobra 根命令入口
├── cmd/                            # 独立命令
│   ├── version/                    # 默认 version 命令
│   ├── daemon/                     # 服务器命令
│   └── server/                     # 可选服务器入口
├── internal/                       # 私有应用代码
│   ├── app/                        # 应用层配置
│   ├── domain/                     # 领域模型
│   ├── interfaces/                 # API 处理器
│   └── services/                   # 业务逻辑
└── ...                             # 其他标准目录
```

## 使用说明

### 技能发现

OpenCode 会自动从以下位置发现技能：
- 项目配置：`skills/<name>/SKILL.md`
- 全局配置：`~/.config/opencode/skill/<name>/SKILL.md`

### 技能加载

在对话中，AI 助手会根据任务自动推荐和加载相关技能。你也可以显式请求使用特定技能。

### 技能分类

- **高优先级**：执行层技能（BDD/TDD/SIT/Chaos）、全栈工作流技能（go-vue-fullstack-workflow）
- **中优先级**：战略层和战术层技能、全栈开发技能（go-backend-scaffolder, vue-quasar-scaffolder, requirements-to-code-docs）
- **低优先级**：工具和集成技能（skill-packaging-tool）、项目初始化技能（fullstack-project-setup）

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
- **新增的 Go + Vue + Quasar 技能**：基于 bitcms 代码库模式，适用于快速创建全栈 Web 应用
- **技能组合使用**：建议通过 `go-vue-fullstack-workflow` 技能协调使用其他相关技能
- **文档可追溯性**：新增技能支持需求到代码的完整可追溯性
- **目录结构优化**：go-backend-scaffolder 已更新为 bitcms 风格的 Cobra 命令结构，main.go 在根目录，cmd/ 存放独立命令，包含默认 version 命令
- 欢迎反馈和改进建议

---

创建日期：2024-01-16  
最后更新：2026-01-21  
创建者：AI Assistant based on Aether.go methodology  
参考文档：`overall.md`, `https://opencode.ai/docs/skills/`
更新记录：
- 2026-01-21: 更新 go-backend-scaffolder 技能，采用 bitcms 风格的 Cobra 命令结构，main.go 在根目录，cmd/ 存放独立命令，包含默认 version 命令
