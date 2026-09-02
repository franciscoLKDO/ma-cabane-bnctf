# Solution — Ghosts in History

Search the complete Action repository history, including deleted files:

```bash
git log --all --stat
git log --all -- .env.production
git show xxx:.env.production
```

The old `.env.production` file contains a `GITHUB_TOKEN` value that was
removed from the current tree but remains recoverable from Git history.