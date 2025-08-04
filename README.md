# GRACE-FO Accelerometer Signal Simulation Workflow

This repository demonstrates a modular workflow designed to simulate and analyse non-conservative accelerations on the GRACE-FO satellites using atmospheric model outputs. The project combines GRACE-FO satellite data, meteorological data from OpenIFS, and physics-based simulations using the GROOPS software. Final analysis is performed in Python using Jupyter Notebook.

> ⚠️ This repository includes documentation and placeholder files only. Some input data and simulation configurations are confidential or licensed and are not distributed here.

---

## Overview of the Workflow

### 1. Retrieve GRACE-FO Level-1B Data
- GRACE-FO satellite data are downloaded using a Bash script from NASA CDDIS archives.
- Only accelerometer-related measurements are used in this simulation.

### 2. Retrieve and Prepare OpenIFS Output
- Atmospheric model outputs (e.g., pressure, temperature, wind) are obtained from a licensed OpenIFS simulation (not included).
- These outputs are preprocessed using a Bash pipeline to extract surface fields and prepare them for satellite simulation.

### 3. Simulate Satellite Accelerations with GROOPS
- GROOPS (TU Graz) is used to simulate satellite orbits and compute expected accelerometer signals based on:
  - Satellite parameters and orbits
  - Atmospheric force fields derived from OpenIFS data
- This step replicates satellite dynamics and produces synthetic measurements under controlled conditions.

### 4. Python Analysis in Jupyter Notebook
- A Jupyter Notebook is used to:
  - Compare simulated accelerations with observed GRACE-FO data
  - Visualise perturbations and errors
  - Evaluate the impact of weather systems on satellite motion

---

## Tools and Technologies

- **Bash** – scripting for data retrieval and OpenIFS preprocessing
- **GROOPS** – satellite dynamics and signal simulation
- **Python** (`xarray`, `matplotlib`, `numpy`, `seaborn`) – analysis and plotting
- **Jupyter Notebook** – interactive results inspection

---

## Repository Structure
│ ├── accelerometer_analysis.ipynb # Python notebook for visualisation
│ └── example_plot.png # Sample output
└── LICENSE_and_disclaimer.md
