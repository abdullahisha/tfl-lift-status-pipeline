#!/bin/bash
cd "$(dirname "$0")/.."
mkdir -p data/raw
TIMESTAMP=$(date +%Y-%m-%d_%H-%M-%S)
curl -sf --retry 3 --retry-delay 5 https://api.tfl.gov.uk/Disruptions/Lifts/v2/ -o data/raw/lifts_$TIMESTAMP.json


