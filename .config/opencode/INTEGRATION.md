# Agent Integration Strategy

## Overview

This document describes how OpenCode's default agents integrate with the custom agent workflow to maintain separation of concerns while leveraging enhanced context.

## Agent Modes

### Default OpenCode Agents

1. **plan** (primary) - OpenCode's built-in planning agent
2. **build** (primary) - OpenCode's built-in implementation agent
3. **explore** (subagent) - Fast codebase exploration
4. **general** (subagent) - General-purpose research and execution

### Custom Agents

1. **core** (primary) - Orchestration agent with workflow management
2. **reviewer** (primary) - Quality validation and test generation
3. **subagents/planner** (subagent) - Requirement analysis and context gathering
4. **subagents/task-manager** (subagent) - Task breakdown and documentation

## Recommended Workflow Patterns

### Pattern 1: Default Agents with Enhanced Context (Recommended for Most Work)

Use OpenCode's default `plan` and `build` modes but leverage PLAN.md + /tasks/ structure:

```bash
# Planning phase
opencode --agent plan
> "Add user authentication to the API"

# Agent will:
# - Check/create PLAN.md
# - Analyze codebase
# - Document approach in PLAN.md
# - Create task structure in /tasks/auth-feature/

# Build phase
opencode --agent build
> "Implement the authentication tasks"

# Agent will:
# - Read PLAN.md for context
# - Read /tasks/auth-feature/ for steps
# - Implement code
# - Update PLAN.md progress
```

**Benefits:**
- Clear separation: planning doesn't execute, building doesn't redesign
- Familiar OpenCode workflow
- Enhanced with persistent context (PLAN.md + tasks)
- Prevents scope creep during implementation

**Use when:**
- You want strict separation of planning vs execution
- Working on well-scoped features
- You prefer explicit mode switching

### Pattern 2: Core Agent Workflow (Recommended for Complex Multi-Phase Work)

Use the custom `core` agent that orchestrates all phases:

```bash
opencode --agent core
> "Add user authentication with OAuth2 support"

# Agent will:
# 1. Check PLAN.md
# 2. Route to subagents/planner for analysis
# 3. Route to subagents/task-manager for breakdown
# 4. Implement following task sequence
# 5. Route to reviewer for validation
# 6. Update PLAN.md with results
```

**Benefits:**
- Fully automated workflow
- Better context handoff between phases
- Integrated review and testing
- Single conversation thread

**Use when:**
- Complex multi-step projects
- You want automated phase transitions
- You trust the agent to manage workflow

### Pattern 3: Hybrid Approach (Best of Both Worlds)

Combine default agents with custom subagents:

```bash
# Phase 1: Deep planning with custom planner
opencode --agent plan
> "@subagents/planner analyze requirements for authentication feature"

# Phase 2: Task breakdown
> "@subagents/task-manager create task breakdown from the plan"

# Phase 3: Implementation with build mode
opencode --agent build
> "Implement tasks in /tasks/auth-feature/ following PLAN.md"

# Phase 4: Review
opencode --agent reviewer
> "Review the authentication implementation"
```

**Benefits:**
- Explicit control over each phase
- Use specialized agents when needed
- Maintain plan/build separation
- Access to deep context from custom agents

**Use when:**
- You want control over workflow transitions
- Need specialized agent capabilities
- Complex projects requiring review between phases

## Mode Comparison Matrix

| Aspect | plan/build (default) | core (custom) | hybrid |
|--------|---------------------|---------------|---------|
| **Separation of Concerns** | ✅ Explicit | ⚠️ Automated | ✅ Explicit |
| **Context Preservation** | ✅ PLAN.md | ✅ PLAN.md + tasks | ✅ PLAN.md + tasks |
| **Workflow Automation** | ❌ Manual switching | ✅ Fully automated | ⚠️ Semi-automated |
| **Review Integration** | ❌ Manual | ✅ Built-in | ✅ On-demand |
| **Learning Curve** | ✅ Familiar | ⚠️ New workflow | ⚠️ More complex |
| **Best For** | Standard features | Complex projects | Flexible workflows |

## File Structure Integration

All modes use the same file structure:

```
/repo/root/
├── PLAN.md                    # Strategic context (all modes read/write)
├── /tasks/                    # Tactical implementation
│   ├── feature-auth/
│   │   ├── seq-001-setup.md
│   │   ├── seq-002-oauth.md
│   │   └── seq-003-tests.md
│   └── feature-api/
│       └── seq-001-endpoints.md
└── /src/                      # Implementation
```

## Agent Responsibilities

### plan (default) + PLAN.md Enhancement
```markdown
**Does:**
- Analyze requirements
- Research codebase
- Create PLAN.md with objectives and approach
- Create /tasks/ structure (optional but recommended)
- Document architectural decisions

**Does NOT:**
- Write implementation code
- Run tests
- Make code changes
```

### build (default) + Task Integration
```markdown
**Does:**
- Read PLAN.md for context
- Read /tasks/ for implementation steps
- Write implementation code
- Run tests and validation
- Update PLAN.md progress
- Mark tasks complete

**Does NOT:**
- Redesign architecture mid-implementation
- Change project objectives
- Create new tasks (unless blockers found)
```

