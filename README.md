# Automated Electronic Beam Steering System

## 📌 Overview
This project demonstrates an SDR-based phased array beamforming system for tracking Low Earth Orbit (LEO) satellites using electronic beam steering.

The system integrates satellite orbit simulation, signal processing, and antenna beamforming to maintain a reliable communication link between a ground station and a moving satellite.

Satellite motion and orbital parameters are simulated using STK, while beamforming algorithms and signal processing are implemented in MATLAB.

## 🎯 Key Features
* Real-time satellite tracking using Azimuth ($\theta$) and Elevation ($\phi$)
* Phased array beam steering using Delay-and-Sum (DAS) beamforming
* Steering vector computation for Uniform Rectangular Array (URA)
* Electronic beam control without mechanical antenna movement
* 3D radiation pattern visualization
* Link budget analysis for communication reliability

## 🛰️ System Workflow
1. STK Satellite Orbit Simulation
2. Export Azimuth & Elevation Data
3. RF Signal Reception using SDR
4. I/Q Signal Conversion to Complex Signal
5. MATLAB Beamforming Processing
6. Steering Vector Generation
7. Apply DAS Beamforming Weights
8. Electronic Beam Steering Toward Satellite
9. Radiation Pattern & Link Budget Validation

## ⚙️ Technologies Used
### Software
* MATLAB – Beamforming algorithms and signal processing
* STK – Satellite orbit simulation
### Hardware
* Software Defined Radio (SDR)
* Phased Array Antenna System

## 📐 Beamforming Mathematics

* **Wavelength:** $\lambda = c / f_n$
* **Wave Number:** $k = 2\pi / \lambda$
* **Steering Vector:** $\psi_{m,n} = kd [m \sin\theta \cos\phi + n \sin\theta \sin\phi]$
* **DAS Beamforming Weight:** $w = a / M$
* **Beamformer Output:** $y = w^H x$

## 📊 Results
* Directed beam toward the satellite using phased array beamforming
* Strong main lobe aligned with satellite direction
* Suppressed side lobes reducing interference
* Stable communication link confirmed using link budget analysis

## 📂 Project Structure
Beam-Steering-System/
├── MATLAB-Code/
├── STK-Simulation/
├── Beamforming-Results/
├── Documentation/
├── Poster/
└── README.md

## 🌍 Applications
* Satellite communication ground stations
* Radar systems
* 5G massive MIMO antenna systems
* Space communication research
* Defense communication systems

## 👩‍💻 Author
**Keerthika Murugan**
Electronics and Communication(Advanced Communication Technology)
R.M.K Engineering College
