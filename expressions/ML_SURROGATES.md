# ML Surrogates & Evolutionary Dynamics — Thread 5 Expression

**Springs**: neuralSpring (primary), groundSpring (LTEE B1-B3), hotSpring (Anderson RMT)
**Thread**: 5 (Evolutionary Biology / LTEE)
**Last Updated**: May 12, 2026
**Status**: 12 targets seeded, B1 Rust binary shipped (14/14 PASS)

## The Core Question

Can ML surrogates — LSTM, ESN, transformer, DeepONet, PINN — reproduce and
predict the dynamics of evolving biological systems, and can those predictions
be validated against analytical baselines with cross-language numerical parity?

neuralSpring answers this by building ML architectures in pure Rust, validating
them against published paper results, and connecting the evolutionary dynamics
thread to LTEE mutation accumulation data from Barrick et al. (2009).

## Four Pillars

| Pillar | What it validates | Key experiments |
|--------|------------------|-----------------|
| **LSTM Time Series** | Prediction accuracy on physical/biological series | Exp 009 (weather), Paper 026 (glucose) |
| **ESN Reservoir Computing** | Regime classification and bioprocess prediction | nW-05 (WDM), Paper 027 (digestion) |
| **WDM Surrogate Physics** | Neural EOS/transport/plasmon surrogates | nW-01, nW-02, nW-03 |
| **Evolutionary Biology** | Open-endedness, selection, mutation dynamics | Papers 011-015, B1 |

## ML Architecture Coverage

| Architecture | Papers | Validated Checks | Domain |
|-------------|--------|-----------------|--------|
| LSTM | 009, 026, nW-03 | Weather NSE 0.849, Glucose R² 0.98, Plasmon R² 0.98 | Time series |
| ESN | nW-05, 027 | WDM regime 96.5%, Digestion R² 0.84 | Reservoir computing |
| MLP | nW-01, nW-02 | Transport 30/30, EOS 36/36 + 15/15 GPU | Surrogate physics |
| PINN | 006 | Burgers 6/6 | Physics-informed |
| DeepONet | 007 | Operator learning 5/5 | Operator networks |
| LeNet-5 | 008 | MNIST 98.89% | Convolutional |

## Evolutionary Biology Reproductions

The Dolson Lab (MSU CSE) papers form the evolutionary biology backbone:

| Paper | Citation | Result | Checks |
|-------|----------|--------|--------|
| 011 | Iram, Dolson et al. (2020) — Counterdiabatic driving | CD outperforms linear | 11/11 |
| 012 | Dolson et al. (2019) — MODES toolbox | 4 OE metrics discriminate | 9/9 |
| 013 | Dolson & Ofria (2018) — Ecological theory | Exclusion + niche | 7/7 |
| 014 | Dolson et al. (2022) — Directed evolution | Lexicase diversity | 8/8 |
| 015 | Foreback & Dolson (2025) — Swarm controllers | Het vs hom | 11/11 |

## LTEE B1: Mutation Accumulation

The B1 reproduction (Barrick et al. 2009) is the bridge between neuralSpring's
ML surrogates and the LTEE backbone:

- **Python baseline**: `experiments/ltee/exp_b1_mutation_accumulation.py` (8/8 PASS)
- **Rust validation**: `validate_ltee_b1_mutation_accumulation` (14/14 PASS)
- **Key values**: mutation rate 3.592e-3 mut/gen, power-law exponent 0.8213 (sublinear)
- **Expected values**: `control/ltee_mutation_accumulation/expected_values.json`
- **Structured output**: `--format json` for Tier 2 projectNUCLEUS ingestion

The Rust binary includes an LSTM forward-pass smoke test on the mutation
time series, connecting the ML surrogate pillar to the LTEE data pillar.

## Validated Targets (12/12)

| Target ID | Expected | Unit | Status |
|-----------|----------|------|--------|
| `lstm_weather_nse` | 0.849 ± 0.05 | NSE | validated |
| `lstm_glucose_r2` | 0.98 ± 0.02 | R² | validated |
| `esn_wdm_accuracy` | 0.965 ± 0.02 | fraction | validated |
| `esn_digestion_r2` | 0.84 ± 0.05 | R² | validated |
| `wdm_transport_mlp` | 1.0 | boolean | validated |
| `wdm_eos_surrogate` | 1.0 | boolean | validated |
| `wdm_sqw_plasmon` | 0.98 ± 0.02 | R² | validated |
| `counterdiabatic_outperforms_linear` | 1.0 | boolean | validated |
| `modes_discrimination` | 1.0 | boolean | validated |
| `lexicase_diversity` | 1.0 | boolean | validated |
| `ltee_b1_mutation_rate` | 0.003592 ± 0.001 | mut/gen | validated |
| `ltee_b1_sublinear_exponent` | 0.8213 ± 0.1 | dimensionless | validated |

## Primal Composition

neuralSpring consumes 5 primals via IPC (`default = []`, barracuda optional):

| Primal | Role | Key capabilities |
|--------|------|-----------------|
| beardog | Security | crypto.sign, crypto.verify |
| songbird | Discovery | discovery.find_primals |
| toadstool | Compute | compute.execute |
| nestgate | Data | storage.put/get |
| barracuda | Math (optional) | GPU-accelerated tensor ops |

## Workloads (projectNUCLEUS)

| Workload | Command | Format |
|----------|---------|--------|
| `neuralspring-ml-validation` | `neuralspring_unibin validate` | `--format json` / `NEURALSPRING_JSON=1` |
| `neuralspring-certification` | `neuralspring_unibin certify` | human-readable |
| `validate_ltee_b1` | `validate_ltee_b1_mutation_accumulation --format json` | JSON (Tier 2) |

## Cross-Thread Contributions

- **Thread 2 (Plasma/QCD)**: WDM surrogate outputs feed hotSpring's plasma thread
- **Thread 4 (Environmental Genomics)**: LSTM time-series methods available to wetSpring
- **Thread 7 (Anderson Math)**: ESN regime classifier touches Anderson localization

## What's Next

- **Transformer surrogate**: When shipped, add `transformer_*` expected values
  to `thread05_ml_surrogates_targets.toml` with `validated = false`
- **GNN surrogate**: Graph neural network for molecular property prediction —
  candidate for new target set
- **LTEE B1 extensions**: Additional mutation categories (IS150, IS186-specific)
  from Barrick 2009 Table 1
- **lithoSpore module 2**: B1-ML outputs ready for ingestion once lithoSpore
  scaffolds module 2
