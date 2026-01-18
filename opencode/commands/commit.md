---
description: Automated Conventional Commit
---

If the output below is "NO_CHANGES", stop immediately and notify the user that no changes were found to stage or commit.

!git diff --staged --quiet && git add . ; git diff --staged --quiet && echo "NO_CHANGES" || git diff --staged

If there are changes, generate a high-quality commit message based on the diff above following this structure:

```
<type>(<scope>): <description>

<body>
```

- **Type**: **REQUIRED**. One of: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert.
- **Scope**: Optional. Only include the scope if the project is large and multifaceted.
- **Description**: **REQUIRED**. Concise summary in the imperative mood (e.g., "add", not "added").
- **Body**: **REQUIRED**. Detailed "why" behind the changes. It should be a single continuous paragraph wrapped at 72 characters. **DO NOT** include empty lines.
- **Line Length**: **ALL** lines (both header and body) **MUST** be **under 72 characters**.
- **Backticks**: Wrap all filenames, paths, and variable names in backticks (` `).

Finally, execute the commit by running this exact command structure, replacing `$GENERATED_COMMIT_MESSAGE` with your message:

```bash
git commit -F - <<'EOF'
$GENERATED_COMMIT_MESSAGE
EOF
```
