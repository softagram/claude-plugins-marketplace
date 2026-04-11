# Softagram Plugin Marketplace for Claude Code

A marketplace for distributing Softagram's Claude Code plugins.

## Available Plugins

### goodreason

A systems-thinking agent topology for complex engineering tasks. Instead of one agent doing everything, GoodReason splits work across **four specialized subagents** with strict role boundaries:

| Agent | Dimension | Role |
|-------|-----------|------|
| **Strategist** | alpha × chi (purpose × information) | Verifies build/test foundations, generates competing hypotheses for diagnostic tasks, flags goal/reality conflicts |
| **Architect** | pi × beta (theory × structure) | Designs structure and interfaces; when hypotheses exist, designs a diagnostic experiment (Phase 0) before a fix |
| **Implementer** | phi × tau (action × integration) | Writes code under strict TDD phasing; when stuck, uses the phi-stuck protocol with probe tests instead of grinding |
| **Evolution** | omega × delta-psi (feedback × change) | Runs tests, verifies the fix works for the right reasons, flags causal-mismatch and unverified-mechanism risks |

The main agent (Claude Code itself) acts as **coordinator**: routing information between subagents, pacing the cycle, and preventing the blind spots that arise when a single agent both writes code and judges its own work.

See the [plugin repository](https://github.com/softagram/goodreason-agents-setup) for the full agent definitions and `GOODREASON.md` for the complete meta-ontology reference (eight symbols, relational operators, dimension status model).

## Installation

```bash
# Add the marketplace (one-time)
/plugin marketplace add softagram/claude-plugins-marketplace

# Install a plugin
/plugin install goodreason@softagram-plugins
```

After installation, the plugin loads automatically in every Claude Code session. Run the full cycle on any task:

```
/goodreason:cycle Add rate limiting to the public API
```

## License

MIT
