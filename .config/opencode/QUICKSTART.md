# OpenCode Agent Quick Start Guide

## TL;DR - What Should I Use?

### For Most Features: Use Default Agents + PLAN.md ✅

```bash
# Planning
opencode --agent plan
> "Add user authentication to the API"

# Implementation  
opencode --agent build
> "Implement the auth tasks"

# Review
opencode --agent reviewer
> "Review authentication implementation"
```

**Why?** Clear separation, familiar workflow, enhanced with persistent context.

### For Complex Multi-Phase Work: Use Core Agent

```bash
opencode --agent core
> "Add OAuth2 with Google and GitHub providers"
```

**Why?** Automated workflow, integrated review, single conversation.

## Available Agents

| Agent | Type | Use For |
|-------|------|---------|
| `plan` | default | Requirements analysis, architecture planning |
| `build` | default | Implementation, coding, testing |
| `core` | custom | Complex workflows with automated orchestration |
| `reviewer` | custom | Code quality, security, test validation |
| `explore` | default | Fast codebase exploration |
| `subagents/planner` | custom | Deep requirement analysis (used by core) |
| `subagents/task-manager` | custom | Task breakdown (used by core) |

## Shell Aliases (Recommended)

Add to `.zshrc` or `.bashrc`:

```bash
# Quick access to common agents
alias ocp='opencode --agent plan'      # Planning
alias ocb='opencode --agent build'     # Building/implementing
alias occ='opencode --agent core'      # Complex workflows
alias ocr='opencode --agent reviewer'  # Review
alias oce='opencode --agent explore'   # Explore codebase
```

Usage:
```bash
ocp  # starts plan mode
ocb  # starts build mode
```

## File Structure

All agents use:

```
/your-repo/
├── PLAN.md              # Strategic context (auto-created)
├── /tasks/              # Tactical tasks (auto-created)
│   └── feature-name/
│       ├── seq-001-*.md
│       └── seq-002-*.md
└── /src/                # Your code
```

## Typical Workflows

### Workflow 1: New Feature (Recommended)

```bash
# Step 1: Plan
opencode --agent plan
> "Add pagination to users API"
# Creates PLAN.md and /tasks/pagination/

# Step 2: Build
opencode --agent build  
> "Implement pagination from PLAN.md"
# Reads PLAN.md, follows tasks, updates progress

# Step 3: Review
opencode --agent reviewer
> "Review pagination implementation"
# Validates quality, security, tests
```

### Workflow 2: Complex Project

```bash
# Use core agent for full automation
opencode --agent core
> "Add OAuth2 authentication"

# Core will automatically:
# - Plan (via subagents/planner)
# - Break down tasks (via subagents/task-manager)
# - Implement
# - Review (via reviewer)
# - Update PLAN.md throughout
```

### Workflow 3: Continue Existing Work

```bash
# Just start - agents read PLAN.md automatically
opencode --agent build
> "Continue with the OAuth work"
# Reads PLAN.md, sees what's in progress, continues
```

## How PLAN.md Works

**Auto-created when:**
- You start multi-step work
- Agent detects complex project
- Architectural decisions needed

**Auto-updated when:**
- Tasks complete
- Decisions made
- Scope changes
- Session ends with work incomplete

**You don't need to manually manage it** - agents handle it.

## Decision Guide

**Use `plan` when:**
- 🎯 Starting new feature or project
- 🤔 Need to understand requirements
- 📐 Want to design approach first
- 🗺️ Exploring options

**Use `build` when:**
- 💻 Plan is clear and ready to code
- 🔨 Implementing defined tasks
- ✅ Following existing PLAN.md
- 🚀 Executing known work

**Use `core` when:**
- 🔄 Complex multi-phase project
- 🤖 Want automated workflow
- 🔗 Need integrated review
- 📦 One-conversation solution

**Use `reviewer` when:**
- ✓ Implementation complete
- 🔒 Need security assessment  
- 🧪 Want test scenarios
- 📊 Pre-merge validation

**Use `explore` when:**
- 🔍 Learning unfamiliar code
- 🗂️ Finding patterns or files
- ❓ Quick research
- 📚 Understanding dependencies

## Key Principles

1. **PLAN.md is automatic** - agents manage it for you
2. **Tasks are detailed** - PLAN.md is strategic, /tasks/ are tactical
3. **One mode per session** - don't switch mid-conversation
4. **Plan before build** - separation prevents scope creep
5. **Review before merge** - always validate before completing

## Common Questions

**Q: Do I need to create PLAN.md manually?**  
A: No, agents create and update it automatically.

**Q: Can I use plan and build in the same session?**  
A: You can, but better to separate: plan first, then exit and start build.

**Q: When should I use core vs plan/build?**  
A: plan/build for control and familiar workflow, core for automation and complex work.

**Q: Do all agents share the same context?**  
A: Yes, via PLAN.md and /tasks/ directory.

**Q: What if I'm just fixing a typo?**  
A: Use default mode (no agent flag) - simple edits don't need PLAN.md.

## Next Steps

1. **Try plan mode first**: `opencode --agent plan` with a feature request
2. **Check PLAN.md**: See how it captures your objectives
3. **Switch to build**: `opencode --agent build` and implement
4. **Run review**: `opencode --agent reviewer` before merging
5. **Graduate to core**: When comfortable, try core for complex work

## Full Documentation

- **INTEGRATION.md**: Detailed workflows and patterns
- **AGENTS.md**: Core principles and philosophy
- **agent/*.md**: Individual agent capabilities

## Pro Tips

- Let plan mode explore and design without coding pressure
- Use build mode to stay focused on implementation
- Run reviewer before every merge or deployment
- Trust PLAN.md to maintain context across sessions
- Use core agent when you want to delegate workflow management

---

**Remember**: Plan mode plans, build mode builds. When in doubt, separate your planning from your building!
