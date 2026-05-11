# Thread 2 — Plasma Physics: Validation Summary

**Date**: 2026-05-11
**Spring**: hotSpring v0.6.32 (guideStone L6 CERTIFIED)
**Executor**: hotSpring barracuda lib tests + sarkas_gpu binary

## Results

| Target ID | Description | Result | Status |
|-----------|-------------|--------|--------|
| sarkas_energy_drift_max | Energy drift ≤ 0.5% | 0.000–0.002% | PASS |
| sarkas_rdf_tail_convergence | RDF tail |g(r→∞)−1| ≤ 0.02 | ≤ 0.0017 | PASS |
| sarkas_d_star_k0_g10 | D* κ=0 Γ=10 vs Sarkas | < 5% | PASS |
| sarkas_d_star_k0_g50 | D* κ=0 Γ=50 vs Sarkas | < 5% | PASS |
| sarkas_d_star_k0_g150 | D* κ=0 Γ=150 vs Sarkas | < 5% | PASS |
| sarkas_d_star_k1_g14 | D* κ=1 Γ=14 vs Sarkas | < 5% | PASS |
| sarkas_d_star_k2_g31 | D* κ=2 Γ=31 vs Sarkas | < 5% | PASS |
| sarkas_d_star_k3_g100 | D* κ=3 Γ=100 vs Sarkas | < 5% | PASS |
| sarkas_rdf_peak_height_k0_g150 | g(r) peak 2.358±0.1 | Match | PASS |
| sarkas_rdf_peak_height_k3_g1510 | g(r) peak 2.607±0.1 | Match | PASS |
| sarkas_daligault_fit_rmse | Fit RMSE < 10% | < 10% | PASS |
| sarkas_viscosity_rust_vs_sarkas | η* < 10% vs Sarkas | < 10% | PASS |

**12/12 targets PASS.**

## Gaps Discovered

None. All Sarkas Yukawa MD targets are validated by hotSpring's existing
test infrastructure. The validation chain (Python Sarkas → Rust → foundation)
is complete and traceable.

## Coverage Notes

- 6 representative D* points shown (of 12 total in reference data)
- All 9 Sarkas PP (κ,Γ) cases validated for energy conservation
- RDF validated at all 12 reference points; 2 extreme cases shown above
- CPU/GPU cross-parity validated separately (tolerances/md.rs)
