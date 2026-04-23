# MicroParkDx-V1

MicroParkDx V1 is a standalone Windows application for Parkinson's disease related classification using pre-trained microstate models.

## Repository structure

- `for_redistribution_files_only/MicroParkDx.exe`: executable application.
- `for_redistribution_files_only/models/*.mat`: deployed model files (PD / PS / PD-PS).
- `for_redistribution_files_only/icon.png`: application icon.
- `for_redistribution_files_only/readme.txt`: MATLAB Runtime deployment notes.
- `tools/check_package.sh`: package integrity and completeness check script.

## Before first run

1. Install **MATLAB Runtime R2023b** on Windows.
2. Confirm all files in `for_redistribution_files_only` remain in their expected relative paths.

> Runtime download reference: <https://www.mathworks.com/products/compiler/mcr/index.html>

## How to use the software

1. Start `MicroParkDx.exe`.
2. Select target model:
   - Button ①: PD diagnostic model
   - Button ②: PS diagnostic model
   - Button ③: PD-PS differential model
3. Wait for the right-side indicator to turn from red to green (model loaded).
4. Import feature file with button ④.
   - Feature names must match the model specification (Table 1.1 in the software documentation).
5. Click button ⑤ to perform automatic feature screening/extraction.
6. Click button ⑥ to run prediction.
7. Read prediction results on the right panel.
   - If multiple subjects are imported together, results are shown per subject.
   - A prediction result file is generated in the working root directory.

The `Status` section at the bottom displays current operation progress and error information.

## Quality improvement added in this repo

To reduce deployment errors, run:

```bash
./tools/check_package.sh
```

This check will:

- verify required files are present,
- fail fast when artifacts are missing,
- output SHA-256 checksums for executable/model artifacts (for delivery verification).

## UI reference

<img width="432" alt="MicroParkDx UI" src="https://github.com/user-attachments/assets/49f8c049-315c-4729-81d5-105280684e85" />
