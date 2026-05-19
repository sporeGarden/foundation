# BLAKE3 Backfill Status

**Updated**: May 19, 2026
**Standard**: All `data/sources/*.toml` entries should have populated
`blake3` fields for content-addressed data integrity.

## Current State

10/165 sources across 11 TOML files now have BLAKE3 hashes.
Thread 1 WCM was backfilled on May 19, 2026 (FN-1).

| Source File | Hashed | Empty | Notes |
|-------------|:------:|:-----:|-------|
| thread01_wcm.toml | **10** | 15 | Backfilled May 19. 15 lack automated fetchers |
| thread02_plasma.toml | 0 | 17 | Literature-only — no automated fetch |
| thread03_immuno.toml | 0 | 17 | Fetchable via BioProject metadata |
| thread04_enviro.toml | 0 | 20 | Fetchable via BioProject metadata |
| thread05_ltee.toml | 0 | 11 | Fetchable via NCBI + Dryad |
| thread05_ml_surrogates.toml | 0 | 15 | Internal models — no external data |
| thread06_ag.toml | 0 | 16 | Mostly web-service/literature |
| thread07_anderson.toml | 0 | 11 | Literature + internal models |
| thread08_health.toml | 0 | 13 | Partially fetchable |
| thread09_gaming.toml | 0 | 14 | Procedural — no external data |
| thread10_provenance.toml | 0 | 6 | Internal test vectors |

## Thread 1 WCM Backfill Detail

Sources with BLAKE3 hashes (fetched from public APIs):

| Source ID | Database | Accession | BLAKE3 (first 16) |
|-----------|----------|-----------|-------------------|
| ncbi_mg_genome | NCBI Nucleotide | NC_000908.2 | `7b247198c66e6fa7` |
| ncbi_mg_assembly | NCBI Assembly | GCA_000027325.1 | `0a8ff703568e8880` |
| uniprot_mg_proteome | UniProt | UP000000807 | `5c1e27ec868405be` |
| kegg_mg | KEGG | mge | `15c66456aee5b829` |
| ncbi_ecoli_genome | NCBI Nucleotide | NC_000913.3 | `67dee55704e1183e` |
| uniprot_ecoli_proteome | UniProt | UP000000625 | `79497129a06cbfca` |
| kegg_ecoli | KEGG | eco | `0749a78559066a8e` |
| ncbi_syn3a_genome | NCBI Nucleotide | CP016816.2 | `0687f00d56d0d477` |
| ncbi_syn3a_bioproject | NCBI BioProject | PRJNA357500 | `6c4cc430ec088bd1` |
| ncbi_syn3a_assembly | NCBI Assembly | GCA_900015295.1 | `d814dea9b5237c1d` |

Sources NOT fetchable automatically (15):

- BRENDA enzyme kinetics (no public bulk API)
- EcoCyc pathway definitions (no public bulk API)
- GitHub source code repos (3 repos — need commit pinning)
- Literature DOIs / supplementary data (4 sources)
- AlphaFold DB structure predictions (need accession enumeration)
- GROMACS software binary (version pinning needed)
- Martini force field parameters (website download)
- EMDB cryo-ET data (accessions pending publication)
- NIST TECRdb thermodynamics (no public bulk API)

## Known Issue

`UP000018174` (M. mycoides proteome): UniProt streaming API returns
empty (20B) as of May 19, 2026. Proteome may be reclassified or
excluded from the streaming endpoint. Alternate fetch needed.

## Backfill Process

```bash
# Fetch Thread 1 WCM sources
bash deploy/fetch_sources.sh --thread wcm

# Compute BLAKE3 and update TOMLs
bash deploy/backfill_hashes.sh --thread wcm
```

## Next Steps

- Backfill Threads 3, 4, 5, 8 (all have fetchable NCBI sources)
- Investigate alternate UniProt endpoint for UP000018174
- Pin GitHub repo commits for source reproducibility
