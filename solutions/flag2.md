# Solution — Follow the Build

The unexpected popup does not appear in the React source. Inspect the
repository's GitHub Actions workflows instead. The release workflow delegates
the production build to an external action through a `uses:` entry ending in
`vite-release-builder@v1`.

Open that Action repository and inspect its README. The flag is present near
the end of the document.