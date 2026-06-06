<div align="center">

# 🎙️ DSP · Audio & Speech Signal Processing in MATLAB

![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-orange?style=flat-square&logo=mathworks)
![Topics](https://img.shields.io/badge/Topics-Beamforming%20·%20DOA%20·%20LPC%20·%20Pitch%20·%20Spectral%20Analysis-blue?style=flat-square)
![Array](https://img.shields.io/badge/Hardware-16--Mic%20Array-green?style=flat-square)

**Built and implemented from scratch** — no black-box toolbox calls for the core algorithms.

</div>

---

## What's Inside

Five interconnected signal processing modules spanning **microphone array beamforming**, **direction-of-arrival estimation**, **speech coding**, and **pitch detection** — implemented in MATLAB with real recorded audio and simulated multichannel data.

---

## 🔊 Microphone Array Beamforming & DOA Estimation

The centrepiece of this repo. A full **16-microphone array** processing pipeline implementing two competing spatial filtering algorithms and comparing them head-to-head.

### Delay-and-Sum (DAS) Beamformer
The classic coherent beamformer. For every candidate azimuth angle φ ∈ [0°, 359°]:
- Computes the exact propagation delay to each microphone from 3D coordinates using the steering vector formula: `τ = (x·sin(θ)·cos(φ) + y·sin(θ)·sin(φ)) / c`
- Applies sample-accurate circular shifts to time-align all 16 channels
- Sums coherently and tracks the peak — that's your source direction

### MVDR Beamformer (Minimum Variance Distortionless Response)
Data-adaptive spatial filtering that goes beyond DAS. Estimates the **sample covariance matrix** R from the aligned data and computes the minimum-variance output:

```
P(φ) = 1 / (aᴴ · R⁻¹ · a)
```

Result: dramatically sharper spatial nulls and better separation of closely spaced sources — the difference is visible when two sources sit within 20° of each other.

### Array Geometry Study
Systematically varied both **inter-element spacing** (1× to 4× baseline at 42 mm) and the **number of active microphones** (2, 4, 6, 8, 16) to empirically map the trade-off between spatial resolution and grating lobes. Two geometries were validated:

| Geometry | Layout | Advantage |
|----------|--------|-----------|
| **1D ULA** | 16 mics, uniform linear, 42 mm pitch | Simple steering, predictable sidelobes |
| **2D Planar** | 4×4 checkerboard grid | Full azimuth coverage, reduced ambiguity |

### Real-Time Streaming Mode
Implemented a **live audio pipeline** (`hope.m`, `akhavan.m`) that processes a 16-channel audio stream frame-by-frame (frame = Fs/5 samples), applies 5th-order Butterworth bandpass filtering, runs both DAS and MVDR per window, and renders a **live waterfall plot** of the evolving spatial spectrum — directional tracking in real time.

---

## 🗣️ Speech Coding: Linear Predictive Coding (LPC)

Built an **LPC coefficient estimator from scratch** — no `lpc()` shortcut for the derivation.

Constructs the autocorrelation matrix manually through zero-padded shifted products, then solves the normal equations via direct matrix inversion to recover the AR coefficients. Cross-validated against MATLAB's built-in `lpc()` to verify correctness.

Applied to real vowel recordings: the predictor captures the vocal tract resonance structure, producing a spectrally smooth all-pole model of speech.

---

## 🎵 Pitch Estimation: SIFT Algorithm

A full pitch estimation pipeline for voiced speech:

1. **Pre-filtering** — FIR low-pass (155 taps, 800 Hz cutoff) followed by pre-emphasis `[1 -0.95]` to flatten the spectral envelope
2. **Downsampling** — factor of 5, guided by a user-provided initial pitch estimate
3. **Frame-by-frame LPC residual** — removes the vocal tract model, leaving the excitation signal
4. **Autocorrelation of residual** — peak location = pitch period
5. **Pitch averaging** — outlier rejection (discard estimates below 75% of max) before final frequency calculation

Tested across five different speakers producing the vowel "oo" — inter-speaker pitch variation clearly resolved.

---

## 📊 Spectral Analysis & Windowing

Comprehensive short-time Fourier analysis on speech signals:

- **Hamming-windowed STFT** — 512-point frames, frame-by-frame FFT magnitude and phase
- **Window comparison** — Hann, Hamming, Bartlett, Blackman, rectangular — spectral leakage trade-offs studied side by side
- **Short-time autocorrelation** — sliding frame autocorrelation for periodicity detection in voiced speech
- **Centre-clipping** — hard clip pre-processing (threshold ±0.1) before autocorrelation to suppress unvoiced interference
- **AMDF (Average Magnitude Difference Function)** — an alternative to autocorrelation for pitch detection, avoids squaring non-linearities

---

## 🧠 k-NN Classification

Applied k-Nearest Neighbours (k=5) classification to the Fisher Iris dataset, benchmarking **five distance metrics** with 10-fold cross-validation:

`Euclidean` · `Minkowski` · `City-block` · `Chebyshev` · `Hamming`

Cross-validation loss compared across all metrics to determine which distance geometry best separates the feature space.

---

## 🛠️ Tech Stack

```
Language   : MATLAB
Toolboxes  : Signal Processing · Statistics & ML · Audio
Hardware   : 16-channel microphone array (48 kHz, real recordings)
Algorithms : DAS · MVDR · LPC · SIFT · AMDF · k-NN · STFT
```

---

## ▶️ Run It

```matlab
% Beamforming — DAS spatial spectrum
cd 'Lab 1'; testdas

% Beamforming — MVDR spatial spectrum
cd 'Lab 1'; testvar

% Full real-time pipeline (requires 16-ch audio input)
cd 'Lab 1'; hope

% LPC manual implementation
cd 'Lab 4'; lpc1

% SIFT pitch estimator
cd 'Lab 4'; sift1

% Short-time spectral analysis
cd 'Lab 5'; q5a
```

---

## 👤 Authors

**Mahyar Onsori** · [mahyaronsori99@gmail.com](mailto:mahyaronsori99@gmail.com)
