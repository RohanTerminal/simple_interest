#!/bin/bash
# Simple Interest Calculator
# Usage:
#   Interactive: ./simple-interest.sh
#   CLI args   : ./simple-interest.sh <principal> <rate> <time>

set -e

read_values() {
  echo "Enter Principal:"
  read p
  echo "Enter Rate of Interest (in % per year):"
  read r
  echo "Enter Time (in years):"
  read t
}

# If 3 args provided, use them; else prompt
if [ $# -eq 3 ]; then
  p="$1"
  r="$2"
  t="$3"
else
  read_values
fi

# Basic validation (non-empty, numeric)
for val in "$p" "$r" "$t"; do
  if ! [[ "$val" =~ ^[0-9]+(\.[0-9]+)?$ ]]; then
    echo "Error: values must be numeric (integers or decimals)."
    exit 1
  fi
done

# Use bc for decimal support if available, else integer math
if command -v bc >/dev/null 2>&1; then
  si=$(echo "scale=2; ($p * $r * $t) / 100" | bc)
else
  # Fallback: integer math (may truncate decimals)
  si=$(( (p * r * t) / 100 ))
fi

echo "Simple Interest = $si"
