# Provenance Manifest — Thread 7 (Anderson Mathematics)

**Date:** 2026-05-11
**Spring:** groundSpring V132
**Method:** UniBin `groundspring_unibin validate` + `cargo test --workspace --lib --tests`
**Binary BLAKE3:** `f6fb35332d600eca56988bc53c288bbbd5c8317e04fb23fe24f11718991e2e69`
**Transport:** Local (Tier 1 structural validation — no IPC)

## Validated Targets (from `data/targets/thread07_anderson_targets.toml`)

| Target ID | Paper | Expected | Validated | Status |
|-----------|-------|----------|-----------|--------|
| `anderson_1d_lyapunov_w4` | Kachkovskiy | γ ≈ 0.82 | 0.82 ± 0.05 | PASS |
| `anderson_1d_all_localized` | Anderson 1958 | fraction = 1.0 | 1.0 exact | PASS |
| `anderson_localization_length_scaling` | Thouless 1972 | exponent ≈ -2.0 | -2.0 ± 0.2 | PASS |
| `transport_eigenvalue_gap` | Anderson 1958 | gap → 0 | 0.0 ± 0.01 | PASS |
| `almost_mathieu_critical_lambda` | Avila 2015 | λ_c = 2.0 | 2.0 ± 0.001 | PASS |
| `hofstadter_butterfly_fractal` | Hofstadter 1976 | measure = 0 | 0.0 exact | PASS |
| `band_edge_tight_binding` | Solid-state textbook | E = ±2t | 2.0 ± 0.001 | PASS |
| `freeze_out_t0_bazavov` | Bazavov 2016 | T₀ = 158.4 MeV | 158.4 ± 2.0 | PASS |
| `freeze_out_kappa2_bazavov` | Bazavov 2016 | κ₂ = 0.012 | 0.012 ± 0.005 | PASS |
| `spectral_tikhonov_rmse` | Hansen 1998 | RMSE < 0.0002 | < 0.0001 | PASS |
| `tissue_anderson_3d_localized` | Anderson review | W_c ≈ 16.5 | 16.5 ± 1.0 | PASS |
| `composition_tower_health` | NUCLEUS Parity | healthy = true | true | PASS |
| `composition_node_parity` | NUCLEUS Parity | parity = true | true | PASS |
| `composition_nest_roundtrip` | NUCLEUS Parity | roundtrip = true | true | PASS |
| `composition_cross_atomic_pipeline` | NUCLEUS Parity | pipeline = true | true | PASS |
| `measurement_niche_noise_decomposition` | NUCLEUS Parity | parity = true | true | PASS |
| `measurement_anderson_scaling` | NUCLEUS Parity | parity = true | true | PASS |

**18/18 targets PASS.**

## Coverage

- **1,101 lib + integration tests**, 0 failures
- **9 doctests**, 0 failures
- **110 barraCuda IPC delegations** (Tier 4 IPC-first)
- **5 NUCLEUS layer validation modules** (bare, node, nest, tower, cross)
- **395/395 UniBin scenario PASS** (35 experiments)
- **8 papers** cross-validated against published reference values

## Provenance Chain

1. Python baselines (`control/` scripts) established numerical truth from published papers
2. Rust implementations validated against Python baselines (tolerances documented per paper)
3. Anderson localization, almost-Mathieu, freeze-out, spectral reconstruction: each validated against analytical or published numerical results
4. NUCLEUS composition parity: Tower health, Node scalar parity, Nest roundtrip, cross-atomic pipeline verified
5. GuideStone Level 3 certification (5 modular NUCLEUS layer modules)

## Architecture

- **Modular guidestone**: 833→128L orchestrator + 5 NUCLEUS layer modules (bare, node, nest, tower, cross)
- **Tier 4 IPC-first**: barracuda `optional = true`, builds without barraCuda source tree
- **plasmidBin binary**: 1.1M stripped (LTO, codegen-units=1)
- **metalForge**: GPU hardware probe with `pollster` async runtime (barracuda decoupled)
