# 1. Record Architecture Decisions

Date: 2026-06-04
Status: Accepted

## Context

When making significant technical decisions, we want to record what was decided and why — so future contributors understand the reasoning without needing to guess.

An Architecture Decision Record (ADR) is a short document that captures one such decision.

## Decision

We will store ADRs in `docs/architecture/decisions/`, numbered sequentially.

File naming: `NNNN-short-title.md`

Statuses:
- **Proposed** — under discussion
- **Accepted** — agreed upon
- **Rejected** — considered and rejected
- **Deprecated** — was accepted, no longer applies
- **Superseded by [N](link)** — replaced by a newer decision

## Consequences

- Significant decisions are documented and traceable.
- New contributors can understand "why" without asking.
- ADRs are append-only — we never delete old ones, only mark them as deprecated or superseded.

---

## Template for new ADRs

Copy the block below into a new file to create the next ADR:

```markdown
# N. <Title>

Date: YYYY-MM-DD
Status: Proposed

## Context

<What is the situation that motivates this decision?>

## Decision

<What was decided?>

## Consequences

<What becomes easier or harder as a result?>
```
