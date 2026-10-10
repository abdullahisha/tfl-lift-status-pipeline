# TfL Lift Status Pipeline

A data pipeline that tracks which London Underground station lifts are out of service, built for step-free travellers.

## About me

As a wheelchair user, I wanted to make journeys more time efficient. Checking whether a station I'm going to has working lifts often means waiting for a member of staff to radio ahead and request live information, so I built this to cut out the middleman. I came to data through psychology. I went to university expecting to prefer the qualitative side, but during my dissertation I was surprised how much I enjoyed the quantitative work, collecting data and running it through statistics software. The results came back null, but I found the process of gathering and working through the data genuinely interesting, and I realised I enjoy picking up technical skills. That led me to teach myself the basics of DevOps, including Bash and Linux.

At Graceful Care I spoke with clients regularly to gather their feedback, then relayed it to care coordinators based on how their care was performing, and to field care supervisors so they could arrange appointments to improve that performance and shape a new care plan. I kept the client records up to date throughout. I enjoyed being the link between people and the information they needed, and consultancy appeals to me for the same reason, understanding what someone needs and making sure the right information reaches the right place.

The Data School appealed to me as a way to widen my technical skills through structured training and become a more well-rounded data professional

## What it does

Every five minutes it fetches live lift disruption data from Transport for London, saves the raw response, and cleans it into a report ranking stations by how many lifts are currently out of service.

## Data source

Transport for London's Unified API, using two endpoints:
- Lift disruptions, which lists lifts currently out of service
- Tube stop points, which lists every station

TfL was the only source used. 

## How the pipeline works

1. Two Bash scripts fetch the data using curl and save the raw JSON exactly as returned.
2. A cron job runs the lift fetch every five minutes.
3. DuckDB reads the raw JSON, and SQL cleans it into two tables, stations and lift faults.
4. A report query joins the tables and ranks stations by how many lifts are out of service, counting only the most recent snapshot.

## How to run it

Requires DuckDB, curl and Bash. Clone the repository, then from the project folder run:

```
./scripts/extract_stations.sh
./scripts/extract_lifts.sh
./scripts/build_database.sh
```

The first two fetch the data, and the third rebuilds the database and prints the report.

## Known issues

- The station list currently includes some non-tube stops and duplicate station names, for example Amersham appears several times under slightly different names. I identified this by querying the data directly, and I plan to resolve it with a station-level filter.
- The lift fetch runs on my laptop via cron, so data is only collected while the machine is awake. This means there are gaps overnight. I plan to move the scheduled job to a cloud service such as GitHub Actions so it runs continuously.

## Future improvements

- A live alert that notifies travellers when a station's lift goes out of service.
- A dashboard showing current lift status across the network.
- Running the data fetch on GitHub Actions, so collection does not depend on my laptop being awake.
- A station-level filter to remove non-tube stops and duplicate names.

## How AI helped

I had not used SQL before this project, so I used Claude mainly to understand it. It helped me find relevant tutorials and explained specific concepts such as joining tables and unnesting nested data. It also gave me outlines of the queries, and based on those outlines I practised writing them out myself.

I chose the project topic and audience, designed the folder structure and file naming, set up the scripts and scheduling, and tested and debugged the pipeline myself. I also spotted that the report was over-counting faults, counting every snapshot rather than only the latest, and worked through the fix.