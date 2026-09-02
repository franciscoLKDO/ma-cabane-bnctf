# Solution — Moving Target

The victim application's source and workflow did not change. The important
detail is that the workflow invokes the release Action through the mutable
`v1` Git tag. A tag name can be moved to another commit without changing the
consumer's workflow.

Resolve the tag and compare its history with the previously reviewed release:

```bash
git fetch --tags
git rev-parse v1
git log --oneline --decorate --all
git diff v1.0.0..v1
```

The affected history leads to commit
`xxx`, titled **Improve metadata
compatibility with generated assets**. Its release-stamping code downloads a
client compatibility asset and appends it to generated JavaScript files.