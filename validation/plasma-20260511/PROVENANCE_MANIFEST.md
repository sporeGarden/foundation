# Thread 2 — Plasma Physics: Sarkas Yukawa MD Provenance Manifest

**Date**: 2026-05-11
**Spring**: hotSpring v0.6.32
**Thread**: 2 (Plasma Physics / Lattice QCD)
**Status**: Validated (12/12 targets PASS)

## Validation Chain

```
Python Sarkas 1.0.0 (reference)
  ↓ validate_all_observables.py
  ↓ all_observables_validation.json
hotSpring Rust MD (reproduction)
  ↓ barracuda/src/md/ (velocity-Verlet + Yukawa force kernel)
  ↓ barracuda/src/md/transport.rs (D* Green-Kubo, RDF, VACF)
  ↓ barracuda/src/bin/sarkas_gpu.rs (9 PP cases, parity validation)
  ↓ barracuda/src/tolerances/md.rs (acceptance criteria)
foundation targets (geological layer)
  ↓ data/targets/thread02_plasma_targets.toml (12 targets)
```

## Source Papers

| Paper | Reference | Domain |
|-------|-----------|--------|
| Stanton & Murillo (2016) | PRE 93, 043203 | Transport: D*, viscosity, thermal conductivity |
| Choi, Dharuman & Murillo (2019) | PRE 100, 013206 | DSF, VACF, dynamic structure factor |
| Daligault (2012) | PRE 86, 047401 | Analytical D*(Γ,κ) model |
| Sarkas (2022) | CPC, 10.1016/j.cpc.2021.108245 | MD software — Python reference implementation |

## Validated Physics

| Observable | Method | Cases | Status |
|-----------|--------|-------|--------|
| Energy conservation | Velocity-Verlet drift | 9 PP | 0.000–0.002% drift |
| RDF g(r) structure | Pair correlation histogram | 12 (κ,Γ) | Tail < 0.0017 |
| Self-diffusion D* | Green-Kubo VACF integral | 12 (κ,Γ) | < 5% vs Sarkas |
| Viscosity η* | Stress-tensor ACF | 12 (κ,Γ) | < 10% vs Sarkas |
| Daligault fit | Analytical model | 12 points | RMSE < 10% |

## Hardware

- **CPU validation**: All 1,019 lib tests (includes transport/RDF/D* verification)
- **GPU validation**: RTX 4070 (Ada Lovelace), WGSL compute shaders via wgpu
- **Cross-parity**: CPU/GPU force parity < 1%, PE parity < 1e-6

## Provenance Hashes

Pending BLAKE3 content hashing when `foundation_validate.sh` runs through
NUCLEUS composition. Reference data is embedded in Rust source:
- `barracuda/src/md/transport.rs::SARKAS_D_MKS_REFERENCE` (12 D values)
- `barracuda/src/md/transport.rs::SARKAS_RDF_REFERENCE` (12 RDF peaks)
- Python source: `control/sarkas/simulations/dsf-study/scripts/validate_all_observables.py`

## Next Steps

- Run `foundation_validate.sh --thread plasma` through NUCLEUS composition
- Generate BLAKE3 content hashes for all reference data
- Commit sweetGrass braid linking Python→Rust→foundation provenance chain
