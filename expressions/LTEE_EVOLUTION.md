<!-- SPDX-License-Identifier: CC-BY-SA-4.0 -->

> **Superseded**: This document was the initial Thread 5 seed (May 11, 2026).
> The canonical Thread 5 expression is now **`LTEE_EVOLUTIONARY_DYNAMICS.md`**
> (May 12, 2026), which has more current spring status and lithoSpore module
> mappings. This file is retained as fossil record.

# Thread 5: Evolutionary Biology / LTEE — Foundation Expression (Superseded)

**Date:** May 11, 2026
**Thread:** 5 — Evolutionary Biology / LTEE
**Status:** Superseded by `LTEE_EVOLUTIONARY_DYNAMICS.md`
**Springs:** wetSpring, neuralSpring, healthSpring, groundSpring, hotSpring, airSpring
**Contacts:** Dolson, Waters

---

## Scope

Thread 5 covers the Long-Term Evolution Experiment (LTEE) and its broader
connections to evolutionary biology across the ecoPrimals ecosystem. The LTEE
— Richard Lenski's 75,000+ generation experiment with *E. coli* — is the
longest-running controlled evolution experiment and provides the gold-standard
dataset for validating computational models of evolution, adaptation, and
contingency.

The thread bridges six springs:
- **groundSpring**: Fitness dynamics (B2 COMPLETE), neutral mutation (B1 COMPLETE)
- **wetSpring**: Cit+ innovation contingency (B7 STARTED)
- **neuralSpring**: Mutation accumulation Rust validation (B1 STARTED)
- **hotSpring**: Anderson spectral analysis of fitness landscapes (B2 STARTED)
- **healthSpring**: Symbiont PK/PD (B5 STARTED), OATP bridge (E2), peptide screening (E4)
- **airSpring**: Environmental FLS2 receptor evolution (E3 QUEUED)

---

## Paper Map

| ID | Paper | Spring | Status | lithoSpore Module |
|----|-------|--------|--------|-------------------|
| B2 | Wiser et al. 2013 (fitness dynamics) | groundSpring | **COMPLETE** | `ltee-fitness` |
| B1 | Tenaillon et al. 2016 (mutation accumulation) | groundSpring | **COMPLETE** | `ltee-mutation` |
| B7 | Tenaillon 2016 (wetSpring angle) | wetSpring | STARTED | — |
| B1 | neuralSpring Rust validation | neuralSpring | STARTED | — |
| B2 | Anderson fitness (hotSpring) | hotSpring | STARTED | — |
| B5 | Leonard et al. 2024 (symbiont PK/PD) | healthSpring | **STARTED** | `ltee-symbiont-pk` |
| E2 | Mardikoraem & Woldring 2025 (HOLIgraph) | healthSpring | QUEUED | — |
| E3 | Dolgikh FLS2 (environmental) | airSpring | QUEUED | — |
| E4 | Woldring Lab 2024 (macrocyclic peptides) | healthSpring | QUEUED | — |

---

## Data Sources (12)

See `data/sources/thread05_ltee.toml`:
- **Core LTEE**: Dryad fitness trajectory (B2), NCBI WGS mutations (B1), Cit+ genomics (02)
- **Symbiont PK/PD**: *S. alvi* reference genome, bee gut microbiome, dsRNA PK literature
- **Protein-ligand**: OATP crystal structures (PDB), ChEMBL binding data
- **Peptide screening**: macrocyclic peptide templates (PDB), ADDRC reference, DrugBank PK
- **Digital evolution**: AVIDA platform (Dolson extensions)

## Validation Targets (10)

See `data/targets/thread05_ltee_targets.toml`:
- 2 COMPLETE (groundSpring B2+B1 → first lithoSpore modules)
- 4 STARTED (wetSpring B7, neuralSpring B1, hotSpring B2, healthSpring B5)
- 4 QUEUED (healthSpring E2+E4, airSpring E3, groundSpring digital evolution)

---

## healthSpring Contribution

healthSpring's LTEE contribution is through the pharmaceutical/clinical lens:

**B5 (Leonard 2024)** — Engineered gut symbiont (*S. alvi*) as drug delivery
vehicle in *Apis mellifera*. This bridges evolution (symbiont-host coevolution)
with pharmacokinetics (drug delivery, bioavailability, elimination). healthSpring
models four coupled processes:
1. Logistic colonization dynamics
2. Biomass-proportional molecule production
3. One-compartment gut-lumen pharmacokinetics
4. Hill dose-response efficacy (target knockdown)

**Python Tier 0 baseline complete** (`control/ltee_symbiont_pkpd/`, 8/8 checks).

**E2 (HOLIgraph)** — Graph neural network for protein-ligand binding predictions
applied to drug transporter (OATP) interactions. Bridges LTEE-evolved enzyme
fitness with drug transporter pharmacokinetics.

**E4 (Macrocyclic peptides)** — Screening library of cyclic peptides against
anti-doping reference compounds. Connects peptide evolution with clinical
reference validation.

---

## lithoSpore Integration Path

```
groundSpring B2+B1 (COMPLETE) → ltee-fitness + ltee-mutation modules
                                   ↓
healthSpring B5 (STARTED)     → ltee-symbiont-pk module
                                   ↓
wetSpring B7 + neuralSpring B1 → lithoSpore cross-validation
                                   ↓
hotSpring B2 + airSpring E3   → spectral + environmental LTEE modules
```

The lithoSpore artifact is a USB-deployable validation subsystem of
projectNUCLEUS. Each LTEE reproduction that passes becomes a module in the
artifact, carrying expected-values JSON + Rust validation binary.

---

## Cross-Thread Links

- **Thread 1 (WCM)**: Whole-cell modeling uses LTEE mutation rate data
- **Thread 3 (Immunology)**: B5 symbiont engineering connects to drug discovery
- **Thread 7 (Anderson)**: Anderson spectral analysis applies to LTEE fitness landscapes
- **Thread 8 (Clinical)**: healthSpring PK/PD models apply to symbiont drug delivery
