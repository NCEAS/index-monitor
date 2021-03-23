# DataONE Metrics Dashboard

A little experiment.

This is a simple dashboard to collect metrics about DataONE and present them in an interactive dashboard, with as minimal custom coding as possible. The system is based on docker deployments of TimescaleDB, a time series database that extends Postgresql, and Grafana, an interactive dashboard server.

# Installation

The system is based on dockerr images. Configure the application by editing the variables in `docker/.env`, and then run `docker-compose -p timedb up -d` to start the applicaiton. Currently persistent data are stored in docker named volumes, so if those get cleared, the data gets cleared. Eventually we would make use of timescaledb features for clearing old data chunks.  WHen the timescaledb container loads, if the postgres database doesn't exist, then it is loaded from the timedb.sql file.

YMMV. This is a simple one evening experiment, and not tested much at all.
