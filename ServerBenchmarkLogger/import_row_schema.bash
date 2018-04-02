#!/bin/bash
source ./hdbsql.bash

# Settings
repetitions=100


hdb_ask $1

#hdb_init_log

# General Information
#hdb_log_start_attribute "General"
#hdb_log_start_map
#hdb_log_set_attribute "Repetitions:" "$repetitions"
#hdb_log_end_map
#hdb_log_end_attribute

# Run row benchmark
printf "Importing row data\n"
hdb_run_file_lite ./sql/schemaRow.sql
hdb_run_file_lite ./sql/import.sql
printf "Row data imported\n"



#hdb_finish_log