### core (custom)
```markdown
**Does:**
- Orchestrate full workflow
- Delegate to subagents
- Manage PLAN.md and /tasks/ coordination
- Execute implementation
- Coordinate review process

**Delegates to:**
- subagents/planner: Deep analysis
- subagents/task-manager: Task breakdown
- reviewer: Quality validation
```

### reviewer (custom)
```markdown
**Does:**
- Code quality assessment
- Security vulnerability analysis
- Test case generation
- Performance review
- Integration testing validation

**Updates:**
- PLAN.md with review findings
- Task files with issues found
```

## Recommended Default Configuration

Add to your shell profile for quick access:

```bash
# Default to plan mode for new work
alias ocp='opencode --agent plan'

# Default to build mode for implementation
alias ocb='opencode --agent build'

# Use core for complex workflows
alias occ='opencode --agent core'

# Quick review
alias ocr='opencode --agent reviewer'

# Exploration
alias oce='opencode --agent explore'
```

## Migration Path

### If you currently use default agents:

1. **Keep using plan/build** - they're great!
2. **Add PLAN.md workflow** - update AGENTS.md to include PLAN.md checks
3. **Gradually add /tasks/** - let plan mode create task files
4. **Try core agent** - for complex multi-phase work
5. **Add reviewer** - run after build phase completes

### If you're starting fresh:

**Start with Pattern 1 (plan/build + PLAN.md):**
- Most familiar
- Clear separation
- Enhanced with persistent context
- Gradually explore core agent for complex work

## Decision Guide

**Use `plan` mode when:**
- Starting new features or projects
- Need to understand requirements deeply
- Want to document approach before coding
- Exploring architectural options

**Use `build` mode when:**
- Plan is clear and documented
- Ready to implement
- Following established tasks
- Executing well-defined work

**Use `core` agent when:**
- Complex multi-phase projects
- Want automated workflow management
- Need integrated review cycles
- Trust agent to manage transitions

**Use `reviewer` agent when:**
- After implementation complete
- Before merging/deploying
- Need security assessment
- Want comprehensive test scenarios

**Use `explore` agent when:**
- Learning unfamiliar codebase
- Finding patterns or examples
- Quick research questions
- Understanding dependencies

## Example Workflows

### Workflow A: Simple Feature (plan/build)

```bash
# Session 1: Planning
opencode --agent plan
> "Add pagination to the users API endpoint"
# Creates PLAN.md with approach
# Creates /tasks/pagination/ with steps
# Exit when plan is complete

# Session 2: Implementation  
opencode --agent build
> "Implement the pagination tasks from PLAN.md"
# Reads PLAN.md for context
# Follows /tasks/pagination/seq-*.md
# Updates progress in PLAN.md

# Session 3: Review
opencode --agent reviewer
> "Review pagination implementation"
# Validates code quality
# Generates test scenarios
# Updates PLAN.md with findings
```

### Workflow B: Complex Feature (core)

```bash
opencode --agent core
> "Add OAuth2 authentication with Google and GitHub providers"

# Agent automatically:
# 1. Checks PLAN.md
# 2. Routes to subagents/planner
# 3. Planner analyzes requirements
# 4. Routes to subagents/task-manager
# 5. Task manager creates /tasks/oauth2/
# 6. Core implements seq-001
# 7. Core implements seq-002
# 8. Routes to reviewer after each major component
# 9. Updates PLAN.md throughout
# All in one conversation
```

### Workflow C: Hybrid (maximum control)

```bash
# Deep planning with custom planner
opencode --agent plan
> "@subagents/planner analyze OAuth2 requirements and create comprehensive plan"
# Custom planner provides deeper analysis than default

# Task breakdown
> "@subagents/task-manager create detailed task breakdown"
# Explicit task creation

# Switch to build mode
opencode --agent build
> "Implement /tasks/oauth2/ following PLAN.md architecture"

# Review before merge
opencode --agent reviewer
> "Comprehensive security review of OAuth2 implementation"
```

## Best Practices

1. **Always maintain PLAN.md** - regardless of which agent mode you use
2. **Use task files for complex work** - simple features can skip /tasks/
3. **Review before merge** - use reviewer agent before completing work
4. **One mode per session** - avoid switching modes mid-conversation
5. **Trust the separation** - plan mode plans, build mode builds
6. **Document decisions** - major choices go in PLAN.md
7. **Keep tasks atomic** - each task file should be independently completable

## Integration with AGENTS.md

All agents (default and custom) inherit from AGENTS.md:
- Security-first mindset
- DevSecOps principles
- Code philosophy (DRY, minimal comments, TODO-driven)
- Technology context (Go, Terraform, K8s, etc.)
- PLAN.md workflow

The custom agents extend these with:
- Explicit workflow orchestration
- Deep context gathering
- Structured task management
- Integrated review cycles

## Conclusion

**Recommended Default Approach:**
- Use `plan` mode for planning (with PLAN.md + /tasks/)
- Use `build` mode for implementation (reading PLAN.md + /tasks/)
- Use `reviewer` mode after implementation
- Graduate to `core` mode for complex multi-phase work

This gives you:
✅ Clear separation of planning vs execution
✅ Persistent context across sessions
✅ Structured task management
✅ Integrated quality review
✅ Familiar OpenCode workflow
✅ Flexibility to use custom agents when needed
