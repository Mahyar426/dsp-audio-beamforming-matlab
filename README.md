<div align="center">

![header](https://readme-typing-svg.demolab.com?font=Fira+Code&size=26&pause=1000&color=00D9FF&center=true&vCenter=true&width=800&lines=🎙️+DSP+·+Audio+%26+Beamforming+in+MATLAB;16-mic+array.+DAS.+MVDR.+Real-time+waterfall.;Built+from+scratch+—+no+black+boxes.)

```
██████╗ ███████╗ █████╗ ███╗   ███╗
██╔══██╗██╔════╝██╔══██╗████╗ ████║
██████╔╝█████╗  ███████║██╔████╔██║
██╔══██╗██╔══╝  ██╔══██║██║╚██╔╝██║
██████╔╝███████╗██║  ██║██║ ╚═╝ ██║
╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝
    spatial audio · direction · pitch · coding
```

![MATLAB](https://img.shields.io/badge/MATLAB-R2020b%2B-orange?style=flat-square&logo=mathworks)
![Topics](https://img.shields.io/badge/Topics-Beamforming%20·%20DOA%20·%20LPC%20·%20Pitch%20·%20Spectral%20Analysis-blue?style=flat-square)
![Array](https://img.shields.io/badge/Hardware-16--Mic%20Array-00D9FF?style=flat-square)
![Domain](https://img.shields.io/badge/Domain-Audio%20DSP%20%7C%20Array%20Processing-green?style=flat-square)

</div>

---

Five interconnected signal processing modules spanning **microphone array beamforming**, **direction-of-arrival estimation**, **speech coding**, and **pitch detection** — implemented in MATLAB with real recorded audio and simulated multichannel data. No black-box toolbox calls for the core algorithms.

---

## 🔊 Microphone Array Beamforming & DOA Estimation

The centrepiece of this repo. A full **16-microphone array** processing pipeline implementing two spatial filtering algorithms and benchmarking them head-to-head.

### Delay-and-Sum (DAS) Beamformer
For every candidate azimuth angle φ ∈ [0°, 359°]:
- Computes the exact propagation delay to each microphone from 3D coordinates: `τ = (x·sin(θ)·cos(φ) + y·sin(θ)·sin(φ)) / c`
- Applies sample-accurate circular shifts to time-align all 16 channels
- Sums coherently — peak = source direction

### MVDR Beamformer (Minimum Variance Distortionless Response)
Data-adaptive spatial filtering that goes beyond DAS. Estimates the **sample covariance matrix** R and computes:

```
P(φ) = 1 / (aᴴ · R⁻¹ · a)
```

Result: dramatically sharper spatial nulls and better separation of closely spaced sources — especially visible when two sources are within 20° of each other.

### Array Geometry Study
Systematically varied both **inter-element spacing** (1× to 4× baseline at 42 mm) and **number of active microphones** (2, 4, 6, 8, 16) to empirically map the trade-off between spatial resolution and grating lobes.

| Geometry | Layout | Advantage |
|----------|--------|-----------|
| **1D ULA** | 16 mics, uniform linear, 42 mm pitch | Simple steering, predictable sidelobes |
| **2D Planar** | 4×4 checkerboard grid | Full azimuth coverage, reduced ambiguity |

### Real-Time Streaming Mode
A **live audio pipeline** that processes a 16-channel audio stream frame-by-frame (frame = Fs/5 samples), applies 5th-order Butterworth bandpass filtering, runs both DAS and MVDR per window, and renders a **live waterfall plot** of the evolving spatial spectrum — directional tracking in real time.

---

## 🗣️ Speech Coding: Linear Predictive Coding (LPC)

An **LPC coefficient estimator built from scratch** — no `lpc()` shortcut for the derivation. Constructs the autocorrelation matrix manually through zero-padded shifted products, then solves the normal equations via direct matrix inversion. Cross-validated against MATLAB's built-in to verify correctness. Applied to real vowel recordings — the predictor captures vocal tract resonance structure cleanly.

---

## 🎵 Pitch Estimation: SIFT Algorithm

A full pitch estimation pipeline for voiced speech:

1. **Pre-filtering** — FIR low-pass (155 taps, 800 Hz cutoff) + pre-emphasis `[1 -0.95]`
2. **Downsampling** — factor of 5, guided by initial pitch estimate
3. **Frame-by-frame LPC residual** — removes vocal tract model, exposing the excitation signal
4. **Autocorrelation of residual** — peak location = pitch period
5. **Pitch averaging** — outlier rejection before final frequency calculation

Tested across multiple speakers producing the vowel "oo" — inter-speaker pitch variation clearly resolved.

---

## 📊 Spectral Analysis & Windowing

- **Hamming-windowed STFT** — 512-point frames, FFT magnitude and phase
- **Window comparison** — Hann, Hamming, Bartlett, Blackman, rectangular — spectral leakage trade-offs studied side by side
- **Short-time autocorrelation** — sliding frame autocorrelation for periodicity detection
- **Centre-clipping** — hard clip pre-processing before autocorrelation to suppress unvoiced interference
- **AMDF** — Average Magnitude Difference Function as an alternative pitch detection approach

---

## 🧠 k-NN Classification

k-Nearest Neighbours (k=5) on the Fisher Iris dataset, benchmarking **five distance metrics** with 10-fold cross-validation: `Euclidean` · `Minkowski` · `City-block` · `Chebyshev` · `Hamming`

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
% DAS beamforming
cd 'Lab 1'; testdas

% MVDR beamforming
cd 'Lab 1'; testvar

% Real-time streaming pipeline (requires 16-ch audio input)
cd 'Lab 1'; hope

% LPC manual implementation
cd 'Lab 4'; lpc1

% SIFT pitch estimator
cd 'Lab 4'; sift1

% Short-time spectral analysis
cd 'Lab 5'; q5a
```
