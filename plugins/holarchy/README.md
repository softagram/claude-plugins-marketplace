# holarchy

Makes knowledge holarchies — repositories generated from the private 
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
`CLAUDE.md` stays the single source of truth. The skill does carry general confidentiality
and customer-boundary rules (attribute every fact, never move content to a looser context
without permission, keep customers' content apart).

## Connecting holarchies

List them in a registry file, one per line: `<owner/repo> [local path]`.

| File | Scope |
|---|---|
| `~/.claude/holarchies` (or `$CLAUDE_CONFIG_DIR/holarchies`) | You, every session on this machine in that Claude profile |
| `<repo>/.claude/holarchies` (committed) | Everyone working in that repo — also works in cloud sessions |

```
# ~/.claude/holarchies
my-org/product-holarchy        ~/holarchies/product-holarchy
my-org/infra-holarchy
```

Clones under `~/holarchies/` (or `$HOLARCHY_HOME`) are found automatically. Of those, only the
holarchy the session runs in is listed with its description; the other clones are listed by
name, so that a large `~/holarchies/` does not fill every session's context. A holarchy in a
registry file always gets its full line. If you run
separate Claude profiles (`CLAUDE_CONFIG_DIR`), each reads its own `holarchies` registry; set
`HOLARCHY_HOME` per profile (`env` in that profile's `settings.json`) to keep their clone
directories apart too. Register customer-owned or restricted holarchies in that context's
`<repo>/.claude/holarchies`, not in the personal registry. You can also
ask Claude to "connect holarchy X" and it adds the line for you.

## Install

```
/plugin marketplace add softagram/claude-plugins-marketplace
/plugin install holarchy@softagram-plugins
```

## License

MIT
