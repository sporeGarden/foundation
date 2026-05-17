# Ferment Transcript Braids — wetSpring

Ferment transcript braids are machine-verifiable provenance records from
wetSpring's real-data computation pipelines. They prove that a specific
computation (e.g., breseq mutation calling on NCBI accession SRP001569)
was executed by a specific spring version and anchored through the
provenance trio.

## Wire Format

```json
{
  "dataset_id": "barrick_2009_mutations",
  "spring": "wetSpring",
  "spring_version": "0.1.0",
  "braid_id": "<from sweetGrass>",
  "dag_session_id": "<from rhizoCrypt>",
  "dag_merkle_root": "<BLAKE3>",
  "spine_id": "<from loamSpine>",
  "computation": {
    "tool": "breseq",
    "tool_version": "0.40.1",
    "input_accession": "SRP001569",
    "node_count": 7,
    "wall_time_seconds": 3793
  },
  "summary_blake3": "529e34ee..."
}
```

## Expected Braids

| Dataset | Spring | Status | Thread |
|---------|--------|--------|--------|
| Barrick 2009 (7 clones) | wetSpring V177 | 3/7 done | Thread 5 LTEE |
| Tenaillon 2016 (264 genomes) | wetSpring | Queued | Thread 5 LTEE |

## Integration

When braid JSON files arrive here, they upgrade Thread 5 LTEE targets
from "trust the published numbers" to "verify the computation chain."
The `provenance.toml` in the parent dated folder should reference the
braid via `braid_urn` and `dag_session_id`.

lithoSpore Module 2 (ltee-mutations) consumes these braids via its
`data.toml` `upstream_braid` field.
