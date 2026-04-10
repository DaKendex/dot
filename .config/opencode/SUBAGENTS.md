# Subagent Quick Reference

This guide helps you quickly decide which specialized agent to use for your DevSecOps workflow.

## Quick Decision Guide

| Task Type | Use This Agent | Example Tasks |
|-----------|----------------|---------------|
| Security architecture design | `cloud-security-architect` | Threat modeling, compliance design, zero trust architecture |
| Writing Terraform code | `terraform-professional` | Creating modules, provisioning resources, state management |
| CI/CD pipeline work | `cicd-devsecops` | GitHub Actions, security scanning, GitOps, ArgoCD |
| Planning complex features | `planner` | Requirements analysis, codebase exploration, impact assessment |
| Breaking down tasks | `task-manager` | Creating `/tasks/` structure for multi-step work |
| Application code | General agent | Go, Python, JavaScript, etc. (use with security requirements from architect) |

## File Path Triggers

OpenCode will automatically use specialized agents when it sees certain file patterns:

- `*.tf`, `*.tfvars` → **terraform-professional**
- `.github/workflows/*.yml` → **cicd-devsecops**
- `.gitlab-ci.yml` → **cicd-devsecops**
- `argocd/*.yaml` → **cicd-devsecops**

## Keyword Triggers

Mention these in your request to automatically invoke the right agent:

- "Terraform", "IaC", "infrastructure code" → **terraform-professional**
- "pipeline", "CI/CD", "GitHub Actions", "GitLab CI" → **cicd-devsecops**
- "security design", "threat model", "compliance" → **cloud-security-architect**
- "plan this feature", "analyze requirements" → **planner**
- "break this down", "create tasks" → **task-manager**

## Common Workflows

### New Feature with Infrastructure

1. **cloud-security-architect** - Design security architecture and threat model
2. **planner** - Analyze codebase and create implementation plan
3. **task-manager** - Break down into `/tasks/` structure
4. **terraform-professional** - Write Terraform for infrastructure
5. **cicd-devsecops** - Create CI/CD pipeline with security gates
6. **general** - Implement application code

### Infrastructure-Only Project

1. **cloud-security-architect** - Security design, network architecture
2. **terraform-professional** - Write Terraform modules and resources
3. **cicd-devsecops** - Create Terraform CI/CD pipeline

### Pipeline Creation

1. **cloud-security-architect** - Define security gate requirements
2. **cicd-devsecops** - Implement pipeline with security automation
3. **terraform-professional** - If pipeline deploys infrastructure

### Security Review

1. **cloud-security-architect** - Perform threat modeling and architecture review
2. **terraform-professional** - Review IaC for security misconfigurations
3. **cicd-devsecops** - Review pipeline security and gates

## Agent Capabilities Matrix

| Capability | cloud-security-architect | terraform-professional | cicd-devsecops | planner | task-manager |
|------------|:------------------------:|:----------------------:|:--------------:|:-------:|:------------:|
| Write files | ✅ | ✅ | ✅ | ❌ | ✅ |
| Edit files | ✅ | ✅ | ✅ | ❌ | ✅ |
| Bash commands | ✅ | ✅ | ✅ | ✅ | ✅ |
| Search code | ✅ | ✅ | ✅ | ✅ | ✅ |
| Design work | ✅ | ✅ | ✅ | ✅ | ❌ |
| Implementation | ⚠️ | ✅ | ✅ | ❌ | ❌ |

✅ = Primary capability  
⚠️ = Designs but doesn't implement (provides requirements)  
❌ = Not designed for this

## Examples

### Example 1: "Create a new microservice with database"

**Agents to use:**
1. `cloud-security-architect` - Design authentication, authorization, data protection
2. `planner` - Analyze codebase patterns, design service structure
3. `task-manager` - Break down into tasks: DB schema, API endpoints, auth, observability
4. `terraform-professional` - Provision database, networking, IAM roles
5. `cicd-devsecops` - Create pipeline with tests, security scanning, deployment
6. General - Implement Go service code

### Example 2: "Fix our Terraform state issues"

**Agent to use:**
- `terraform-professional` only - This is a pure Terraform technical issue

### Example 3: "Add SOC2 compliance controls"

**Agents to use:**
1. `cloud-security-architect` - Map SOC2 requirements to controls
2. `terraform-professional` - Implement infrastructure controls (logging, encryption)
3. `cicd-devsecops` - Add compliance checks to pipelines

### Example 4: "Improve our deployment pipeline"

**Agents to use:**
1. `cloud-security-architect` - Review security gates and requirements
2. `cicd-devsecops` - Refactor pipeline with security automation

### Example 5: "Build a Terraform module for EKS"

**Agent to use:**
- `terraform-professional` only - This is pure Terraform module development
- (Security requirements should already be known, or use `cloud-security-architect` first)

## Tips

- **Start with architecture**: For new features, use `cloud-security-architect` first
- **Parallel work**: Launch multiple agents in parallel when they don't depend on each other
- **Sequential work**: Use outputs from one agent as inputs to another
- **Trust the automation**: OpenCode will auto-select agents based on file paths and keywords
- **Override when needed**: You can explicitly request a specific agent

## Invoking Agents

You can explicitly invoke agents by saying:
- "Use the cloud-security-architect agent to design security for..."
- "Use terraform-professional to create a module for..."
- "Use cicd-devsecops to add security scanning to..."

Or let OpenCode automatically select based on context (recommended).
