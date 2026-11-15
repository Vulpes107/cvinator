#!/usr/bin/env bash
# Print a CV HTML file to PDF and report what a screening parser would see.
# usage: ./render.sh path/to/cv.html [out.pdf]
set -euo pipefail

html=$(realpath "$1")
pdf=$(realpath -m "${2:-${html%.html}.pdf}")

# snap chromium cannot read /tmp or dot-directories, so both paths must live in the project
log=$(chromium --headless --disable-gpu --no-pdf-header-footer \
      --print-to-pdf="$pdf" "file://$html" 2>&1) || { echo "$log" >&2; exit 1; }
[ -s "$pdf" ] || { echo "$log" >&2; echo "render failed: no PDF written" >&2; exit 1; }

echo "pdf:   $pdf"
if command -v pdftotext >/dev/null; then
  echo "pages: $(pdfinfo "$pdf" | awk '/^Pages:/{print $2}')"
  # -raw: content-stream order, what the simplest parsers read; smarter ones do better
  pdftotext -raw "$pdf" "$(dirname "$pdf")/cv.txt"
  echo "text:  $(dirname "$pdf")/cv.txt ($(wc -w < "$(dirname "$pdf")/cv.txt") words) - read it, order must make sense"
else
  echo "pages: $(grep -ac '/Type /Page$' "$pdf")"
  echo "text:  SKIPPED - install poppler-utils (sudo apt install poppler-utils) for the parser check"
fi
