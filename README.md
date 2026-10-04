# TfL Lift Status Pipeline

A data pipeline that tracks which London Underground station lifts are out of service, built for step-free travellers.

## About me

As a wheelchair user, I wanted to make journeys more time efficient. Checking whether a station im going to has working lifts often means waiting to for a member of staff to radio ahead and request live information, so i built this to cut out the middleman.

## What it does

Every five minutes it fetches live lift disruption data from Transport for London, saves the raw response, and cleans it into a report ranking stations by how many lifts are currently out of service.

## Data source

Transport for London's Unified API, using two endpoints:
-Lift disruptions, which lists lifts currently out of service
- Tube stop points, which lists every station
TFL was the only source used 

## How the pipeline works

1. Two Bash scripts fetch the data using curl and save the raw JSON exactly as returned.
2. A cron job runs the lift fetch every five minutes.
3. DuckDB reads the raw JSON, and SQL cleans it into two tables, stations and lift faults.
4. A report query joins the tables and ranks stations by how many lifts are out of service, counting only the most recent snapshot.

## How to run it

Clone the repository, then from the project folder run:
./scripts/build_database.sh
Which rebuilds the whole database from the raw data and prints the report. It requires DuckDB to be installed.

## Known issues

- The station list currently includes some non-tube stops and a few duplicate station names. I plan to fix this with a station-level filter.
- The lift fetch runs on my laptop via cron, so data is only collected while the machine is awake. This means there are gaps overnight.

## Future improvements

- A live alert that notifies travellers when a station's lift goes out of service.
- A dashboard showing current lift status across the network.
- Running the data fetch on GitHub Actions, so collection does not depend on my laptop being awake.
- A station-level filter to remove non-tube stops and duplicate names.

## How AI helped

I had not used SQL before this project, so I used Claude mainly to understand it. It helped me find relevant tutorials and explained specific concepts such as joining tables and unnesting nested data. It also gave me outlines of the queries, and based on those outlines I practised writing them out myself.

I chose the project topic and audience, designed the folder structure and file naming, set up the scripts and scheduling, and tested and debugged the pipeline myself. I also spotted that the report was over-counting faults, counting every snapshot rather than only the latest, and worked through the fix.