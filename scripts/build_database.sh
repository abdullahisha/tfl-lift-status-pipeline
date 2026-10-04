#!/bin/bash
cd "$(dirname "$0")/.."
duckdb data/tfl.duckdb < sql/clean_stations.sql
duckdb data/tfl.duckdb < sql/clean_lift_faults.sql
duckdb data/tfl.duckdb < sql/report_broken_lifts.sql
