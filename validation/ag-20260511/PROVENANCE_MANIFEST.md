# Provenance Manifest — Thread 6 (Agricultural Science)

**Date:** 2026-05-11
**Spring:** airSpring v0.10.0
**Method:** UniBin `airspring validate` + `cargo test --workspace --lib --tests`
**Binary BLAKE3:** `cc0aff99df0830d24bcf9f2ae2fbd70073ef37074e8d357c368b82f1383ba3d5`
**Transport:** Local (Tier 1 structural validation — no IPC)

## Validated Targets (from `data/targets/thread06_ag_targets.toml`)

| Target ID | Paper | Expected | Validated | Status |
|-----------|-------|----------|-----------|--------|
| `fao56_ex17_bangkok_et0` | FAO56_PM | 5.72 mm/d | 5.72 ± 0.01 | PASS |
| `fao56_ex18_uccle_et0` | FAO56_PM | 3.88 mm/d | 3.88 ± 0.01 | PASS |
| `fao56_ex20_lyon_et0` | FAO56_PM | 4.56 mm/d | 4.56 ± 0.01 | PASS |
| `fao56_svp_table` | FAO56_PM | 11 entries | 11/11 | PASS |
| `pt_summer_sea_level` | PT1972 | 5.682 mm/d | 5.682 ± 0.001 | PASS |
| `pt_pm_ratio_uccle` | PT1972 | [0.85, 1.25] | 1.05 | PASS |
| `pt_climate_gradient_monotonic` | PT1972 | monotonic | verified | PASS |
| `thornthwaite_east_lansing_annual` | TH1948 | 687.81 mm | 687.81 ± 0.01 | PASS |
| `thornthwaite_wooster_annual` | TH1948 | 719.66 mm | 719.66 ± 0.01 | PASS |
| `hargreaves_analytical` | HS1985 | 4.6694 mm/d | 4.669 ± 0.001 | PASS |
| `hargreaves_ra_lat42_doy172` | HS1985 | 17.106 mm/d | 17.106 ± 0.001 | PASS |
| `makkink_analytical` | MK1957 | 2.438 mm/d | 2.438 ± 0.001 | PASS |
| `turc_humid_rh70` | TC1961 | 3.033 mm/d | 3.033 ± 0.001 | PASS |
| `turc_arid_rh40` | TC1961 | 6.410 mm/d | 6.410 ± 0.001 | PASS |
| `hamon_20c_14h` | HM1961 | 3.993 mm/d | 3.993 ± 0.001 | PASS |
| `hamon_35c_15h` | HM1961 | 9.787 mm/d | 9.787 ± 0.001 | PASS |
| `blaney_criddle_equator_25c` | BC1950 | 5.38 mm/d | 5.38 ± 0.01 | PASS |
| `blaney_criddle_lat40_summer` | BC1950 | 7.30 mm/d | 7.30 ± 0.01 | PASS |
| `dual_kc_corn_kcb_mid` | FAO56_Kc | 1.15 | 1.15 exact | PASS |
| `dual_kc_soybean_kcb_mid` | FAO56_Kc | 1.10 | 1.10 exact | PASS |
| `dual_kc_full_cover_etc` | FAO56_Kc | 5.75 mm/d | 5.75 exact | PASS |
| `stewart_corn_ky` | SW1977 | 1.25 | 1.25 exact | PASS |
| `stewart_mild_stress_yield` | SW1977 | 0.875 | 0.875 exact | PASS |
| `pedotransfer_loam_theta_wp` | SR2006 | 0.137024 m³/m³ | 0.1370 ± 0.0001 | PASS |
| `pedotransfer_loam_theta_fc` | SR2006 | 0.27961 m³/m³ | 0.2796 ± 0.0001 | PASS |
| `pedotransfer_loam_theta_s` | SR2006 | 0.459478 m³/m³ | 0.4595 ± 0.0001 | PASS |
| `pedotransfer_loam_ksat` | SR2006 | 15.4757 mm/hr | 15.48 ± 0.5 | PASS |
| `richards_sand_theta_10cm` | VG1980 | 0.2143 m³/m³ | 0.214 ± 0.001 | PASS |
| `richards_sand_theta_100cm` | VG1980 | 0.0493 m³/m³ | 0.049 ± 0.001 | PASS |
| `scs_cn75_50mm_runoff` | SCS1972 | 9.27 mm | 9.27 ± 0.1 | PASS |
| `scs_cn98_50mm_runoff` | SCS1972 | 44.28 mm | 44.28 ± 0.1 | PASS |
| `green_ampt_sandy_loam_1hr` | GA1911 | 3.51 cm | 3.51 ± 0.15 | PASS |
| `spi_gamma_alpha` | SPI1993 | 4.27322 | 4.273 ± 0.01 | PASS |
| `biochar_langmuir_r2` | KM2025 | ≥ 0.95 | 0.9916 | PASS |
| `atlas_annual_et0_representative` | MI_ATLAS | 702 mm | ~702 ± 5 | PASS |
| `atlas_corn_yield_ratio` | MI_ATLAS | 0.9949 | 0.995 ± 0.01 | PASS |

**36/36 targets PASS.**

## Frozen Result Artifacts

| File | BLAKE3 |
|------|--------|
| `experiments/results/experiment_catalog.json` | `da39d1820ed6981dfa52f22e534af24a498775a6f7c6df62a1234fd46e0e8df0` |
| `experiments/results/benchmark_timing.json` | `f33e3c171c6d5a8bb7c7317c31b117500512ee66a4bf60ffb8a90f63b38f65be` |
| `experiments/results/composition_validation.json` | `47985b3610a4436df8985c91d1ac7cf6b3a71d1f8d24fad3877da4042f249fa5` |
| `experiments/results/test_suite_report.json` | `e15220a79f05df8e55361bb54e273b728e8877c1296325e19e3309fe008b7453` |

## Coverage

- **1,011 lib tests** (unit + integration), 0 failures
- **1,314 total test passes** including binary tests
- **46 registered capabilities** (46 methods in `capability_registry.toml`)
- **7 ET₀ methods** cross-validated against published reference values
- **25 Tier A GPU-accelerated modules** (wgsl validated, CPU fallback live)

## Provenance Chain

1. Python baselines (control/ scripts) established numerical truth
2. Rust implementations in barracuda validated against Python baselines
3. GPU shaders (WGSL via barraCuda/coralReef) validated against CPU Rust
4. Named tolerances with provenance (paper, section, table) for every assertion
5. Frozen JSON artifacts provide reproducible validation data
