# Skills Directory Migration Guide

---

**Language**: [English](MIGRATION.md) | [中文](MIGRATION_CN.md)

---

## Migration Overview

The skills directory has been migrated from `.opencode/skill/` to the `skills/` directory in the project root, for easier tool invocation and unified management.

## Migration Details

### Original Location
```
.opencode/skill/<skill-name>/SKILL.md
```

### New Location
```
skills/<skill-name>/SKILL.md
```

## New Directory Structure

```
skills/
├── README.md                       # Skills overview (English)
├── README_CN.md                    # Skills overview (Chinese)
├── SKILLS_SUMMARY.md               # Detailed skills list (English)
├── SKILLS_SUMMARY_CN.md            # Detailed skills list (Chinese)
├── MIGRATION.md                   # Migration guide (English)
├── MIGRATION_CN.md                # Migration guide (Chinese)
├── skills.sh                       # Skills management script
│
├── Execution Layer Skills
│   ├── bdd-scenario-writer/       # BDD scenario writer
│   ├── tdd-red-green-refactor/    # TDD cycle guide
│   ├── test-pyramid-analyzer/     # Test pyramid analyzer
│   ├── sit-scenario-generator/    # SIT scenario generator
│   └── chaos-test-designer/       # Chaos engineering experiment designer
│
├── Strategic Layer Skills
│   ├── business-value-mapper/     # Business value mapper
│   ├── metrics-definer/           # Metrics definer
│   ├── architecture-decision-recorder/ # Architecture decision recorder
│   └── data-flow-analyzer/        # Data flow analyzer
│
├── Tactical Layer Skills
│   ├── spec-parser/               # Specification parser
│   ├── constitution-validator/    # Constitution validator
│   ├── spec-to-code-tracer/       # Specification to code tracer
│   └── spec-evolution-tracker/    # Specification evolution tracker
│
├── AI Collaboration Layer Skills
│   ├── context-manager/           # Context manager
│   ├── skill-recommender/         # Skill recommender
│   ├── recursive-optimizer/       # Recursive optimizer
│   └── prompt-template-manager/   # Prompt template manager
│
├── Go + Vue + Quasar Fullstack Development Skills
│   ├── go-backend-scaffolder/     # Go backend scaffolder
│   ├── vue-quasar-scaffolder/     # Vue + Quasar frontend scaffolder
│   ├── fullstack-project-setup/   # Fullstack project initialization
│   ├── requirements-to-code-docs/ # Requirements to code documentation generator
│   ├── go-vue-fullstack-workflow/ # Go + Vue fullstack workflow
│   └── makefile-backend-generator/ # Makefile generator
│
└── Tools & Integration Skills
    ├── skill-packaging-tool/      # Skill packaging tool
    ├── go-cli-builder/            # Go CLI application builder
    └── rust-cli-builder/          # Rust CLI application builder
```

## Usage

### 1. Skills Management Script

A convenient `skills.sh` script is provided to manage skills:

```bash
# List all skills
cd skills
./skills.sh list

# Show skill details
./skills.sh show bdd-scenario-writer

# Search skills
./skills.sh search testing

# View statistics
./skills.sh stats

# Validate skill format
./skills.sh validate

# Install skill to global location
./skills.sh install bdd-scenario-writer
```

### 2. OpenCode Auto-discovery

OpenCode automatically discovers all skills in the `skills/` directory from the current working directory.

In the project root directory:
```bash
cd /path/to/project
# OpenCode will automatically discover the skills/ directory
```

### 3. Manual Skill Invocation

In conversation, the AI assistant will automatically recommend and load relevant skills based on tasks.

## Validation Results

All 25 skills have passed format validation:
- ✅ All skills contain the required `name` field
- ✅ All skills contain the required `description` field
- ✅ All descriptions start with "Use when"
- ✅ All skill files are in the correct location

## OpenCode Integration

