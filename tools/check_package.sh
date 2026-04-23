#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  "README.md"
  "for_redistribution_files_only/MicroParkDx.exe"
  "for_redistribution_files_only/icon.png"
  "for_redistribution_files_only/models/PD_Model.mat"
  "for_redistribution_files_only/models/PS_Model.mat"
  "for_redistribution_files_only/models/PDPS_Model.mat"
  "for_redistribution_files_only/readme.txt"
)

missing=0
printf 'Checking required distribution files...\n'
for path in "${required_files[@]}"; do
  if [[ -f "$ROOT_DIR/$path" ]]; then
    printf '  [OK] %s\n' "$path"
  else
    printf '  [MISSING] %s\n' "$path"
    missing=1
  fi
done

if [[ $missing -ne 0 ]]; then
  printf '\nOne or more required files are missing.\n' >&2
  exit 1
fi

printf '\nComputing SHA-256 for package artifacts...\n'
sha256sum \
  "$ROOT_DIR/for_redistribution_files_only/MicroParkDx.exe" \
  "$ROOT_DIR/for_redistribution_files_only/icon.png" \
  "$ROOT_DIR/for_redistribution_files_only/models/PD_Model.mat" \
  "$ROOT_DIR/for_redistribution_files_only/models/PS_Model.mat" \
  "$ROOT_DIR/for_redistribution_files_only/models/PDPS_Model.mat"

printf '\nValidation complete.\n'
