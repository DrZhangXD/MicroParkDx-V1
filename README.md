# MicroParkDx V1

> A standalone Windows application for Parkinson's disease–related classification using pre-trained EEG microstate models.

[![License: CC0-1.0](https://img.shields.io/badge/License-CC0%201.0-lightgrey.svg)](./LICENSE)
[![Platform](https://img.shields.io/badge/platform-Windows-blue.svg)](#system-requirements)
[![Runtime](https://img.shields.io/badge/MATLAB%20Runtime-R2023b-orange.svg)](https://www.mathworks.com/products/compiler/mcr/index.html)
[![Release](https://img.shields.io/badge/version-v1-green.svg)](#)

MicroParkDx is a one-click desktop tool that loads a pre-trained model, imports a
feature file, performs automatic feature screening, and outputs a classification
result. It is intended to make microstate-model–based Parkinson's disease
analysis accessible without writing any code or installing a full MATLAB license.

<p align="center">
  <img width="432" alt="MicroParkDx UI" src="https://github.com/user-attachments/assets/49f8c049-315c-4729-81d5-105280684e85" />
</p>

---

## Table of contents

- [Overview](#overview)
- [Bundled models](#bundled-models)
- [System requirements](#system-requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Input feature file](#input-feature-file)
- [Output](#output)
- [Package validation](#package-validation)
- [Repository structure](#repository-structure)
- [Troubleshooting](#troubleshooting)
- [Disclaimer](#disclaimer)
- [License](#license)

---

## Overview

MicroParkDx wraps several pre-trained classification models behind a simple
graphical interface. A typical session is:

1. Select one of the bundled models.
2. Wait for the model to load.
3. Import a feature file for one or more subjects.
4. Run automatic feature screening / extraction.
5. Run the prediction.
6. Read the per-subject results and pick up the generated result file.

Because the application is compiled with MATLAB Compiler, it runs on machines
**without** a MATLAB installation — only the matching **MATLAB Runtime** is
required (see [System requirements](#system-requirements)).

---

## Bundled models

Three pre-trained models ship with the application and are selected from the
buttons on the left of the interface:

| Button | Model | File | Purpose |
| :----: | :---- | :--- | :------ |
| ① | PD model | `models/PD_Model.mat` | Parkinson's disease diagnostic classification |
| ② | PS model | `models/PS_Model.mat` | PS diagnostic classification |
| ③ | PD-PS model | `models/PDPS_Model.mat` | PD vs. PS differential classification |

> The exact meaning of each label and the feature set each model expects are
> defined in the software documentation (see [Input feature file](#input-feature-file)).

---

## System requirements

| Requirement | Details |
| :---------- | :------ |
| Operating system | Windows (64-bit) |
| Runtime | **MATLAB Runtime R2023b (9.15)** |
| Disk space | A few hundred MB for the runtime, plus this package |
| Privileges | Administrator rights are required to install the MATLAB Runtime |

The MATLAB Runtime is a free, redistributable set of shared libraries that lets
compiled MATLAB applications run on computers without MATLAB installed.

---

## Installation

1. **Install MATLAB Runtime R2023b.**
   - If MATLAB is available on the machine, run `mcrinstaller` at the MATLAB
     prompt to locate the installer.
   - Otherwise, download the Windows R2023b runtime from MathWorks:
     <https://www.mathworks.com/products/compiler/mcr/index.html>
   - Administrator rights are required.

2. **Obtain this package** and keep every file in
   `for_redistribution_files_only/` in its original relative location. The
   application loads `models/*.mat` relative to the executable, so the folder
   layout must not be changed.

3. *(Optional but recommended)* **Validate the package** before first run — see
   [Package validation](#package-validation).

See [`for_redistribution_files_only/readme.txt`](./for_redistribution_files_only/readme.txt)
for the original MATLAB Compiler deployment notes.

---

## Usage

1. Launch **`MicroParkDx.exe`**.
2. Select the target model:
   - **Button ①** — PD diagnostic model
   - **Button ②** — PS diagnostic model
   - **Button ③** — PD-PS differential model
3. Wait until the indicator on the right turns from **red to green** — this means
   the model has finished loading.
4. **Button ④** — import the feature file (see [Input feature file](#input-feature-file)).
5. **Button ⑤** — run automatic feature screening / extraction.
6. **Button ⑥** — run the prediction.
7. Read the prediction results on the right-hand panel.
   - When several subjects are imported together, results are reported per subject.
   - A prediction result file is also written to the working root directory.

The **`Status`** area at the bottom of the window shows live progress and any
error messages.

---

## Input feature file

- The feature file is imported with **Button ④**.
- **Feature names must match the model specification** (Table 1.1 in the software
  documentation). Mismatched or missing feature columns will cause prediction to
  fail.
- Multiple subjects can be included in a single file; each is classified
  independently and reported separately.

---

## Output

- **On-screen:** classification result(s) shown on the right panel, one row per
  imported subject.
- **On-disk:** a prediction result file is generated in the working root
  directory (the folder from which the application is run).

---

## Package validation

To reduce deployment errors, a helper script verifies that the distribution is
complete and reports artifact checksums:

```bash
./tools/check_package.sh
```

The script will:

- verify that every required file is present,
- fail fast (non-zero exit) when an artifact is missing, and
- print **SHA-256** checksums for the executable and model files, so a delivered
  package can be checked against a known-good reference.

> The check script uses standard POSIX tools (`bash`, `sha256sum`). On Windows it
> can be run from Git Bash, WSL, or any environment that provides these tools.

---

## Repository structure

```
.
├── for_redistribution_files_only/
│   ├── MicroParkDx.exe        # Compiled standalone application
│   ├── icon.png               # Application icon
│   ├── readme.txt             # MATLAB Runtime deployment notes
│   └── models/
│       ├── PD_Model.mat       # PD diagnostic model
│       ├── PS_Model.mat       # PS diagnostic model
│       └── PDPS_Model.mat     # PD-PS differential model
├── tools/
│   └── check_package.sh       # Package integrity / completeness check
├── LICENSE                    # CC0 1.0 Universal
└── README.md
```

---

## Troubleshooting

| Symptom | Likely cause / fix |
| :------ | :----------------- |
| Application fails to start or reports missing DLLs | MATLAB Runtime **R2023b** is not installed, or a different version is installed. Install the matching runtime. |
| Indicator stays red after selecting a model | The model file could not be loaded. Confirm the `models/` folder is intact and located next to the executable; re-run `tools/check_package.sh`. |
| Prediction fails after import | Feature names in the imported file do not match the model specification (Table 1.1). Align the column names and re-import. |
| Missing files reported by the check script | The package is incomplete — re-download / re-extract the full distribution. |

Check the **`Status`** panel at the bottom of the window for the specific error
message.

---

## Disclaimer

MicroParkDx is provided for **research and educational purposes**. It is **not a
medical device** and is **not a substitute for professional medical diagnosis,
advice, or treatment**. Outputs should be interpreted only by qualified
personnel and should not be used as the sole basis for any clinical decision.

---

## License

This project is released under the **Creative Commons CC0 1.0 Universal** public
domain dedication. See [`LICENSE`](./LICENSE) for the full text.

> The MATLAB Runtime is distributed by MathWorks under its own license terms.
</content>
</invoke>
