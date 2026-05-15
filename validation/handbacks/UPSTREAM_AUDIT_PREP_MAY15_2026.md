# Upstream Audit Preparation — primalPing Review

**Date**: 2026-05-15
**From**: CATHEDRAL (lithoSpore + foundation)
**For**: primalPing, upstream primal teams

## Summary

Both `lithoSpore` and `foundation` repos have been cleaned for upstream
audit. This document consolidates open items that require attention from
upstream primal teams.

## lithoSpore — Open Items for Upstream Teams

### Blocked on External

| Item | Owner | Status |
|------|-------|--------|
| Module 5 (BioBrick burden) | External — Burden 2024 DOI pending | Scaffold only |
| Songbird TURN client library | Songbird team | Stub (env-var discovery only) |
| BearDog FIDO2/CTAP2 witness | BearDog team | Not started |
| sporePrint pipeline wiring | sporePrint/Zola team | Not started |
| genomeBin Tier 3 USB packaging | genomeBin team | Not started |

### petalTongue (owned, completed)

Interactive SceneGraph pipeline fully operational:
- Semantic data_id flow from DataBinding through SceneGraph
- Click-to-select with visual highlights and detail strip
- Pan/zoom ViewCamera with cursor-centered scroll
- IPC bridge fires InteractionApplyRequest on selections
- Data-driven animation on stream updates (350ms crossfade)
- Local parameter controls (geometry, scale, coordinates)

6 `#[allow(dead_code)]` markers in `domain_charts/mod.rs` and
`scene_paint.rs` are retained as reference implementations during
SceneGraph convergence. Will be removed when chart renderer is fully
deprecated in favor of SceneGraph paint path.

### Discovery Chain

UDS RPC transport and TURN-relayed RPC are documented stubs. All callers
degrade gracefully. Needs Songbird client library for actual relay IPC.

## foundation — Open Items for Upstream Teams

### Data Integrity

| Item | Action | Owner |
|------|--------|-------|
| `data/sources/*.toml` — all `blake3 = ""` | Run `deploy/backfill_hashes.sh` after fetching | CATHEDRAL (needs fetch infrastructure) |
| Thread 1 WCM — 0/24 targets validated | Review `validation/wcm-20260509/`, flip where justified | CATHEDRAL |
| Thread 5 ML — `accessions = []` | Document as `source_type = "internal"` (neuralSpring models) | neuralSpring team |

### Validation State

| Thread | Last Run | Status |
|--------|----------|--------|
| 1 — Whole-Cell Modeling | 2026-05-09 | Attempted — fetch infra validated, RPC upstream-blocked |
| 2 — Plasma Physics | 2026-05-11 | 12/12 PASS |
| 6 — Agricultural Science | 2026-05-11 | 36/36 PASS |
| 7 — Anderson Mathematics | 2026-05-11 | 18/18 PASS |

### Handback Archive (geological record)

All handbacks in `validation/handbacks/` are dated snapshots. Each now
carries a banner noting that upstream state should be re-verified before
acting on the findings.

## Paper Count Reconciliation

- `THREAD_INDEX.toml`: 28 total baseCamp papers
- `BASECAMP_PAPER_MAP.toml`: 26 individually mapped (14, 23, 24 are meta)
- Both are correct; the distinction is now documented in both files

## Repos Ready for Push

Both repos pass local `cargo check` / `cargo test` / `cargo clippy`.
Foundation CI jobs (shellcheck, TOML syntax, thread index, hash coverage)
expected to pass on clean state.
