---
name: holarchy
description: Use a GoodReason knowledge holarchy (a git repo with a root .holon-* marker and 8 dimension directories alpha, pi, chi, deltapsi, beta, phi, tau, omega) as the shared memory for a task. Use whenever a task touches the scope of a holarchy listed in this session's context ("Knowledge holarchies available"), or a repository whose CLAUDE.md or .claude/holarchies names a holarchy — before changing code there, when asked why something is the way it is, what was decided or who is responsible, and before recording a decision, measurement or finding. Also use when the user asks to connect, register or kytkeä a holarchy, or mentions holarkia, holarchy or holon.
---

# Working with knowledge holarchies

A holarchy is a git repository that holds a team's shared memory: what each thing is,
what was decided and why, who is responsible, what breaks when something fails. An agent
remembers nothing between sessions; the holarchy is that memory.

**This skill only gets you to the holarchy and states the common conventions. The
holarchy's own `CLAUDE.md` is the rulebook** — read it in full and follow it; where it
and this file disagree, `CLAUDE.md` wins. Never copy a holarchy's facts or rules into
another place: each fact has one owner inside the holarchy, and a copy goes stale silently.

## 0. Which holarchies exist

At session start this plugin lists the holarchies the user works with (from
`.claude/holarchies` in the project, `holarchies` in the Claude config dir —
`~/.claude/holarchies`, or `$CLAUDE_CONFIG_DIR/holarchies` when a separate profile is
used — and clones under `~/holarchies/` or `$HOLARCHY_HOME`). Also check:

- the current repo's `CLAUDE.md` / README for a link to a `*-holarchy` repo;
- the holarchy's own `CLAUDE.md`, which may name **related holarchies** and define the
  boundary between them — follow that split.

If none is known for the topic, say so; do not guess.

## Confidentiality and boundaries

Every holarchy has an **owner** (your organisation, a customer, a project) and a
**confidentiality level**, stated in its `CLAUDE.md` or README — typically `public` (may be
quoted anywhere), `internal` (the owner's people only; not in external communication without
review) or `restricted` (only the people with access to the repository, e.g. finance, HR,
leadership). Git permissions enforce access; the remaining risk is *you moving content across
a boundary*. So:

1. **Say which holarchy a fact comes from** (holarchy name + file path) whenever you use it.
2. **Never move content from a stricter to a looser context without the user's explicit
   permission** for that specific transfer — into another holarchy, a shared document, an
   email, a blog post, a ticket, a chat message or another customer's material. Content from a
   customer-owned holarchy never goes into your organisation's or another customer's holarchy,
   and vice versa, unless the user asks for exactly that.
3. **`restricted` content** stays out of agent memory, messages to other sessions and external
   services (web search, third-party MCP servers); keep quotes in answers to what the user
   needs. A summary for someone without access carries at most an opaque reference (a path),
   not the content.
4. **Several holarchies in one session:** keep their content apart in your reasoning and
   outputs; when in doubt, ask which holarchy the user means.
5. **Working for one customer** (that customer's repository or working directory, a task for
   them): a holarchy that covers many customers — such as a company holarchy — may be consulted
   only for this customer's own entries and for general, non-customer knowledge. Do not read
   up on, quote or reuse other customers' facts in this customer's code, documents, commits,
   tickets or messages, even when they would help; if another customer's case is relevant,
   describe it only in anonymised, generalised form and only with the user's go-ahead. Lessons
   worth keeping go to a customer-neutral holarchy without identifying details.

Where the holarchy's own `CLAUDE.md` is stricter, it wins.

## 1. Connecting a holarchy (when the user asks)

Add one line `<owner/repo> [local path]` to a registry file:

- `~/.claude/holarchies` (or `$CLAUDE_CONFIG_DIR/holarchies`) — personal, for all of the
  user's sessions on this machine in that Claude profile;
- `<code repo>/.claude/holarchies`, committed — for everyone working in that repo, and the
  option that also works in cloud sessions, where the home directory does not persist.

Ask which one if it is not obvious. Register a customer-owned or `restricted` holarchy only
in the project of that context (the customer's own working directory, the leadership
workspace), never in the personal registry: everything listed there reaches every session,
including other customers' work. If that directory is shared by several contexts, say so
instead of registering. The listing takes effect in the next session; in this
session, just proceed to step 2.

## 2. Get the holarchy within reach

- **Local:** use the clone at the listed path (usually `~/holarchies/<repo>`); if absent,
  `git clone` it there.
- **Cloud session:** attach the repo (`add_repo`; read is enough for answering, push only
  for opening a PR), clone it with `--depth 1`, then `register_repo_root` so its
  `CLAUDE.md` loads.
- **Update first** (`git pull --ff-only`). A stale clone answers with facts that have
  already been corrected.

## 3. Orient before answering

1. Read `CLAUDE.md` completely; if a git-ignored `CLAUDE.personal.md` exists, read it too.
2. Check open GitHub issues the way `CLAUDE.md` says — some holarchies have more than one
   tracker. The task you are about to start may already be an issue with more context.
3. Navigate by the `README.md` at each level. Holons are directories with a `.holon-<type>`
   marker: `find . -name '.holon-*' -not -path './_templates/*'` gives the map.
4. Use `_templates/vocabulary.yaml` for controlled terms.

## 4. Answer from the holarchy

- **Cite the file** (and YAML key path) for every fact you use.
- **Check the date** of measured values. If old and measurable, say so or re-measure.
- **The holarchy wins on *why*, the issue tracker on *status*.**
- **Speak plainly, in the user's language.** People using a holarchy usually do not know
  the GoodReason symbols; never hand them `β`, `⊘` or "the φ dimension". Notation
  belongs inside the holarchy's files.
- If the holarchy does not know, say so instead of filling the gap with a guess.

## 5. Before changing code that a holarchy describes

- Read the owning holon's plans and decisions. Do not re-propose an alternative it
  records as rejected — or say explicitly why its reasons no longer hold.
- If the change alters a recorded fact, decision or dependency, update the holarchy too
  (its own PR), or tell the user that it is still needed.

## 6. Writing back

Follow `CLAUDE.md`. The points most often broken:

- **One owner per fact.** A measured value lives once, in the owning holon's `chi/` YAML;
  elsewhere refer to it by path or key path.
- **Placement is your decision.** Choose the dimension yourself and tell the user in one
  plain sentence where you put it and why.
- **Run the holarchy's own checks** (link checker, consistency scripts, git hooks — see
  `bin/` and `CLAUDE.md`). Never bypass a hook with `--no-verify`.
- **Branch and PR, never a direct push to `main`.** Match the repo's commit style
  (`git log`).
- **Tasks for people go to issues, not prose.** Personal data (phone numbers, verbatim
  meeting records) stays out of the shared repo.
