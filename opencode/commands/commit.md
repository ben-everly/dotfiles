---
description: Commit changes with a generated commit message
---

Commit the staged changes. I have prepared everything for you, all you need to do is generate a conventional commit message and run `git commit`. The following output is `git diff --staged`. If the output is "NO_CHANGES", stop immediately and notify the user that no changes were found to stage or commit:

```diff
!`git diff --staged --quiet && git add . ; git diff --staged --quiet && echo "NO_CHANGES" || git diff --staged`
```

If there are changes, generate a high-quality commit message based on the diff above and this extra context:

> $ARGUMENTS

Execute the commit by running this exact command structure, replacing `$GENERATED_COMMIT_MESSAGE` with your message:

```bash
git commit -F - <<'EOF'
$GENERATED_COMMIT_MESSAGE
EOF
```
