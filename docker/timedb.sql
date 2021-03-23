CREATE database timedb;
\connect timedb

CREATE EXTENSION IF NOT EXISTS timescaledb;

CREATE TABLE queue_monitor (
 time        TIMESTAMPTZ       NOT NULL,
 host        TEXT              NOT NULL,
 queue       TEXT              NOT NULL,
 queue_size  INTEGER           NULL
);
SELECT create_hypertable('queue_monitor', 'time');


CREATE TABLE conditions (
  time        TIMESTAMPTZ       NOT NULL,
  location    TEXT              NOT NULL,
  temperature DOUBLE PRECISION  NULL,
  humidity    DOUBLE PRECISION  NULL
);
SELECT create_hypertable('conditions', 'time');
