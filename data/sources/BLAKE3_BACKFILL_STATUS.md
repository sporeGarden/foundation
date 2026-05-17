# BLAKE3 Backfill Status

**Updated**: May 17, 2026
**Standard**: All `data/sources/*.toml` entries should have populated
`blake3` fields for content-addressed data integrity.

## Current State

All 165 sources across 11 TOML files have `blake3 = ""` (empty).

| Source File | Empty blake3 |
|-------------|:------------:|
| thread01_wcm.toml | 25 |
| thread02_plasma.toml | 17 |
| thread03_immuno.toml | 17 |
| thread04_enviro.toml | 20 |
| thread05_ltee.toml | 11 |
| thread05_ml_surrogates.toml | 15 |
| thread06_ag.toml | 16 |
| thread07_anderson.toml | 11 |
| thread08_health.toml | 13 |
| thread09_gaming.toml | 14 |
| thread10_provenance.toml | 6 |

## Why They're Empty

BLAKE3 hashes require fetched data. The sources are public repository
references (NCBI, UniProt, KEGG, Dryad, etc.) that are fetched at
validation time via `deploy/fetch_sources.sh`. Until data is fetched
and cached locally, hashes cannot be computed.

## Backfill Process

```bash
# 1. Fetch all public data sources
bash deploy/fetch_sources.sh

# 2. Compute BLAKE3 hashes for fetched files
bash deploy/backfill_hashes.sh
```

`backfill_hashes.sh` walks the `data/sources/*.toml` manifest and
matches accession patterns to fetched files, computing BLAKE3 per
file and updating the TOML in place.

## Reference Pattern

lithoSpore demonstrates complete BLAKE3 anchoring for all data
artifacts. Use `litho fetch` as reference for the hash-on-fetch
pattern (per Wave 21 guidance).

## Priority

Medium. The data sources are documented and accessible; the hashes
add integrity verification but don't block validation. Backfill
when fetch infrastructure is running on a gate with network access.
