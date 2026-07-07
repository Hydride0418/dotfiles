# Global agent instructions

- Use Chinese for user-facing replies by default.
- Do not use em dashes. Use plain hyphens instead.
- When writing commit messages, never auto-add your agent name as co-author.
- Never manually modify CHANGELOG.md files or any files marked as auto-generated.
- Protect existing user changes. Do not reset, stash, overwrite, or delete unrelated work unless explicitly asked.
- Keep changes surgical. Match the existing style and touch only the files needed for the task.
- Prefer simple, robust, maintainable solutions over shortcuts chosen only to reduce development effort.
- When fixing bugs, reproduce the issue first in a setting close to how the user experiences it.
- Verify meaningful changes with focused tests, lint, type checks, or a clear manual check when automated tests are unavailable.

