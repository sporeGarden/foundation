# Degradation Behavior — projectFOUNDATION

**Date**: May 17, 2026
**Standard**: Ecosystem degradation behavior (Wave 20)
**Invariant**: Science is never gated behind primal availability.

---

## Pipeline Degradation Matrix

`foundation_validate.sh` degrades gracefully when primals are unreachable.
Each phase handles unreachable primals with `[WARN]` + continue, never abort.

| Phase | Primal | If unreachable | Impact |
|-------|--------|----------------|--------|
| 1: Health | All 13 | Skip health check, continue | No health baseline |
| 2: Provenance session | rhizoCrypt | `SESSION_ID=""`, skip DAG events | No provenance — standalone mode |
| 2: Provenance session | loamSpine | `SPINE_ID=""`, skip ledger | DAG-only provenance |
| 3: Data fetch | NestGate | Skip registration, fetch directly | Data present but unregistered |
| 4: Registration | NestGate | Log `[WARN]`, skip | Data hashed but not anchored |
| 5: Workload execution | toadStool | Execute directly (no sandbox) | No resource accounting |
| 5: Workload execution | Spring binary | `[SKIP]` workload, continue | Partial thread coverage |
| 6: Target comparison | — | Runs offline against stdout | Always works if workloads ran |
| 7: Provenance commit | rhizoCrypt | `MERKLE_ROOT="unknown"` | Session unclosed |
| 7: Provenance commit | loamSpine | Log `[WARN]`, skip seal | DAG without ledger |
| 7: Provenance commit | sweetGrass | `BRAID_URN="unknown"` | No attribution braid |
| 8: Report | — | Always writes report | Report reflects partial state |

## Degradation States

| State | Primals reachable | What you get |
|-------|-------------------|--------------|
| **Full NUCLEUS** | All 13 | Complete provenance: DAG + spine + braid |
| **Nest Atomic** | Trio + NestGate | Full provenance, no compute dispatch |
| **Node only** | toadStool + barraCuda | Compute dispatch, no provenance |
| **Standalone** | None | Direct execution, stdout validation only |

## Design Principle

Thread 1 WCM (0/27 targets) is **degraded, not broken**. The upstream
RPC stack is unavailable, so WCM workloads produce `[SKIP]` — but the
pipeline continues and validates every other thread. Partial results
are real results.

Similarly, partial provenance (DAG without braid) is valid per the
trio transaction semantics. A DAG session ID proves the validation
ran; a braid proves attribution. The absence of attribution doesn't
invalidate the science.

## Discovery Fallback

`discover_port()` in `deploy/lib/primal_ipc.sh` tracks fallbacks:

```
1. Try UDS discovery socket ($XDG_RUNTIME_DIR/ecoPrimals/discovery.sock)
2. Try ${PRIMAL_NAME}_PORT environment variable
3. Fall back to hardcoded default port
```

When fallback occurs, `DISCOVERY_FALLBACK_COUNT` increments. The final
report warns if any ports were resolved via defaults. This is degraded
discovery, not broken discovery.
