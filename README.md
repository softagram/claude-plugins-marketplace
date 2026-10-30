# Softagram Plugin Marketplace for Claude Code

A marketplace for distributing Softagram's Claude Code plugins.

## Available Plugins

### goodreason

A systems-thinking agent topology for complex engineering tasks. Instead of one agent doing everything, GoodReason splits work across **four specialized subagents** with strict role boundaries:

| Agent | Anchors | Role |
|-------|---------|------|
| **Strategist** | alpha × chi (purpose × information) | Verifies build/test foundations, generates competing hypotheses for diagnostic tasks, flags goal/reality conflicts |
| **Architect** | pi × beta (theory × structure) | Designs structure and interfaces; when hypotheses exist, designs a diagnostic experiment (Phase 0) before a fix |
| **Implementer** | phi × tau (solution × implementation) | Writes code under strict TDD phasing; when stuck, uses the phi-stuck protocol with probe tests instead of grinding |
| **Evolution** | omega × delta-psi (feedback × change) | Runs tests, verifies the fix works for the right reasons, flags causal-mismatch and unverified-mechanism risks |

The main agent (Claude Code itself) acts as **coordinator**: routing information between subagents, pacing the cycle, and preventing the blind spots that arise when a single agent both writes code and judges its own work.

See the [plugin repository](https://github.com/softagram/goodreason-agents-setup) for the full agent definitions and `GOODREASON.md` for the complete meta-ontology reference (eight semantic anchors, relational operators, anchor status model).

### holarchy

Makes GoodReason knowledge holarchies (repositories built with [gr-holarchy-template](https://github.com/softagram/gr-holarchy-template) conventions) a shared memory in every session, not only in sessions opened inside the holarchy repo. A SessionStart hook lists the holarchies you have connected (`~/.claude/holarchies`, a repo's `.claude/holarchies`, or clones under `~/holarchies/`) with their scope; the `holarchy` skill then fetches the right one when a task touches it, follows its own `CLAUDE.md`, answers with sources, checks recorded decisions before code changes and writes new knowledge back by the holarchy's rules. It carries no facts or rules of any particular holarchy. See the [plugin README](plugins/holarchy/README.md).

## Installation

```bash
# Add the marketplace (one-time)
/plugin marketplace add softagram/claude-plugins-marketplace

# Install a plugin
/plugin install goodreason@softagram-plugins
/plugin install holarchy@softagram-plugins
```

After installation, the plugin loads automatically in every Claude Code session. Run the full cycle on any task:

```
/goodreason:cycle Add rate limiting to the public API
```

## License

MIT
