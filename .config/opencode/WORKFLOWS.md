# DevSecOps Agent Workflow Patterns

This document illustrates common workflow patterns using the specialized subagents.

## Agent Relationship Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                      User Request                                │
└──────────────────────┬──────────────────────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────────────────────┐
│                  OpenCode (Main Agent)                           │
│  Analyzes request and routes to appropriate specialized agents   │
└───────┬──────────┬──────────┬──────────┬──────────┬────────────┘
        │          │          │          │          │
        ▼          ▼          ▼          ▼          ▼
    ┌─────┐   ┌─────┐   ┌─────┐   ┌─────┐   ┌─────┐
    │ CSA │   │ TF  │   │CICD │   │ PLN │   │ TSK │
    └─────┘   └─────┘   └─────┘   └─────┘   └─────┘
        │          │          │          │          │
        └──────────┴──────────┴──────────┴──────────┘
                       │
                       ▼
            ┌──────────────────┐
            │  Implementation  │
            │  (via General)   │
            └──────────────────┘
```

**Legend:**
- CSA = cloud-security-architect
- TF = terraform-professional
- CICD = cicd-devsecops
- PLN = planner
- TSK = task-manager

## Pattern 1: New Microservice (Full Stack)

```
User: "Build a new user authentication service with PostgreSQL"

    ┌─────────────────────────────────────────────┐
    │ 1. cloud-security-architect                 │
    │    - Threat model for auth service          │
    │    - Design OAuth2/OIDC flow                │
    │    - Define encryption requirements         │
    │    Output: Security requirements doc        │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 2. planner                                  │
    │    - Analyze existing auth patterns         │
    │    - Review DB schema conventions           │
    │    - Plan service structure                 │
    │    Output: Implementation plan              │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 3. task-manager                             │
    │    - Break into /tasks/auth-service/        │
    │    - seq-001-database-schema.md             │
    │    - seq-002-api-endpoints.md               │
    │    - seq-003-authentication.md              │
    │    Output: Task structure                   │
    └──────────────────┬──────────────────────────┘
                       │
                ┌──────┴──────┐
                │             │
                ▼             ▼
    ┌─────────────────┐ ┌────────────────────┐
    │ 4a. terraform-  │ │ 4b. cicd-devsecops │
    │     professional│ │                    │
    │  - RDS instance │ │  - GitHub Actions  │
    │  - IAM roles    │ │  - Security scans  │
    │  - Secrets mgmt │ │  - Deploy pipeline │
    └────────┬────────┘ └─────────┬──────────┘
             │                    │
             └──────────┬─────────┘
                        │
                        ▼
             ┌──────────────────────┐
             │ 5. General Agent     │
             │    - Go service code │
             │    - Tests           │
             │    - Observability   │
             └──────────────────────┘
```

## Pattern 2: Infrastructure-Only Project

```
User: "Set up production Kubernetes cluster in AWS"

    ┌─────────────────────────────────────────────┐
    │ 1. cloud-security-architect                 │
    │    - Network segmentation design            │
    │    - Security groups and NACLs              │
    │    - Encryption and secrets strategy        │
    │    Output: Security architecture            │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 2. terraform-professional                   │
    │    - VPC and networking                     │
    │    - EKS cluster                            │
    │    - IAM roles and policies                 │
    │    - KMS keys                               │
    │    Output: Terraform modules                │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 3. cicd-devsecops                           │
    │    - Terraform CI/CD pipeline               │
    │    - tfsec and Checkov scanning             │
    │    - Atlantis or Terraform Cloud            │
    │    Output: Pipeline with security gates     │
    └─────────────────────────────────────────────┘
```

## Pattern 3: Add Security Controls (SOC2)

```
User: "Implement SOC2 logging and audit controls"

    ┌─────────────────────────────────────────────┐
    │ 1. cloud-security-architect                 │
    │    - Map SOC2 requirements                  │
    │    - Define audit logging scope             │
    │    - Design log retention policy            │
    │    Output: Compliance control mapping       │
    └──────────────────┬──────────────────────────┘
                       │
                ┌──────┴──────┐
                │             │
                ▼             ▼
    ┌─────────────────┐ ┌────────────────────┐
    │ 2a. terraform-  │ │ 2b. cicd-devsecops │
    │     professional│ │                    │
    │  - CloudTrail   │ │  - Add compliance  │
    │  - Log bucket   │ │    checks to CI/CD │
    │  - Encryption   │ │  - Audit reports   │
    │  - Lifecycle    │ │  - Attestation     │
    └─────────────────┘ └────────────────────┘
