# barraCuda CPU Parity Baselines

Python (scipy/numpy) reference implementations for operations that
barraCuda implements in pure Rust + WGSL GPU compute.

These baselines serve as ground truth for numerical parity verification:
- Rust CPU results must match Python within documented tolerances
- GPU results must match Rust CPU within IEEE 754 bounds
- Any deviation must be named, justified, and minimal

## Operations covered

| Baseline | barraCuda equivalent | Parity standard |
|----------|---------------------|-----------------|
| `stats_variance.py` | `VarianceF64` kernel | ULP-exact for n<10^6 |
| `md_velocity_verlet.py` | `velocity_verlet_split_f64.wgsl` | 1e-12 (Kokkos/LAMMPS) |
| `spectral_eigenvalues.py` | Anderson localization eigensolver | 1e-10 (LAPACK reference) |

## Running

```bash
python3 -m pytest benchmarks/barracuda_cpu_parity/ -v
# Or individually:
python3 benchmarks/barracuda_cpu_parity/stats_variance.py
```

## Industry references

- Kokkos: parallel dispatch model (barraCuda uses wgpu compute equivalent)
- LAMMPS: MD force/integration parity (Sarkas OCP Yukawa regime)
- SciPy: statistical functions, eigenvalue decomposition
- cuBLAS: BLAS operation semantics (not FFI — pure Rust reimplementation)
