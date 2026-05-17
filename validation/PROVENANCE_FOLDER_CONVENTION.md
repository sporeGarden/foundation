# Provenance Folder Convention

**Effective**: May 16, 2026 (post-CATHEDRAL split)
**Source**: `CATHEDRAL_SPLIT_SPRING_GUIDANCE_MAY16_2026.md`

## Structure

```
validation/
  <spring>/
    <YYYY-MM-DD>/
      results.json         ValidationResult export from the spring
      provenance.toml      Run metadata: tier, primals, duration, methods
      braid.json           sweetGrass attribution braid (if trio available)
      *.stdout             Raw validation output logs
    braids/                Ferment transcript braids (computation-verified provenance)
      <dataset_id>.json    Machine-verifiable computation record
```

## Example

```
validation/
  hotSpring/
    2026-05-11/
      results.json
      provenance.toml
      braid.json
  groundSpring/
    2026-05-11/
      results.json
      provenance.toml
```

## provenance.toml Template

```toml
[run]
spring = "hotSpring"
version = "0.6.32"
date = "2026-05-11"
threads = ["02", "07"]
tier = 2                    # 1=structural, 2=live IPC, 3=full provenance

[environment]
gate = "irongate"
nucleus_composition = "nest"
primals_available = ["toadStool", "NestGate", "rhizoCrypt", "loamSpine", "sweetGrass"]
host = "irongate-local"

[results]
total_checks = 12
passed = 12
failed = 0
skipped = 0
duration_seconds = 4.2

[provenance]
dag_session_id = ""
merkle_root = ""
spine_id = ""
braid_urn = ""
```

## Legacy Folders

Existing validation runs (`wcm-20260509/`, `plasma-20260511/`, etc.) are
preserved as geological record. New runs use the spring-oriented convention.
The `foundation_validate.sh` pipeline writes to `validation/run-<timestamp>/`
for ad-hoc runs; results should be sorted into spring folders post-run.

## Partial Trio Completion

Per `wateringHole/PROVENANCE_TRIO_INTEGRATION_GUIDE.md`, partial
provenance is valid. If only some trio primals are reachable, record
whatever is available:

- **Full**: dag_session_id + spine_id + braid_urn (all populated)
- **DAG + spine**: dag_session_id + spine_id (braid_urn empty)
- **DAG only**: dag_session_id only (spine_id and braid_urn empty)
- **Standalone**: All provenance fields empty (science still valid)

No rollback on partial. The consumer decides whether partial is acceptable.

## Ferment Transcript Braids

The `braids/` subfolder within a spring directory holds ferment transcript
braids — computation-verified provenance records from real-data pipelines.
These are distinct from run-level `braid.json` (which covers a validation
session) and instead prove specific upstream computations.

See `validation/wetSpring/braids/README.md` for the wire format.

## Who Creates These

Each spring is responsible for exporting its `ValidationResult` to JSON
via `ValidationResult::to_json()` or equivalent. The dated folder and
`provenance.toml` metadata are created by the spring's validation binary
or by `foundation_validate.sh` when wrapping workload execution.
