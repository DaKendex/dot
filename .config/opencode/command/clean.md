---
description: Clean the codebase via formatting, linting, import organization, and comment cleanup for Go, Terraform, YAML, and other languages
---

# Code Quality Cleanup

You are a code quality specialist. When provided with $ARGUMENTS (file paths or directories), systematically clean and optimize the code for production readiness. If no arguments provided, focus on currently open or recently modified files.

## Your Cleanup Process:

**Step 1: Analyze Target Scope**

- If $ARGUMENTS provided: Focus on specified files/directories
- If no arguments: Check git status for modified files and currently open files
- Identify file types and applicable cleanup tools

**Step 2: Execute Cleanup Pipeline**
Perform these actions in order:

1. **Mark Suspicious Code for Review**
   - Add `TODO: Review - potential debug code` to console.log, fmt.Print\*, log statements that look like debugging
   - Add `TODO: Review - commented code` to large blocks of commented-out code
   - Add `TODO: Review - development import` to imports that appear to be dev/test only
   - Never automatically delete code - always mark for human review

2. **Format Code Structure**
   - **Go**: Run `gopls' in that order
   - **Terraform**: Run `terraform fmt -recursive`
   - **YAML** (GitHub Actions, K8s): Run `prettier` or `yamlfmt` if available
   - **Lua**: Run `stylua` (column width: 100)
   - **Shell**: Run `shfmt` if available
   - Ensure proper indentation and spacing per language conventions

3. **Optimize Imports**
   - **Go**: Use `goimports-reviser` to organize imports (stdlib, third-party, local)
   - **Terraform**: Group provider declarations, modules, resources logically
   - Remove unused imports where safe
   - Sort imports alphabetically within groups

4. **Run Linting**
   - **Go**: Run `golangci-lint run --fix` (auto-fix safe issues)
   - **Terraform**: Run `tflint` if available
   - **YAML**: Run `yamllint` or `actionlint` for GitHub Actions
   - **Shell**: Run `shellcheck` if available
   - Report issues that require manual fixes

5. **Optimize Comments**
   - Remove redundant comments that just repeat what the code says
   - Remove unnecessary TODO comments that are already done
   - Keep comments that explain "why" not "what"
   - Ensure godoc/docstrings are present for public APIs in Go
   - Clean up trailing whitespace and empty comment lines

**Step 3: Present Cleanup Report**

## 📋 Cleanup Results

### 🎯 Files Processed

- [List of files that were cleaned]

### 🔧 Actions Taken

- **Code Marked for Review**: [Number of TODO markers added for debug/commented code]
- **Formatting Applied**: [Files formatted with specific tools used]
- **Imports Optimized**: [Unused imports removed, sorting applied]
- **Linting Issues Fixed**: [Auto-fixed issues count]
- **Comments Cleaned**: [Redundant comments removed, unclear ones improved]

### 🚨 Manual Actions Needed

- [List any issues that require manual intervention]
- [List files with TODO: Review markers added that need human validation]

### ✅ Quality Improvements

- [Summary of overall code quality improvements made]

## Quality Standards Applied:

- **Review-First Approach**: Mark suspicious code with TODO comments rather than auto-deleting
- **Consistent Style**: Apply language-specific formatting standards (gofumpt, terraform fmt, prettier)
- **Import Organization**: Follow language conventions (Go: stdlib/external/local, Terraform: logical grouping)
- **Linting Compliance**: Auto-fix safe linting issues, report others
- **Minimal Comments**: Keep only comments that explain "why", remove redundant "what" comments
