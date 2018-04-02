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

# Import column schema
printf "Importing column data\n"
hdb_run_file_lite ./sql/schemaCol.sql
hdb_run_file_lite ./sql/import.sql
printf "Column data imported\n"


#hdb_finish_log
