# 🎙️ Digital Signal Processing — Lab Collection
### Isfahan University of Technology · B.Sc. Electrical Engineering

![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-orange?style=flat-square&logo=mathworks)
![Domain](https://img.shields.io/badge/Domain-Audio%20%26%20Speech%20DSP-blue?style=flat-square)
![Topic](https://img.shields.io/badge/Topic-Beamforming%20%7C%20DOA%20%7C%20LPC%20%7C%20Pitch-green?style=flat-square)
![License](https://img.shields.io/badge/License-Academic-lightgrey?style=flat-square)

A collection of five laboratory sessions from the **Digital Signal Processing** course at Isfahan University of Technology. The labs progress from array signal processing fundamentals all the way through speech analysis, covering both theory implementation and real-world audio experimentation with a 16-microphone array.

---

## 📂 Repository Structure

```
LAB_DSP/
├── Lab 1/   →  DOA Estimation: DAS & MVDR Beamforming
├── Lab 2/   →  Array Geometry & Spacing Analysis
├── Lab 3/   →  k-NN Classification on Fisher Iris Dataset
├── Lab 4/   →  LPC Coding & Pitch Estimation (SIFT)
└── Lab 5/   →  Speech Analysis: Windowing, FFT & Autocorrelation
```

---

## 🔬 Lab Summaries

### Lab 1 — Direction of Arrival Estimation with Microphone Arrays

Implements two classical time-domain beamforming algorithms on a **16-microphone array**, comparing a 1D uniform linear array against a 2D planar geometry.

**Algorithms implemented:**

| Algorithm | Description |
|-----------|-------------|
| **DAS** (Delay-and-Sum) | Compensates propagation delays per mic, sums coherently, takes norm over all 360° azimuths |
| **MVDR** (Minimum Variance Distortionless Response) | Sample covariance-based spatial filter — sharper nulls, better source separation |

**Key files:**

| File | Role |
|------|------|
| `DAS.m` | DAS beamformer function — sweeps φ ∈ [0°, 359°], returns normalized spatial power |
| `minvar.m` | MVDR beamformer — computes `P(φ) = 1 / (aᴴ R⁻¹ a)` |
| `takhir.m` | Propagation delay calculator from mic coordinates + azimuth/elevation |
| `produce_data.m` | Simulates multi-source signals arriving from specified angles |
| `maincode.m` | Full pipeline: load data → apply DAS/MVDR → plot spatial spectrum |
| `hope.m` / `akhavan.m` | Real-time streaming versions with Butterworth filtering and waterfall plots |
| `az2code.m` | Comparative analysis across array spacings and mic counts |

**Mic geometries tested:**
- **1D Linear Array:** 16 mics spaced at 42 mm intervals along the x-axis
- **2D Planar Array:** 16 mics in a checkerboard-style grid pattern

**Datasets:** Six pre-recorded `.mat` multichannel files — sources at various angles including a 50° test case.

---

### Lab 2 — Array Geometry & Element Spacing Analysis

Extends Lab 1 by **systematically varying** array inter-element spacing (×1 to ×4 baseline) and the number of active microphones (2, 4, 6, 8 of 16), studying the effect on beamforming resolution and the MVDR spatial spectrum. Simulated signals are generated programmatically via `produce_data.m` with two sources at φ = 51° and φ = 71°.

**Key insight explored:** How inter-element spacing and aperture size trade off spatial resolution against spatial aliasing.

---

### Lab 3 — k-NN Classification on the Fisher Iris Dataset

A pattern recognition exercise applying **k-Nearest Neighbours** classification to the classic Fisher Iris dataset using MATLAB's Statistics and Machine Learning Toolbox.

**Five distance metrics compared:**

| Metric | MATLAB key |
|--------|-----------|
| Chebyshev | `chebychev` |
| Hamming | `hamming` |
| Minkowski | `minkowski` |
| City-block (Manhattan) | `cityblock` |
| Euclidean | `euclidean` |

All models use k=5 and are evaluated with **10-fold cross-validation** (`kfoldLoss`), with a held-out test point `[5.7, 2.8, 4.5, 1.3]` predicted across all metrics.

---

### Lab 4 — Linear Predictive Coding & Pitch Estimation (SIFT)

Speech coding fundamentals applied to real `.wav` recordings of vowel sounds.

**Two components:**

**`lpc1.m` — Manual LPC implementation**
Builds the autocorrelation matrix by hand using zero-padded shifts, solves for LPC coefficients via matrix inversion, and cross-validates against MATLAB's built-in `lpc()` function.

**`sift1.m` — SIFT-based Pitch Estimation**
Full pitch estimation pipeline:
1. Low-pass filter (FIR, cutoff 800 Hz) + pre-emphasis
2. Downsampling (factor 5) for computational efficiency
3. Frame-by-frame LPC residual computation
4. Autocorrelation of the LPC residual to locate the pitch period
5. Final pitch frequency estimate via weighted averaging

**Audio data:** Five `.wav` files of speakers producing the vowel "oo" (speakers d26, n01, n13, t15, y25).

---

### Lab 5 — Speech Analysis: Windowing, Spectral & Autocorrelation Methods

Short-time analysis of speech signals using classical DSP windows and pitch detection techniques.

**Exercises covered:**

| File | Topic |
|------|-------|
| `q1.m` | Live microphone recording and signal norm |
| `q4a.m` | Plotting `αⁿ − βⁿ` sequences across a 3×3 grid of (α, β) pairs |
| `q4b.m` | FFT magnitude + phase of `αⁿ − βⁿ` with `fftshift` |
| `q4c.m` | Raised-cosine / Tukey window generation across parameter grids |
| `q4d.m` | FFT of Tukey window — magnitude and phase spectra |
| `q5a.m` | Short-time FFT + autocorrelation on voiced speech frames (Hamming window) |
| `q5b.m` | Centre-clipping pre-processing before autocorrelation-based pitch detection |
| `q6.m` | AMDF (Average Magnitude Difference Function) pitch estimation on `/iy/` vowel |

**Core technique:** All spectral analyses use 512-point frames with a Hamming window; frames overlap via sliding to capture speech dynamics.

---

## 🛠️ Requirements

- **MATLAB R2020b** or later
- Signal Processing Toolbox
- Statistics and Machine Learning Toolbox (Lab 3)
- Audio Toolbox (Labs 4 & 5, for `audioread`)

---

## ▶️ Quick Start

```matlab
% Lab 1 — Run DAS beamformer on linear array data
cd 'Lab 1'
testdas   % plots DAS spatial power spectrum

% Lab 1 — Run MVDR beamformer
testvar   % plots MVDR spatial power spectrum

% Lab 3 — Run k-NN classification comparison
cd 'Lab 3'
iris

% Lab 4 — Run LPC coefficient comparison
cd 'Lab 4'
lpc1
```

---
