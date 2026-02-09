---
name: conventional-commits
description: A guide for writing commit messages following the Conventional Commits specification. Use this skill any time you need to create a commit message.
---

Commit messages should follow **Conventional Commits** structure:

```
<type>(<scope>): <description>

<body>
```

- **Type**: **REQUIRED**. One of: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- **Scope**: Optional. Only include the scope if the project is large and multifaceted.
- **Description**: **REQUIRED**. Concise summary in the imperative mood (e.g., "add", not "added").
- **Body**: **REQUIRED**. Detailed "why" behind the changes. It should be a single continuous paragraph wrapped at 72 characters. **DO NOT** include empty lines.
- **Line Length**: **ALL** lines (both the type/scope/description and body) **MUST** be **under 72 characters**.
- **Backticks**: Wrap all filenames, paths, and variable names in backticks (` `).

Execute commits by running this exact command structure, replacing `$GENERATED_COMMIT_MESSAGE` with your message:

```bash
git commit -F - <<'EOF'
$GENERATED_COMMIT_MESSAGE
EOF
```