OpenCode is a terminal-based AI agent that supports Skills functionality. See [OpenCode Official Documentation](https://opencode.ai/docs/skills/) and [GitHub Repository](https://github.com/anthropics/skills).

### Project Configuration

To use these skills in OpenCode, ensure:

1. The `skills/` directory is located in the project root
2. Start OpenCode from the project root

OpenCode will automatically search upwards from the current working directory for the `skills/` directory and load all skills within it.

### Global Installation

If you need to use these skills in all projects, there are several installation methods:

#### Method 1: Install Using OpenSkills (Recommended)

OpenSkills is an open-source tool for managing and installing skills. See [OpenSkills GitHub](https://github.com/numman-ali/openskills).

```bash
# Install OpenSkills (if not already installed)
npm install -g @openskills/cli

# Install from local project to global
openskills install ./skills --global

# Or install from GitHub repository
openskills install <your-github-username>/aether-go-skills --global
```

#### Method 2: Manual Copy to Global Directory

```bash
# Copy the entire skills directory to the global Claude skills directory
cp -r skills/* ~/.claude/skills/

# Or copy to OpenCode's global skills directory
cp -r skills/* ~/.config/opencode/skill/
```

#### Method 3: Project-level Installation (Current Project Only)

```bash
# Create .claude/skills directory in project root
mkdir -p .claude/skills

# Copy skills to project-level directory
cp -r skills/* .claude/skills/
```

#### Directory Path Explanation

OpenCode searches for SKILL.md files in the following paths:

- **Project-level path**: `./.claude/skills/` - Available only in the current project
- **Global path**: `~/.claude/skills/` - Available in all projects
- **OpenCode configuration path**: `~/.config/opencode/skill/` - OpenCode-specific path

Choose the appropriate installation method:
- If skills are only for the current project, use project-level installation
- If skills need to be used in multiple projects, use global installation
- If using OpenCode, you can copy to the OpenCode configuration path

## Maintenance

### Adding New Skills

1. Create a new subdirectory in the `skills/` directory
2. Add a `SKILL.md` file, following the specification
3. Run `./skills.sh validate` to verify format

### Modifying Existing Skills

1. Edit the corresponding `SKILL.md` file
2. Use `./skills.sh validate` to verify format
3. Use `./skills.sh show <skill-name>` to preview

### Version Control

All skill files should be under Git version control:

```bash
git add skills/
git commit -m "Add/update skills"
```

## Related Documentation

- **[README.md](README.md)** - Skills usage guide
- **[SKILLS_SUMMARY.md](SKILLS_SUMMARY.md)** - Detailed skills list
- **[overall.md](overall.md)** - Aether.go methodology planning
- **[AGENTS.md](AGENTS.md)** - AI assistant usage guide

### External Resources

- **[OpenCode Official Documentation](https://opencode.ai/docs/skills/)** - OpenCode Skills functionality documentation
- **[Anthropic Skills GitHub](https://github.com/anthropics/skills)** - Official Skills repository
- **[OpenSkills GitHub](https://github.com/numman-ali/openskills)** - OpenSkills tool repository

## Troubleshooting

### Skills Not Discovered

1. Confirm that OpenCode is started from the project root
2. Check if the `skills/` directory exists
3. Verify that skill filenames are `SKILL.md` (uppercase)

### Format Validation Failed

1. Check if YAML frontmatter is correct
2. Confirm that `description` starts with "Use when"
3. Verify that file encoding is UTF-8

### Skills Cannot Load

1. Check OpenCode version (>= 1.0.0)
2. Verify skill file permissions
3. Check OpenCode logs for error messages

## Migration Date

- Execution Date: 2024-01-16
- Executor: AI Assistant
- Status: ✅ Completed

## Rollback Plan

If you need to rollback to the old location:

```bash
# Restore to .opencode/skill
mkdir -p .opencode/skill
mv skills/* .opencode/skill/

# However, it is recommended to continue using the new skills/ directory
```

---

**Note**: It is recommended to use the new `skills/` directory structure for easier tool invocation and management.
