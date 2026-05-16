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
      braid.json           sweetGrass attribution braid (if provenance trio available)
      *.stdout             Raw validation output logs
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

## Who Creates These

Each spring is responsible for exporting its `ValidationResult` to JSON
via `ValidationResult::to_json()` or equivalent. The dated folder and
`provenance.toml` metadata are created by the spring's validation binary
or by `foundation_validate.sh` when wrapping workload execution.
