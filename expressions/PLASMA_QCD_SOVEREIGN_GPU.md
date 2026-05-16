# Plasma Physics & Lattice QCD — Thread 2 Expression

**Springs**: hotSpring (primary)
**Thread**: 2 (Plasma Physics / Lattice QCD)
**Last Updated**: May 11, 2026
**Status**: Active — 25/25 papers reproduced (CPU), 20/25 GPU, Sarkas MD parity validated

## The Core Question

Can we reproduce — and then improve upon — published computational physics
results using sovereign GPU compute? From Yukawa plasmas to lattice QCD
gauge theory, every observable is computed from first principles on consumer
hardware, validated against published Python/Fortran/C++ baselines, and
proven at paper-parity precision.

## Three Physics Domains

| Domain | What it computes | Key papers |
|--------|-----------------|------------|
| **Molecular Dynamics** | Yukawa OCP transport: D*, η*, RDF, VACF | Stanton & Murillo (2016), Choi et al. (2019) |
| **Lattice QCD** | SU(3) gauge fields, gradient flow, RHMC | Bazavov & Chuna (2021), MILC configs |
| **Nuclear EOS** | Hartree-Fock-Bogoliubov, nuclear matter | Duflo-Zuker, FRDM, Skyrme |

## Validation Chain

```
Published paper (Python/Fortran/C++ reference)
  → Python control script (hotSpring/control/)
  → Rust CPU reproduction (barracuda/src/)
  → GPU sovereign dispatch (WGSL compute shaders via wgpu)
  → Parity verification (CPU-GPU force/energy/observable agreement)
  → Foundation target (data/targets/thread02_plasma_targets.toml)
```

Each link in the chain is traceable: source paper → Python baseline → Rust
implementation → GPU shader → automated test → foundation geological layer.

## Sarkas Yukawa MD (Primary Validated Surface)

The Sarkas validation suite covers 12 (κ,Γ) points spanning weak to strong
coupling across 4 screening lengths:

| κ | Γ range | Physics regime | Observables |
|---|---------|----------------|-------------|
| 0 | 10–150 | OCP (no screening) | D*, η*, g(r), VACF |
| 1 | 14–217 | Moderate screening | D*, η*, g(r), VACF |
| 2 | 31–476 | Strong screening | D*, η*, g(r), VACF |
| 3 | 100–1510 | Extreme screening | D*, η*, g(r), VACF |

**Key results:**
- Energy drift: 0.000–0.002% across 9 PP cases (tolerance: 0.5%)
- RDF tail convergence: |g(r→∞)−1| ≤ 0.0017 (tolerance: 0.02)
- Self-diffusion D*: < 5% vs Sarkas Python (Green-Kubo VACF integral)
- Viscosity η*: < 10% vs Sarkas Python (stress-tensor ACF)
- Daligault fit RMSE: < 10% across 12 calibration points

## Lattice QCD (GPU Sovereign Compute)

SU(3) gauge theory on 4D lattice with velocity-Verlet/Omelyan/RK3 integrators:

| Observable | Method | GPU shader | Status |
|------------|--------|------------|--------|
| Wilson plaquette | SU(3) trace | `plaquette.wgsl` | Validated |
| Gradient flow | RK3 Lüscher | `flow_rk3.wgsl` | Validated |
| Polyakov loop | Temporal link product | `polyakov.wgsl` | Validated |
| HMC trajectory | Metropolis accept/reject | `hmc_*.wgsl` | Validated |
| RHMC (dynamical) | Rational approximation | `rhmc_*.wgsl` | Validated |
| CG solver | Conjugate gradient | `cg_solve.wgsl` | Validated |

128 WGSL shaders total, all AGPL-3.0-only, validated on RTX 4070 (Ada Lovelace).

## Kokkos/LAMMPS Parity

Industry-standard benchmark comparison for MD:

- 9 Yukawa PP cases validated against LAMMPS + Kokkos CUDA
- CPU parity baseline: `benchmarks/barracuda_cpu_parity/md_velocity_verlet.py`
- GPU parity benches: `primals/barraCuda/crates/barracuda/benches/lammps_parity.rs`
- Kokkos timing comparison: `primals/barraCuda/crates/barracuda/benches/kokkos_parity.rs`
- Status: COMPLETE (Papers 43-45) — kokkos-lammps orchestrator superseded by
  barraCuda bench harness + projectFOUNDATION CPU baselines

## Source Data Anchors

18 literature/public anchors in `data/sources/thread02_plasma.toml`:
- Murillo MD transport (PRE 2016)
- Sarkas CPC software paper (2022)
- FLAG lattice review (2022)
- Kokkos dispatch model
- Volta/Ampere GPU architecture references

## Foundation Targets

12 validated targets in `data/targets/thread02_plasma_targets.toml`:
- Energy conservation (9 PP cases)
- RDF structural properties (12 reference points)
- Transport coefficients (6 D* points + viscosity)
- Analytical model parity (Daligault fit)

All targets have `validated = true` with provenance tracing to
`hotSpring/barracuda/src/md/transport.rs` reference data.

## Cross-Thread Connections

- **Thread 7 (Anderson)**: Lattice disorder → localization → spectral statistics
  (hotSpring proves regime classification on GPU)
- **Thread 1 (WCM)**: Nuclear EOS feeds whole-cell energetics models
- **Thread 6 (Ag)**: Soil disorder maps to Anderson localization parameter W

## Next Steps

- Additional NUCLEUS workloads for nuclear EOS and spectral validation
- BLAKE3 content hashing for all reference data artifacts
- GPU parity for remaining 5/25 papers
- Tier 4 WDM/NIF-adjacent reproduction (Militzer, atoMEC)
