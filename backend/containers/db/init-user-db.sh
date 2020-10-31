#!/bin/bash

psql -U postgres <<-EOSQL
  CREATE DATABASE tampre_app;
  CREATE USER admin WITH PASSWORD 'password';
  GRANT ALL PRIVILEGES ON DATABASE tampre_app TO admin;
EOSQL
