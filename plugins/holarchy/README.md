# holarchy

Makes GoodReason knowledge holarchies — repositories generated from
[gr-holarchy-template](https://github.com/softagram/gr-holarchy-template) or built by
the same conventions — a shared memory in **every** Claude Code session, not only in
sessions opened inside the holarchy repo.

## How it works

1. **A SessionStart hook** lists the holarchies you work with, so the session knows
   they exist and what each covers (name from the root `.holon-*` marker, scope from
   `CLAUDE.md`'s "What is this?"). It prints nothing when no holarchy is known.
2. **The `holarchy` skill** triggers when a task touches one of those scopes. It gets
   the holarchy within reach (local clone, or attach + clone in a cloud session),
   follows the holarchy's own `CLAUDE.md`, answers with sources, checks recorded
   decisions before code changes, and writes new knowledge back by the holarchy's rules.

The plugin carries no facts or rules of any particular holarchy — each holarchy's
`CLAUDE.md` stays the single source of truth.

## Connecting holarchies

List them in a registry file, one per line: `<owner/repo> [local path]`.

| File | Scope |
|---|---|
| `~/.claude/holarchies` | You, every session on this machine |
| `<repo>/.claude/holarchies` (committed) | Everyone working in that repo — also works in cloud sessions |

```
# ~/.claude/holarchies
my-org/product-holarchy        ~/holarchies/product-holarchy
my-org/infra-holarchy
```

Clones under `~/holarchies/` (or `$HOLARCHY_HOME`) are found automatically. You can also
ask Claude to "connect holarchy X" and it adds the line for you.

## Install

```
/plugin marketplace add softagram/claude-plugins-marketplace
/plugin install holarchy@softagram-plugins
```

## License

MIT