```

## Pattern 4: Pipeline Improvement

```
User: "Add security scanning to our deployment pipeline"

    ┌─────────────────────────────────────────────┐
    │ 1. cloud-security-architect                 │
    │    - Define security gate requirements      │
    │    - Choose scanning tools                  │
    │    - Set severity thresholds                │
    │    Output: Security requirements            │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 2. cicd-devsecops                           │
    │    - Add Trivy container scanning           │
    │    - Add SBOM generation                    │
    │    - Add dependency scanning                │
    │    - Configure failure thresholds           │
    │    Output: Enhanced pipeline                │
    └─────────────────────────────────────────────┘
```

## Pattern 5: Quick Terraform Fix

```
User: "Fix the Terraform state locking issue"

    ┌─────────────────────────────────────────────┐
    │ terraform-professional (only)               │
    │    - Diagnose state lock                    │
    │    - Release lock if stale                  │
    │    - Fix backend configuration              │
    │    Output: Fixed state                      │
    └─────────────────────────────────────────────┘

(No other agents needed - tactical fix)
```

## Pattern 6: Database Schema Migration

```
User: "Add new user preferences table with encryption"

    ┌─────────────────────────────────────────────┐
    │ 1. cloud-security-architect                 │
    │    - Define field-level encryption          │
    │    - Key management strategy                │
    │    - Access control requirements            │
    │    Output: Security requirements            │
    └──────────────────┬──────────────────────────┘
                       │
                       ▼
    ┌─────────────────────────────────────────────┐
    │ 2. planner                                  │
    │    - Review existing schema patterns        │
    │    - Plan migration strategy                │
    │    - Assess backward compatibility          │
    │    Output: Migration plan                   │
    └──────────────────┬──────────────────────────┘
                       │
                ┌──────┴──────┐
                │             │
                ▼             ▼
    ┌─────────────────┐ ┌────────────────────┐
    │ 3a. terraform-  │ │ 3b. General Agent  │
    │     professional│ │                    │
    │  - RDS params   │ │  - Migration code  │
    │  - KMS key      │ │  - Application code│
    └─────────────────┘ └────────────────────┘
```

## Parallel vs Sequential Execution

### Parallel Execution (Independent Work)

```
User: "Set up infrastructure and pipeline for new service"

    cloud-security-architect
            │
            └──┬──────────────────────┐
               │                      │
    ┌──────────▼────────┐  ┌─────────▼────────┐
    │ terraform-         │  │ cicd-devsecops   │
    │ professional       │  │                  │
    │ (Infrastructure)   │  │ (Pipeline)       │
    └────────────────────┘  └──────────────────┘

Both can run in parallel after security design is complete.
```

### Sequential Execution (Dependent Work)

```
User: "Design and implement new auth system"

    cloud-security-architect
            │
            ▼
        planner
            │
            ▼
      task-manager
            │
            ▼
    terraform-professional
            │
            ▼
    cicd-devsecops
            │
            ▼
      General Agent

Each step depends on previous step's output.
```

## Decision Matrix: When to Use Which Agent(s)

| Scenario | Agents (in order) | Rationale |
|----------|-------------------|-----------|
| New feature | CSA → PLN → TSK → TF/CICD/General | Need design, planning, breakdown, implementation |
| Security review | CSA only | Pure security analysis |
| Terraform module | TF only | Pure IaC work |
| Pipeline creation | CSA → CICD | Need security requirements, then implementation |
| Bug fix | General only | Tactical code change |
| Compliance project | CSA → TF + CICD | Design controls, implement in infrastructure and pipelines |
| Refactoring | PLN → General | Understand impact, then refactor |
| Multi-step feature | PLN → TSK → Specialized agents | Complex work needs task breakdown |

## Tips for Effective Agent Usage

1. **Security First**: Start with `cloud-security-architect` for anything customer-facing
2. **Plan Complex Work**: Use `planner` for multi-file changes or unclear scope
3. **Break Down Large Features**: Use `task-manager` for features with >3 steps
4. **Let OpenCode Decide**: File path triggers work automatically
5. **Use Parallel Execution**: When agents don't depend on each other
6. **Trust Specialized Expertise**: Each agent has deep domain knowledge
7. **Update PLAN.md**: All agents integrate with PLAN.md for context

## Anti-Patterns to Avoid

❌ Using general agent for Terraform when `terraform-professional` exists  
❌ Using `planner` for simple one-file changes  
❌ Skipping `cloud-security-architect` for customer-facing features  
❌ Using `task-manager` for tasks that are already clear and simple  
❌ Running agents sequentially when they could run in parallel  
❌ Not reading PLAN.md before starting work  

## Success Patterns

✅ Security design before implementation  
✅ Planning before task breakdown  
✅ Parallel execution when possible  
✅ Using specialized agents for their domain  
✅ Keeping PLAN.md updated throughout  
✅ Breaking complex work into manageable tasks  
