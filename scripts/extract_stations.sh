#!/bin/bash
cd "$(dirname "$0")/.."
curl -sf --retry 3 --retry-delay 5 https://api.tfl.gov.uk/StopPoint/Mode/tube -o data/raw/stations.json
