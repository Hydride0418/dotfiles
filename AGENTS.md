# Project notes for agents

Deliberate decisions in this repo - do NOT silently revert them:

- `homebrew.onActivation.cleanup = "none"` in `configuration.nix` is intentional for first adoption on an existing Mac. Do not change it to `zap` until every Homebrew package and cask that should be kept has been declared in `configuration.nix`.
- Never commit `.no-mistakes/` validation evidence to this public repo. `.no-mistakes/` is gitignored; if a validation pipeline stages evidence into a branch, drop it before merging.
