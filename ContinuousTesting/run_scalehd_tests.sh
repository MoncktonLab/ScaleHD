#!/bin/bash

#run_scalehd_test.sh

set -euo pipefail

echo "Running ScaleHD demo tests..."

echo "" > MiSeq_runX/ScaleHDLog.txt
# Run ScaleHD on example demo BAM and reference FASTA
# Adjust file names/paths according to the actual demo data in ScaleHD repo
ScaleHD -v -b -c "MiSeq_runX/ConfigurationFile_MiSeq_runX.xml" -o MiSeq_runX -j MiSeq_runX_ScaleHDresults

echo "Validating checksums..."

# Generate actual checksums
find MiSeq_runX/MiSeq_runX_ScaleHDresults -maxdepth 1 -type f -name "*.csv" \
  -exec sha256sum {} \; \
  | awk '{split($2, a, "/"); print a[length(a)] "," $1}' > MiSeq_runX/actual_checksums.csv

# Compare against expected
diff_output=$(diff <(sort MiSeq_runX/scalehd_test_expected_checksums.csv) <(sort MiSeq_runX/actual_checksums.csv) || true)

if [[ -z "$diff_output" ]]; then
    echo "All checksums match. Demo test passed."
else
    echo "Checksum mismatch found:"
    echo "$diff_output"
    exit 1
fi

